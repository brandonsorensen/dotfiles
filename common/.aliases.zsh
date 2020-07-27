alias la='ls -a'
alias mserver='208.98.171.214'
alias clock='date +%H:%M:%S'

alias dtypes="column -xt $HOME/.dtypes.tsv"
alias bztar="tar -jcvf"
alias bzuntar="tar -xjf"


lf_args='-I "*.log" -I "*.aux" -I "*.toc" -I "*.blg" '\
'-I "*.fdb_latexmk" -I "*.out" -I "*.fls" -I "*.synctex.gz" -I "*.bbl"'

if [[ "$OSTYPE" = darwin* ]]; then
	alias mvim='mvim -v'
	alias python='/usr/local/bin/python3'
	alias pip='/usr/local/bin/pip3'
	# Always want color when using GNU ls
	alias gls='gls --color=auto'
	# Filters out the auxilary files that are output
	# when compiling a LaTeX file; `lf` for list_filter
	alias lf="gls $1 $lf_args"
else
	# On Linux I'll just use regular `ls` and hope the
	# distro uses the GNU core
	alias lf="ls $1 $lf_args"
fi
