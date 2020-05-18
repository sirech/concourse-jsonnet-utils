local concourse = import 'concourse.libsonnet';

concourse.Group('grouping', ['job1', 'job2', 'job3'])
