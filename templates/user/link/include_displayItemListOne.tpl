{* purpose of this template: inclusion template for display of related links in user area *}
{checkpermission component='VerySimpleLinkCollection:Link:' instance='::' level='ACCESS_COMMENT' assign='hasAdminPermission'}
{checkpermission component='VerySimpleLinkCollection:Link:' instance='::' level='ACCESS_COMMENT' assign='hasEditPermission'}
{if !isset($nolink)}
    {assign var='nolink' value=false}
{/if}
<h4>
{strip}
{if !$nolink}
    <a href="{modurl modname='VerySimpleLinkCollection' type='user' func='display' ot='link' id=$item.id}" title="{$item->getTitleFromDisplayPattern()|replace:"\"":""}">
{/if}
    {$item->getTitleFromDisplayPattern()}
{if !$nolink}
    </a>
    <a id="linkItem{$item.id}Display" href="{modurl modname='VerySimpleLinkCollection' type='user' func='display' ot='link' id=$item.id theme='Printer' forcelongurl=true}" title="{gt text='Open quick view window'}" class="z-hide">{icon type='view' size='extrasmall' __alt='Quick view'}</a>
{/if}
{/strip}
</h4>
{if !$nolink}
<script type="text/javascript">
/* <![CDATA[ */
    document.observe('dom:loaded', function() {
        vslcInitInlineWindow($('linkItem{{$item.id}}Display'), '{{$item->getTitleFromDisplayPattern()|replace:"'":""}}');
    });
/* ]]> */
</script>
{/if}
