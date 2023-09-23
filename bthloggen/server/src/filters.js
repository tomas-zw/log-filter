module.exports = {
    "onIp": onIp,
    "onUrl": onUrl,
    "onMonth": onMonth,
    "onDay": onDay,
    "onTime": onTime
};

function onIp(ip, data) {
    const result = data.filter(item => item.ip.includes(ip));

    return result;
}

function onUrl(url, data) {
    const result = data.filter(item => item.url.includes(url));

    return result;
}

function onMonth(month, data) {
    const result = data.filter(item => item.month == month);

    return result;
}

function onDay(day, data) {
    const result = data.filter(item => item.day == day);

    return result;
}

function onTime(time, data) {
    const result = data.filter(item => item.time.startsWith(time));

    return result;
}
