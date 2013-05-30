use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    name              => 'Yancha-Bot',
    module_name       => 'Yancha::Bot',
    license           => 'perl',
    dist_author       => 'moznion <moznion@gmail.com>',
    dist_version_from => 'lib/Yancha/Bot.pm',
    build_requires    => {
        'Test::More' => '0.98',
    },
    configure_requires => {
        'Module::Build' => '0.40',
    },
    requires => {
        perl                      => '5.008009',
        'URI'                     => '1.60',
        'AnyEvent::HTTP::Request' => '0.301',
    },
    add_to_cleanup => ['Yancha-Bot-*'],
    no_index       => { 'directory' => [ 'inc', 'xt' ] },
    meta_merge     => {
        'resource' => {
            'license'    => 'http://dev.perl.org/licenses/',
            'repository' => 'git@github.com:moznion/Yancha--Bot.git',
        },
    },
    test_files => ( -d '.git' || $ENV{RELEASE_TESTING} ) ? 't/ xt/' : 't/',
    recursive_test_files => 1,
    create_license       => 1,
    create_readme        => 1,
);

$builder->create_build_script();
