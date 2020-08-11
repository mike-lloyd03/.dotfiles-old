"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const tslib_1 = require("tslib");
const path_1 = tslib_1.__importDefault(require("path"));
const events_1 = require("events");
const vscode_languageserver_types_1 = require("vscode-languageserver-types");
const commands_1 = tslib_1.__importDefault(require("./commands"));
const completion_1 = tslib_1.__importDefault(require("./completion"));
const cursors_1 = tslib_1.__importDefault(require("./cursors"));
const manager_1 = tslib_1.__importDefault(require("./diagnostic/manager"));
const extensions_1 = tslib_1.__importDefault(require("./extensions"));
const handler_1 = tslib_1.__importDefault(require("./handler"));
const languages_1 = tslib_1.__importDefault(require("./languages"));
const manager_2 = tslib_1.__importDefault(require("./list/manager"));
const services_1 = tslib_1.__importDefault(require("./services"));
const manager_3 = tslib_1.__importDefault(require("./snippets/manager"));
const sources_1 = tslib_1.__importDefault(require("./sources"));
const types_1 = require("./types");
const util_1 = require("./util");
const workspace_1 = tslib_1.__importDefault(require("./workspace"));
const logger = require('./util/logger')('plugin');
class Plugin extends events_1.EventEmitter {
    constructor(nvim) {
        super();
        this.nvim = nvim;
        this._ready = false;
        this.actions = new Map();
        Object.defineProperty(workspace_1.default, 'nvim', {
            get: () => this.nvim
        });
        this.cursors = new cursors_1.default(nvim);
        this.addMethod('hasProvider', (id) => this.handler.hasProvider(id));
        this.addMethod('getTagList', async () => await this.handler.getTagList());
        this.addMethod('hasSelected', () => completion_1.default.hasSelected());
        this.addMethod('listNames', () => manager_2.default.names);
        this.addMethod('search', (...args) => this.handler.search(args));
        this.addMethod('cursorsSelect', (bufnr, kind, mode) => this.cursors.select(bufnr, kind, mode));
        this.addMethod('codeActionRange', (start, end, only) => this.handler.codeActionRange(start, end, only));
        this.addMethod('getConfig', async (key) => {
            let document = await workspace_1.default.document;
            // eslint-disable-next-line id-blacklist
            return workspace_1.default.getConfiguration(key, document ? document.uri : undefined);
        });
        this.addMethod('rootPatterns', bufnr => {
            let doc = workspace_1.default.getDocument(bufnr);
            if (!doc)
                return null;
            return {
                buffer: workspace_1.default.getRootPatterns(doc, types_1.PatternType.Buffer),
                server: workspace_1.default.getRootPatterns(doc, types_1.PatternType.LanguageServer),
                global: workspace_1.default.getRootPatterns(doc, types_1.PatternType.Global)
            };
        });
        this.addMethod('installExtensions', async (...list) => {
            await extensions_1.default.installExtensions(list);
        });
        this.addMethod('saveRefactor', async (bufnr) => {
            await this.handler.saveRefactor(bufnr);
        });
        this.addMethod('updateExtensions', async (sync) => {
            await extensions_1.default.updateExtensions(sync);
        });
        this.addMethod('commandList', () => commands_1.default.commandList.map(o => o.id));
        this.addMethod('openList', async (...args) => {
            await this.ready;
            await manager_2.default.start(args);
        });
        this.addMethod('runCommand', async (...args) => {
            await this.ready;
            return await this.handler.runCommand(...args);
        });
        this.addMethod('selectSymbolRange', async (inner, visualmode, supportedSymbols) => await this.handler.selectSymbolRange(inner, visualmode, supportedSymbols));
        this.addMethod('listResume', () => manager_2.default.resume());
        this.addMethod('listPrev', () => manager_2.default.previous());
        this.addMethod('listNext', () => manager_2.default.next());
        this.addMethod('detach', () => workspace_1.default.detach());
        this.addMethod('sendRequest', (id, method, params) => services_1.default.sendRequest(id, method, params));
        this.addMethod('sendNotification', async (id, method, params) => {
            await services_1.default.sendNotification(id, method, params);
        });
        this.addMethod('registNotification', async (id, method) => {
            await services_1.default.registNotification(id, method);
        });
        this.addMethod('doAutocmd', async (id, ...args) => {
            let autocmd = workspace_1.default.autocmds.get(id);
            if (autocmd) {
                try {
                    await Promise.resolve(autocmd.callback.apply(autocmd.thisArg, args));
                }
                catch (e) {
                    logger.error(`Error on autocmd ${autocmd.event}`, e);
                    workspace_1.default.showMessage(`Error on autocmd ${autocmd.event}: ${e.message}`);
                }
            }
        });
        this.addMethod('updateConfig', (section, val) => {
            workspace_1.default.configurations.updateUserConfig({ [section]: val });
        });
        this.addMethod('snippetNext', async () => {
            await manager_3.default.nextPlaceholder();
            return '';
        });
        this.addMethod('snippetPrev', async () => {
            await manager_3.default.previousPlaceholder();
            return '';
        });
        this.addMethod('snippetCancel', () => {
            manager_3.default.cancel();
        });
        this.addMethod('openLocalConfig', async () => {
            await workspace_1.default.openLocalConfig();
        });
        this.addMethod('openLog', () => {
            let file = logger.getLogFile();
            nvim.call(`coc#util#open_url`, [file], true);
        });
        this.addMethod('doKeymap', async (key, defaultReturn = '') => {
            let [fn, repeat] = workspace_1.default.keymaps.get(key);
            if (!fn) {
                logger.error(`keymap for ${key} not found`);
                return defaultReturn;
            }
            let res = await Promise.resolve(fn());
            if (repeat)
                await nvim.command(`silent! call repeat#set("\\<Plug>(coc-${key})", -1)`);
            return res || defaultReturn;
        });
        this.addMethod('registExtensions', async (...folders) => {
            for (let folder of folders) {
                await extensions_1.default.loadExtension(folder);
            }
        });
        this.addMethod('snippetCheck', async (checkExpand, checkJump) => {
            if (checkExpand && !extensions_1.default.has('coc-snippets')) {
                console.error('coc-snippets required for check expand status!');
                return false;
            }
            if (checkJump) {
                let jumpable = manager_3.default.jumpable();
                if (jumpable)
                    return true;
            }
            if (checkExpand) {
                let api = extensions_1.default.getExtensionApi('coc-snippets');
                if (api && api.hasOwnProperty('expandable')) {
                    let expandable = await Promise.resolve(api.expandable());
                    if (expandable)
                        return true;
                }
            }
            return false;
        });
        this.addMethod('showInfo', async () => {
            if (!this.infoChannel) {
                this.infoChannel = workspace_1.default.createOutputChannel('info');
            }
            else {
                this.infoChannel.clear();
            }
            let channel = this.infoChannel;
            channel.appendLine('## versions');
            channel.appendLine('');
            let out = await this.nvim.call('execute', ['version']);
            let first = out.trim().split('\n', 2)[0].replace(/\(.*\)/, '').trim();
            channel.appendLine('vim version: ' + first + `${workspace_1.default.isVim ? ' ' + workspace_1.default.env.version : ''}`);
            channel.appendLine('node version: ' + process.version);
            channel.appendLine('coc.nvim version: ' + this.version);
            channel.appendLine('coc.nivm directory: ' + path_1.default.dirname(__dirname));
            channel.appendLine('term: ' + (process.env.TERM_PROGRAM || process.env.TERM));
            channel.appendLine('platform: ' + process.platform);
            channel.appendLine('');
            for (let ch of workspace_1.default.outputChannels.values()) {
                if (ch.name !== 'info') {
                    channel.appendLine(`## Output channel: ${ch.name}\n`);
                    channel.append(ch.content);
                    channel.appendLine('');
                }
            }
            channel.show();
        });
        // register actions
        this.addAction('links', () => {
            return this.handler.links();
        });
        this.addAction('openLink', () => {
            return this.handler.openLink();
        });
        this.addAction('pickColor', () => {
            return this.handler.pickColor();
        });
        this.addAction('colorPresentation', () => {
            return this.handler.pickPresentation();
        });
        this.addAction('highlight', async () => {
            await this.handler.highlight();
        });
        this.addAction('fold', (kind) => {
            return this.handler.fold(kind);
        });
        this.addAction('startCompletion', async (option) => {
            await completion_1.default.startCompletion(option);
        });
        this.addAction('sourceStat', () => {
            return sources_1.default.sourceStats();
        });
        this.addAction('refreshSource', async (name) => {
            await sources_1.default.refresh(name);
        });
        this.addAction('tokenSource', name => {
            sources_1.default.toggleSource(name);
        });
        this.addAction('diagnosticInfo', async () => {
            await manager_1.default.echoMessage();
        });
        this.addAction('diagnosticNext', async (severity) => {
            await manager_1.default.jumpNext(severity);
        });
        this.addAction('diagnosticPrevious', async (severity) => {
            await manager_1.default.jumpPrevious(severity);
        });
        this.addAction('diagnosticPreview', async () => {
            await manager_1.default.preview();
        });
        this.addAction('diagnosticList', () => {
            return manager_1.default.getDiagnosticList();
        });
        this.addAction('jumpDefinition', openCommand => {
            return this.handler.gotoDefinition(openCommand);
        });
        this.addAction('jumpDeclaration', openCommand => {
            return this.handler.gotoDeclaration(openCommand);
        });
        this.addAction('jumpImplementation', openCommand => {
            return this.handler.gotoImplementation(openCommand);
        });
        this.addAction('jumpTypeDefinition', openCommand => {
            return this.handler.gotoTypeDefinition(openCommand);
        });
        this.addAction('jumpReferences', openCommand => {
            return this.handler.gotoReferences(openCommand);
        });
        this.addAction('doHover', () => {
            return this.handler.onHover();
        });
        this.addAction('showSignatureHelp', () => {
            return this.handler.showSignatureHelp();
        });
        this.addAction('documentSymbols', () => {
            return this.handler.getDocumentSymbols();
        });
        this.addAction('symbolRanges', () => {
            return this.handler.getSymbolsRanges();
        });
        this.addAction('selectionRanges', () => {
            return this.handler.getSelectionRanges();
        });
        this.addAction('rangeSelect', (visualmode, forward) => {
            return this.handler.selectRange(visualmode, forward);
        });
        this.addAction('rename', newName => {
            return this.handler.rename(newName);
        });
        this.addAction('getWorkspaceSymbols', async (input, bufnr) => {
            if (!bufnr)
                bufnr = await this.nvim.eval('bufnr("%")');
            let document = workspace_1.default.getDocument(bufnr);
            if (!document)
                return;
            return await languages_1.default.getWorkspaceSymbols(document.textDocument, input);
        });
        this.addAction('formatSelected', mode => {
            return this.handler.documentRangeFormatting(mode);
        });
        this.addAction('format', () => {
            return this.handler.documentFormatting();
        });
        this.addAction('commands', () => {
            return this.handler.getCommands();
        });
        this.addAction('services', () => {
            return services_1.default.getServiceStats();
        });
        this.addAction('toggleService', name => {
            return services_1.default.toggle(name);
        });
        this.addAction('codeAction', (mode, only) => {
            return this.handler.doCodeAction(mode, only);
        });
        this.addAction('organizeImport', () => {
            return this.handler.doCodeAction(null, [vscode_languageserver_types_1.CodeActionKind.SourceOrganizeImports]);
        });
        this.addAction('fixAll', () => {
            return this.handler.doCodeAction(null, [vscode_languageserver_types_1.CodeActionKind.SourceFixAll]);
        });
        this.addAction('doCodeAction', codeAction => {
            return this.handler.applyCodeAction(codeAction);
        });
        this.addAction('codeActions', (mode, only) => {
            return this.handler.getCurrentCodeActions(mode, only);
        });
        this.addAction('quickfixes', mode => {
            return this.handler.getCurrentCodeActions(mode, [vscode_languageserver_types_1.CodeActionKind.QuickFix]);
        });
        this.addAction('codeLensAction', () => {
            return this.handler.doCodeLensAction();
        });
        this.addAction('runCommand', (...args) => {
            return this.handler.runCommand(...args);
        });
        this.addAction('doQuickfix', () => {
            return this.handler.doQuickfix();
        });
        this.addAction('refactor', () => {
            return this.handler.doRefactor();
        });
        this.addAction('repeatCommand', () => {
            return commands_1.default.repeatCommand();
        });
        this.addAction('extensionStats', () => {
            return extensions_1.default.getExtensionStates();
        });
        this.addAction('activeExtension', name => {
            return extensions_1.default.activate(name);
        });
        this.addAction('deactivateExtension', name => {
            return extensions_1.default.deactivate(name);
        });
        this.addAction('reloadExtension', name => {
            return extensions_1.default.reloadExtension(name);
        });
        this.addAction('toggleExtension', name => {
            return extensions_1.default.toggleExtension(name);
        });
        this.addAction('uninstallExtension', (...args) => {
            return extensions_1.default.uninstallExtension(args);
        });
        this.addAction('getCurrentFunctionSymbol', () => {
            return this.handler.getCurrentFunctionSymbol();
        });
        this.addAction('getWordEdit', () => {
            return this.handler.getWordEdit();
        });
        this.addAction('addRanges', async (ranges) => {
            await this.cursors.addRanges(ranges);
        });
        this.addAction('currentWorkspacePath', () => {
            return workspace_1.default.rootPath;
        });
        workspace_1.default.onDidChangeWorkspaceFolders(() => {
            nvim.setVar('WorkspaceFolders', workspace_1.default.folderPaths, true);
        });
        commands_1.default.init(nvim, this);
    }
    addAction(key, fn) {
        if (this.actions.has(key)) {
            throw new Error(`Action ${key} already exists`);
        }
        this.actions.set(key, fn);
    }
    addMethod(name, fn) {
        if (this.hasOwnProperty(name)) {
            throw new Error(`Method ${name} already exists`);
        }
        Object.defineProperty(this, name, { value: fn });
    }
    addCommand(cmd) {
        let id = `vim.${cmd.id}`;
        commands_1.default.registerCommand(id, async () => {
            await this.nvim.command(cmd.cmd);
        });
        if (cmd.title)
            commands_1.default.titles.set(id, cmd.title);
    }
    async init() {
        let { nvim } = this;
        let s = Date.now();
        try {
            await workspace_1.default.init();
            await extensions_1.default.init();
            for (let item of workspace_1.default.env.vimCommands) {
                this.addCommand(item);
            }
            manager_3.default.init();
            completion_1.default.init();
            manager_1.default.init();
            manager_2.default.init(nvim);
            nvim.setVar('coc_workspace_initialized', 1, true);
            nvim.setVar('coc_process_pid', process.pid, true);
            nvim.setVar('WorkspaceFolders', workspace_1.default.folderPaths, true);
            sources_1.default.init();
            this.handler = new handler_1.default(nvim);
            services_1.default.init();
            await extensions_1.default.activateExtensions();
            nvim.setVar('coc_service_initialized', 1, true);
            nvim.call('coc#util#do_autocmd', ['CocNvimInit'], true);
            this._ready = true;
            logger.info(`coc.nvim ${this.version} initialized with node: ${process.version} after ${Date.now() - s}ms`);
            this.emit('ready');
        }
        catch (e) {
            console.error(`Error on initialize: ${e.stack}`);
            logger.error(e.stack);
        }
        workspace_1.default.onDidOpenTextDocument(async (doc) => {
            if (!doc.uri.endsWith(util_1.CONFIG_FILE_NAME))
                return;
            if (extensions_1.default.has('coc-json') || extensions_1.default.isDisabled('coc-json'))
                return;
            workspace_1.default.showMessage(`Run: CocInstall coc-json for json intellisense`, 'more');
        });
    }
    get isReady() {
        return this._ready;
    }
    get ready() {
        if (this._ready)
            return Promise.resolve();
        return new Promise(resolve => {
            this.once('ready', () => {
                resolve();
            });
        });
    }
    async findLocations(id, method, params, openCommand) {
        let { document, position } = await workspace_1.default.getCurrentState();
        params = params || {};
        Object.assign(params, {
            textDocument: { uri: document.uri },
            position
        });
        let res = await services_1.default.sendRequest(id, method, params);
        if (!res) {
            workspace_1.default.showMessage(`Locations of "${method}" not found!`, 'warning');
            return;
        }
        let locations = [];
        if (Array.isArray(res)) {
            locations = res;
        }
        else if (res.hasOwnProperty('location') && res.hasOwnProperty('children')) {
            let getLocation = (item) => {
                locations.push(item.location);
                if (item.children && item.children.length) {
                    for (let loc of item.children) {
                        getLocation(loc);
                    }
                }
            };
            getLocation(res);
        }
        await this.handler.handleLocations(locations, openCommand);
    }
    get version() {
        return workspace_1.default.version + (process.env.REVISION ? '-' + process.env.REVISION : '');
    }
    async cocAction(...args) {
        if (!this._ready)
            return;
        let [method, ...others] = args;
        let fn = this.actions.get(method);
        if (!fn) {
            workspace_1.default.showMessage(`Method "${method}" not exists for CocAction.`, 'error');
            return;
        }
        try {
            return await Promise.resolve(fn.apply(null, others));
        }
        catch (e) {
            let message = e.hasOwnProperty('message') ? e.message : e.toString();
            if (!/\btimeout\b/.test(message)) {
                workspace_1.default.showMessage(`Error on '${args[0]}': ${message}`, 'error');
            }
            if (e.stack)
                logger.error(e.stack);
        }
    }
    async dispose() {
        this.removeAllListeners();
        extensions_1.default.dispose();
        manager_2.default.dispose();
        workspace_1.default.dispose();
        sources_1.default.dispose();
        await services_1.default.stopAll();
        services_1.default.dispose();
        if (this.handler) {
            this.handler.dispose();
        }
        manager_3.default.dispose();
        commands_1.default.dispose();
        completion_1.default.dispose();
        manager_1.default.dispose();
    }
}
exports.default = Plugin;
//# sourceMappingURL=plugin.js.map