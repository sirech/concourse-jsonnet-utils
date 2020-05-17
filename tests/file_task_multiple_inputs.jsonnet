local concourse = import 'concourse.libsonnet';

concourse.FileTask('pipeline/tasks/build/task.sh', inputs = ['git', 'dev-tools'])
