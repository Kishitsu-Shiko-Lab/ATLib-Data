#!/usr/bin/perl
use strict;
use warnings;
use Test::More tests => 14;

use ATLib::Std::Int;
use ATLib::Data::Table;

my $class = q{ATLib::Data::Rows};

#1
use_ok($class);

#2
my $table = ATLib::Data::Table->create();
$table->columns->add(ATLib::Data::Column->create(q{Key}, q{ATLib::Std::Int}));
$table->columns->add(ATLib::Data::Column->create(q{Value}, q{ATLib::Std::String}));
my $instance = $table->rows;
isa_ok($instance, $class);

#3
is($instance->count, 0);

#4
my $row1 = $table->create_new_row();
$instance = $instance->add($row1);
is($instance->count, 1);

#5
isa_ok($instance->items(0), q{ATLib::Data::Row});

#6
is($instance->items(0)->get_hash_code(), $row1->get_hash_code());

#7
my $row2 = $table->create_new_row();
$instance = $instance->add($row2);
is($instance->count, 2);

#8
is($instance->items(1)->get_hash_code(), $row2->get_hash_code());

#9
$instance = $instance->remove_at(0);
is($instance->count, 1);

#10
is($instance->items(0)->get_hash_code(), $row2->get_hash_code());

#11
$instance = $instance->add($row1);
is($instance->count, 2);

#12
is($instance->items(ATLib::Std::Int->from(1))->get_hash_code(), $row1->get_hash_code());

#13
$instance = $instance->remove($row2);
is($instance->count, 1);

#14
$instance = $instance->clear();
is($instance->count, 0);

done_testing();
__END__