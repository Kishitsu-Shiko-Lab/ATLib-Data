#!/usr/bin/perl
use strict;
use warnings;
use Test::More tests => 12;

use ATLib::Std;

my $class = q{ATLib::Data::Column};

#1
use_ok($class);

#2
my $column_name = 'column_name_bare';
my $data_type = 'ATLib::Std::Number';
my $instance = ATLib::Data::Column->create($column_name, $data_type);
isa_ok($instance, $class);

#3
is($instance->type_name, $class);

#4
ok($instance->column_name->equals($column_name));

#5
ok($instance->data_type->equals($data_type));

#6
my $column_name_str = ATLib::Std::String->from('column_name_str');
my $data_type_str = ATLib::Std::String->from('ATLib::Std::Int');
$instance = ATLib::Data::Column->create($column_name_str, $data_type_str);
ok($instance->column_name->equals($column_name_str));

#7
ok($instance->data_type->equals($data_type_str));

#8
$data_type_str = ATLib::Std::String->from('ATLib::Std::String');
$instance = ATLib::Data::Column->create($column_name_str, $data_type_str);
ok($instance->data_type->equals($data_type_str));

#9
$data_type_str = ATLib::Std::String->from('ATLib::Std::DateTime');
$instance = ATLib::Data::Column->create($column_name_str, $data_type_str);
ok($instance->data_type->equals($data_type_str));

#10
is($instance->equals($instance), 1);

#11
is($instance->caption, $column_name_str);

#12
my $caption_bare = "column_caption_bare";
my $caption_str = ATLib::Std::String->from($caption_bare);
$instance->caption($caption_bare);
is($instance->caption, $caption_str);

done_testing();
__END__
