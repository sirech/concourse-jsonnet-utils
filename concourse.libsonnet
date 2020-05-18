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

  Get(name, trigger = true, dependencies = []):: std.prune({
    get: name,
    trigger: trigger,
    passed: if std.isArray(dependencies) then dependencies else [dependencies]
  }),

  Group(name, jobs):: {
    name: name,
    jobs: jobs
  },

  Parallel(tasks):: {
    in_parallel: tasks
  },

  Job(name, serial = true, plan = []):: std.prune({
    name: name,
    serial: serial,
    plan: plan
  }),

  FileTask(path, platform = 'linux', inputs = [], caches = [], dir = null)::
    local formattedInputs = if std.isArray(inputs) then inputs else [inputs];
  std.prune({
    platform: platform,
    inputs: formattedInputs,
    caches: if std.isArray(caches) then caches else [caches],
    run: {
      path: path,
      dir: if std.length(formattedInputs) > 0 then formattedInputs[0] else null
    }
  }),
}
