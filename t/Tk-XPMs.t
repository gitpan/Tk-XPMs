# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl 1.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test::More tests => 2 + 44;
BEGIN {
  use Tk::XPMs ":all";
  ok(1, "use");
};

#########################

# Insert your test code below, the Test::More module is use()ed here so read
# its man page ( perldoc Test::More ) for help writing this test script.

#===================================================================

use Tk;
use Tk::ErrorDialog;

use strict;


my $top = MainWindow->new();


my $VERSION = "1.01";
$top -> configure( -title => "$0   Revision: $VERSION",
);
#

# Menubar
# -------
my $menubar = $top->Frame( -relief => "raised", -borderwidth => 2);

########
# File #
########
my $mb_file = $menubar->Menubutton(
  -text      => "File",
  -underline => 0,
);

$mb_file->separator();
$mb_file->command(
  -label     => "Exit", 
  -command   => sub { 
      ok(1, "exit menu");
      exit 0} ,
  -underline => 0,
);
#-------

# Application window
# ------------------


my $b1 = $top->Button(
  -text     => "click to finish the test ...",
  -command   => sub{
    ok(1, "exit");
    exit;
                },
);

# Status line
# -----------
my $status = "";
my $lb_status_line = $top->Label(
  -textvariable => \$status,
  -relief       => 'sunken',
);

# pack all
# --------
$menubar -> pack(-side => "top", -fill => 'x');
$mb_file -> pack(-side => "left");

$b1 -> pack();
my $frm = $top->Frame();
$frm->pack;

my ($i, $j) = (0, 0);
foreach my $xp ( list_xpms() ) {
  my $p1;
  eval "\$p1 = \$top->Pixmap(-data=>${xp}());";
  ok(!$@, $xp);
  my $b1 = $frm->Button(
    -image     => $p1,
    -width     => 34,
    -height     => 34,
    -command   => sub{
                    $status = "${xp}()";
                  },
    -state     => "normal",
    ) ;
   
  $b1-> grid(-column => $j, -row => $i, -sticky => "w", -padx => 3, -pady => 3);
  $j = ($j+1)%5;
  $i++ if $j == 0;
} # foreach $xp


$lb_status_line -> pack(-side => 'bottom', -expand => 'no', -fill => 'x');

# Main Event Loop
# ---------------
MainLoop;

__END__

# vim:foldmethod=marker:foldcolumn=4:ft=perl

