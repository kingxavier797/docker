#!/usr/bin/perl
#
# NAME
#       preface.cgi - counts the number of customers accessing this site.
#
# AUTHOR
#       Andialy Sokone
#       Copyrigh Oct 06, 2004.
#       Tel: Home (770) 393 3675
#       Email: asokone@thecloudedu.com
#
# #############################################################################
# ########################       MAIN ROUTINE HERE      #######################
# #############################################################################
# *****************************************************************************
#                                               QUELQUES HELPFUL FUNCTIONS HERE
# *****************************************************************************
# Function Name: LaPub
# Author       : Andialy Sokone - Copyright: Wed Nov  1, 2000
# Usage        : This function make to display commercial banner in any webpage
#                and uses the vile javapubscript.txt located in the directory
#                $BASE//html/
# ============================= START OF PUB ==================================
sub laPub {
                local($JAVAPUBSCRIPT);
                $JAVAPUBSCRIPT="$BASE/html/javapubscript.txt";
                print "<CENTER>\n";
                open (F, "cat $JAVAPUBSCRIPT |") || die "Can't open $JAVAPUBSCRIPT :$!\n";
                while(<F>) {
                                chop $_;
                                print "$_\n";
                }
                close(F);
                print "</CENTER>\n";
}
sub copyRight() {
                local($COPYRIGHT);
                $COPYRIGHT="$BASE/html/copyright.txt";
                print "<CENTER>\n";
                open (F, "cat $COPYRIGHT |") || die "Can't open $COPYRIGHT :$!\n";
                while(<F>) {
                                chop $_;
                                print "$_\n";
                }
                close(F);
                print "</CENTER>\n";
}
# *****************************************************************************
$BASE="/var/www/";

# *****************************************************************************
print "Content-type:text/html\n";
print "\n";                     # This new line is very important

$file = "counter.txt";
open (FILE, "+>>" . $file) or
        die "cannot open $file for reading and appending: $!";
flock(FILE, 2) or
        die "cannot lock $file exclusively: $!";

seek FILE, 0, 0;

my @file_value = <FILE>;

truncate FILE, 0;

my $counter;

if ($file_value[0] =~ /^(\d+)$/)
{
        # If the value read in the file is a valid number
        # then set the value of the variable $counter
        # to the value read from the file
   $counter = $1;
        # $1 is captured by the ()'s in the regular expression
}
else
{
   $counter = 'COUNTER ERROR';  # the regular expression didn't match
}

$counter++;  # auto-increment the same variable with 1

                # NOTE: If count doesn't increase verify the write permission
                # and owner of the file.
print FILE $counter;
close (FILE);

print<<END;
<html>
<head>
<title>My Visitor Tracking Web Site</title>
</head>
END
# *****************************************************************************
#                                                       APPEL A LA PUB
# *****************************************************************************
&laPub();
# *****************************************************************************
$modulo=$counter%10;
$newcounter=$counter;
chop $newcounter;
#print "============= $newcounter|$modulo<BR\n";

print<<END;
<hr noshade>
<center>
	<blink>
	<font color=\"#0033ff\" size=5>HISTORY OF DOCKER</font><font color=\"black\" size=1><br>YOU ARE VISITOR NUMBER</font>

	</blink>
	<table border=2 cellpadding=0 cellspacing=0>
	<tr bgcolor=#191970>
		<td>
	<font color=\"#33FF00\" size=5>$newcounter</font>
	<font color=white size=5>$modulo</font>
		</td>
	</tr>
	</table>
END
# ------------------------------------------
my $htmlfile = '/var/www/html/customer.html';

open(HF, '<', $htmlfile) or 
	die "cannot open $htmlfile for reading and appending: $!";

while(<HF>){
   print $_;
}
close(FH);
# ------------------------------------------
print<<END;
<hr noshade>
<center>
Click to hit Andialy Sokone's<a href="/AndialySokone.html">Web site</a>.
<hr noshade>
<font color=red><i>Pubpag V1.0 - (My Pub page) - Written by  <a href="mailto:andialy.sokone\@gmail.com?subject=Someone using your Docker Hub Image">Andialy Sokone</a><i></font>
<hr noshade>
<a href="/copyright.html">Terms and Conditions of Use</a>.
</center>
</body>
</html>
END
#&copyRight();
# ----------------------------------- en of script ----------------------------
# *****************************************************************************
