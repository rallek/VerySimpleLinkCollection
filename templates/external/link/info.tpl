{* Purpose of this template: Display item information for previewing from other modules *}
<dl id="link{$link.id}">
<dt>{$link->getTitleFromDisplayPattern()|notifyfilters:'verysimplelinkcollection.filter_hooks.links.filter'|htmlentities}</dt>
{if $link.linkName ne ''}<dd>{$link.linkName}</dd>{/if}
<dd>{assignedcategorieslist categories=$link.categories doctrine2=true}</dd>
</dl>
