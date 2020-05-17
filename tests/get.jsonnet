local concourse = import 'concourse.libsonnet';

{
  get: concourse.Get('git', dependencies = 'prepare'),
}
