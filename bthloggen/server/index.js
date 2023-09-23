const express = require("express");
const cors = require("cors");
const app = express();

const filterData = require("./src/filters.js");
const logData = require("../data/log.json");

const port = 1337;
const info = {
    routes: {
        "/ ": "info",
        "/data/ ": "show all items",
        "/data?ip=<ip> ": "filter on <ip>",
        "/data?url=<url> ": "filter on <url>",
        "/data?month=<month> ": "filter on <month>",
        "/data?day=<day> ": "filter on <day>",
        "/data?time=<time> ": "filter on <time>",
        "/data?day=<day>&time=<time> ": "filter on <day> and <time>",
        "/data?month=<month>&day=<day>&time=<time> ": "filter on <month>, <day> and <time>"
    }
};

app.use(cors());
app.options('*', cors());
app.disable('x-powered-by');

app.get("/", (req, res) => {
    res.json(info);
});

app.get("/data", (req, res) => {
    let result = {};

    if (req.query.month && req.query.day && req.query.time) {
        const firstPass = filterData.onMonth(req.query.month, logData);
        const secondPass = filterData.onDay(req.query.day, firstPass);

        result = filterData.onTime(req.query.time, secondPass);
        res.json(result);
        return;
    }

    if (req.query.day && req.query.time) {
        const firstPass = filterData.onDay(req.query.day, logData);

        result = filterData.onTime(req.query.time, firstPass);
        res.json(result);
        return;
    }

    if (req.query.ip) {
        result = filterData.onIp(req.query.ip, logData);
        res.json(result);
        return;
    }

    if (req.query.url) {
        result = filterData.onUrl(req.query.url, logData);
        res.json(result);
        return;
    }

    if (req.query.month) {
        result = filterData.onMonth(req.query.month, logData);
        res.json(result);
        return;
    }

    if (req.query.day) {
        result = filterData.onDay(req.query.day, logData);
        res.json(result);
        return;
    }

    if (req.query.time) {
        result = filterData.onTime(req.query.time, logData);
        res.json(result);
        return;
    }

    res.json(logData);
});


app.listen(port, () => console.log(`Example app listening on port ${port}!`));
