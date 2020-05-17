local concourse = import 'concourse.libsonnet';

{
  docker: concourse.DockerResource('serverspec-container', 'sirech/dind-ruby', tag = '2.6.3'),
}
