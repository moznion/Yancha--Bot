requires 'AnyEvent';
requires 'AnyEvent::HTTP::Request';
requires 'URI';
requires 'perl', '5.008009';

on 'test' => sub {
    requires 'Test::More', '0.98';
};

on configure => sub {
    requires 'CPAN::Meta';
    requires 'CPAN::Meta::Prereqs';
    requires 'Module::Build';
};

on develop => sub {
    requires 'Test::Perl::Critic';
};
