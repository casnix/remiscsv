use strict;
use warnings;

package Popsoof;

#
# Private variables

#
#

#
# Public variables

#
#

#
# Private functions declared

#
#

#
# Private functions implemented

#
#

#
# Public functions

# Popsoof new(void) -- Popsoof object constructor.
sub new {
  my $class = shift;

  my $self = {
    loggingenginerecords => [ ],
  };

  return bless $self, $class;
}

#
#

1;
