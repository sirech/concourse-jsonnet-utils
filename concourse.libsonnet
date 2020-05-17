{
  GitResource(name, repository, branch = 'master'):: {
    name: name,
    type: 'git',
    source: {
      uri: repository,
      branch: branch
    },
  },

  DockerResource(name, repository, tag = 'latest', allow_insecure = false):: {
    name: name,
    type: 'docker-image',
    source: {
      repository: repository,
      tag: tag
    } + (
      if allow_insecure then { insecure_registries: [std.split(repository, '/')[0]]} else {}
    ),
  },

  Get(name, trigger = true, dependencies = []):: {
    get: name,
    trigger: trigger,
    passed: dependencies
  },

  Parallel(tasks):: {
    in_parallel: tasks
  },

  Job(name, serial = true, plan = []):: {
    name: name,
    serial: serial,
    plan: plan
  },
}
