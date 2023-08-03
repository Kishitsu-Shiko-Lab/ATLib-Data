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
ok(!defined $instance->items(0));

#5
ok(!defined $instance->items(1));

# Read by name of column
#6
ok(!defined $instance->items($table->columns->items(0)->column_name));

#7
ok(!defined $instance->items($table->columns->items(1)->column_name));

# Write by index
my %row1 = ( Key => 1, Value => q{Record 1.});
$instance->items(ATLib::Std::Int->from(0), ATLib::Std::Int->from($row1{Key}));
$instance->items(ATLib::Std::Int->from(1), ATLib::Std::String->from($row1{Value}));

#8
isa_ok($instance->items(0), $table->columns->items(0)->data_type);

#9
isa_ok($instance->items(1), $table->columns->items(1)->data_type);

#10
is($instance->items(0), $row1{Key});

#11
is($instance->items(1), $row1{Value});

# Write by name of column
my %row2 = ( Key => 2, Value => q{Record 2.});
$instance = $table->create_new_row();
$instance->items($table->columns->items(0)->column_name, ATLib::Std::Int->from($row2{Key}));
$instance->items($table->columns->items(1)->column_name->as_string(), ATLib::Std::String->from($row2{Value}));

#12
is($instance->items($table->columns->items(0)->column_name), $row2{Key});

#13
is($instance->items($table->columns->items(1)->column_name->as_string()), $row2{Value});

#14
is($instance->equals($instance), 1);

#15
my $row = $table->create_new_row();
is($instance->equals($row), 0);

#16
is($instance->equals(9999), 0);

#17
is($instance->equals(q{ATLib::Data::Row}), 0);

done_testing();
__END__