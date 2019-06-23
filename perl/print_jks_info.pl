use strict;
use warnings;

my $pass = 'changeit';

print "cert full path > ";
my $certFile = <STDIN>;
chomp $certFile;

my $rightIndex = rindex($certFile, '/');
my $certTxtFile = substr($certFile, $rightIndex + 1, length($certFile));

$certTxtFile = substr($certTxtFile, 0, rindex($certTxtFile, '.')) . '.txt';
$certTxtFile = '/c/Users/mouli/scripts/tmp/' . $certTxtFile;
print "certificate text file : $certTxtFile";

# create text file
system("touch $certTxtFile");

# save command output in file
system("keytool -list -v -storepass $pass -keystore $certFile > $certTxtFile");

print "\n";
print("#" x 50);
print "\n";

open(my $fh, '<', $certTxtFile) or die $!;

while (my $row = <$fh>) {
    if (index($row, 'Alias name:') != -1) {
        print $row;
    }

    if (index($row, 'Creation date:') != -1) {
        print $row;
    }

    if (index($row, 'Owner:') != -1) {
        print $row;
    }

    if (index($row, 'Valid from:') != -1) {
        print $row;
    }

    if (index($row, '*******') != -1) {
        print $row;
    }
}

close($fh);