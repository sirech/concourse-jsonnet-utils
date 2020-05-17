local concourse = import 'concourse.libsonnet';

{
  docker: concourse.DockerResource('dev-container', 'registry:5000/dev-container', allow_insecure = true),
}
