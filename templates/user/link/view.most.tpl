{* purpose of this template: links view view in user area *}
{include file='user/header.tpl'}
<div class="verysimplelinkcollection-link verysimplelinkcollection-view">
    {gt text='Link list' assign='templateTitle'}
    {pagesetvar name='title' value=$templateTitle}
    <h2>{$templateTitle}</h2>

    {if $canBeCreated}
        {checkpermissionblock component='VerySimpleLinkCollection:Link:' instance='::' level='ACCESS_COMMENT'}
            {gt text='Create link' assign='createTitle'}
            <a href="{modurl modname='VerySimpleLinkCollection' type='user' func='edit' ot='link'}" title="{$createTitle}" class="z-icon-es-add">{$createTitle}</a>
        {/checkpermissionblock}
    {/if}
    {assign var='own' value=0}
    {if isset($showOwnEntries) && $showOwnEntries eq 1}
        {assign var='own' value=1}
    {/if}
    {assign var='all' value=0}
    {if isset($showAllEntries) && $showAllEntries eq 1}
        {gt text='Back to paginated view' assign='linkTitle'}
        <a href="{modurl modname='VerySimpleLinkCollection' type='user' func='view' ot='link'}" title="{$linkTitle}" class="z-icon-es-view">
            {$linkTitle}
        </a>
        {assign var='all' value=1}
    {else}
        {gt text='Show all entries' assign='linkTitle'}
        <a href="{modurl modname='VerySimpleLinkCollection' type='user' func='view' ot='link' all=1}" title="{$linkTitle}" class="z-icon-es-view">{$linkTitle}</a>
    {/if}

    {include file='user/link/view_quickNav.tpl' all=$all own=$own}{* see template file for available options *}

    <table class="z-datatable">
        <colgroup>
            <col id="cWorkflowState" />
            <col id="cLinkName" />
            <col id="cLinkText" />
            <col id="cLinkUrl" />
            <col id="cItemActions" />
        </colgroup>
        <thead>
        <tr>
            {assign var='catIdListMainString' value=','|implode:$catIdList.Main}
            <th id="hWorkflowState" scope="col" class="z-left">
                {sortlink __linktext='State' currentsort=$sort modname='VerySimpleLinkCollection' type='user' func='view' ot='link' sort='workflowState' sortdir=$sdir all=$all own=$own catidMain=$catIdListMainString workflowState=$workflowState searchterm=$searchterm pageSize=$pageSize}
            </th>
            <th id="hLinkName" scope="col" class="z-left">
                {sortlink __linktext='Link name' currentsort=$sort modname='VerySimpleLinkCollection' type='user' func='view' ot='link' sort='linkName' sortdir=$sdir all=$all own=$own catidMain=$catIdListMainString workflowState=$workflowState searchterm=$searchterm pageSize=$pageSize}
            </th>
            <th id="hLinkText" scope="col" class="z-left">
                {sortlink __linktext='Link text' currentsort=$sort modname='VerySimpleLinkCollection' type='user' func='view' ot='link' sort='linkText' sortdir=$sdir all=$all own=$own catidMain=$catIdListMainString workflowState=$workflowState searchterm=$searchterm pageSize=$pageSize}
            </th>
            <th id="hLinkUrl" scope="col" class="z-left">
                {sortlink __linktext='Link url' currentsort=$sort modname='VerySimpleLinkCollection' type='user' func='view' ot='link' sort='linkUrl' sortdir=$sdir all=$all own=$own catidMain=$catIdListMainString workflowState=$workflowState searchterm=$searchterm pageSize=$pageSize}
            </th>
            <th id="hItemActions" scope="col" class="z-right z-order-unsorted">{gt text='Actions'}</th>
        </tr>
        </thead>
        <tbody>
    
    {foreach item='link' from=$items}
        <tr class="{cycle values='z-odd, z-even'}">
            <td headers="hWorkflowState" class="z-left z-nowrap">
                {$link.workflowState|verysimplelinkcollectionObjectState}
            </td>
            <td headers="hLinkName" class="z-left">
                {$link.linkName}
            </td>
            <td headers="hLinkText" class="z-left">
                {$link.linkText}
            </td>
            <td headers="hLinkUrl" class="z-left">
                <a href="{$link.linkUrl}" title="{gt text='Visit this page'}">{icon type='url' size='extrasmall' __alt='Homepage'}</a>
            </td>
            <td id="itemActions{$link.id}" headers="hItemActions" class="z-right z-nowrap z-w02">
                {if count($link._actions) gt 0}
                    {foreach item='option' from=$link._actions}
                        <a href="{$option.url.type|verysimplelinkcollectionActionUrl:$option.url.func:$option.url.arguments}" title="{$option.linkTitle|safetext}"{if $option.icon eq 'preview'} target="_blank"{/if}>{icon type=$option.icon size='extrasmall' alt=$option.linkText|safetext}</a>
                    {/foreach}
                    {icon id="itemActions`$link.id`Trigger" type='options' size='extrasmall' __alt='Actions' class='z-pointer z-hide'}
                    <script type="text/javascript">
                    /* <![CDATA[ */
                        document.observe('dom:loaded', function() {
                            vslcInitItemActions('link', 'view', 'itemActions{{$link.id}}');
                        });
                    /* ]]> */
                    </script>
                {/if}
            </td>
        </tr>
    {foreachelse}
        <tr class="z-datatableempty">
          <td class="z-left" colspan="5">
        {gt text='No links found.'}
          </td>
        </tr>
    {/foreach}
    
        </tbody>
    </table>
    
    {if !isset($showAllEntries) || $showAllEntries ne 1}
        {pager rowcount=$pager.numitems limit=$pager.itemsperpage display='page' modname='VerySimpleLinkCollection' type='user' func='view' ot='link'}
    {/if}

    
    {notifydisplayhooks eventname='verysimplelinkcollection.ui_hooks.links.display_view' urlobject=$currentUrlObject assign='hooks'}
    {foreach key='providerArea' item='hook' from=$hooks}
        {$hook}
    {/foreach}
</div>
{include file='user/footer.tpl'}
