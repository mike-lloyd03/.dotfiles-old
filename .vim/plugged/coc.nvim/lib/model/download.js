"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const tslib_1 = require("tslib");
const follow_redirects_1 = require("follow-redirects");
const uuid_1 = require("uuid");
const fs_1 = tslib_1.__importDefault(require("fs"));
const mkdirp_1 = tslib_1.__importDefault(require("mkdirp"));
const path_1 = tslib_1.__importDefault(require("path"));
const tar_1 = tslib_1.__importDefault(require("tar"));
const fetch_1 = require("./fetch");
const logger = require('../util/logger')('model-download');
/**
 * Download file from url, with optional untar support.
 *
 * @param {string} url
 * @param {DownloadOptions} options contains dest folder and optional onProgress callback
 */
function download(url, options) {
    let { dest, onProgress, extract } = options;
    if (!dest || !path_1.default.isAbsolute(dest)) {
        throw new Error(`Expect absolute file path for dest option.`);
    }
    if (!fs_1.default.existsSync(dest))
        mkdirp_1.default.sync(dest);
    let mod = url.startsWith('https') ? follow_redirects_1.https : follow_redirects_1.http;
    let opts = fetch_1.resolveRequestOptions(url, options);
    let extname = path_1.default.extname(url);
    if (!extract)
        dest = path_1.default.join(dest, `${uuid_1.v1()}${extname}`);
    return new Promise((resolve, reject) => {
        const req = mod.request(opts, (res) => {
            if ((res.statusCode >= 200 && res.statusCode < 300) || res.statusCode === 1223) {
                let headers = res.headers || {};
                let total = Number(headers['content-length']);
                let cur = 0;
                if (!isNaN(total)) {
                    res.on('data', chunk => {
                        cur += chunk.length;
                        let percent = (cur / total * 100).toFixed(1);
                        if (onProgress) {
                            onProgress(percent);
                        }
                        else {
                            logger.info(`Download progress ${percent}%`);
                        }
                    });
                }
                res.on('error', err => {
                    reject(new Error(`Unable to connect ${url}: ${err.message}`));
                });
                res.on('end', () => {
                    logger.info('Download completed:', url);
                });
                let stream;
                if (extract) {
                    stream = res.pipe(tar_1.default.x({ strip: 1, C: dest }));
                }
                else {
                    stream = res.pipe(fs_1.default.createWriteStream(dest));
                }
                stream.on('finish', () => {
                    logger.info(`Downloaded ${url} => ${dest}`);
                    setTimeout(() => {
                        resolve(dest);
                    }, 100);
                });
                stream.on('error', reject);
            }
            else {
                reject(new Error(`Invalid response from ${url}: ${res.statusCode}`));
            }
        });
        req.on('error', reject);
        req.on('timeout', () => {
            req.destroy(new Error(`request timeout after ${options.timeout}ms`));
        });
        if (options.timeout) {
            req.setTimeout(options.timeout);
        }
        req.end();
    });
}
exports.default = download;
//# sourceMappingURL=download.js.map