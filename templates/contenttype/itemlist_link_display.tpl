{* Purpose of this template: Display links within an external context *}
{foreach item='link' from=$items}
    <h3>{$link->getTitleFromDisplayPattern()}</h3>
    <p><a href="{modurl modname='VerySimpleLinkCollection' type='user' func='display' ot=$objectType id=$link.id}">{gt text='Read more'}</a>
    </p>
{/foreach}
