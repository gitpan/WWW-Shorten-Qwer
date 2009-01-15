use Module::Build;

my $build = Module::Build->new(
			       module_name => 'WWW::Shorten::Qwer',
                               dist_version => '1.00',
			       license     => 'perl',
			       requires    => {
                                 'perl'                => '5.6.0',
                                 'WWW::Shorten'        => 0,
                               },
			       build_requires => {
                                 'Test::More'          => '0.47',
                               },
                               build_recommends => {
                                 'Test::Pod'           => 0,
                                 'Test::Pod::Coverage' => 0,
                                 'Test::Signature'     => 0,
                               },               
			       create_makefile_pl => 'traditional',
);

$build->create_build_script;
