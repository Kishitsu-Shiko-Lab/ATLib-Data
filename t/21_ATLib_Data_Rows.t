#!/usr/bin/perl
use strict;
use warnings;
use Test::More tests => 17;
use Test::Exception;

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
is($instance->type_name, $class);

#4
is($instance->count, 0);

#5
my $row1 = $table->create_new_row();
$instance = $instance->add($row1);
is($instance->count, 1);

#6
isa_ok($instance->item(0), q{ATLib::Data::Row});

#7
is($instance->item(0)->get_hash_code(), $row1->get_hash_code());

#8
my $row2 = $table->create_new_row();
$instance = $instance->add($row2);
is($instance->count, 2);

#9
is($instance->item(1)->get_hash_code(), $row2->get_hash_code());

#10
$instance = $instance->remove_at(0);
is($instance->count, 1);

#11
is($instance->item(0)->get_hash_code(), $row2->get_hash_code());

#12
$instance = $instance->add($row1);
is($instance->count, 2);

#13
is($instance->item(ATLib::Std::Int->from(1))->get_hash_code(), $row1->get_hash_code());

#14
$instance = $instance->remove($row2);
is($instance->count, 1);

#15
$instance = $instance->clear();
is($instance->count, 0);

#16
my $table_other = ATLib::Data::Table->create();
$table_other->columns->add(ATLib::Data::Column->create(q{Key}, q{ATLib::Std::Int}));
$table_other->columns->add(ATLib::Data::Column->create(q{Value}, q{ATLib::Std::String}));
my $row_other = $table_other->create_new_row();
my $message = "This row belongs to other table.";
throws_ok { $table->rows->add($row_other); } qr/$message/, q{Specified other table's row.};

#17
$table_other->rows->add($row_other);
$message = "This row already belongs to this table.";
throws_ok { $table_other->rows->add($row_other); } qr/$message/, q{Specified the duplicate row.};

done_testing();
__END__