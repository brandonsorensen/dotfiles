alias la='ls -a'
alias mserver='208.98.171.214'
alias clock='date +%H:%M:%S'

alias dtypes="column -xt $HOME/.dtypes.tsv"
alias bztar="tar -jcvf"
alias bzuntar="tar -xjf"
alias reddit='ttrv'
alias lg='lazygit'


latex_aux_ext="*.log *.aux *.toc *.blg *.fdb_latexmk *.out *.fls *.synctex.gz *.bbl *.dvi"
lf_args=$(echo $latex_aux_ext | sed -E 's/(\\)?(\*\.[a-z]+)/-I "\2"/g')

alias cleantex='latexmk -C &> /dev/null'
if [[ "$OSTYPE" = darwin* ]]; then
	alias mvim='mvim -v'
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
