{* purpose of this template: links display view in admin area *}
{include file='admin/header.tpl'}
<div class="verysimplelinkcollection-link verysimplelinkcollection-display">
    {gt text='Link' assign='templateTitle'}
    {assign var='templateTitle' value=$link->getTitleFromDisplayPattern()|default:$templateTitle}
    {pagesetvar name='title' value=$templateTitle|@html_entity_decode}
    <div class="z-admin-content-pagetitle">
        {icon type='display' size='small' __alt='Details'}
        <h3>{$templateTitle|notifyfilters:'verysimplelinkcollection.filter_hooks.links.filter'} <small>({$link.workflowState|verysimplelinkcollectionObjectState:false|lower})</small>{icon id='itemActionsTrigger' type='options' size='extrasmall' __alt='Actions' class='z-pointer z-hide'}</h3>
    </div>

    <dl>
        <dt>{gt text='State'}</dt>
        <dd>{$link.workflowState|verysimplelinkcollectionGetListEntry:'link':'workflowState'|safetext}</dd>
        <dt>{gt text='Link name'}</dt>
        <dd>{$link.linkName}</dd>
        <dt>{gt text='Link text'}</dt>
        <dd>{$link.linkText}</dd>
        <dt>{gt text='Link u r l'}</dt>
        <dd>{if !isset($smarty.get.theme) || $smarty.get.theme ne 'Printer'}
        <a href="{$link.linkURL}" title="{gt text='Visit this page'}">{icon type='url' size='extrasmall' __alt='Homepage'}</a>
        {else}
          {$link.linkURL}
        {/if}
        </dd>
        
    </dl>
    {include file='admin/include_categories_display.tpl' obj=$link}
    {include file='admin/include_standardfields_display.tpl' obj=$link}

    {if !isset($smarty.get.theme) || $smarty.get.theme ne 'Printer'}
        {* include display hooks *}
        {notifydisplayhooks eventname='verysimplelinkcollection.ui_hooks.links.display_view' id=$link.id urlobject=$currentUrlObject assign='hooks'}
        {foreach key='providerArea' item='hook' from=$hooks}
            {$hook}
        {/foreach}
        {if count($link._actions) gt 0}
            <p id="itemActions">
            {foreach item='option' from=$link._actions}
                <a href="{$option.url.type|verysimplelinkcollectionActionUrl:$option.url.func:$option.url.arguments}" title="{$option.linkTitle|safetext}" class="z-icon-es-{$option.icon}">{$option.linkText|safetext}</a>
            {/foreach}
            </p>
            <script type="text/javascript">
            /* <![CDATA[ */
                document.observe('dom:loaded', function() {
                    vslcInitItemActions('link', 'display', 'itemActions');
                });
            /* ]]> */
            </script>
        {/if}
    {/if}
</div>
{include file='admin/footer.tpl'}
