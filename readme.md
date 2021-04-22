# Elm PWA

A minimal PWA using Elm!

PWAs signify a bunch of features that are all enabled in this example:

1. Installable on desktop/homescreen.
2. Full offline-support.
3. Seamless upgrade when a new version is available.

Elm also brings a bunch of nice features to the table:

1. Extendable and maintainable codebase.
2. Very fast UI rendering.
3. Tiny compiler-output.

This PWA is based on the guidance from [the Google PWA site](https://codelabs.developers.google.com/codelabs/your-first-pwapp/#0).

It is built using [Elm](https://guide.elm-lang.org/) and [Elm-UI](https://package.elm-lang.org/packages/mdgriffith/elm-ui/latest/).

This is just a dummy example that passes the audits in [Google Lighthouse](https://developers.google.com/web/tools/lighthouse/) for PWAs.

## Scripts

```bash
# install
deno_url=https://github.com/denoland/deno/releases/download/v1.9.1/deno-x86_64-pc-windows-msvc.zip
elm_url=https://github.com/elm/compiler/releases/download/0.19.1/binary-for-windows-64-bit.gz
mkdir -p binary
curl -L $deno_url | gunzip -c > binary/deno.exe
curl -L $elm_url | gunzip -c > binary/elm.exe

# build
binary/elm make --output=build/main.js src/Main.elm

# run
server_url=https://deno.land/std/http/file_server.ts
binary/deno run --allow-read=. --allow-net=localhost $server_url --host=localhost
```
