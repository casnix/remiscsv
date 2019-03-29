use strict;
use warnings;
use boolean ':all';

use GlobalEnvironment;
use Debugger;
use Popsoof::Messenger;

package Packet;
our @ISA = qw(Popsoof::Messenger);

#
# Global variables for internal use
use constant lclDebugger => Debugger->new('packet');
#
#

#
# Private functions declared
my $LastNameSort;
my $FirstNameSort;
my $GetEmail;
my $CopyCell;
#
#

#
# Private functions implemented

# string $LastNameSort($) -- prop. packet.
$LastNameSort = sub {
  lclDebugger->Register('$LastNameSort');
  lclDebugger->OpenHere();

  my $this = shift;
  my $cell = shift;

  if(ref $cell ne "SCALAR") return "";

  my $regex = qr/,\s.*$/;

  return "Last Name" unless $cell =~ $regex;

  $cell =~ $regex;
  lclDebugger->Note("\$cell before: $`");
  lclDebugger->Note("\$cell match: $&");
  lclDebugger->Note("\$cell after: $'");

  my $lastName = $`;
  return $lastName;
}

# string $FirstNameSort($) -- prop. packet.
$LastNameSort = sub {
  lclDebugger->Register('$FirstNameSort');
  lclDebugger->OpenHere();

  my $this = shift;
  my $cell = shift;

  if(ref $cell ne "SCALAR") return "";

  my $regex = qr/,\s.*$/;

  return "Last Name" unless $cell =~ $regex;

  $cell =~ $regex;
  lclDebugger->Note("\$cell before: $`");
  lclDebugger->Note("\$cell match: $&");
  lclDebugger->Note("\$cell after: $'");

  my $lastName = $`;
  return $lastName;
}
