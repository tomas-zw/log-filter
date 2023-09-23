#!/usr/bin/env bash
#

sed -nE 's/^([0-9\.]+).+\[([0-9]+)\/([a-zA-Z]+)\/[0-9]+:([0-9:]+).+(https?:\/\/[a-zA-Z0-9\.]+).*/\1 \2 \3 \4 \5/p' ../access-50k.log | awk \
'BEGIN {
  counter = 0
  print "["
}
function stringToJson(ip, day, month, time, url) {
  print "\t{"
    print "\t\t\"ip\": \""ip"\","
    print "\t\t\"day\": \""day"\","
    print "\t\t\"month\": \""month"\","
    print "\t\t\"time\": \""time"\","
    print "\t\t\"url\": \""url"\""
}
{
  items[counter++]=$0
}
END {
  last = length(items)-1
  for (item in items) {
    split(items[item], value, " ")
    stringToJson(value[1], value[2], value[3], value[4], value[5])
    if (item+0 < last) {
      print "\t},"
    } else {
      print "\t}"
    }
  }
  print "]"
}' > ./data/log.json
