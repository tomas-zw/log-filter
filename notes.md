# vlinux project

## bthloggen/log2json.bash inkl krav 4

  1. ../access-50k.log sed => `"ip" "day" "month" "time" "url"`
    - 1.208.61.234 - - [17/Aug/2016:13:56:33 +0200] "GET /community HTTP/1.1" 200 7763 "https://dbwebb.se/kurser" "Mozilla/5.0 (Windows NT 10.0; WOW64; rv:47.0) Gecko/20100101 Firefox/47.0"
    - `ip` = ^([0-9\.]+)
    - `x`  = .+\[
    - `day` = ([0-9]+)
    - `x`  = \/
    - `month` = ([a-zA-Z]+)
    - `x`  = \/[0-9]+:
    - `time` = ([0-9:]+)
    - `x`  = .*
    - `url` = (https?:\/\/[a-zA-Z0-9\.]+)
    - `x`  = .*
    -
    - `result` = s/^([0-9\.]+).+\[([0-9]+)\/([a-zA-Z]+)\/[0-9]+:([0-9:]+).+(https?:\/\/[a-zA-Z0-9\.]+).*/\1 \2 \3 \4 \5/p

  2. awk => valid json

  ```json
  [
    {
      "ip": "3.46.13.143",
      "day": "17",
      "month": "Aug",
      "time": "14:36:04",
      "url": "http://www.bing.com"
    },
  ]
  ```
  3. => bthloggen/data/log.json




## bthloggen/server

```javascript

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

```




## bthloggen/client

```bash

SERVERNAME="$(cat server.txt)"

function main
{
    while (( $# ))
    do
        case "$1" in

            .....
            ;;

            use)
                shift
                echo "$1" > server.txt
                echo "Servername set to: $1"
                exit 0
            ;;

            view)
                shift
                view "$@"
                exit 0
            ;;

            .....
        esac
    done
}

#
# Get and view info from server.
# Builds search string from optional args.
#
function view
{
    # without declare, +=1 does string concat for some reason
    declare -i isEven=0
    local search="?"
    for var in "$@"
    do
        isEven+=1
        local mod=$((isEven % 2))
        if [[ $mod -ne 0 ]]
        then
            search+="$var="
        else
            search+="$var&"
        fi
    done
    data=$(curl -s "$SERVERNAME:1337/data$search")
    if [[ $COUNTROWS == "true" ]]
    then
         printf "%s %s\\n" "$(echo "$data" | jq -r '. | length')" "items found"
    else
        echo "$data" | jq -r '.'
    fi
}

```




## bthloggen/webbclient

    - localhost:1338
    - Vue3
    - ingen sortering i clienten

