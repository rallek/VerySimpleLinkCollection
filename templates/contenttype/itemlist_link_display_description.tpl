{* Purpose of this template: Display links within an external context *}
<dl>
    {foreach item='link' from=$items}
        <dt>{$link->getTitleFromDisplayPattern()}</dt>
        {if $link.linkName}
            <dd>{$link.linkName|strip_tags|truncate:200:'&hellip;'}</dd>
        {/if}
        <dd><a href="{modurl modname='VerySimpleLinkCollection' type='user' func='display' ot=$objectType id=$link.id}">{gt text='Read more'}</a>
        </dd>
    {foreachelse}
        <dt>{gt text='No entries found.'}</dt>
    {/foreach}
</dl>
