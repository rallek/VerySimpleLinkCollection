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
 * This is the base category class for link entities.
 */
class VerySimpleLinkCollection_Entity_Base_LinkCategory extends Zikula_Doctrine2_Entity_EntityCategory
{
    /**
     * @ORM\ManyToOne(targetEntity="VerySimpleLinkCollection_Entity_Link", inversedBy="categories")
     * @ORM\JoinColumn(name="entityId", referencedColumnName="id")
     * @var VerySimpleLinkCollection_Entity_Link
     */
    protected $entity;

    /**
     * Get reference to owning entity.
     *
     * @return VerySimpleLinkCollection_Entity_Link
     */
    public function getEntity()
    {
        return $this->entity;
    }
    
    /**
     * Set reference to owning entity.
     *
     * @param VerySimpleLinkCollection_Entity_Link $entity
     */
    public function setEntity(/*VerySimpleLinkCollection_Entity_Link */$entity)
    {
        $this->entity = $entity;
    }
}
