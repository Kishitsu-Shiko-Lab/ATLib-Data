package ATLib::Data::Rows;
use Mouse;
extends 'ATLib::Std::Collections::List';

use ATLib::Utils qw{ is_int as_type_of };
use ATLib::Std;

# Attributes
has '_table' => (is => 'ro', isa => 'ATLib::Data::Table', required => 0, writer => '_set__table');

sub item
{
    my $self = shift;
    my $index = shift;

    if (is_int($index) || as_type_of('ATLib::Std::Int', $index))
    {
        $index = ATLib::Std::Int->value($index);
    }
    else
    {
        ATLib::Std::Exception::Argument->new({
            message    => ATLib::Std::String->from(q{Type miss match. The $index must be Int or ATLib::Std::Int.}),
            param_name => ATLib::Std::String->from(q{$index}),
        })->throw();
    }
    return $self->SUPER::item($index);
}

# Builder
sub BUILDARGS
{
    my ($class, $args_ref) = @_;
    $class->SUPER::BUILDARGS($args_ref);
    return $args_ref;
}

# Class Methods
sub _create
{
    my $class = shift;
    return $class->of('ATLib::Data::Row');
}

# Instance Methods
sub add
{
    my $self = shift;
    my $row = shift;

    if ($row->table ne $self->_table)
    {
        ATLib::Std::Exception::Argument->new({
            message    => q{This row belongs to other table.},
            param_name => q{$row},
        })->throw();
    }

    if ($self->contains($row))
    {
        ATLib::Std::Exception::Argument->new({
            message    => q{This row already belongs to this table.},
            param_name => q{$row},
        })->throw();
    }

    $self->SUPER::add($row);

    return $self;
}

sub remove_at
{
    my $self = shift;
    my $index = shift;

    $self->SUPER::remove_at($index);
    return $self;
}

sub remove
{
    my $self = shift;
    my $row = shift;

    $self->SUPER::remove($row);
    return $self;
}

__PACKAGE__->meta->make_immutable();
no Mouse;
1;

=encoding utf8

=head1 名前

ATLib::Data::Rows - L<< ATLib::Data::Table >>内の行のコレクション

=head1 バージョン

この文書は ATLib::Data 0.4.0 について説明しています。

=head1 概要

    use ATLib::Data;

    my $table = ATLib::Data::Table->create();
    $table-columns->add(ATLib::Data::Column->create('column1', 'ATLib::Std::Int'));
    $table-columns->add(ATLib::Data::Column->create('column2', 'ATLib::Std::String'));

    my $row = $table->create_new_row();
    $row->item('column1', 1);
    $row->item('column2', 'Row data (1)');
    $table->rows->add($row);

=head1 基底クラス

L<< ATLib::Std::Any >> E<lt>- L<< ATLib::Std::Collections::List >>

=head1 説明

ATLib::Data::Rowsは、L<< ATLib::Data::Table >>に格納されている行L<< ATLib::Data::Row >>のコレクションです。
このコレクションのオブジェクトは L<< ATLib::Data::Table >>のC<< $instance->create_new_row >>によって生成して追加します。

=head1 プロパティ

=head2 C<< $count = $instance->count; >> -E<gt> L<< ATLib::Std::Int >>

本インスタンスに格納されている L<< ATLib::Data::Row >>の行数を取得します。

=head2 C<< $row = $instance->item($index); >> -E<gt> L<< ATLib::Data::Row >>

$indexの位置にある L<< ATLib::Data::Row >> を取得します。

=head1 インスタンスメソッド

=head2 C<< $instance = $instance->clear();  >> -E<gt> L<< ATLib::Data::Rows >>

行のコレクションからすべてのL<< ATLib::Data::Row >>を削除します。
また、操作結果のインスタンスを返します。

=head2 C<< $instance = $instance->add($row); >> -E<gt> L<< ATLib::Data::Rows >>

行のコレクションに $rowで指定した新しい L<< ATLib::Data::Row >>オブジェクトを追加します。
また、操作結果のインスタンスを返します。

=head2 C<< $instance = $instance->remove_at($index) >> -E<gt> L<< ATLib::Data::Rows >>

行のコレクションの索引$indexの位置にあるL<< ATLib::Data::Row >>を削除します。
また、操作結果のインスタンスを返します。

=head2 C<< $instance = $instance->remove($row) >> -E<gt> L<< ATLib::Data::Rows >>

行のコレクションから$rowで指定したL<< ATLib::Data::Row >>を削除します。
また、操作結果のインスタンスを返します。

=head1 AUTHOR

atdev01 E<lt>mine_t7 at hotmail.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2020-2025 atdev01.

This library is free software; you can redistribute it and/or modify
it under the same terms of the Artistic License 2.0. For details,
see the full text of the license in the file LICENSE.

=cut