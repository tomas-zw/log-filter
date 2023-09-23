#!/usr/bin/env bash
#
# Exit values:
#  0 on success
#  1 on failure

# Name of the script
SCRIPT=$( basename "$0" )

# Current version
VERSION="1.0.0"

# Current servername
SERVERNAME="$(cat server.txt)"

# -c / --count set
COUNTROWS="false"

function main
{
    while (( $# ))
    do
        case "$1" in

            --help | -h)
                usage
                exit 0
            ;;

            --version | -v)
                version
                exit 0
            ;;

            --count | -c)
                COUNTROWS="true"
                shift
            ;;

            url)
                echo "$SERVERNAME:1337"
                exit 0
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

            *)
                badUsage "Option/command not recognized."
                exit 1
            ;;

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

#
# Help menu
#
function usage
{
    local txt=(
    ""
    "Commands available:"

    "   url                                             Get url to view the server in browser."
    "   use <server>                                    Set the servername (localhost or service name)."
    "   view                                            List all entries."
    "   view url <url>                                  View all entries containing <url>."
    "   view ip <ip>                                    View all entries containing <ip>."
    "   view month <month>                              View all entries containing <month>."
    "   view day <day>                                  View all entries containing <day>."
    "   view time <time>                                View all entries containing <time>."
    "   view day <day> time <time>                      View all entries containing <day> and <time>."
    "   view month <month> day <day> time <time>        View all entries containing <month>,<day> and <time>."
    ""
    ""
    "Options available:"
    "   -h, --help                                      Display the menu"
    "   -v, --version                                   Display the current version"
    "   -c, --count                                     Display the numbers of items returned"
    ""
    )

    printf "%s\\n" "${txt[@]}"
}

#
# Message to display when bad usage.
#
function badUsage
{
    local message="$1"
    local txt=(
"For an overview of the command, execute:"
"$SCRIPT --help"
    )

    [[ -n $message ]] && printf "%s\\n" "$message"

    printf "%s\\n" "${txt[@]}"
}

#
# Message to display for version.
#
function version
{
    local txt=(
"$SCRIPT version $VERSION"
    )

    printf "%s\\n" "${txt[@]}"
}

main "$@"
badUsage "No option or command entered"
exit 1
