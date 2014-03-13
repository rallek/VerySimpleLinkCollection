{* purpose of this template: build the Form to edit an instance of link *}
{include file='user/header.tpl'}
{pageaddvar name='javascript' value='modules/VerySimpleLinkCollection/javascript/VerySimpleLinkCollection_editFunctions.js'}
{pageaddvar name='javascript' value='modules/VerySimpleLinkCollection/javascript/VerySimpleLinkCollection_validation.js'}

{if $mode eq 'edit'}
    {gt text='Edit link' assign='templateTitle'}
{elseif $mode eq 'create'}
    {gt text='Create link' assign='templateTitle'}
{else}
    {gt text='Edit link' assign='templateTitle'}
{/if}
<div class="verysimplelinkcollection-link verysimplelinkcollection-edit">
    {pagesetvar name='title' value=$templateTitle}
    <h2>{$templateTitle}</h2>
{form cssClass='z-form'}
    {* add validation summary and a <div> element for styling the form *}
    {verysimplelinkcollectionFormFrame}
    {formsetinitialfocus inputId='linkName'}

    <fieldset>
        <legend>{gt text='Content'}</legend>
        
        <div class="z-formrow">
            {formlabel for='linkName' __text='Link name' mandatorysym='1' cssClass=''}
            {formtextinput group='link' id='linkName' mandatory=true readOnly=false __title='Enter the link name of the link' textMode='singleline' maxLength=255 cssClass='required' }
            {verysimplelinkcollectionValidationError id='linkName' class='required'}
        </div>
        
        <div class="z-formrow">
            {formlabel for='linkText' __text='Link text' cssClass=''}
            {formtextinput group='link' id='linkText' mandatory=false __title='Enter the link text of the link' textMode='multiline' rows='6' cols='50' cssClass='' }
        </div>
        
        <div class="z-formrow">
            {formlabel for='linkUrl' __text='Link url' mandatorysym='1' cssClass=''}
            {formurlinput group='link' id='linkUrl' mandatory=true readOnly=false __title='Enter the link url of the link' textMode='singleline' maxLength=255 cssClass='required validate-url' }
            {verysimplelinkcollectionValidationError id='linkUrl' class='required'}
            {verysimplelinkcollectionValidationError id='linkUrl' class='validate-url'}
        </div>
    </fieldset>
    
    {include file='user/include_categories_edit.tpl' obj=$link groupName='linkObj'}
    {if $mode ne 'create'}
        {include file='user/include_standardfields_edit.tpl' obj=$link}
    {/if}
    
    {* include display hooks *}
    {if $mode ne 'create'}
        {assign var='hookId' value=$link.id}
        {notifydisplayhooks eventname='verysimplelinkcollection.ui_hooks.links.form_edit' id=$hookId assign='hooks'}
    {else}
        {notifydisplayhooks eventname='verysimplelinkcollection.ui_hooks.links.form_edit' id=null assign='hooks'}
    {/if}
    {if is_array($hooks) && count($hooks)}
        {foreach key='providerArea' item='hook' from=$hooks}
            <fieldset>
                {$hook}
            </fieldset>
        {/foreach}
    {/if}
    
    {* include return control *}
    {if $mode eq 'create'}
        <fieldset>
            <legend>{gt text='Return control'}</legend>
            <div class="z-formrow">
                {formlabel for='repeatCreation' __text='Create another item after save'}
                    {formcheckbox group='link' id='repeatCreation' readOnly=false}
            </div>
        </fieldset>
    {/if}
    
    {* include possible submit actions *}
    <div class="z-buttons z-formbuttons">
    {foreach item='action' from=$actions}
        {assign var='actionIdCapital' value=$action.id|@ucwords}
        {gt text=$action.title assign='actionTitle'}
        {*gt text=$action.description assign='actionDescription'*}{* TODO: formbutton could support title attributes *}
        {if $action.id eq 'delete'}
            {gt text='Really delete this link?' assign='deleteConfirmMsg'}
            {formbutton id="btn`$actionIdCapital`" commandName=$action.id text=$actionTitle class=$action.buttonClass confirmMessage=$deleteConfirmMsg}
        {else}
            {formbutton id="btn`$actionIdCapital`" commandName=$action.id text=$actionTitle class=$action.buttonClass}
        {/if}
    {/foreach}
        {formbutton id='btnCancel' commandName='cancel' __text='Cancel' class='z-bt-cancel'}
    </div>
    {/verysimplelinkcollectionFormFrame}
{/form}
</div>
{include file='user/footer.tpl'}

{icon type='edit' size='extrasmall' assign='editImageArray'}
{icon type='delete' size='extrasmall' assign='removeImageArray'}


<script type="text/javascript">
/* <![CDATA[ */

    var formButtons, formValidator;

    function handleFormButton (event) {
        var result = formValidator.validate();
        if (!result) {
            // validation error, abort form submit
            Event.stop(event);
        } else {
            // hide form buttons to prevent double submits by accident
            formButtons.each(function (btn) {
                btn.addClassName('z-hide');
            });
        }

        return result;
    }

    document.observe('dom:loaded', function() {

        vslcAddCommonValidationRules('link', '{{if $mode ne 'create'}}{{$link.id}}{{/if}}');
        {{* observe validation on button events instead of form submit to exclude the cancel command *}}
        formValidator = new Validation('{{$__formid}}', {onSubmit: false, immediate: true, focusOnError: false});
        {{if $mode ne 'create'}}
            var result = formValidator.validate();
        {{/if}}

        formButtons = $('{{$__formid}}').select('div.z-formbuttons input');

        formButtons.each(function (elem) {
            if (elem.id != 'btnCancel') {
                elem.observe('click', handleFormButton);
            }
        });

        Zikula.UI.Tooltips($$('.verysimplelinkcollection-form-tooltips'));
    });

/* ]]> */
</script>
