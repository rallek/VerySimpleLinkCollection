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
 * The verysimplelinkcollectionGetListEntry modifier displays the name
 * or names for a given list item.
 *
 * @param string $value      The dropdown value to process.
 * @param string $objectType The treated object type.
 * @param string $fieldName  The list field's name.
 * @param string $delimiter  String used as separator for multiple selections.
 *
 * @return string List item name.
 */
function smarty_modifier_verysimplelinkcollectionGetListEntry($value, $objectType = '', $fieldName = '', $delimiter = ', ')
{
    if (empty($value) || empty($objectType) || empty($fieldName)) {
        return $value;
    }

    $serviceManager = ServiceUtil::getManager();
    $helper = new VerySimpleLinkCollection_Util_ListEntries($serviceManager);

    return $helper->resolve($value, $objectType, $fieldName, $delimiter);
}
