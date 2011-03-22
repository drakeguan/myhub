#!/usr/bin/perl

#    Copyright (C) 2002 Zaheer Merali, Peter Oliver
#
#    Bits of code taken from source of BINS Photo Album
#    Copyright (C) 2001,2002 Jérôme Sautret (Jerome@Sautret.org)
#
#    This program is free software; you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation; either version 2 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program; see the file COPYING.  If not, write to
#    the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
#    Boston, MA 02111-1307, USA.

use Getopt::Long;
use Pod::Usage;

my @knownImageExtentions = ("jpg", "jpeg", "gif", "png", "tiff",
			    "bmp", "tga", "ps", "eps", "fit", "pcx",
			    "miff", "pix", "pnm", "rgb", "im1", "xcf",
			    "xwd", "xpm", "avs", "dcm", "dcx", "dib",
			    "dps", "dpx", "epdf", "epi", "ept", "fpx",
			    "icb", "mat", "mtv", "pbm", "pcd", "pct",
			    "pdb", "ppm", "ptif", "pwp", "ras",
			    );
my $directory = "";
my @layouts = ( 'wallpaper', 'centered', 'scaled', 'stretched' );
my %option;

main();

sub process_arguments {
	my $layout;
	foreach $layout ( @layouts ) {
		$option{ $layout } = [];
	}
	
	my $help;
#	Getopt::Long::Configure("bundling");  # Useless without more options
	GetOptions(
		   'help|h' => \$help,
		   'wallpaper=s' => $option{'wallpaper'},
		   'centered=s' => $option{'centered'},
		   'scaled=s' => $option{'scaled'},
		   'stretched=s' => $option{'stretched'},		   
		   ) or pod2usage( 2 );
	pod2usage( 1 ) if $help;
	
	foreach $layout ( @layouts ) {
		goto allclear if @{ $option{ $layout } };
	}
	pod2usage( 2 );
      allclear:
	
}
# This builds up a list of picture filenames, given a root directory to check
sub build_picture_list {
	my $rootdir = shift(@_);
	my @imagelist;
	opendir(DIR, "$rootdir") || die "can't open dir $rootdir: $!";
  	my @filesInDir = grep { !/^\./ } readdir(DIR);
  	closedir DIR;
	my $fileInDir;
	foreach $fileInDir (@filesInDir) {
		# print "Now testing $fileInDir in $rootdir\n";
		if ( -d "$rootdir/$fileInDir") {
			my @subdirfiles = build_picture_list("$rootdir/$fileInDir");
			my $subdirfile;
			foreach $subdirfile (@subdirfiles) {
				# print "SD: Putting $subdirfile in image list\n";
				
				push @imagelist,"$subdirfile";
			}
		}
		else {
			my $known = 0;
      			foreach my $ext (@knownImageExtentions){
				if ($fileInDir =~ /\.$ext\Z/i) {
	  				$known = 1;
					last;
				}
			}
			if ($known) {
				# this is a known image format--remember its name
				# print "FI: Putting $rootdir/$fileInDir in image list\n";
				push @imagelist,"$rootdir/$fileInDir";
				 
			}
		}
	}
	return @imagelist;
}

# This picks a random picture from list
sub pick_random_picture {
	my %pictures = @_;

	my $total;
	my $key;
	foreach $key ( keys %pictures ) {
		$total += scalar( @{ $pictures{$key} } );
	}
	my $index = int rand($total);

	foreach $key ( keys %pictures ) {
		my $no = scalar( @{ $pictures{$key} } );
		if ( $index < $no ) {
			return $key, $pictures{ $key }[ $index ];
		}
		$index -= $no;
	}
}

sub change_gnome2_background {
        my $picture_options = shift;
	my $picture_filename = shift(@_);
	exec "gconftool-2 -t string -s /desktop/gnome/background/picture_filename \"$picture_filename\" -s /desktop/gnome/background/picture_options $picture_options 2> /dev/null";
}

sub main {
	srand();
	process_arguments();

	my %pictures;
	my $layout;
	foreach $layout ( @layouts ) {
		my $dir;
		foreach $dir ( @{ $option{$layout} } ) {
			push @{ $pictures{$layout} }, build_picture_list($dir);
		}
	}

	change_gnome2_background( pick_random_picture( %pictures ) );
}

__END__

=head1 NAME

chbg-gnome2.pl - Pick a random background picture for GNOME 2.

=head1 SYNOPSIS

chbg-gnome2.pl ( B<--wallpaper>=I<dir> | B<--centered>=I<dir> | B<--scaled>=I<dir> | B<--stretched>=I<dir> ) ...

=head1 OPTIONS

=over 8

=item I<dir>

A random picture from these directories, including sub directories, is
chosen, and set as the background.

=item B<--wallpaper>=I<dir> B<--centered>=I<dir> B<--scaled>=I<dir> B<--streched>=I<dir>

How the images in the given directories should be displayed.  Described in detail in L<ghelp:user-guide#goscustdesk-7>.

=back

=head1 SEE ALSO

L<http://www.mavit.pwp.blueyonder.co.uk/chbg-gnome2/>,
L<http://zaheer.grid9.net/chbg-gnome2/>

=head1 VERSION

0.0.2-pdo-fork
