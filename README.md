# hemerocallis

Script for generating a resume.

## Usage

Requires `stack` and `node` and `chromium`.

Run `npm install` or `yarn install` or whatever to install node dependencies.

Set `PUPPETEER_EXECUTABLE_PATH` to your `chromium`.

Edit `config/Main.hs` for the content of the resume.

Run the following - output will be `index.pdf`. PDF scale defaults to `1`. Timeout defaults to `2000` (ms).

```sh
./build.sh [pdf scale] [load time before rendering pdf]
```
