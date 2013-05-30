requires 'AnyEvent::HTTP::Request', '0.301';
requires 'URI', '1.60';
requires 'perl', '5.008009';

on build => sub {
    requires 'Test::More', '0.98';
};
