package ATLib::Data::Row;
use Mouse;
extends 'ATLib::Std::Collections::Dictionary';

use ATLib::Utils qw{ is_int as_type_of};
use ATLib::Std::Int;
use ATLib::Data::Column;
use ATLib::Data::Columns;

# Attributes
has 'table' => (is => 'ro', isa => 'ATLib::Data::Table', required => 0, writer => '_set_table');

sub items
{
    my $self = shift;
    my $index_or_name = shift;
    my $data = shift if (scalar(@_));

    if (is_int($index_or_name) || as_type_of('ATLib::Std::Int', $index_or_name))
    {
        my $name = $self->table->columns->items($index_or_name)->column_name;
        if (defined $data)
        {
            $self->SUPER::items($name, $data);
            return;
        }
        else
        {
            return $self->SUPER::items($name);
        }
    }
    else
    {
        my $name = '';
        if (as_type_of('Str', $index_or_name))
        {
            $name = ATLib::Std::String->from($index_or_name);
        }
        else
        {
            $name = $index_or_name;
        }

        if (defined $data)
        {
            $self->SUPER::items($name, $data);
            return;
        }
        else
        {
            return $self->SUPER::items($name, $data);
        }
    }
}

# Class Methods
sub _from
{
    my $class = shift;
    my $table = shift;

    my $instance = $class->of('ATLib::Std::String', 'ATLib::Std::Any');
    $instance->_set_table($table);
    for my $column_name (@{$instance->table->columns->get_keys_ref()})
    {
        $instance->add($column_name, undef);
    }
    return $instance;
}

# Instance Methods
sub _can_equals
{
    shift;
    my $target = shift;
    return as_type_of('ATLib::Data::Row', $target);
}

sub equals
{
    my $self = shift;
    my $row = shift;

    if ($self->_can_equals($row))
    {
        if ($self->get_hash_code() eq $row->get_hash_code())
        {
            return 1;
        }
    }
    return 0;
}

__PACKAGE__->meta->make_immutable();
no Mouse;
1;

=encoding utf8

=head1 名前

ATLib::Data::Row - L<< ATLib::Data::Table >>マトリクス構造内の行

=head1 バージョン

この文書は ATLib::Data version v0.3.1 について説明しています。

=head1 概要

    use ATLib::Data::Table;
    use ATLib::Data::Column;
    use ATLib::Data::Row;

    my $table = ATLib::Data::Table->create();
    $table-columns->add(ATLib::Data::Column->create('column1', 'ATLib::Std::Int'));
    $table-columns->add(ATLib::Data::Column->create('column2', 'ATLib::Std::String'));

    my $row = $table->create_new_row();
    $row->items('column1', 1);
    $row->items('column2', 'Row data (1)');
    $table->rows->add($row);

    my $column1_value = $table->rows->items(0)->items(0);
    # or
    my $column1_value = $table->rows->items(0)->items('column1');

    $table->rows->items(0)->items(0, 2);
    # or
    $table->rows->items(0)->items('column1', 2);

=head1 基底クラス

L<< ATLib::Std::Any >> E<lt>- L<< ATLib::Std::Collections::Dictionary >>

=head1 説明

ATLib::Data::Rowは、L<< ATLib::Data::Table >>内の行を表します。

=head1 プロパティ

=head2 C<< $data = $instance->items($index_or_name[, $data]); >> -E<gt> L<< ATLib::Std::Any >>

列名、または列索引$index_or_nameに格納されているデータを取得、または設定します。

=head2 C<< $table = $instance->table; >> -E<gt> L<< ATLib::Data::Table >>

行が属するL<< ATLib::Data::Table >>オブジェクトを取得します。

=head1 インスタンスメソッド

=head2 C<< $result = $instance->equals($row); >> -E<gt> Bool

指定した$rowが同じインスタンスかどうかを判定します。

=head1 AUTHOR

atdev01 E<lt>mine_t7 at hotmail.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2020-2023 atdev01.

This library is free software; you can redistribute it and/or modify
it under the same terms of the Artistic License 2.0. For details,
see the full text of the license in the file LICENSE.

=cut