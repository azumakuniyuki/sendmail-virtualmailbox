#!/bin/sh
# $Id: sidctl.SH,v 5.43 2008/02/28 06:16:16 ak Exp $
# @(#) sidctl(8) - The control interface of sid-milter
#      _     _      _   _ 
#  ___(_) __| | ___| |_| |
# / __| |/ _` |/ __| __| |
# \__ \ | (_| | (__| |_| |
# |___/_|\__,_|\___|\__|_|
#                         
readonly SENDMAILROOT='__PREFIX__'
readonly MYNAME="`basename $0`"

KILL_SIGNAL=15
DEBUG_LEVEL=''
SMLOG_LEVEL=''
RUN_MAKEMAP='0'
STDERRORDEV='/dev/stderr'
STATUS_CODE=1
CHAR_OK='[ OK ]'
CHAR_NG='[FAIL]'
CHAR_WARN='[WARN]'
CHAR_INFO='[INFO]'
CHAR_SKIP='[SKIP]'

# * Error or exit status code. see sysexits.h
EX_OK=0		# operation completed successfully
EX_GENERAL=1	# generic error
EX_USAGE=64	# invalid gesogram option or argument
EX_SOFTWARE=70	# internal software error
EX_OSERR=71	# system error
EX_OSFILE=72	# critical OS file missing
EX_CONFIG=78	# gesogram config | environment error
EX_NOPERM=77	# permission denied


sidcontrol()
{
	local whataction=$1
	local procidfile="$SENDMAILROOT/var/run/sid-milter.pid"
	local socketaddr='inet:8891@127.0.0.1'

	if [ "${whataction}X" = "startX" ]; then

		msg 'Starting sid-milter'
		if [ -s "$procidfile" ]; then
			msg ", $procidfile exists"
			result NG
			STATUS_CODE=$EX_GENERAL
		else
			local mtaoptions=''
			local daemonopts="`test -s $SENDMAILROOT/etc/daemon-options && grep -v '^#' $SENDMAILROOT/etc/daemon-options`"
			local mqinterval="`test -s $SENDMAILROOT/etc/queue-interval && head -1 $SENDMAILROOT/etc/queue-interval`"

			[ -n "$SMLOG_LEVEL" ] && mtaoptions="$mtaoptions -OLogLevel=$SMLOG_LEVEL"
			[ -n "$DEBUG_LEVEL" ] && mtaoptions="$mtaoptions -d$DEBUG_LEVEL"

			( $SENDMAILROOT/bin/sid-filter -Aha $SENDMAILROOT/etc/sid-peer-hosts \
				-d $SENDMAILROOT/etc/sid-pass-domains -r0 -T10 \
				-P $procidfile -p $socketaddr && sleep 1 )

			if [ "$?" -eq "0" -a -s "$procidfile" ]; then
				result OK
				STATUS_CODE=$EX_OK
			else
				result NG
				STATUS_CODE=$EX_GENERAL
			fi
		fi

	elif [ "${whataction}X" = "stopX" ]; then

		msg 'Stopping sid-milter'
		if [ -s "$procidfile" ]; then
			( kill -$KILL_SIGNAL `head -1 $procidfile` && sleep 1 )
			if [ "$?" -eq "0" -a ! -s "$procidfile" ]; then
				result OK
				STATUS_CODE=$EX_OK
			else
				result NG
				STATUS_CODE=$EX_GENERAL
			fi
		else
			msg ", $procidfile does not exist"
			result NG
			STATUS_CODE=$EX_GENERAL
		fi
	fi
}

proclist()
{
	ps axuww | grep sbin/sid-filter | grep -v grep | sed 's| *$||g'
}

msg()
{
	[ "${TERM}X" = "X" ] && STDERRORDEV='/dev/null'
	echo -n "$1" > $STDERRORDEV
}

result()
{
	local msgtype="$1"
	local message=''
	[ "${TERM}X" = "X" ] && STDERRORDEV='/dev/null'

	case "$msgtype" in
		ok|OK)
			message=$CHAR_OK
			;;

		ng|NG)
			message=$CHAR_NG
			;;

		warn|WARN)
			message=$CHAR_WARN
			;;

		info|INFO)
			message=$CHAR_INFO
			;;

		skip|SKIP)
			message=$CHAR_SKIP
			;;
		*)
			;;
	esac

	printf \\033[70G > $STDERRORDEV
	printf \\033[1\;49m > $STDERRORDEV
	echo -n $message > $STDERRORDEV
	printf \\033[0\;39m > $STDERRORDEV
	echo > $STDERRORDEV
}

init()
{
	export PATH='__SBINDIR__:__BINDIR__:/bin:/usr/bin:/sbin:/usr/sbin:/usr/local/bin:/usr/local/sbin'
	export LANG='C'
	if [ -x "$SENDMAILROOT/bin/sid-filter" ]; then 
		SIDFILTER="$SENDMAILROOT/bin/sid-filter"
	else
		echo "Cannot execute $SENDMAILROOT/bin/sid-filter" > $STDERRORDEV
		exit $EX_GENERAL
	fi
}

help()
{
	echo
	echo 'usage:'
	echo " $MYNAME [ OPTION [ARGV] ] COMMAND"
	echo
	echo '  COMMAND:'
	echo '     start        : Start sendmail daemon.'
	echo '     stop         : Stop sendmail.'
	echo '     restart      : Restart ( stop & start )'
	echo '     status,s     : Print sendmail status, content of pid file.'
	echo '     ps           : Print sendmail processes.'
	echo '     help,h       : Print this screen. '
	echo 

	echo '  OPTIONS:'
	echo '   * boot options:'
	echo '     -L <n>       : Specify LogLevel'
	echo "     -v           : Print $MYNAME/sendmail version"
	echo
}

init
while getopts ":L:" opt; do
	case $opt in
		L)
			# Specify LogLevel option(external only)
			[ -n "$OPTARG" ] && SMLOG_LEVEL="$OPTARG"
			;;
		\?|*)
			;;
	esac
done

shift $( expr $OPTIND - 1 )


#  ____ ____ ____ ____ 
# ||m |||a |||i |||n ||
# ||__|||__|||__|||__||
# |/__`|/__`|/__`|/__`|
#
case "$1" in
	#  ____ ____ ____ _________ ____ ____ ____ ____ ____ ____ ____ ____ 
	# ||s |||u |||b |||       |||c |||o |||m |||m |||a |||n |||d |||s ||
	# ||__|||__|||__|||_______|||__|||__|||__|||__|||__|||__|||__|||__||
	# |/__`|/__`|/__`|/_______`|/__`|/__`|/__`|/__`|/__`|/__`|/__`|/__`|
	#
	help|h)
		help
		exit $EX_OK
		;;
	ps)
		# Print processes.
		proclist
		exit $EX_OK
		;;
	restart)
		sidcontrol stop
		sidcontrol start
		;;

	start)
		sidcontrol start
		;;

	stop|abort)
		if [ "$1" = "abort" ]; then
			KILL_SIGNAL=9	
		fi
		sidcontrol stop
		;;
	
	*)
		echo "try $MYNAME help"
		exit $EX_USAGE
		;;
esac


