{* purpose of this template: links view view in admin area *}
{include file='admin/header.tpl'}
<div class="verysimplelinkcollection-link verysimplelinkcollection-view">
    {gt text='Link list' assign='templateTitle'}
    {pagesetvar name='title' value=$templateTitle}
    <div class="z-admin-content-pagetitle">
        {icon type='view' size='small' alt=$templateTitle}
        <h3>{$templateTitle}</h3>
    </div>

    {if $canBeCreated}
        {checkpermissionblock component='VerySimpleLinkCollection:Link:' instance='::' level='ACCESS_COMMENT'}
            {gt text='Create link' assign='createTitle'}
            <a href="{modurl modname='VerySimpleLinkCollection' type='admin' func='edit' ot='link'}" title="{$createTitle}" class="z-icon-es-add">{$createTitle}</a>
        {/checkpermissionblock}
    {/if}
    {assign var='own' value=0}
    {if isset($showOwnEntries) && $showOwnEntries eq 1}
        {assign var='own' value=1}
    {/if}
    {assign var='all' value=0}
    {if isset($showAllEntries) && $showAllEntries eq 1}
        {gt text='Back to paginated view' assign='linkTitle'}
        <a href="{modurl modname='VerySimpleLinkCollection' type='admin' func='view' ot='link'}" title="{$linkTitle}" class="z-icon-es-view">
            {$linkTitle}
        </a>
        {assign var='all' value=1}
    {else}
        {gt text='Show all entries' assign='linkTitle'}
        <a href="{modurl modname='VerySimpleLinkCollection' type='admin' func='view' ot='link' all=1}" title="{$linkTitle}" class="z-icon-es-view">{$linkTitle}</a>
    {/if}

    {include file='admin/link/view_quickNav.tpl' all=$all own=$own}{* see template file for available options *}

    <form action="{modurl modname='VerySimpleLinkCollection' type='admin' func='handleSelectedEntries'}" method="post" id="linksViewForm" class="z-form">
        <div>
            <input type="hidden" name="csrftoken" value="{insert name='csrftoken'}" />
            <input type="hidden" name="ot" value="link" />
            <table class="z-datatable">
                <colgroup>
                    <col id="cSelect" />
                    <col id="cWorkflowState" />
                    <col id="cLinkName" />
                    <col id="cLinkText" />
                    <col id="cLinkURL" />
                    <col id="cItemActions" />
                </colgroup>
                <thead>
                <tr>
                    {assign var='catIdListMainString' value=','|implode:$catIdList.Main}
                    <th id="hSelect" scope="col" align="center" valign="middle">
                        <input type="checkbox" id="toggleLinks" />
                    </th>
                    <th id="hWorkflowState" scope="col" class="z-left">
                        {sortlink __linktext='State' currentsort=$sort modname='VerySimpleLinkCollection' type='admin' func='view' ot='link' sort='workflowState' sortdir=$sdir all=$all own=$own catidMain=$catIdListMainString workflowState=$workflowState searchterm=$searchterm pageSize=$pageSize}
                    </th>
                    <th id="hLinkName" scope="col" class="z-left">
                        {sortlink __linktext='Link name' currentsort=$sort modname='VerySimpleLinkCollection' type='admin' func='view' ot='link' sort='linkName' sortdir=$sdir all=$all own=$own catidMain=$catIdListMainString workflowState=$workflowState searchterm=$searchterm pageSize=$pageSize}
                    </th>
                    <th id="hLinkText" scope="col" class="z-left">
                        {sortlink __linktext='Link text' currentsort=$sort modname='VerySimpleLinkCollection' type='admin' func='view' ot='link' sort='linkText' sortdir=$sdir all=$all own=$own catidMain=$catIdListMainString workflowState=$workflowState searchterm=$searchterm pageSize=$pageSize}
                    </th>
                    <th id="hLinkURL" scope="col" class="z-left">
                        {sortlink __linktext='Link u r l' currentsort=$sort modname='VerySimpleLinkCollection' type='admin' func='view' ot='link' sort='linkURL' sortdir=$sdir all=$all own=$own catidMain=$catIdListMainString workflowState=$workflowState searchterm=$searchterm pageSize=$pageSize}
                    </th>
                    <th id="hItemActions" scope="col" class="z-right z-order-unsorted">{gt text='Actions'}</th>
                </tr>
                </thead>
                <tbody>
            
            {foreach item='link' from=$items}
                <tr class="{cycle values='z-odd, z-even'}">
                    <td headers="hselect" align="center" valign="top">
                        <input type="checkbox" name="items[]" value="{$link.id}" class="links-checkbox" />
                    </td>
                    <td headers="hWorkflowState" class="z-left z-nowrap">
                        {$link.workflowState|verysimplelinkcollectionObjectState}
                    </td>
                    <td headers="hLinkName" class="z-left">
                        {$link.linkName}
                    </td>
                    <td headers="hLinkText" class="z-left">
                        {$link.linkText}
                    </td>
                    <td headers="hLinkURL" class="z-left">
                        <a href="{$link.linkURL}" title="{gt text='Visit this page'}">{icon type='url' size='extrasmall' __alt='Homepage'}</a>
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
                <tr class="z-admintableempty">
                  <td class="z-left" colspan="6">
                {gt text='No links found.'}
                  </td>
                </tr>
            {/foreach}
            
                </tbody>
            </table>
            
            {if !isset($showAllEntries) || $showAllEntries ne 1}
                {pager rowcount=$pager.numitems limit=$pager.itemsperpage display='page' modname='VerySimpleLinkCollection' type='admin' func='view' ot='link'}
            {/if}
            <fieldset>
                <label for="verySimpleLinkCollectionAction">{gt text='With selected links'}</label>
                <select id="verySimpleLinkCollectionAction" name="action">
                    <option value="">{gt text='Choose action'}</option>
                <option value="approve" title="{gt text='Update content and approve for immediate publishing.'}">{gt text='Approve'}</option>
                    <option value="delete" title="{gt text='Delete content permanently.'}">{gt text='Delete'}</option>
                </select>
                <input type="submit" value="{gt text='Submit'}" />
            </fieldset>
        </div>
    </form>

</div>
{include file='admin/footer.tpl'}

<script type="text/javascript">
/* <![CDATA[ */
    document.observe('dom:loaded', function() {
    {{* init the "toggle all" functionality *}}
    if ($('toggleLinks') != undefined) {
        $('toggleLinks').observe('click', function (e) {
            Zikula.toggleInput('linksViewForm');
            e.stop()
        });
    }
    });
/* ]]> */
</script>
