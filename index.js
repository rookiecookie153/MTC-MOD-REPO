const express = require('express')
const app = express()

app.use(express.static("src"))

app.listen(70, () => {
    console.log(":P")
})