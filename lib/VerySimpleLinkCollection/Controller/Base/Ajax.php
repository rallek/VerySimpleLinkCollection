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
 * Ajax controller class.
 */
class VerySimpleLinkCollection_Controller_Base_Ajax extends Zikula_Controller_AbstractAjax
{


    /**
     * This method is the default function handling the ajax area called without defining arguments.
     *
     *
     * @return mixed Output.
     */
    public function main()
    {
        $this->throwForbiddenUnless(SecurityUtil::checkPermission($this->name . '::', '::', ACCESS_OVERVIEW), LogUtil::getErrorMsgPermission());
    }
    
    
    /**
     * Retrieve item list for finder selections in Forms, Content type plugin and Scribite.
     *
     * @param string $ot      Name of currently used object type.
     * @param string $sort    Sorting field.
     * @param string $sortdir Sorting direction.
     *
     * @return Zikula_Response_Ajax
     */
    public function getItemListFinder()
    {
        if (!SecurityUtil::checkPermission($this->name . '::Ajax', '::', ACCESS_EDIT)) {
            return true;
        }
    
        $objectType = 'link';
        if ($this->request->isPost() && $this->request->request->has('ot')) {
            $objectType = $this->request->request->filter('ot', 'link', FILTER_SANITIZE_STRING);
        } elseif ($this->request->isGet() && $this->request->query->has('ot')) {
            $objectType = $this->request->query->filter('ot', 'link', FILTER_SANITIZE_STRING);
        }
        $controllerHelper = new VerySimpleLinkCollection_Util_Controller($this->serviceManager);
        $utilArgs = array('controller' => 'ajax', 'action' => 'getItemListFinder');
        if (!in_array($objectType, $controllerHelper->getObjectTypes('controllerAction', $utilArgs))) {
            $objectType = $controllerHelper->getDefaultObjectType('controllerAction', $utilArgs);
        }
    
        $entityClass = 'VerySimpleLinkCollection_Entity_' . ucfirst($objectType);
        $repository = $this->entityManager->getRepository($entityClass);
        $repository->setControllerArguments(array());
        $idFields = ModUtil::apiFunc($this->name, 'selection', 'getIdFields', array('ot' => $objectType));
    
        $descriptionField = $repository->getDescriptionFieldName();
    
        $sort = $this->request->request->filter('sort', '', FILTER_SANITIZE_STRING);
        if (empty($sort) || !in_array($sort, $repository->getAllowedSortingFields())) {
            $sort = $repository->getDefaultSortingField();
        }
    
        $sdir = $this->request->request->filter('sortdir', '', FILTER_SANITIZE_STRING);
        $sdir = strtolower($sdir);
        if ($sdir != 'asc' && $sdir != 'desc') {
            $sdir = 'asc';
        }
    
        $where = ''; // filters are processed inside the repository class
        $sortParam = $sort . ' ' . $sdir;
    
        $entities = $repository->selectWhere($where, $sortParam);
    
        $slimItems = array();
        $component = $this->name . ':' . ucwords($objectType) . ':';
        foreach ($entities as $item) {
            $itemId = '';
            foreach ($idFields as $idField) {
                $itemId .= ((!empty($itemId)) ? '_' : '') . $item[$idField];
            }
            if (!SecurityUtil::checkPermission($component, $itemId . '::', ACCESS_READ)) {
                continue;
            }
            $slimItems[] = $this->prepareSlimItem($objectType, $item, $itemId, $descriptionField);
        }
    
        return new Zikula_Response_Ajax($slimItems);
    }
    
    /**
     * Builds and returns a slim data array from a given entity.
     *
     * @param string $objectType       The currently treated object type.
     * @param object $item             The currently treated entity.
     * @param string $itemid           Data item identifier(s).
     * @param string $descriptionField Name of item description field.
     *
     * @return array The slim data representation.
     */
    protected function prepareSlimItem($objectType, $item, $itemId, $descriptionField)
    {
        $view = Zikula_View::getInstance('VerySimpleLinkCollection', false);
        $view->assign($objectType, $item);
        $previewInfo = base64_encode($view->fetch('external/' . $objectType . '/info.tpl'));
    
        $title = $item->getTitleFromDisplayPattern();
        $description = ($descriptionField != '') ? $item[$descriptionField] : '';
    
        return array('id'          => $itemId,
                     'title'       => str_replace('&amp;', '&', $title),
                     'description' => $description,
                     'previewInfo' => $previewInfo);
    }
}
