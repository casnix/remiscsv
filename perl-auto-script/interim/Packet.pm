use strict;
use warnings;
use boolean ':all';

use GlobalEnvironment;
use Debugger;
use Popsoof::Messenger;
use Popsoof::String;

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

  if(ref $cell->Value ne "SCALAR") return "";

  my $regex = qr/,\s.*$/;

  return "Last Name" unless $cell->Filter($regex);

  lclDebugger->Note("\$cell before: ".$cell->Before($regex));
  lclDebugger->Note("\$cell match: ".$cell->Filter($regex));
  lclDebugger->Note("\$cell after: ".$cell->After($regex));

  my $lastName = Popsoof::String->new($cell->Filter($regex));
  return $lastName;
}

# string $FirstNameSort($) -- prop. packet.
$FirstNameSort = sub {
  lclDebugger->Register('$FirstNameSort');
  lclDebugger->OpenHere();

  my $this = shift;
  my $cell = shift;

  if(ref $cell->Value ne "SCALAR") return "";

  my $regex = qr/^.*,\s/;

  return "First Name" unless $cell->Filter($regex);

  lclDebugger->Note("\$cell before: ".$cell->Before($regex));
  lclDebugger->Note("\$cell match: ".$cell->Filter($regex));
  lclDebugger->Note("\$cell after: ".$cell->After($regex));

  my $firstName = Popsoof::String->new($cell->Filter($regex));
  return $firstName;
}

# string GetEmail($) -- prop. packet.
$GetEmail = sub {
  lclDebugger->Register('$GetEmail');
  lclDebugger->OpenHere();

  my $this = shift;
  my $cell = shift;

  if(ref $cell->Value ne "SCALAR") return "";

  my $regex = qr/,\s.*$/;

  return "Email" unless $cell->Filter($regex);

  lclDebugger->Note("\$cell before: ".$cell->Before($regex));
  lclDebugger->Note("\$cell match: ".$cell->Filter($regex));
  lclDebugger->Note("\$cell after: ".$cell->After($regex));

  my $email = Popsoof::String->new($cell->Filter($regex));
  return $email;
}

#
#

#
# Public functions

#
#

1;
