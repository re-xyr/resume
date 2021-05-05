const puppeteer = require("puppeteer-core")

void async function () {
  const executablePath = process.env["PUPPETEER_EXECUTABLE_PATH"]
  const [, , infile, outfile, scale, timeout] = process.argv
  const browser = await puppeteer.launch({ executablePath })
  const page = await browser.newPage()
  await page.goto(`file://${process.cwd()}/${infile}`)
  setTimeout(async () => {
    await page.pdf({
      path: outfile,
      scale: Number(scale),
    })
    await browser.close()
  }, Number(timeout))
}()
