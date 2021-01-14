use Cro::HTTP::Log::File;
use Cro::HTTP::Server;
use Routes;

my Cro::Service $http = Cro::HTTP::Server.new(
    http => <1.1>,
    host => %*ENV<RAKU_IBM_SPECTRUM_PROTECT_CLIENT_CONFIGURATION_HOST> ||
        die("Missing RAKU_IBM_SPECTRUM_PROTECT_CLIENT_CONFIGURATION_HOST in environment"),
    port => %*ENV<RAKU_IBM_SPECTRUM_PROTECT_CLIENT_CONFIGURATION_PORT> ||
        die("Missing RAKU_IBM_SPECTRUM_PROTECT_CLIENT_CONFIGURATION_PORT in environment"),
    application => routes(),
    after => [
        Cro::HTTP::Log::File.new(logs => $*OUT, errors => $*ERR)
    ]
);
$http.start;
say "Listening at http://%*ENV<RAKU_IBM_SPECTRUM_PROTECT_CLIENT_CONFIGURATION_HOST>:%*ENV<RAKU_IBM_SPECTRUM_PROTECT_CLIENT_CONFIGURATION_PORT>";
react {
    whenever signal(SIGINT) {
        say "Shutting down...";
        $http.stop;
        done;
    }
}
