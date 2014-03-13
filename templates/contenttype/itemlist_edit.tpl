{* Purpose of this template: edit view of generic item list content type *}
<div class="z-formrow">
    {gt text='Object type' domain='module_verysimplelinkcollection' assign='objectTypeSelectorLabel'}
    {formlabel for='verySimpleLinkCollectionObjectType' text=$objectTypeSelectorLabel}
        {verysimplelinkcollectionObjectTypeSelector assign='allObjectTypes'}
        {formdropdownlist id='verySimpleLinkCollectionOjectType' dataField='objectType' group='data' mandatory=true items=$allObjectTypes}
        <span class="z-sub z-formnote">{gt text='If you change this please save the element once to reload the parameters below.' domain='module_verysimplelinkcollection'}</span>
</div>

{formvolatile}
{if $properties ne null && is_array($properties)}
    {nocache}
    {foreach key='registryId' item='registryCid' from=$registries}
        {assign var='propName' value=''}
        {foreach key='propertyName' item='propertyId' from=$properties}
            {if $propertyId eq $registryId}
                {assign var='propName' value=$propertyName}
            {/if}
        {/foreach}
        <div class="z-formrow">
            {modapifunc modname='VerySimpleLinkCollection' type='category' func='hasMultipleSelection' ot=$objectType registry=$propertyName assign='hasMultiSelection'}
            {gt text='Category' domain='module_verysimplelinkcollection' assign='categorySelectorLabel'}
            {assign var='selectionMode' value='single'}
            {if $hasMultiSelection eq true}
                {gt text='Categories' domain='module_verysimplelinkcollection' assign='categorySelectorLabel'}
                {assign var='selectionMode' value='multiple'}
            {/if}
            {formlabel for="verySimpleLinkCollectionCatIds`$propertyName`" text=$categorySelectorLabel}
                {formdropdownlist id="verySimpleLinkCollectionCatIds`$propName`" items=$categories.$propName dataField="catids`$propName`" group='data' selectionMode=$selectionMode}
                <span class="z-sub z-formnote">{gt text='This is an optional filter.' domain='module_verysimplelinkcollection'}</span>
        </div>
    {/foreach}
    {/nocache}
{/if}
{/formvolatile}

<div class="z-formrow">
    {gt text='Sorting' domain='module_verysimplelinkcollection' assign='sortingLabel'}
    {formlabel text=$sortingLabel}
    <div>
        {formradiobutton id='verySimpleLinkCollectionSortRandom' value='random' dataField='sorting' group='data' mandatory=true}
        {gt text='Random' domain='module_verysimplelinkcollection' assign='sortingRandomLabel'}
        {formlabel for='verySimpleLinkCollectionSortRandom' text=$sortingRandomLabel}
        {formradiobutton id='verySimpleLinkCollectionSortNewest' value='newest' dataField='sorting' group='data' mandatory=true}
        {gt text='Newest' domain='module_verysimplelinkcollection' assign='sortingNewestLabel'}
        {formlabel for='verySimpleLinkCollectionSortNewest' text=$sortingNewestLabel}
        {formradiobutton id='verySimpleLinkCollectionSortDefault' value='default' dataField='sorting' group='data' mandatory=true}
        {gt text='Default' domain='module_verysimplelinkcollection' assign='sortingDefaultLabel'}
        {formlabel for='verySimpleLinkCollectionSortDefault' text=$sortingDefaultLabel}
    </div>
</div>

<div class="z-formrow">
    {gt text='Amount' domain='module_verysimplelinkcollection' assign='amountLabel'}
    {formlabel for='verySimpleLinkCollectionAmount' text=$amountLabel}
        {formintinput id='verySimpleLinkCollectionAmount' dataField='amount' group='data' mandatory=true maxLength=2}
</div>

<div class="z-formrow">
    {gt text='Template' domain='module_verysimplelinkcollection' assign='templateLabel'}
    {formlabel for='verySimpleLinkCollectionTemplate' text=$templateLabel}
        {verysimplelinkcollectionTemplateSelector assign='allTemplates'}
        {formdropdownlist id='verySimpleLinkCollectionTemplate' dataField='template' group='data' mandatory=true items=$allTemplates}
</div>

<div id="customTemplateArea" class="z-formrow z-hide">
    {gt text='Custom template' domain='module_verysimplelinkcollection' assign='customTemplateLabel'}
    {formlabel for='verySimpleLinkCollectionCustomTemplate' text=$customTemplateLabel}
        {formtextinput id='verySimpleLinkCollectionCustomTemplate' dataField='customTemplate' group='data' mandatory=false maxLength=80}
        <span class="z-sub z-formnote">{gt text='Example' domain='module_verysimplelinkcollection'}: <em>itemlist_[objectType]_display.tpl</em></span>
</div>

<div class="z-formrow z-hide">
    {gt text='Filter (expert option)' domain='module_verysimplelinkcollection' assign='filterLabel'}
    {formlabel for='verySimpleLinkCollectionFilter' text=$filterLabel}
        {formtextinput id='verySimpleLinkCollectionFilter' dataField='filter' group='data' mandatory=false maxLength=255}
        <span class="z-sub z-formnote">
            ({gt text='Syntax examples'}: <kbd>name:like:foobar</kbd> {gt text='or'} <kbd>status:ne:3</kbd>)
        </span>
</div>

{pageaddvar name='javascript' value='prototype'}
<script type="text/javascript">
/* <![CDATA[ */
    function vslcToggleCustomTemplate() {
        if ($F('verySimpleLinkCollectionTemplate') == 'custom') {
            $('customTemplateArea').removeClassName('z-hide');
        } else {
            $('customTemplateArea').addClassName('z-hide');
        }
    }

    document.observe('dom:loaded', function() {
        vslcToggleCustomTemplate();
        $('verySimpleLinkCollectionTemplate').observe('change', function(e) {
            vslcToggleCustomTemplate();
        });
    });
/* ]]> */
</script>
