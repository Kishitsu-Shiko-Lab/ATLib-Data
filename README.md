# 名前

ATLib::Data - ATLib 共通型システムの [Mouse](https://metacpan.org/pod/Mouse) による実装

# バージョン

この文書は ATLib::Data version v0.2.5 について説明しています。

# 概要

それぞれのクラスのドキュメントを参照してください。

# 説明

ATLib::Data は、Perlでのマトリクス構造を扱う開発に.NET Frameworkのような共通型を [Mouse](https://metacpan.org/pod/Mouse) による実装で導入します。
標準型は.NET Framework (C#) での開発経験からエンタープライズ開発で便利と考えられるものを、
Perlの型に合わせて作成しております。

# インターフェース

# クラス

## [ATLib::Data::Column](https://metacpan.org/pod/ATLib%3A%3AData%3A%3AColumn)

マトリクス構造の列を表す型です。

## [ATLib::Data::Columns](https://metacpan.org/pod/ATLib%3A%3AData%3A%3AColumns)

マトリクス構造に属する列のコレクションです。
[ATLib::Data::Table](https://metacpan.org/pod/ATLib%3A%3AData%3A%3ATable)のプロパティからアクセスします。

## [ATLib::Data::Row](https://metacpan.org/pod/ATLib%3A%3AData%3A%3ARow)

マトリクス構造の行を表す型です。

## [ATLib::Data::Rows](https://metacpan.org/pod/ATLib%3A%3AData%3A%3ARows)

マトリクス構造に属する行のコレクションです。
[ATLib::Data::Table](https://metacpan.org/pod/ATLib%3A%3AData%3A%3ATable)のプロパティからアクセスします。

## [ATLib::Data::Table](https://metacpan.org/pod/ATLib%3A%3AData%3A%3ATable)

データベースのテーブルのようなマトリクス構造を管理する型です。

# インストール方法

    $cpanm https://github.com/Kishitsu-Shiko-Lab/ATLib-Utils.git
    $cpanm https://github.com/Kishitsu-Shiko-Lab/ATLib-Std.git
    $cpanm https://github.com/Kishitsu-Shiko-Lab/ATLib-Data.git

# AUTHOR

atdev01 &lt;mine\_t7 at hotmail.com>

# COPYRIGHT AND LICENSE

Copyright (C) 2020-2023 atdev01.

This library is free software; you can redistribute it and/or modify
it under the same terms of the Artistic License 2.0. For details,
see the full text of the license in the file LICENSE.
