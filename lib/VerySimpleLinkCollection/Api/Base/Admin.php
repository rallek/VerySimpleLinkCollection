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
 * @version Generated by ModuleStudio 0.6.1 (http://modulestudio.de).
 */

/**
 * This is the Admin api helper class.
 */
class VerySimpleLinkCollection_Api_Base_Admin extends Zikula_AbstractApi
{
    /**
     * Returns available admin panel links.
     *
     * @return array Array of admin links.
     */
    public function getlinks()
    {
        $links = array();

        if (SecurityUtil::checkPermission($this->name . '::', '::', ACCESS_READ)) {
            $links[] = array('url' => ModUtil::url($this->name, 'user', 'main'),
                             'text' => $this->__('Frontend'),
                             'title' => $this->__('Switch to user area.'),
                             'class' => 'z-icon-es-home');
        }

        $controllerHelper = new VerySimpleLinkCollection_Util_Controller($this->serviceManager);
        $utilArgs = array('api' => 'admin', 'action' => 'getlinks');
        $allowedObjectTypes = $controllerHelper->getObjectTypes('api', $utilArgs);

        if (in_array('link', $allowedObjectTypes)
            && SecurityUtil::checkPermission($this->name . ':Link:', '::', ACCESS_ADMIN)) {
            $links[] = array('url' => ModUtil::url($this->name, 'admin', 'view', array('ot' => 'link')),
                             'text' => $this->__('Links'),
                             'title' => $this->__('Link list'));
        }
        if (SecurityUtil::checkPermission($this->name . '::', '::', ACCESS_ADMIN)) {
            $links[] = array('url' => ModUtil::url($this->name, 'admin', 'config'),
                             'text' => $this->__('Configuration'),
                             'title' => $this->__('Manage settings for this application'));
        }

        return $links;
    }
}
