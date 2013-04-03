package Yancha::Bot;
use strict;
use warnings;
use utf8;

use URI::Escape;
use AnyEvent::HTTP::Request;

our $VERSION = '0.01';

sub new {
    my ( $class, $config, $listener ) = @_;
    bless {
        config            => $config,
        listener          => $listener,
        yancha_auth_token => undef,
    }, $class;
}

sub get_yancha_auth_token {
    my $self = shift;

    my $config = $self->{config};
    my $req    = AnyEvent::HTTP::Request->new(
        {
            method => 'GET',
            uri    => $config->{YanchaUrl}
              . '/login?nick='
              . uri_escape_utf8( $config->{BotName} )
              . '&token_only=1',
            cb => sub {
                my $body  = shift;
                $self->{yancha_auth_token} = $body;
                if ( $self->{yancha_auth_token} ) {
                    $self->set_timer->(0);
                }
            },
        }
    );

    $req->send();
}

sub post_yancha_message {
    my ( $self, $message ) = @_;

    my $config = $self->{config};

    $message =~ s/#/＃/g;
    $message .= " $config->{YanchaTag}";

    my $req = AnyEvent::HTTP::Request->new(
        {
            method => 'GET',
            uri    => $config->{YanchaUrl}
              . '/api/post?token='
              . $self->{yancha_auth_token}
              . '&text='
              . uri_escape_utf8($message),
            cb => sub {
                my $body = shift;
              }
        }
    );
    $req->send();
}

sub set_timer {
    my ( $self, $after ) = @_;

    $self->{listener} || return;

    $after ||= 0;
    my $listener_timer;
    $listener_timer = AnyEvent->timer(
        after => $after,
        cb    => sub {
            undef $listener_timer;
            $self->{listener}->();
        }
    );
}
1;
__END__


=head1 NAME

Yancha::Bot - Provides supplementary functions to make bots for Yancha


=head1 VERSION

This document describes Yancha::Bot version 0.01


=head1 SYNOPSIS

    use Yancha::Bot;

    my $bot = Yancha::Bot->new($config, $create_listener);
    $bot->get_yancha_auth_token();

    # as you like:
    $bot->post_yancha_message("Rock'n'Roll!!!!!");


=head1 DESCRIPTION

このモジュールはYancha 向けのBot を作成する際に役立つ補助関数を提供します.


=head1 METHODS

=over

=item C<< new >>
コンストラクタです。第一引数にHash リファレンス形式でconfig を渡して使います。
第二引数には関数リファレンス形式でリスナーを作成する関数を渡します。
第一引数は必須ですが、第二引数は省略が可能です。

=item C<< get_yancha_auth_token >>
Authentication Token を取得します。コンストラクタで第二引数で関数リファレンスを
指定している場合は、Token を取得した後にその関数が呼ばれます。

=item C<< post_yancha_message >>
第一引数に指定された文字列をYancha にPost します。
先にAuthentication Token を取得していないと動きません。

=item C<< set_timer >>
第一引数に設定された秒数だけ待ってから、コンストラクタで指定された関数リファレンスを
実行します。第一引数が省略された場合は待ち処理無しで関数リファレンスを実行します。
関数リファレンスが設定されていない場合は何もしません。

=back


=head1 CONFIGURATION AND ENVIRONMENT

設定ファイルが必要です。sample 内の設定ファイル例をご覧ください。


=head1 DEPENDENCIES

URI::Escape (version 3.31 or later);

AnyEvent::HTTP::Request (version 0.301 or later);


=head1 BUGS AND LIMITATIONS

No bugs have been reported.

何かありましたら本リポジトリのIssues に上げて下さい。


=head1 AUTHOR

moznion  C<< <moznion@gmail.com> >>


=head1 LICENCE AND COPYRIGHT

Copyright (c) 2013, moznion C<< <moznion@gmail.com> >>. All rights reserved.

This module is free software; you can redistribute it and/or
modify it under the same terms as Perl itself. See L<perlartistic>.


=head1 DISCLAIMER OF WARRANTY

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
