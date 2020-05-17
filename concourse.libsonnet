{
  GitResource(name, repository, branch = 'master'):: {
    name: name,
    type: 'git',
    source: {
      uri: repository,
      branch: branch
    },
  },
}
