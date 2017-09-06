package App::Netdisco::Worker::Plugin::Stats;

use Dancer ':syntax';
use App::Netdisco::Worker::Plugin;
use aliased 'App::Netdisco::Worker::Status';

use App::Netdisco::Util::Statistics ();

register_worker({ primary => true }, sub {
  my ($job, $workerconf) = @_;
  App::Netdisco::Util::Statistics::update_stats();
  return Status->done('Updated statistics.');
});

true;
