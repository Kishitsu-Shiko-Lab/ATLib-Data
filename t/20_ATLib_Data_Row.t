#!/usr/bin/perl
use strict;
use warnings;
use Test::More tests => 17;

use ATLib::Std::Int;
use ATLib::Std::String;
use ATLib::Data::Column;
use ATLib::Data::Table;

my $class = q{ATLib::Data::Row};

#1
use_ok($class);

#2
my $table = ATLib::Data::Table->create();
$table->columns->add(ATLib::Data::Column->create(q{Key}, q{ATLib::Std::Int}));
$table->columns->add(ATLib::Data::Column->create(q{Value}, q{ATLib::Std::String}));
my $instance = $table->create_new_row();
isa_ok($instance, $class);

#3
is($instance->type_name, $class);

# Read by index
#4
ok(!defined $instance->item(0));

#5
ok(!defined $instance->item(1));

# Read by name of column
#6
ok(!defined $instance->item($table->columns->item(0)->column_name));

#7
ok(!defined $instance->item($table->columns->item(1)->column_name));

# Write by index
my %row1 = ( Key => 1, Value => q{Record 1.});
$instance->item(ATLib::Std::Int->from(0), ATLib::Std::Int->from($row1{Key}));
$instance->item(ATLib::Std::Int->from(1), ATLib::Std::String->from($row1{Value}));

#8
isa_ok($instance->item(0), $table->columns->item(0)->data_type);

#9
isa_ok($instance->item(1), $table->columns->item(1)->data_type);

#10
is($instance->item(0), $row1{Key});

#11
is($instance->item(1), $row1{Value});

# Write by name of column
my %row2 = ( Key => 2, Value => q{Record 2.});
$instance = $table->create_new_row();
$instance->item($table->columns->item(0)->column_name, ATLib::Std::Int->from($row2{Key}));
$instance->item($table->columns->item(1)->column_name->as_string(), ATLib::Std::String->from($row2{Value}));

#12
is($instance->item($table->columns->item(0)->column_name), $row2{Key});

#13
is($instance->item($table->columns->item(1)->column_name->as_string()), $row2{Value});

#14
ok($instance->equals($instance));

#15
my $row = $table->create_new_row();
ok(!$instance->equals($row));

#16
ok(!$instance->equals(9999));

#17
ok(!$instance->equals(q{ATLib::Data::Row}));

done_testing();
__END__