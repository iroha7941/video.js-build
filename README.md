# video.js-build

This repo contains a build of video.js modified to implement decryption of fMP4 streams correctly.

`build` contains the js/css files that support decryption.  Sources used:
* [videojs/video.js v7.11.4](https://github.com/videojs/video.js/tree/v7.11.4)
* [iroha7941/http-streaming v2.4.2-decryption](https://github.com/iroha7941/http-streaming/tree/v2.4.2-decryption)
* [iroha7941/m3u8-parser v4.5.0-decryption](https://github.com/iroha7941/m3u8-parser/tree/v4.5.0-decryption)

`green` contains a script that generates a simple example of an encrypted stream.
