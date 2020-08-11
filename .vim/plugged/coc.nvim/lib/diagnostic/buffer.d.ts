import { Diagnostic, Event } from 'vscode-languageserver-protocol';
import { DiagnosticConfig } from './manager';
export declare class DiagnosticBuffer {
    readonly bufnr: number;
    readonly uri: string;
    private config;
    private readonly srdId;
    private readonly signIds;
    private readonly _onDidRefresh;
    readonly matchIds: Set<number>;
    readonly onDidRefresh: Event<void>;
    /**
     * Refresh diagnostics with debounce
     */
    refresh: Function & {
        clear(): void;
    };
    constructor(bufnr: number, uri: string, config: DiagnosticConfig);
    /**
     * Refresh diagnostics without debounce
     */
    forceRefresh(diagnostics: ReadonlyArray<Diagnostic>): void;
    private _refresh;
    setLocationlist(diagnostics: ReadonlyArray<Diagnostic>, winid: number): void;
    private clearSigns;
    checkSigns(): Promise<void>;
    addSigns(diagnostics: ReadonlyArray<Diagnostic>): void;
    setDiagnosticInfo(bufnr: number, diagnostics: ReadonlyArray<Diagnostic>): void;
    showVirtualText(diagnostics: ReadonlyArray<Diagnostic>, lnum: number): void;
    clearHighlight(): void;
    addHighlight(diagnostics: ReadonlyArray<Diagnostic>, winid: any): void;
    private fixRange;
    /**
     * Used on buffer unload
     *
     * @public
     * @returns {Promise<void>}
     */
    clear(): Promise<void>;
    hasHighlights(): boolean;
    dispose(): void;
    private get document();
    private get nvim();
}
