<?php
/**
 * VerySimpleLinkCollection.
 *
 * @copyright Ralf Koester (Koester)
 * @license http://www.gnu.org/licenses/lgpl.html GNU Lesser General Public License
 * @package VerySimpleLinkCollection
 * @author Ralf Koester <ralf@familie-koester.de>.
 * @link http://support.zikula.de
 * @link http://zikula.org
 * @version Generated by ModuleStudio 0.6.2 (http://modulestudio.de).
 */

/**
 * Search api base class.
 */
class VerySimpleLinkCollection_Api_Base_Search extends Zikula_AbstractApi
{
    /**
     * Get search plugin information.
     *
     * @return array The search plugin information
     */
    public function info()
    {
        return array('title'     => $this->name,
                     'functions' => array($this->name => 'search'));
    }
    
    /**
     * Display the search form.
     *
     * @param array $args List of arguments.
     *
     * @return string Template output
     */
    public function options(array $args = array())
    {
        if (!SecurityUtil::checkPermission($this->name . '::', '::', ACCESS_READ)) {
            return '';
        }
    
        $view = Zikula_View::getInstance($this->name);
    
        $view->assign('active_link', (!isset($args['active_link']) || isset($args['active']['active_link'])));
    
        return $view->fetch('search/options.tpl');
    }
    
    /**
     * Executes the actual search process.
     *
     * @param array $args List of arguments.
     *
     * @return boolean
     *
     * @throws RuntimeException Thrown if search results can not be saved
     */
    public function search(array $args = array())
    {
        if (!SecurityUtil::checkPermission($this->name . '::', '::', ACCESS_READ)) {
            return '';
        }
    
        // ensure that database information of Search module is loaded
        ModUtil::dbInfoLoad('Search');
    
        // save session id as it is used when inserting search results below
        $sessionId  = session_id();
    
        // retrieve list of activated object types
        $searchTypes = isset($args['objectTypes']) ? (array)$args['objectTypes'] : (array) FormUtil::getPassedValue('verySimpleLinkCollectionSearchTypes', array(), 'GETPOST');
    
        $controllerHelper = new VerySimpleLinkCollection_Util_Controller($this->serviceManager);
        $utilArgs = array('api' => 'search', 'action' => 'search');
        $allowedTypes = $controllerHelper->getObjectTypes('api', $utilArgs);
        $entityManager = ServiceUtil::getService('doctrine.entitymanager');
        $currentPage = 1;
        $resultsPerPage = 50;
    
        foreach ($searchTypes as $objectType) {
            if (!in_array($objectType, $allowedTypes)) {
                continue;
            }
    
            $whereArray = array();
            $languageField = null;
            switch ($objectType) {
                case 'link':
                    $whereArray[] = 'tbl.workflowState';
                    $whereArray[] = 'tbl.linkName';
                    $whereArray[] = 'tbl.linkText';
                    $whereArray[] = 'tbl.linkUrl';
                    break;
            }
            $where = Search_Api_User::construct_where($args, $whereArray, $languageField);
    
            $entityClass = $this->name . '_Entity_' . ucwords($objectType);
            $repository = $entityManager->getRepository($entityClass);
    
            // get objects from database
            list($entities, $objectCount) = $repository->selectWherePaginated($where, '', $currentPage, $resultsPerPage, false);
    
            if ($objectCount == 0) {
                continue;
            }
    
            $idFields = ModUtil::apiFunc($this->name, 'selection', 'getIdFields', array('ot' => $objectType));
            $descriptionField = $repository->getDescriptionFieldName();
            foreach ($entities as $entity) {
                $urlArgs = array('ot' => $objectType);
                // create identifier for permission check
                $instanceId = '';
                foreach ($idFields as $idField) {
                    $urlArgs[$idField] = $entity[$idField];
                    if (!empty($instanceId)) {
                        $instanceId .= '_';
                    }
                    $instanceId .= $entity[$idField];
                }
                $urlArgs['id'] = $instanceId;
                /* commented out as it could exceed the maximum length of the 'extra' field
                if (isset($entity['slug'])) {
                    $urlArgs['slug'] = $entity['slug'];
                }*/
    
                // perform permission check
                if (!SecurityUtil::checkPermission($this->name . ':' . ucfirst($objectType) . ':', $instanceId . '::', ACCESS_OVERVIEW)) {
                    continue;
                }
    
                $title = $entity->getTitleFromDisplayPattern();
                $description = !empty($descriptionField) ? $entity[$descriptionField] : '';
                $created = isset($entity['createdDate']) ? $entity['createdDate']->format('Y-m-d H:i:s') : '';
    
                $searchItemData = array(
                    'title'   => $title,
                    'text'    => $description,
                    'extra'   => serialize($urlArgs),
                    'created' => $created,
                    'module'  => $this->name,
                    'session' => $sessionId
                );
    
                if (!DBUtil::insertObject($searchItemData, 'search_result')) {
                    return LogUtil::registerError($this->__('Error! Could not save the search results.'));
                }
            }
        }
    
        return true;
    }
    
    /**
     * Assign URL to items.
     *
     * @param array $args List of arguments.
     *
     * @return boolean
     */
    public function search_check(array $args = array())
    {
        $datarow = &$args['datarow'];
        $urlArgs = unserialize($datarow['extra']);
        $datarow['url'] = ModUtil::url($this->name, 'user', 'display', $urlArgs);
    
        return true;
    }
}
