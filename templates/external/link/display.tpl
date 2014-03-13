{* Purpose of this template: Display one certain link within an external context *}
<div id="link{$link.id}" class="verysimplelinkcollection-external-link">
{if $displayMode eq 'link'}
    <p class="verysimplelinkcollection-external-link">
    <a href="{modurl modname='VerySimpleLinkCollection' type='user' func='display' ot='link' id=$link.id}" title="{$link->getTitleFromDisplayPattern()|replace:"\"":""}">
    {$link->getTitleFromDisplayPattern()|notifyfilters:'verysimplelinkcollection.filter_hooks.links.filter'}
    </a>
    </p>
{/if}
{checkpermissionblock component='VerySimpleLinkCollection::' instance='::' level='ACCESS_EDIT'}
    {if $displayMode eq 'embed'}
        <p class="verysimplelinkcollection-external-title">
            <strong>{$link->getTitleFromDisplayPattern()|notifyfilters:'verysimplelinkcollection.filter_hooks.links.filter'}</strong>
        </p>
    {/if}
{/checkpermissionblock}

{if $displayMode eq 'link'}
{elseif $displayMode eq 'embed'}
    <div class="verysimplelinkcollection-external-snippet">
        &nbsp;
    </div>

    {* you can distinguish the context like this: *}
    {*if $source eq 'contentType'}
        ...
    {elseif $source eq 'scribite'}
        ...
    {/if*}

    {* you can enable more details about the item: *}
    {*
        <p class="verysimplelinkcollection-external-description">
            {if $link.linkName ne ''}{$link.linkName}<br />{/if}
            {assignedcategorieslist categories=$link.categories doctrine2=true}
        </p>
    *}
{/if}
</div>
