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

use Doctrine\ORM\Mapping as ORM;

/**
 * Entity extension domain class storing link categories.
 *
 * This is the concrete category class for link entities.
* @ORM\Entity(repositoryClass="VerySimpleLinkCollection_Entity_Repository_LinkCategory")
   * @ORM\Table(name="vslc_link_category",
   *     uniqueConstraints={
   *         @ORM\UniqueConstraint(name="cat_unq", columns={"registryId", "categoryId", "entityId"})
   *     }
   * )
 */
class VerySimpleLinkCollection_Entity_LinkCategory extends VerySimpleLinkCollection_Entity_Base_LinkCategory
{
    // feel free to add your own methods here
}
