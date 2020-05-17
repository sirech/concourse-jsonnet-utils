local concourse = import 'concourse.libsonnet';

{
  git: concourse.GitResource('git', 'https://github.com/sirech/example-concourse-pipeline.git', branch = 'devel'),
}
