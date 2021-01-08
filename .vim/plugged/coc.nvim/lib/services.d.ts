/// <reference types="node" />
import { EventEmitter } from 'events';
import { Disposable, DocumentSelector } from 'vscode-languageserver-protocol';
import { TextDocument } from 'vscode-languageserver-textdocument';
import { LanguageClient, LanguageClientOptions, RevealOutputChannelOn, ServerOptions, Transport } from './language-client';
import { IServiceProvider, LanguageServerConfig, ServiceStat } from './types';
interface ServiceInfo {
    id: string;
    state: string;
    languageIds: string[];
}
export declare function getStateName(state: ServiceStat): string;
export declare class ServiceManager extends EventEmitter implements Disposable {
    private readonly registered;
    private disposables;
    init(): void;
    dispose(): void;
    regist(service: IServiceProvider): Disposable;
    getService(id: string): IServiceProvider;
    private shouldStart;
    private start;
    getServices(document: TextDocument): IServiceProvider[];
    stop(id: string): Promise<void>;
    stopAll(): Promise<void>;
    toggle(id: string): Promise<void>;
    getServiceStats(): ServiceInfo[];
    private createCustomServices;
    private waitClient;
    registNotification(id: string, method: string): Promise<void>;
    sendNotification(id: string, method: string, params?: any): Promise<void>;
    sendRequest(id: string, method: string, params?: any): Promise<any>;
    registLanguageClient(client: LanguageClient): Disposable;
    registLanguageClient(name: string, config: LanguageServerConfig): Disposable;
}
export declare function documentSelectorToLanguageIds(documentSelector: DocumentSelector): string[];
export declare function getLanguageServerOptions(id: string, name: string, config: LanguageServerConfig): [LanguageClientOptions, ServerOptions];
export declare function getRevealOutputChannelOn(revealOn: string | undefined): RevealOutputChannelOn;
export declare function getDocumentSelector(filetypes: string[] | undefined, additionalSchemes?: string[]): DocumentSelector;
export declare function getTransportKind(config: LanguageServerConfig): Transport;
declare const _default: ServiceManager;
export default _default;