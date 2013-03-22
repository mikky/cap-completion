# Bash completion for Capistrano

_cap() 
{
	local tasks

	[ ! -r Capfile ] && return

	COMPREPLY=()
	local cur="${COMP_LINE:4:$COMP_POINT}"
	local colonprefixes=${cur%"${cur##*:}"}
	local stg=( $cur )
	stg=${stg[0]}
	if [ ! -r .cap_completion ]; then
		cap -T | awk '/^cap /{print $2}' > .cap_completion
	fi
	# for multi stage
	local stages=( $(egrep 'production|test|staging|development' .cap_completion) )
	if [ -n "$stages" ]; then
		local tmp=" ${stages[*]} "
		if [ "$tmp" != "${tmp/ $stg /}" ]; then
			# $stg must be stage name
			cur=${cur#$stg }
			colonprefixes=${colonprefixes#$stg }
		else
			# $stg must not be stage name
			stg=''
		fi
	fi
	if [ -z "$stg" ]; then
		tasks=$(< .cap_completion)
	else
		tasks=$(egrep -v 'production|test|staging|development' .cap_completion)
	fi
	COMPREPLY=( $(compgen -W "$tasks" -- "$cur") )
	local i=${#COMPREPLY[*]}
	while [ $((--i)) -ge 0 ]; do
		COMPREPLY[$i]=${COMPREPLY[$i]#"$colonprefixes"}
	done

	if [ ! -e .cap_completion_proc ]; then
		# create completion list in background without echoing job ID.
		( bash -c "touch .cap_completion_proc; sleep 10; cap -T | awk '/^cap /{print \$2}' > .cap_completion; rm -f .cap_completion_proc" & )
	fi

	return 0
}
complete -F _cap cap
