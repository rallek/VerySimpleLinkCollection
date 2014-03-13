{* Purpose of this template: Display search options *}
<input type="hidden" id="verySimpleLinkCollectionActive" name="active[VerySimpleLinkCollection]" value="1" checked="checked" />
<div>
    <input type="checkbox" id="active_verySimpleLinkCollectionLinks" name="verySimpleLinkCollectionSearchTypes[]" value="link"{if $active_link} checked="checked"{/if} />
    <label for="active_verySimpleLinkCollectionLinks">{gt text='Links' domain='module_verysimplelinkcollection'}</label>
</div>
