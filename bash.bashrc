# System-wide .bashrc file
PS1='bmc:\w\$ '
PATH=/c/Progra~1/Subversion:$PATH:~/bin:~/unix_tools

alias phpunit='~/php5/phpunit.bat'
alias pear='~/php5/pear.bat'
alias ls='ls --color=auto'
alias mysql='mysql -uroot'
alias mysqldump='mysqldump -uroot'
alias more='less'
alias vdiff='/cygdrive/c/Progra~1/Beyond~1/BC2.exe'
alias mssql='~/mssql2005/90/Tools/Binn/sqlcmd.exe'
alias 7z='/cygdrive/c/Progra~1/7-zip/7z.exe'
alias csep='var=`(ctrlv | while read i; do echo -n $i,; done) | sed s/,$//`; echo $var'
alias zip='/cygdrive/c/Progra~1/7-zip/7z.exe a -tzip'
alias python='~/python/python.exe'
alias excel='/c/Progra~1/Microsoft\ Office/OFFICE11/EXCEL.EXE'
alias putt='/c/Progra~1/PuTTY/putty.exe -load'
alias list_avail_revs='svnmerge avail | python C:/one45/bin/split_revs'

export HISTSIZE=10000
export HISTCONTROL=ignoreboth
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;36'

function ml
{
	cd ~/htdocs/mainline/"$1"
}

function cl
{
	cd ~/htdocs/mainline/admin/pages/classes/"$1"
}

function rgrep
{
	find . -type f ! -wholename "*/.*" -print0 | xargs -0 grep $*
}

function ft
{
	command find . -type f ! -wholename "*/.*" -print0 | xargs -0 grep -il "$1"
}

function uts
{
	for i in $*
	do
		ut $i
	done
}

function ut
{
	cl testing
	php cmdline.php $*
	cd - >/dev/null
}

cd ~/htdocs/mainline
shopt -s histappend
