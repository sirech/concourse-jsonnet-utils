local concourse = import 'concourse.libsonnet';

[
  concourse.Job('prepare')
]
