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
 * Event handler implementation class for module installer events.
 */
class VerySimpleLinkCollection_Listener_Installer extends VerySimpleLinkCollection_Listener_Base_Installer
{
    /**
     * Listener for the `installer.module.installed` event.
     *
     * Called after a module has been successfully installed.
     * Receives `$modinfo` as args.
     *
     * @param Zikula_Event $event The event instance.
     */
    public static function moduleInstalled(Zikula_Event $event)
    {
        parent::moduleInstalled($event);
    }
    
    /**
     * Listener for the `installer.module.upgraded` event.
     *
     * Called after a module has been successfully upgraded.
     * Receives `$modinfo` as args.
     *
     * @param Zikula_Event $event The event instance.
     */
    public static function moduleUpgraded(Zikula_Event $event)
    {
        parent::moduleUpgraded($event);
    }
    
    /**
     * Listener for the `installer.module.uninstalled` event.
     *
     * Called after a module has been successfully uninstalled.
     * Receives `$modinfo` as args.
     *
     * @param Zikula_Event $event The event instance.
     */
    public static function moduleUninstalled(Zikula_Event $event)
    {
        parent::moduleUninstalled($event);
    }
    
    /**
     * Listener for the `installer.subscriberarea.uninstalled` event.
     *
     * Called after a hook subscriber area has been unregistered.
     * Receives args['areaid'] as the areaId. Use this to remove orphan data associated with this area.
     *
     * @param Zikula_Event $event The event instance.
     */
    public static function subscriberAreaUninstalled(Zikula_Event $event)
    {
        parent::subscriberAreaUninstalled($event);
    }
}