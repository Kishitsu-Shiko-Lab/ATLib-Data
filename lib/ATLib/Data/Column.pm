package ATLib::Data::Column;
use Mouse;
extends 'ATLib::Std::Any';

use ATLib::Utils qw{ as_type_of };
use ATLib::Std;

# Attributes
has 'column_name' => (is => 'ro', isa => 'ATLib::Std::String', required => 1);
has 'data_type'   => (is => 'ro', isa => 'ATLib::Std::String', required => 1);
has 'table'       => (is => 'ro', isa => 'ATLib::Data::Table', required => 0, writer => '_set_table');

# Builder
sub BUILDARGS
{
    my ($class, $args_ref) = @_;
    $class->SUPER::BUILDARGS($args_ref);
    return $args_ref;
}

# Class Methods
sub create
{
    my $class = shift;
    my $column_name = shift;
    my $data_type = shift;

    if (!as_type_of('Str', $column_name) && !as_type_of('ATLib::Std::String', $column_name))
    {
        ATLib::Std::Exception::Argument->new({
            message    => ATLib::Std::String->from(q{Type miss match. The $column_name must be Str or ATLib::Std::String}),
            param_name => ATLib::Std::String->from(q{$column_name}),
        })->throw();
    }
    if (!as_type_of('Str', $data_type) && !as_type_of('ATLib::Std::String', $data_type))
    {
        ATLib::Std::Exception::Argument->new({
            message    => ATLib::Std::String->from(q{Type miss match. The $data_type must be Str or ATLib::Std::String}),
            param_name => ATLib::Std::String->from(q{$data_type}),
        })->throw();
    }

    if (as_type_of('Str', $column_name))
    {
        $column_name = ATLib::Std::String->from($column_name);
    }
    if (as_type_of('Str', $data_type))
    {
        $data_type = ATLib::Std::String->from($data_type);
    }

    if (!($data_type->as_string() eq 'ATLib::Std::Number')
        && !($data_type->as_string() eq 'ATLib::Std::Int')
        && !($data_type->as_string() eq 'ATLib::Std::String')
        && !($data_type->as_string() eq 'ATLib::Std::DateTime')
    )
    {
        ATLib::Std::Exception::Argument->new({
            message    => ATLib::Std::String->from(q{The specified $data_type is not supported.}),
            param_name => ATLib::Std::String->from(q{$data_type}),
        })->throw();
    }

    return $class->new({type_name => $class, column_name => $column_name, data_type => $data_type});
}

__PACKAGE__->meta->make_immutable();
no Mouse;
1;

=encoding utf8

=head1 名前

ATLib::Data::Column - L<< ATLib::Data::Table >>マトリクス構造の列を定義

=head1 バージョン

この文書は ATLib::Data version v0.4.0 について説明しています。

=head1 概要

    use ATLib::Std;
    use ATLib::Data;

    my $column = ATLib::Data::Column->create('column_name', 'ATLib::Std::String');

=head1 基底クラス

L<< ATLib::Std::Any >>

=head1 説明

ATLib::Data::Column は、L<< ATLib::Data::Table >>マトリクス構造の列定義を表すクラスです。

=head1 コンストラクタ

=head2 C<< $instance = ATLib::Data::Column->create($column_name, $data_type);  >>

列名を$column_name、データ型を$data_typeとする列定義のインスタンスを生成します。
データ型は以下の L<< ATLib::Std >> の基本型をサポートしています。

=over 4

=item *

L<< ATLib::Std::Number >>

=item *

L<< ATLib::Std::Int >>

=item *

L<< ATLib::Std::String >>

=item *

L<< ATLib::Std::DateTime >>

=back

=head1 プロパティ

=head2 C<< $column_name = $instance->column_name; >> -E<gt> L<< ATLib::Std::String >>

インスタンスで定義された列名を取得します。
この列名は多くの場合、データベースの物理列名です。

=head2 C<< $data_type_name = $instance->data_type; >> -E<gt> L<< ATLib::Std::String >>

インスタンスで定義された列の型名を取得します。
型名は以下の L<< ATLib::Std >> の基本型をサポートしています。

=over 4

=item *

L<< ATLib::Std::Number >>

=item *

L<< ATLib::Std::Int >>

=item *

L<< ATLib::Std::String >>

=item *

L<< ATLib::Std::DateTime >>

=back

=head2 C<< $table = $instance->table; >> -E<gt> L<< ATLib::Data::Table >>

列が属するL<< ATLib::Data::Table >>オブジェクトを取得します。

=head1 AUTHOR

atdev01 E<lt>mine_t7 at hotmail.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2020-2025 atdev01.

This library is free software; you can redistribute it and/or modify
it under the same terms of the Artistic License 2.0. For details,
see the full text of the license in the file LICENSE.

=cut