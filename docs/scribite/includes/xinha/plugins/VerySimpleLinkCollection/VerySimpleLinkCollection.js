// VerySimpleLinkCollection plugin for Xinha
// developed by Ralf Koester
//
// requires VerySimpleLinkCollection module (http://support.zikula.de)
//
// Distributed under the same terms as xinha itself.
// This notice MUST stay intact for use (see license.txt).

'use strict';

function VerySimpleLinkCollection(editor) {
    var cfg, self;

    this.editor = editor;
    cfg = editor.config;
    self = this;

    cfg.registerButton({
        id       : 'VerySimpleLinkCollection',
        tooltip  : 'Insert VerySimpleLinkCollection object',
     // image    : _editor_url + 'plugins/VerySimpleLinkCollection/img/ed_VerySimpleLinkCollection.gif',
        image    : '/images/icons/extrasmall/favorites.png',
        textMode : false,
        action   : function (editor) {
            var url = Zikula.Config.baseURL + 'index.php'/*Zikula.Config.entrypoint*/ + '?module=VerySimpleLinkCollection&type=external&func=finder&editor=xinha';
            VerySimpleLinkCollectionFinderXinha(editor, url);
        }
    });
    cfg.addToolbarElement('VerySimpleLinkCollection', 'insertimage', 1);
}

VerySimpleLinkCollection._pluginInfo = {
    name          : 'VerySimpleLinkCollection for xinha',
    version       : '0.0.1',
    developer     : 'Ralf Koester',
    developer_url : 'http://support.zikula.de',
    sponsor       : 'ModuleStudio 0.6.2',
    sponsor_url   : 'http://modulestudio.de',
    license       : 'htmlArea'
};
