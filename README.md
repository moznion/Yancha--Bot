# NAME

Yancha::Bot - Provides supplementary functions to make bots for Yancha



# VERSION

This document describes Yancha::Bot version 0.11



# SYNOPSIS

    use Yancha::Bot;

    my $bot = Yancha::Bot->new($config, $callback);
    $bot->up();

    # as you like:
    $bot->post_yancha_message("Rock'n'Roll!!!!!");



# DESCRIPTION

このモジュールはYancha 向けのBot を作成する際に役立つ補助関数を提供します.



# METHODS

- `new`

    コンストラクタです。第一引数にHash リファレンス形式でconfig を渡して使います。
    第二引数には関数リファレンス形式でリスナーを作成する関数を渡します。
    第一引数は必須ですが、第二引数は省略が可能です。

- `up`

    Authentication Token を取得し、bot を起動します。コンストラクタで第二引数で関数リファレンスを
    指定している場合は、Token を取得した後にその関数が呼ばれます。

- `post_yancha_message`

    第一引数に指定された文字列をYancha にPost します。
    先にAuthentication Token を取得していないと動きません。

- `callback_later`

    第一引数に設定された秒数だけ待ってから、コンストラクタで指定された関数リファレンスを
    実行します。第一引数が省略された場合は待ち処理無しで関数リファレンスを実行します。
    関数リファレンスが設定されていない場合は何もしません。



# CONFIGURATION AND ENVIRONMENT

設定ファイルが必要です。sample 内の設定ファイル例をご覧ください。



# DEPENDENCIES

URI::Escape (version 3.31 or later);

AnyEvent::HTTP::Request (version 0.301 or later);



# BUGS AND LIMITATIONS

No bugs have been reported.

何かありましたら本リポジトリのIssues に上げて下さい。



# AUTHOR

moznion  `<moznion@gmail.com>`



# LICENCE AND COPYRIGHT

Copyright (c) 2013, moznion `<moznion@gmail.com>`. All rights reserved.

This module is free software; you can redistribute it and/or
modify it under the same terms as Perl itself. See [perlartistic](http://search.cpan.org/perldoc?perlartistic).



# DISCLAIMER OF WARRANTY

BECAUSE THIS SOFTWARE IS LICENSED FREE OF CHARGE, THERE IS NO WARRANTY
FOR THE SOFTWARE, TO THE EXTENT PERMITTED BY APPLICABLE LAW. EXCEPT WHEN
OTHERWISE STATED IN WRITING THE COPYRIGHT HOLDERS AND/OR OTHER PARTIES
PROVIDE THE SOFTWARE "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER
EXPRESSED OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE. THE
ENTIRE RISK AS TO THE QUALITY AND PERFORMANCE OF THE SOFTWARE IS WITH
YOU. SHOULD THE SOFTWARE PROVE DEFECTIVE, YOU ASSUME THE COST OF ALL
NECESSARY SERVICING, REPAIR, OR CORRECTION.

IN NO EVENT UNLESS REQUIRED BY APPLICABLE LAW OR AGREED TO IN WRITING
WILL ANY COPYRIGHT HOLDER, OR ANY OTHER PARTY WHO MAY MODIFY AND/OR
REDISTRIBUTE THE SOFTWARE AS PERMITTED BY THE ABOVE LICENCE, BE
LIABLE TO YOU FOR DAMAGES, INCLUDING ANY GENERAL, SPECIAL, INCIDENTAL,
OR CONSEQUENTIAL DAMAGES ARISING OUT OF THE USE OR INABILITY TO USE
THE SOFTWARE (INCLUDING BUT NOT LIMITED TO LOSS OF DATA OR DATA BEING
RENDERED INACCURATE OR LOSSES SUSTAINED BY YOU OR THIRD PARTIES OR A
FAILURE OF THE SOFTWARE TO OPERATE WITH ANY OTHER SOFTWARE), EVEN IF
SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE POSSIBILITY OF
SUCH DAMAGES.
