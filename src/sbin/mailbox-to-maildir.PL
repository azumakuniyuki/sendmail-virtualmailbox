#!/usr/bin/perl -w
# $Id: mailbox2maildir,v 1.9 2010/02/06 19:29:16 ak Exp $
use strict;
use warnings;
use Getopt::Long;
use File::Basename qw(basename);
use File::Copy;
use Time::Piece;
use Digest::MD5;
use Carp ();

# __     __         _       _     _           
# \ \   / /_ _ _ __(_) __ _| |__ | | ___  ___ 
#  \ \ / / _` | '__| |/ _` | '_ \| |/ _ \/ __|
#   \ V / (_| | |  | | (_| | |_) | |  __/\__ \
#    \_/ \__,_|_|  |_|\__,_|_.__/|_|\___||___/
#                                             
my $Version = '__SYSVERSION__';
my $Program = File::Basename::basename($0);
my $TheHost = lc(qx(hostname)); chomp($TheHost);
my $ErrHead = q( **ERROR:);

my $Mailbox = undef();
my $Maildir = undef();
my $SubDirs = [ 'cur', 'new', 'tmp' ];

my $UserUID = $>;
my $UserGID = [split( ' ', $) )]->[0];
my $ValidID = 0;	# X-IMAPbase, UIDVALIDITY

my $WhatMDA = q();
my $GetDate = q(From);
my $Verbose = 0;


#  _____                 _   _                 
# |  ___|   _ _ __   ___| |_(_) ___  _ __  ___ 
# | |_ | | | | '_ \ / __| __| |/ _ \| '_ \/ __|
# |  _|| |_| | | | | (__| |_| | (_) | | | \__ \
# |_|   \__,_|_| |_|\___|\__|_|\___/|_| |_|___/
#                                              
sub e { die( $ErrHead.' '.shift() ); }
sub p { printf( STDERR "%s", @_ ); }
sub parseOptions
{ 
	# +-+-+-+-+-+-+-+-+-+-+-+-+
	# |p|a|r|s|e|O|p|t|i|o|n|s|
	# +-+-+-+-+-+-+-+-+-+-+-+-+
	#
	# @description	Parse given options, and set the operation mode.
	# @param	None
	# @return	n = Integer: operation value(24bit integer)

	# Variables for decide operation
	my (
		$_opt_uid,
		$_opt_gid,
		$_opt_date,
		$_opt_mda,
		$_opt_verbose,
	);

	# Relations of the option name and the option value
	Getopt::Long::Configure( 'bundling', 'no_ignore_case' ); 
	Getopt::Long::GetOptions(
			'u=s'		=> \$_opt_uid,
			'user=s'	=> \$_opt_uid,
			'g=s'		=> \$_opt_gid,
			'group=s'	=> \$_opt_gid,
			'd=s'		=> \$_opt_date,
			'date=s'	=> \$_opt_date,
			'M=s'		=> \$_opt_mda,
			'MDA=s'		=> \$_opt_mda,
			'help'		=> sub { help(); exit(0); },
			'verbose'	=> \$_opt_verbose,
			'v+'		=> \$_opt_verbose,
		);
	$Verbose = $_opt_verbose ? $_opt_verbose : 0;
	$WhatMDA = defined($_opt_mda) ? lc($_opt_mda) : q();

	if( $> == 0 )
	{
		# Run as root
		$UserUID = $_opt_uid if(defined($_opt_uid));
		$UserGID = $_opt_gid if(defined($_opt_gid));

		if( $UserUID =~ m{\A[A-Za-z]+\z} ){ $UserUID = getpwnam($UserUID) || $>; }
		if( $UserGID =~ m{\A[A-Za-z]+\z} ){ $UserGID = getgrnam($UserGID) || $); }
	}

	$GetDate = q(Date) if( defined($_opt_date) && lc($_opt_date) eq 'date' );
	$Mailbox = defined($ARGV[0]) ? $ARGV[0] : q();
	$Maildir = defined($ARGV[1]) ? $ARGV[1] : q();

	do { help(); exit(1); } if( ! $Mailbox || ! $Maildir );
	e( $Mailbox." does not exist" ) unless( -e $Mailbox );
	e( $Mailbox." is not a file" ) unless( -f $Mailbox );
	e( $Mailbox." is not readable" ) unless( -r $Mailbox );
	e( $Mailbox." is empty" ) unless( -s $Mailbox );

	if( -e $Maildir )
	{
		e( $Maildir." is not a directory" ) unless( -d $Maildir );
		e( $Maildir." is not executable" ) unless( -x $Maildir );
		e( $Maildir." is not readable" ) unless( -r $Maildir );
	}
	else
	{
		e( $Maildir." does not exist" );

		# Create Maildir directory
		# mkdir( $Maildir, 0700 ) || e( 'Cannot create '.$Maildir );
		# map { mkdir( "$Maildir/$_", 0700 ) || e('Cannot create '."$Maildir/$_") } @$SubDirs;
	}

	if( $Maildir && $Mailbox )
	{
		my $_tmpdirname = File::Spec->tmpdir();
		my $_tmpmailbox = sprintf( "%s/%s.%d.tmp", $_tmpdirname, File::Basename::basename($Mailbox), $$ );
		File::Copy::copy( $Mailbox, $_tmpmailbox );
		$Mailbox = $_tmpmailbox;

		printf(STDERR "Mailbox: %s, size = %d\n", $Mailbox, -s $Mailbox) if( $Verbose );
		printf(STDERR "Maildir: %s\n", $Maildir) if( $Verbose );
		e( 'Subdir in '.$Maildir.' is not enough' ) if( scalar(grep { -d "$Maildir/$_" && -w _ } @$SubDirs) != 3 );
		return(1);
	}
	return(0);
}

sub help
{
	# +-+-+-+-+
	# |h|e|l|p|
	# +-+-+-+-+
	#
	# @description	Print help messages
	# @param	NONE
	# @return	1

	printf( STDERR "%s/%s\n", $Program, $Version );
	printf( STDERR "Usage: %s [OPTIONS] /path/to/mailbox /path/to/Maildir\n", $Program );
	printf( STDERR "\n" );
	printf( STDERR " * OPTIONS\n" );
	printf( STDERR "    -u, --uid <uid|user>     : Maildir owner's uid, when you run this script as root.\n");
	printf( STDERR "    -g, --gid <gid|group>    : Maildir owner's gid, when you run this script as root.\n");
	printf( STDERR "    -d, --date <date|from>   : Get date from 'Date:' header or 'From_' line\n");
	printf( STDERR "    -p, --maildirpp          : Use Maildir++ format\n");
	printf( STDERR "    -M, --MDA <name>         : Mailserver's MDA name: default = dovecot, EXPERIMENTAL\n");
	printf( STDERR "    -v, --verbose            : Run in verbose mode.\n");
	printf( STDERR "\n" );
	printf( STDERR " * Examples\n" );
	printf( STDERR "  %s %s -u 1024 -g 1024 /var/mail/hoge /home/hoge/Maildir\n", '#',$Program );
	printf( STDERR "\n" );
	return(1);
}

#  __  __       _       
# |  \/  | __ _(_)_ __  
# | |\/| |/ _` | | '_ \ 
# | |  | | (_| | | | | |
# |_|  |_|\__,_|_|_| |_|
#                       
if( parseOptions() )
{
	my $mailboxFH = undef();	# Mailbox file handle
	my $emaildata = [];		# Keep $emailhead variables
	my $emailhead = {};		# Email header
	my $timestamp = undef();	# Time::Piece object
	my $headcount = 0;		# The number of 'From_' lines
	my $skip2next = 0;		# If 1, skip to the next message


	open( $mailboxFH, q{<}, $Mailbox ) || e('Cannot open the mailbox: '.$Mailbox);
	p('Parse each email: ') if( $Verbose );

	READ_EMAIL_HEADER: while( my $eachhead = <$mailboxFH> )
	{
		if( $eachhead =~ m{\AFrom[ ]}s )
		{
			# Initialize for this message header
			$skip2next = 0;
			$timestamp = undef();
			$emailhead = {
				'time' => undef(),
				'dest' => q(new),
				'skip' => 0,
				'flag' => q(),
				'xuidl' => 0,
				'number' => $headcount,
				'reason' => q(),
				'subject' => q(),
			};

			if( $GetDate eq 'From' )
			{
				# From MAILER_DAEMON  Mon Feb 21 18:12:42 2000
				$timestamp = $1 if( $eachhead =~ m{\AFrom[ ]+[^\s]+[ ]+(.+\d{4}).*\z}s );
				$emailhead->{'time'} = Time::Piece->strptime( $timestamp, q{%a %b %d %T %Y} );
			}

			p('*') if( $Verbose );
			$headcount++;
			next();
		}

		next() if( $skip2next );

		if( $eachhead =~ m{\ADate:[ ]}s && $GetDate eq 'Date' )
		{
			# Date: Thu, 05 Nov 2009 18:28:53 +0900
			$timestamp = $1 if( $eachhead =~ m{\ADate:[ ]*(.+[ ]\d{2}[:]\d{2}[:]\d{2}).*\z}s );
			$emailhead->{'time'} = Time::Piece->strptime( $timestamp, q{%a, %d %b %Y %T} );
		}

		if( $eachhead =~ m{\ASubject:[ ]*(.+)\z}s )
		{
			$emailhead->{'subject'} = $1;
			chomp($emailhead->{'subject'});
			if( $emailhead->{'subject'} =~ m{\ADON[']T DELETE THIS MESSAGE [-][-] FOLDER INTERNAL DATA\z}s )
			{
				$emailhead->{'reason'} = q(Subject: ).$emailhead->{'subject'};
				$emailhead->{'skip'} = 1;
			}
		}

		if( $eachhead =~ m{\AX-IMAP(?:base)?:[ ](\d+)\s(\d+)\s\z}s )
		{
			# X-IMAPbase: 1257321881 4
			$ValidID ||= $1;
			$emailhead->{'xuidl'} ||= $2;
		}

		if( $eachhead =~ m{\AX-UIDL?:[ ](.+)\z}s )
		{
			# X-UID: 1234
			$emailhead->{'xuidl'} = $1;
			chomp($emailhead->{'xuidl'});
		}

		if( $eachhead =~ m{\A(?:X-)?Status:[ ](.+)\z}s )
		{
			my $_status = $1;
			chomp($_status);
			$emailhead->{'dest'}  = 'cur' if( $_status =~ m{O} );

			if( $_status =~ m{\A[A-Z]+\z}s )
			{
				# See http://cr.yp.to/proto/maildir.html
				$emailhead->{'flag'} .= 'F' if( $_status =~ m{F} );		# Flagged
				$emailhead->{'flag'} .= 'R' if( $_status =~ m{A} );		# Replied
				$emailhead->{'flag'} .= 'S' if( $_status =~ m{[RO]} );		# Read|Seen
				$emailhead->{'flag'} .= 'T' if( $_status =~ m{D} );		# Trashed
			}
		}

		if( $eachhead =~ m{^$} && $skip2next == 0 )
		{
			# Blank line, end of headers
			$skip2next = 1;
			push( @$emaildata, $emailhead );
		}
	}

	p( '('.$headcount.")\n" ) if( $Verbose );
	close($mailboxFH);

	# Insert sentinel
	open( $mailboxFH, q{>>}, $Mailbox );
	printf( $mailboxFH "\n%s\n", q(From MAILER-DAEMON-AS-SENTINEL Sun Dec 31 23:59:59 2000) );
	close( $mailboxFH );


	# Check MD5 Digest value
	my $md5hashes = [];
	my $md5digest = q();
	my $dirhandle = undef();
	my $enthandle = undef();

	CHECK_MD5_DIGEST: foreach my $s ( @$SubDirs )
	{
		next() unless( -d "$Maildir/$s" );
		opendir( $dirhandle, "$Maildir/$s" );

		while( my $_ent = readdir($dirhandle) )
		{
			next() unless( -f "$Maildir/$s/$_ent" );
			next() unless( -s "$Maildir/$s/$_ent" );
			next() unless( -r "$Maildir/$s/$_ent" );

			open( $enthandle, q{<}, "$Maildir/$s/$_ent" );
			$md5digest = Digest::MD5->new->addfile($enthandle)->hexdigest();
			push( @$md5hashes, $md5digest ) unless( grep { $_ eq $md5digest } @$md5hashes );
			close( $enthandle );
		}

		closedir($dirhandle);
	}


	# Read the mailbox and write into Maildir/
	my $mesgcount = 0;
	my $crlfcount = 0;
	my $xuidlisok = 0;
	my $emailsize = 0;
	my $emailmesg = q();
	my $emailfile = undef();
	my $savedname = undef();
	my $messageFH = undef();
	my $uidlistFH = undef();
	my $uidlistfn = q();

	open( $mailboxFH, q{<}, $Mailbox ) || e('Cannot open the mailbox: '.$Mailbox);

	p( 'Write each email: ' ) if( $Verbose );
	p( "\n" ) if( $Verbose > 1 );

	if( $ValidID )
	{
		if( $WhatMDA eq 'dovecot' && ! -e "$Maildir/dovecot-uidlist" )
		{
			$uidlistfn = $Maildir.q{/dovecot-uidlist};
			open( $uidlistFH, q{>>}, $uidlistfn ) || e('Cannot write '.$uidlistfn);
			printf( $uidlistFH "%d V%d N%d\n", 3, $ValidID, scalar(@$emaildata) + 1 );

			my $_uidvalidityFH = undef();
			my $_uidvalidity16 = sprintf("%08x",$ValidID);

			foreach my $f ( 'dovecot-uidvalidity', 'dovecot-uidvalidity.'.$_uidvalidity16 )
			{
				next() if( -e "$Maildir/$f" );
				open( $_uidvalidityFH, q{>}, "$Maildir/$f" );
				close( $_uidvalidityFH );
				chown( $UserUID, $UserGID, "$Maildir/$f" ) if( $> == 0 );
				chmod( 0600, "$Maildir/$f" );
			}
		}
	}


	WRITE_MESSAGES: while( my $eachline = <$mailboxFH> )
	{
		if( $eachline =~ m{\AFrom[ ]}s )
		{
			if( defined($messageFH) && ref($messageFH) eq q|GLOB| && length($emailmesg) )
			{
				# Check MD5
				$md5digest = Digest::MD5::md5_hex($emailmesg);
				$savedname = sprintf("%s/%s/%d.%s_0.%s:%s",
							$Maildir, $emaildata->[$mesgcount]->{'dest'},
							$emaildata->[$mesgcount]->{'time'}->epoch(), $md5digest, $TheHost,
							$emaildata->[$mesgcount]->{'flag'} eq q{} ? q{} : '2,'.$emaildata->[$mesgcount]->{'flag'}
						);

				if( ( scalar(@$md5hashes) && grep { $md5digest eq $_ } @$md5hashes ) || ( -f $savedname && -e _ && -s _ ) )
				{
					# The file that has same MD5 Digest exists!
					close( $messageFH );
					unlink( $emailfile );
					p( '_' ) if( $Verbose == 1 );
					printf( STDERR " Skip %s/%s ... [skip]\n",
							$emaildata->[$mesgcount]->{'dest'}, 
							File::Basename::basename($savedname) ) if( $Verbose > 1 );
				}
				else
				{
					# Write email message and close previous message's file handle
					printf( $messageFH "%s", $emailmesg );
					close( $messageFH );
					rename( $emailfile, $savedname );
					chown( $UserUID, $UserGID, $savedname ) if( $> == 0 );
					chmod( 0600, $savedname );
					$emailsize = -s $savedname;

					# Maildir++ Format
					MAILDIR_PP: {
						my $_newfname = $savedname;
						$_newfname =~ s{[.]$TheHost}{.$TheHost,S=$emailsize,W=($emailsize+$crlfcount)};
						rename( $savedname, $_newfname );
						$savedname = $_newfname;
					}

					if( defined($uidlistFH) )
					{
						# Write UIDL file
						if( $WhatMDA eq 'dovecot' )
						{
							printf( $uidlistFH "%d W%d :%s\n",
								$mesgcount, $emailsize, File::Basename::basename($savedname) );
						}
					}

					p( '*' ) if( $Verbose == 1 );
					printf( STDERR " Write %s/%s ... [done]\n",
							$emaildata->[$mesgcount]->{'dest'},
							File::Basename::basename($savedname) ) if( $Verbose > 1 );
				}

				$mesgcount++;
				last() if( $eachline =~ m{\AFrom MAILER-DAEMON-AS-SENTINEL} );

			}


			# Initialize
			if( $emaildata->[$mesgcount]->{'skip'} == 1 )
			{
				printf( STDERR " (%04d) Skip, %s\n", ( $mesgcount + 1 ),
					$emaildata->[$mesgcount]->{'reason'} ) if( $Verbose > 1 );
				p( '_' ) if( $Verbose == 1 );
				$mesgcount++;
				next();
			}

			# See http://www.dovecot.jp/wiki/MailboxFormat.Maildir.txt
			$crlfcount = 0;
			$md5digest = q();
			$emailmesg = q();
			$emailsize = 0;
			$xuidlisok = 0;
			$emailfile = sprintf("%s/%s/%d.%x.%x_%05d.%s%s",
						$Maildir, $emaildata->[$mesgcount]->{'dest'},
						$emaildata->[$mesgcount]->{'time'}->epoch(), time(), $$, ( $mesgcount + 1 ), $TheHost,
						$emaildata->[$mesgcount]->{'flag'} eq q{} ? q{} : ':2,'.$emaildata->[$mesgcount]->{'flag'}
					);
			open( $messageFH, q{>>}, $emailfile );
			printf( STDERR " (%04d)", $mesgcount + 1 ) if( $Verbose > 1 );
		}
		else
		{
			# Write each line
			next() if( defined($emailfile) && ! defined($messageFH) );

			if( $xuidlisok == 0 && $eachline =~ m{^$} && $emaildata->[$mesgcount]->{'xuidl'} )
			{
				# Convert from X-UID field to X-UIDL field
				#  * Dovecot: "pop3_reuse_xuidl = yes" is required in dovecot.conf
				$emailmesg .= sprintf("X-UIDL: %d\n", $emaildata->[$mesgcount]->{'xuidl'} );
				$emailmesg .= qq(\n);
				$xuidlisok  = 1;
			}
			elsif( $eachline =~ m{\AStatus:[ ]([A-Z]+)\s+\z}s && $emaildata->[$mesgcount]->{'flag'} )
			{
				# Write the contents of 'Status:' field as X-Mbox-Status and X-Message-Flags
				$emailmesg .= sprintf("X-Mbox-Status: %s\n", $1 );
				$emailmesg .= sprintf("X-Message-Flags: %s\n", $emaildata->[$mesgcount]->{'flag'} );
			}
			else
			{
				$emailmesg .= $eachline;
			}
			$crlfcount++;
		}
	}


	printf( STDERR "(%s)\n", $mesgcount ) if( $Verbose == 1 );

	close($mailboxFH);
	unlink($Mailbox);

	if( defined($uidlistFH) )
	{
		close($uidlistFH);
		chown( $UserUID, $UserGID, $uidlistfn ) if( $> == 0 );
		chmod( 0600, $uidlistfn );
	}

}
else
{
	help();
	exit(1);
}


__END__
