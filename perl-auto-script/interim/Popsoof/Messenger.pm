use strict;
use warnings;
use boolean ':all'; # Mod: replace with Popsoof::Boolean.

package Popsoof::Messenger;

our @ISA = qw(Popsoof); # Mod: Make Object inherited too.

#
# Static public variables.
my $Silent = false;
my $Minimal = false;
#
#

#
# Private variables.

#
#

#
# Private functions declared.
my %Messenger;
#
#

#
# Private functions implemented.

# void %Messenger{bareword} -- A hash of subroutines for printing messages.
#-- Arguments: bareword, the subroutine key.
#-- Returns: Depends.
%Messenger = (
  # {Levels}->[$]($) -- Print a message at specified level.
  #-- Arguments: $level, the level to print at
  #              $msg, the message to print.
  #-- Returns: Nothing.
  Levels => [
    # Level 0 -- Prints always unless in silent mode.
    sub {
      if($GlobalEnvironment::Silent) return;

      lclDebugger->Register('%Messenger{Levels}->[0]');
      lclDebugger->OpenHere();

      print shift;

      lclDebugger->CloseHere();
    },

    # Level 1 -- Prints unless in silent or minimal mode.
    sub {
      if($GlobalEnvironment::Silent || $GlobalEnvironment::RunSilent) return;

      lclDebugger->Register('%Messenger{Levels}->[1]');
      lclDebugger->OpenHere();

      print shift;

      lclDebugger->CloseHere();
    },
  ],
);

#
#

#
# Public functions

# Messenger new() -- Class constructor.
sub new {
  my $class = shift;

  my $self = Popsoof->new();
  return bless $self, $class;
}

# void Message($ or %) -- Print a message depending on the messaging level.
#-- Argument: Two cases:
# 1-          $msg, a text string to be printed at level 1.
# 2-          %msg => { level => $number, msg => $string}, hashed level and message.
#-- Returns: Nothing.
sub Message {
  if($Silent);

  my $this = shift;

  if(ref $_[0] eq "SCALAR") $Messenger{Levels}->[1](shift);
  if(ref $_[0] eq "HASH") $Messenger{Levels}->[$_[0]->{level}]($_[0]->{msg});
}

#
#

1;
