alias mserver='208.98.171.214'
alias clock='while true; echo "`date +%I:%M`"; sleep 60; clear; done'
alias jport=127.0.0.1:8888:127.0.0.1:8888

alias dtypes="column -xt $HOME/.dtypes.tsv"
alias bztar="tar -jcvf"
alias bzuntar="tar -xjf"

if [[ "$OSTYPE" = darwin* ]]; then
	alias mvim='mvim -v'
	alias python='/usr/local/bin/python3'
	alias pip='/usr/local/bin/pip3'
fi
