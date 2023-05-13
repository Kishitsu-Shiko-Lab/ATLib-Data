package ATLib::Data::Table;
use Mouse;
extends 'ATLib::Std::Any';

use ATLib::Utils qw{ as_type_of };
use ATLib::Std::String;
use ATLib::Std::Exception::Argument;
use ATLib::Data::Columns;
use ATLib::Data::Rows;
use ATLib::Data::Row;

# Attributes
has '_table_name' => (is => 'ro', isa => 'ATLib::Std::String', required => 1, writer => '_set__table_name');
has 'columns'     => (is => 'ro', isa => 'ATLib::Data::Columns', required => 1);
has 'rows'        => (is => 'ro', isa => 'ATLib::Data::Rows', required => 1);

sub table_name
{
    my $self = shift;
    my $table_name = shift if (scalar(@_));

    if (defined $table_name)
    {
        if (!as_type_of('Str', $table_name) && !as_type_of('ATLib::Std::String', $table_name))
        {
            ATLib::Std::Exception::Argument->new({
                message    => ATLib::Std::String->from(q{Type miss match. The $table_name must be Str or ATLib::Std::String.}),
                param_name => ATLib::Std::String->from(q{$table_name}),
            })->throw();
        }
        if (as_type_of('Str', $table_name))
        {
            $table_name = ATLib::Std::String->from($table_name);
        }
        $self->_set__table_name($table_name);
        return;
    }
    return $self->_table_name;
}

# Class Methods
sub create
{
    my $class = shift;
    my $table_name = shift if (scalar(@_) > 0);

    if (ATLib::Std::String->is_undef_or_empty($table_name))
    {
        $table_name = ATLib::Std::String->from('Table1');
    }
    else
    {
        if (!as_type_of('Str', $table_name) && !as_type_of('ATLib::Std::String', $table_name))
        {
            ATLib::Std::Exception::Argument->new({
                message    => ATLib::Std::String->from(q{Type miss match. The $table_name must be Str or ATLib::Std::String.}),
                param_name => ATLib::Std::String->from(q{$table_name}),
            })->throw();
        }
        if (as_type_of('Str', $table_name))
        {
            $table_name = ATLib::Std::String->from($table_name);
        }
    }

    my $columns = ATLib::Data::Columns->_create();
    my $rows = ATLib::Data::Rows->_create();
    my $instance = $class->new({
        type_name   => $class,
        _table_name => $table_name,
        columns     => $columns,
        rows        => $rows
    });
    $instance->columns->_set__table($instance);
    return $instance;
}

# Instance Methods
sub create_new_row
{
    my $self = shift;
    return ATLib::Data::Row->_from($self);
}

__PACKAGE__->meta->make_immutable();
no Mouse;
1;

=encoding utf8

=head1 名前

ATLib::Data::Table - マトリクス構造を表す型

=head1 バージョン

この文書は ATLib::Data version v0.2.5 について説明しています。

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

L<< ATLib::Std::Any >>

=head1 説明

ATLib::Data::Table は、データベースのテーブルのようなマトリクス構造を表すクラスです。

=head1 コンストラクタ

=head1 プロパティ

=head2 C<< $table_name = $instance->table_name($table_name); >> -E<gt> L<< ATLib::Std::String >>

本インスタンスのマトリクス構造の名前を取得、または設定します。

=head2 C<< $columns = $instance->columns; >> -E<gt> L<< ATLib::Data::Columns >>

本インスタンスのマトリクス構造に属する列L<< ATLib::Data::Column >>のコレクションを取得します。

=head2 C<< $rows = $instance->rows; >> -E<gt> L<< ATLib::Data::Rows >>

本インスタンスのマトリクス構造に属する行L<< ATLib::Data::Row >>のコレクションを取得します。

=head1 インスタンスメソッド

=head2 C<< $row = $instance->create_new_row(); >> -E<gt> L<< ATLib::Data::Row >>

本インスタンスのマトリクス構造に属する新しい行L<< ATLib::Data::Row >>オブジェクトを生成します。

=head1 AUTHOR

atdev01 E<lt>mine_t7 at hotmail.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2020-2023 atdev01.

This library is free software; you can redistribute it and/or modify
it under the same terms of the Artistic License 2.0. For details,
see the full text of the license in the file LICENSE.

=cut