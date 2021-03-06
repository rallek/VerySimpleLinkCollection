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
 * @version Generated by ModuleStudio 0.6.2 (http://modulestudio.de) at Sun Mar 16 16:48:11 CET 2014.
 */

/**
 * Version information base class.
 */
class VerySimpleLinkCollection_Base_Version extends Zikula_AbstractVersion
{
    /**
     * Retrieves meta data information for this application.
     *
     * @return array List of meta data.
     */
    public function getMetaData()
    {
        $meta = array();
        // the current module version
        $meta['version']              = '0.0.1';
        // the displayed name of the module
        $meta['displayname']          = $this->__('Very simple link collection');
        // the module description
        $meta['description']          = $this->__('Very simple link collection module generated by ModuleStudio 0.6.2.');
        //! url version of name, should be in lowercase without space
        $meta['url']                  = $this->__('verysimplelinkcollection');
        // core requirement
        $meta['core_min']             = '1.3.5'; // requires minimum 1.3.5
        $meta['core_max']             = '1.3.99'; // not ready for 1.4.0 yet

        // define special capabilities of this module
        $meta['capabilities'] = array(
                          HookUtil::SUBSCRIBER_CAPABLE => array('enabled' => true)/*,
                          HookUtil::PROVIDER_CAPABLE => array('enabled' => true), // TODO: see #15
                          'authentication' => array('version' => '1.0'),
                          'profile'        => array('version' => '1.0', 'anotherkey' => 'anothervalue'),
                          'message'        => array('version' => '1.0', 'anotherkey' => 'anothervalue')
*/
        );

        // permission schema
        $meta['securityschema'] = array(
            'VerySimpleLinkCollection::' => '::',
            'VerySimpleLinkCollection::Ajax' => '::',
            'VerySimpleLinkCollection:ItemListBlock:' => 'Block title::',
            'VerySimpleLinkCollection:ModerationBlock:' => 'Block title::',
            'VerySimpleLinkCollection:Link:' => 'Link ID::',
        );
        // DEBUG: permission schema aspect ends


        return $meta;
    }

    /**
     * Define hook subscriber bundles.
     */
    protected function setupHookBundles()
    {
        
        $bundle = new Zikula_HookManager_SubscriberBundle($this->name, 'subscriber.verysimplelinkcollection.ui_hooks.links', 'ui_hooks', __('verysimplelinkcollection Links Display Hooks'));
        
        // Display hook for view/display templates.
        $bundle->addEvent('display_view', 'verysimplelinkcollection.ui_hooks.links.display_view');
        // Display hook for create/edit forms.
        $bundle->addEvent('form_edit', 'verysimplelinkcollection.ui_hooks.links.form_edit');
        // Display hook for delete dialogues.
        $bundle->addEvent('form_delete', 'verysimplelinkcollection.ui_hooks.links.form_delete');
        // Validate input from an ui create/edit form.
        $bundle->addEvent('validate_edit', 'verysimplelinkcollection.ui_hooks.links.validate_edit');
        // Validate input from an ui create/edit form (generally not used).
        $bundle->addEvent('validate_delete', 'verysimplelinkcollection.ui_hooks.links.validate_delete');
        // Perform the final update actions for a ui create/edit form.
        $bundle->addEvent('process_edit', 'verysimplelinkcollection.ui_hooks.links.process_edit');
        // Perform the final delete actions for a ui form.
        $bundle->addEvent('process_delete', 'verysimplelinkcollection.ui_hooks.links.process_delete');
        $this->registerHookSubscriberBundle($bundle);

        $bundle = new Zikula_HookManager_SubscriberBundle($this->name, 'subscriber.verysimplelinkcollection.filter_hooks.links', 'filter_hooks', __('verysimplelinkcollection Links Filter Hooks'));
        // A filter applied to the given area.
        $bundle->addEvent('filter', 'verysimplelinkcollection.filter_hooks.links.filter');
        $this->registerHookSubscriberBundle($bundle);

        
    }
}
