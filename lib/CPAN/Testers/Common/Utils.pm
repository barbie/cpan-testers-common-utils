# Copyright (c) 2010 by David Golden. All rights reserved.
# Licensed under Apache License, Version 2.0 (the "License").
# You may not use this file except in compliance with the License.
# A copy of the License was distributed with this file or you may obtain a 
# copy of the License from http://www.apache.org/licenses/LICENSE-2.0

package CPAN::Testers::Common::Utils;
use strict;
use warnings;

our $VERSION = '0.001';
$VERSION = eval $VERSION; ## no critic

use Exporter ();
our @ISA = qw/Exporter/;
our @EXPORT_OK = qw(
  nntp_to_guid 
  guid_to_nntp
);
our %EXPORT_TAGS = (
  all => [@EXPORT_OK]
);

#--------------------------------------------------------------------------#
# NNTP <-> GUID
#--------------------------------------------------------------------------#

# Base GUID generated with:
# Data::UUID->new->create_from_name_str(
#   NameSpace_URL, "http://nntp.x.perl.org/group/perl.cpan.testers"
# );

my $base_guid = "ED372D00-B19F-3F77-B713-D32BBA55D77F";

sub nntp_to_guid {
  my ($nntp_id) = @_;
  my $guid = $base_guid;
  substr($guid, 0, 8, sprintf("%08d",$nntp_id)); # zero padded
  return $guid;
}

sub guid_to_nntp {
  my ($guid) = @_;
  my ($nntp_id) = $guid =~ m{\A0*([0-9]{1,7})}; # strip leading zeros
  return $nntp_id;
}

1;

__END__

=begin wikidoc

= NAME

CPAN::Testers::Common::Utils - Utility functions for CPAN Testers modules

= VERSION

This documentation describes version %%VERSION%%.

= SYNOPSIS

    use CPAN::Testers::Common::Utils ':all';

    # NNTP ID <=> GUID mapping
    $guid    = nntp_to_guid( $nntp_id );
    $nntp_id = guid_to_nntp( $guid    );

= DESCRIPTION

This module contains common utility functions for use by other CPAN Testers
modules

= USAGE

== Mapping NNTP IDs to GUIDS

Legacy CPAN Testers reports were sent via email and made available via an NNTP
group, perl.cpan.testers.  Reports were 'indexed' by their NNTP ID.  The next
generation of CPAN Testers uses a GUID to identify reports.  

Old reports with an NNTP ID are mapped to GUIDs by replacing the first 8 hex
characters of a common 'base GUID' with a zero-padded decimal representation of
the NNTP ID.  

  XXXXXXXX-B19F-3F77-B713-D32BBA55D77F
  
Such GUIDS are visually distinctive and have the nice feature of
sorting earlier than second-generated report GUIDS based on a timestamp.

Two translation functions are provided for convenience.

=== {nntp_to_guid}

    $guid    = nntp_to_guid( $nntp_id );

Given a numeric NNTP ID, returns a standard string-form GUID.  (No range
checking is done.) Examples: 

  nntp_to_guid( 51432   );  # 00051432-B19F-3F77-B713-D32BBA55D77F
  nntp_to_guid( 6171265 );  # 06171265-B19F-3F77-B713-D32BBA55D77F

=== {guid_to_nntp}

    $guid    = nntp_to_guid( $nntp_id );

Given a GUID of the form described above, returns the decimal number
in the first 8 characaters.  (Again, there is no error checking that
the GUID is properly formatted.)  Examples:

  guid_to_nntp( '00051432-B19F-3F77-B713-D32BBA55D77F' ); # 51432
  guid_to_nntp( '06171265-B19F-3F77-B713-D32BBA55D77F' ); # 6171265 
  
= BUGS

Please report any bugs or feature requests using the CPAN Request Tracker  
web interface at [http://rt.cpan.org/Dist/Display.html?Queue=CPAN-Testers-Common-Utils]

When submitting a bug or request, please include a test-file or a patch to an
existing test-file that illustrates the bug or desired feature.

= SEE ALSO

* Data::GUID
* Data::UUID

= AUTHOR

David A. Golden (DAGOLDEN)

= COPYRIGHT AND LICENSE

Copyright (c) 2010 by David A. Golden. All rights reserved.

Licensed under Apache License, Version 2.0 (the "License").
You may not use this file except in compliance with the License.
A copy of the License was distributed with this file or you may obtain a 
copy of the License from http://www.apache.org/licenses/LICENSE-2.0

Files produced as output though the use of this software, shall not be
considered Derivative Works, but shall be considered the original work of the
Licensor.

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

=end wikidoc

=cut

