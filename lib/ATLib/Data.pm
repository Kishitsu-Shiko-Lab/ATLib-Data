package ATLib::Data;
use 5.016_001;
use version; our $VERSION = version->declare('v0.4.1');
use strict;
use warnings;

sub import
{
    use ATLib::Data::Column;
    use ATLib::Data::Columns;
    use ATLib::Data::Table;
    use ATLib::Data::Row;
    use ATLib::Data::Rows;
}

1;
__END__

=encoding utf8

=head1 名前

ATLib::Data - ATLib 標準型システムの L<< Mouse >> による実装

=head1 バージョン

この文書は ATLib::Data version v0.4.0 について説明しています。

=head1 概要

それぞれのクラスのドキュメントを参照してください。

=head1 説明

ATLib::Data は、Perlでのマトリクス構造を扱う開発に.NET Frameworkのような共通型を L<< Mouse >> による実装で導入します。

=head1 インターフェース

=head1 クラス

=head2 L<< ATLib::Data::Column >>

マトリクス構造の列を表す型です。

=head2 L<< ATLib::Data::Columns >>

マトリクス構造に属する列のコレクションです。
L<< ATLib::Data::Table >>のプロパティからアクセスします。

=head2 L<< ATLib::Data::Row >>

マトリクス構造の行を表す型です。

=head2 L<< ATLib::Data::Rows >>

マトリクス構造に属する行のコレクションです。
L<< ATLib::Data::Table >>のプロパティからアクセスします。

=head2 L<< ATLib::Data::Table >>

データベースのテーブルのようなマトリクス構造を管理する型です。

=head1 インストール方法

    $cpanm https://github.com/Kishitsu-Shiko-Lab/ATLib-Utils.git
    $cpanm https://github.com/Kishitsu-Shiko-Lab/ATLib-Std.git
    $cpanm https://github.com/Kishitsu-Shiko-Lab/ATLib-Data.git

    Or

    $cpm https://github.com/Kishitsu-Shiko-Lab/ATLib-Data.git

=head1 AUTHOR

atdev01 E<lt>mine_t7 at hotmail.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2020-2025 atdev01.

This library is free software; you can redistribute it and/or modify
it under the same terms of the Artistic License 2.0. For details,
see the full text of the license in the file LICENSE.

=cut
