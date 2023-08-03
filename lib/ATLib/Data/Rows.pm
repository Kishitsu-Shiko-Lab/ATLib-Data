package ATLib::Data::Rows;
use Mouse;
extends 'ATLib::Std::Collections::List';

use ATLib::Utils qw{ is_int as_type_of };
use ATLib::Std::Int;
use ATLib::Std::String;
use ATLib::Std::Exception::Argument;

# Attributes
sub items
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
    return $self->SUPER::items($index);
}

# Class Methods
sub _create
{
    my $class = shift;
    return $class->of('ATLib::Data::Row');
}

# Instance Methods
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

この文書は ATLib::Data 0.3.1 について説明しています。

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

=head1 基底クラス

L<< ATLib::Std::Any >> E<lt>- L<< ATLib::Std::Collections::List >>

=head1 説明

ATLib::Data::Rowsは、L<< ATLib::Data::Table >>に格納されている行L<< ATLib::Data::Row >>のコレクションです。
このコレクションのオブジェクトは L<< ATLib::Data::Table >>のC<< $instance->create_new_row >>によって生成して追加します。

=head1 プロパティ

=head2 C<< $count = $instance->count; >> -E<gt> L<< ATLib::Std::Int >>

本インスタンスに格納されている L<< ATLib::Data::Row >>の行数を取得します。

=head2 C<< $row = $instance->items($index); >> -E<gt> L<< ATLib::Data::Row >>

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


=cut