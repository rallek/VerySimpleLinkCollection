'use strict';

var currentVerySimpleLinkCollectionEditor = null;
var currentVerySimpleLinkCollectionInput = null;

/**
 * Returns the attributes used for the popup window. 
 * @return {String}
 */
function getPopupAttributes()
{
    var pWidth, pHeight;

    pWidth = screen.width * 0.75;
    pHeight = screen.height * 0.66;

    return 'width=' + pWidth + ',height=' + pHeight + ',scrollbars,resizable';
}

/**
 * Open a popup window with the finder triggered by a Xinha button.
 */
function VerySimpleLinkCollectionFinderXinha(editor, vslcURL)
{
    var popupAttributes;

    // Save editor for access in selector window
    currentVerySimpleLinkCollectionEditor = editor;

    popupAttributes = getPopupAttributes();
    window.open(vslcURL, '', popupAttributes);
}

/**
 * Open a popup window with the finder triggered by a CKEditor button.
 */
function VerySimpleLinkCollectionFinderCKEditor(editor, vslcURL)
{
    // Save editor for access in selector window
    currentVerySimpleLinkCollectionEditor = editor;

    editor.popup(
        Zikula.Config.baseURL + Zikula.Config.entrypoint + '?module=VerySimpleLinkCollection&type=external&func=finder&editor=ckeditor',
        /*width*/ '80%', /*height*/ '70%',
        'location=no,menubar=no,toolbar=no,dependent=yes,minimizable=no,modal=yes,alwaysRaised=yes,resizable=yes,scrollbars=yes'
    );
}



var verysimplelinkcollection = {};

verysimplelinkcollection.finder = {};

verysimplelinkcollection.finder.onLoad = function (baseId, selectedId)
{
    $$('div.categoryselector select').invoke('observe', 'change', verysimplelinkcollection.finder.onParamChanged);
    $('verySimpleLinkCollectionSort').observe('change', verysimplelinkcollection.finder.onParamChanged);
    $('verySimpleLinkCollectionSortDir').observe('change', verysimplelinkcollection.finder.onParamChanged);
    $('verySimpleLinkCollectionPageSize').observe('change', verysimplelinkcollection.finder.onParamChanged);
    $('verySimpleLinkCollectionSearchGo').observe('click', verysimplelinkcollection.finder.onParamChanged);
    $('verySimpleLinkCollectionSearchGo').observe('keypress', verysimplelinkcollection.finder.onParamChanged);
    $('verySimpleLinkCollectionSubmit').addClassName('z-hide');
    $('verySimpleLinkCollectionCancel').observe('click', verysimplelinkcollection.finder.handleCancel);
};

verysimplelinkcollection.finder.onParamChanged = function ()
{
    $('verySimpleLinkCollectionSelectorForm').submit();
};

verysimplelinkcollection.finder.handleCancel = function ()
{
    var editor, w;

    editor = $F('editorName');
    if (editor === 'xinha') {
        w = parent.window;
        window.close();
        w.focus();
    } else if (editor === 'tinymce') {
        vslcClosePopup();
    } else if (editor === 'ckeditor') {
        vslcClosePopup();
    } else {
        alert('Close Editor: ' + editor);
    }
};


function getPasteSnippet(mode, itemId)
{
    var itemUrl, itemTitle, itemDescription, pasteMode;

    itemUrl = $F('url' + itemId);
    itemTitle = $F('title' + itemId);
    itemDescription = $F('desc' + itemId);
    pasteMode = $F('verySimpleLinkCollectionPasteAs');

    if (pasteMode === '2' || pasteMode !== '1') {
        return itemId;
    }

    // return link to item
    if (mode === 'url') {
        // plugin mode
        return itemUrl;
    } else {
        // editor mode
        return '<a href="' + itemUrl + '" title="' + itemDescription + '">' + itemTitle + '</a>';
    }
}


// User clicks on "select item" button
verysimplelinkcollection.finder.selectItem = function (itemId)
{
    var editor, html;

    editor = $F('editorName');
    if (editor === 'xinha') {
        if (window.opener.currentVerySimpleLinkCollectionEditor !== null) {
            html = getPasteSnippet('html', itemId);

            window.opener.currentVerySimpleLinkCollectionEditor.focusEditor();
            window.opener.currentVerySimpleLinkCollectionEditor.insertHTML(html);
        } else {
            html = getPasteSnippet('url', itemId);
            var currentInput = window.opener.currentVerySimpleLinkCollectionInput;

            if (currentInput.tagName === 'INPUT') {
                // Simply overwrite value of input elements
                currentInput.value = html;
            } else if (currentInput.tagName === 'TEXTAREA') {
                // Try to paste into textarea - technique depends on environment
                if (typeof document.selection !== 'undefined') {
                    // IE: Move focus to textarea (which fortunately keeps its current selection) and overwrite selection
                    currentInput.focus();
                    window.opener.document.selection.createRange().text = html;
                } else if (typeof currentInput.selectionStart !== 'undefined') {
                    // Firefox: Get start and end points of selection and create new value based on old value
                    var startPos = currentInput.selectionStart;
                    var endPos = currentInput.selectionEnd;
                    currentInput.value = currentInput.value.substring(0, startPos)
                                        + html
                                        + currentInput.value.substring(endPos, currentInput.value.length);
                } else {
                    // Others: just append to the current value
                    currentInput.value += html;
                }
            }
        }
    } else if (editor === 'tinymce') {
        html = getPasteSnippet('html', itemId);
        window.opener.tinyMCE.activeEditor.execCommand('mceInsertContent', false, html);
        // other tinymce commands: mceImage, mceInsertLink, mceReplaceContent, see http://www.tinymce.com/wiki.php/Command_identifiers
    } else if (editor === 'ckeditor') {
        /** to be done*/
    } else {
        alert('Insert into Editor: ' + editor);
    }
    vslcClosePopup();
};


function vslcClosePopup()
{
    window.opener.focus();
    window.close();
}




//=============================================================================
// VerySimpleLinkCollection item selector for Forms
//=============================================================================

verysimplelinkcollection.itemSelector = {};
verysimplelinkcollection.itemSelector.items = {};
verysimplelinkcollection.itemSelector.baseId = 0;
verysimplelinkcollection.itemSelector.selectedId = 0;

verysimplelinkcollection.itemSelector.onLoad = function (baseId, selectedId)
{
    verysimplelinkcollection.itemSelector.baseId = baseId;
    verysimplelinkcollection.itemSelector.selectedId = selectedId;

    // required as a changed object type requires a new instance of the item selector plugin
    $('verySimpleLinkCollectionObjectType').observe('change', verysimplelinkcollection.itemSelector.onParamChanged);

    if ($(baseId + '_catidMain') != undefined) {
        $(baseId + '_catidMain').observe('change', verysimplelinkcollection.itemSelector.onParamChanged);
    } else if ($(baseId + '_catidsMain') != undefined) {
        $(baseId + '_catidsMain').observe('change', verysimplelinkcollection.itemSelector.onParamChanged);
    }
    $(baseId + 'Id').observe('change', verysimplelinkcollection.itemSelector.onItemChanged);
    $(baseId + 'Sort').observe('change', verysimplelinkcollection.itemSelector.onParamChanged);
    $(baseId + 'SortDir').observe('change', verysimplelinkcollection.itemSelector.onParamChanged);
    $('verySimpleLinkCollectionSearchGo').observe('click', verysimplelinkcollection.itemSelector.onParamChanged);
    $('verySimpleLinkCollectionSearchGo').observe('keypress', verysimplelinkcollection.itemSelector.onParamChanged);

    verysimplelinkcollection.itemSelector.getItemList();
};

verysimplelinkcollection.itemSelector.onParamChanged = function ()
{
    $('ajax_indicator').removeClassName('z-hide');

    verysimplelinkcollection.itemSelector.getItemList();
};

verysimplelinkcollection.itemSelector.getItemList = function ()
{
    var baseId, pars, request;

    baseId = verysimplelinkcollection.itemSelector.baseId;
    pars = 'ot=' + baseId + '&';
    if ($(baseId + '_catidMain') != undefined) {
        pars += 'catidMain=' + $F(baseId + '_catidMain') + '&';
    } else if ($(baseId + '_catidsMain') != undefined) {
        pars += 'catidsMain=' + $F(baseId + '_catidsMain') + '&';
    }
    pars += 'sort=' + $F(baseId + 'Sort') + '&' +
            'sortdir=' + $F(baseId + 'SortDir') + '&' +
            'searchterm=' + $F(baseId + 'SearchTerm');

    request = new Zikula.Ajax.Request(
        Zikula.Config.baseURL + 'ajax.php?module=VerySimpleLinkCollection&func=getItemListFinder',
        {
            method: 'post',
            parameters: pars,
            onFailure: function(req) {
                Zikula.showajaxerror(req.getMessage());
            },
            onSuccess: function(req) {
                var baseId;
                baseId = verysimplelinkcollection.itemSelector.baseId;
                verysimplelinkcollection.itemSelector.items[baseId] = req.getData();
                $('ajax_indicator').addClassName('z-hide');
                verysimplelinkcollection.itemSelector.updateItemDropdownEntries();
                verysimplelinkcollection.itemSelector.updatePreview();
            }
        }
    );
};

verysimplelinkcollection.itemSelector.updateItemDropdownEntries = function ()
{
    var baseId, itemSelector, items, i, item;

    baseId = verysimplelinkcollection.itemSelector.baseId;
    itemSelector = $(baseId + 'Id');
    itemSelector.length = 0;

    items = verysimplelinkcollection.itemSelector.items[baseId];
    for (i = 0; i < items.length; ++i) {
        item = items[i];
        itemSelector.options[i] = new Option(item.title, item.id, false);
    }

    if (verysimplelinkcollection.itemSelector.selectedId > 0) {
        $(baseId + 'Id').value = verysimplelinkcollection.itemSelector.selectedId;
    }
};

verysimplelinkcollection.itemSelector.updatePreview = function ()
{
    var baseId, items, selectedElement, i;

    baseId = verysimplelinkcollection.itemSelector.baseId;
    items = verysimplelinkcollection.itemSelector.items[baseId];

    $(baseId + 'PreviewContainer').addClassName('z-hide');

    if (items.length === 0) {
        return;
    }

    selectedElement = items[0];
    if (verysimplelinkcollection.itemSelector.selectedId > 0) {
        for (var i = 0; i < items.length; ++i) {
            if (items[i].id === verysimplelinkcollection.itemSelector.selectedId) {
                selectedElement = items[i];
                break;
            }
        }
    }

    if (selectedElement !== null) {
        $(baseId + 'PreviewContainer').update(window.atob(selectedElement.previewInfo))
                                      .removeClassName('z-hide');
    }
};

verysimplelinkcollection.itemSelector.onItemChanged = function ()
{
    var baseId, itemSelector, preview;

    baseId = verysimplelinkcollection.itemSelector.baseId;
    itemSelector = $(baseId + 'Id');
    preview = window.atob(verysimplelinkcollection.itemSelector.items[baseId][itemSelector.selectedIndex].previewInfo);

    $(baseId + 'PreviewContainer').update(preview);
    verysimplelinkcollection.itemSelector.selectedId = $F(baseId + 'Id');
};
