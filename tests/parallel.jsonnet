local concourse = import 'concourse.libsonnet';
{
  parallel: concourse.Parallel([
    concourse.Get('git'),
    concourse.Get('dev-container'),
  ])
}
