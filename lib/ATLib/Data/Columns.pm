package ATLib::Data::Columns;
use Mouse;
extends 'ATLib::Std::Collections::Dictionary';

use ATLib::Utils qw{ is_int as_type_of };
use ATLib::Std::Collections::List;
use ATLib::Std::Int;
use ATLib::Std::String;
use ATLib::Std::Exception::Argument;
use ATLib::Data::Table;

# Attributes
has '_table'   => (is => 'ro', isa => 'ATLib::Data::Table', required => 0, writer => '_set__table');
has '_columns' => (is => 'ro', isa => 'ATLib::Std::Collections::List', required => 1);

sub count
{
    my $self = shift;
    return $self->SUPER::count;
}

sub items
{
    my $self = shift;
    my $index_or_name = shift;

    if (is_int($index_or_name) || as_type_of('ATLib::Std::Int', $index_or_name))
    {
        return $self->_columns->items(ATLib::Std::Int->value($index_or_name));
    }

    if (as_type_of('Str', $index_or_name))
    {
        $index_or_name = ATLib::Std::String->from($index_or_name);
    }

    return $self->SUPER::items($index_or_name);
}

# Builder
sub BUILDARGS
{
    my ($class, $args_ref) = @_;
    $class->SUPER::BUILDARGS($args_ref);

    if (!exists $args_ref->{_columns})
    {
        $args_ref->{_columns} = ATLib::Std::Collections::List->from('ATLib::Data::Column');
    }
    return $args_ref;
}

# Class Methods
sub _create
{
    my $class = shift;
    return $class->of('ATLib::Std::String', 'ATLib::Data::Column');
}

# Instance Methods
sub clear
{
    my $self = shift;

    $self->_columns->clear();
    $self->SUPER::clear();
    return $self;
}

sub add
{
    my $self = shift;
    my $column = shift;

    if ($self->contains($column->column_name))
    {
        my $column_name = $column->column_name->as_string();
        ATLib::Std::Exception::Argument->new({
            message    => ATLib::Std::String->from(qq{The specified column $column_name is already exists.}),
            param_name => ATLib::Std::String->from(q{$column}),
        })->throw();
    }

    $self->_columns->add($column);
    $self->SUPER::add($column->column_name, $column);
    $self->items($column->column_name)->_set_table($self->_table);
    return $self;
}

sub remove_at
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

    my $column_name = $self->items($index)->column_name;
    $self->_columns->remove_at($index);
    $self->SUPER::remove($column_name);
    return $self;
}

sub remove
{
    my $self = shift;
    my $column_or_name = shift;

    my $column = undef;
    my $column_name = undef;
    if (as_type_of('ATLib::Data::Column', $column_or_name))
    {
        $column = $column_or_name;
        $column_name = $column->column_name;
    }
    else
    {
        $column_name = $column_or_name;
        $column = $self->items($column_name);
    }

    if (!$self->contains($column_name))
    {
        ATLib::Std::Exception::Argument->new({
            message    => ATLib::Std::String->from(qq{The specified column $column_or_name is not exists.}),
            param_name => ATLib::Std::String->from(q{$column_or_name}),
        })->throw();
    }

    $self->_columns->remove($column);
    $self->SUPER::remove($column->column_name);
    return $self;
}

__PACKAGE__->meta->make_immutable();
no Mouse;
1;

=encoding utf8

=head1 名前

ATLib::Data::Columns - L<< ATLib::Data::Column >> オブジェクトのコレクション

=head1 バージョン

この文書は ATLib::Data 0.3.1 について説明しています。

=head1 概要

    use ATLib::Data::Table;
    use ATLib::Data::Column;
    use ATLib::Data::Row;

    my $table = ATLib::Data::Table->create();
    $table-columns->add(ATLib::Data::Column->create('column1', 'ATLib::Std::Int'));
    $table-columns->add(ATLib::Data::Column->create('column2', 'ATLib::Std::String'));

=head1 基底クラス

L<< ATLib::Std::Any >> E<lt>- L<< ATLib::Std::Collections::Dictionary >>

=head1 説明

ATLib::Data::Columnsは、L<< ATLib::Data::Column >>オブジェクトのコレクションです。
このクラスは L<< ATLib::Data::Table >>のプロパティとして自動生成されます。

=head1 プロパティ

=head2 C<< $count = $instance->count; >> -E<gt> L<< ATLib::Std::Int >>

定義されている列数を取得します。

=head2 C<< $column = $instance->items($index_or_name) >> -E<gt> L<< ATLib::Data::Column >>

$index_or_nameで指定した索引、または列名の列定義を列定義コレクションから取得します。

=head1 インスタンスメソッド

=head2 C<< $instance->clear() >> -E<gt> L<< ATLib::Data::Columns >>

コレクションに格納された列定義をすべてクリアします。
また、操作結果のインスタンスを返します。

=head2 C<< $instance->add($column) >> -E<gt> L<< ATLib::Data::Columns >>

指定した列定義オブジェクトをコレクションに追加します。
また、操作結果のインスタンスを返します。

=head2 C<< $instance->remove_at($index);  >> -E<gt> L<< ATLib::Data::Columns >>

指定した索引$indexの位置にある列定義オブジェクトをコレクションから削除します。
また、操作結果のインスタンスを返します。

=head2 C<< $instance->remove($column_or_name) >> -E<gt> L<< ATLib::Data::Columns >>

指定した列定義オブジェクト、または列名の列定義オブジェクトをコレクションから削除します。
また、操作結果のインスタンスを返します。

=cut