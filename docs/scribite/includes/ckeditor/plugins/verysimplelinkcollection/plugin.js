CKEDITOR.plugins.add('VerySimpleLinkCollection', {
    requires: 'popup',
    lang: 'en,nl,de',
    init: function (editor) {
        editor.addCommand('insertVerySimpleLinkCollection', {
            exec: function (editor) {
                var url = Zikula.Config.baseURL + Zikula.Config.entrypoint + '?module=VerySimpleLinkCollection&type=external&func=finder&editor=ckeditor';
                // call method in VerySimpleLinkCollection_Finder.js and also give current editor
                VerySimpleLinkCollectionFinderCKEditor(editor, url);
            }
        });
        editor.ui.addButton('verysimplelinkcollection', {
            label: 'Insert VerySimpleLinkCollection object',
            command: 'insertVerySimpleLinkCollection',
         // icon: this.path + 'images/ed_verysimplelinkcollection.png'
            icon: '/images/icons/extrasmall/favorites.png'
        });
    }
});
