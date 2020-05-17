# concourse-jsonnet-utils

This is a collection of utility blocks to represent [Concourse](https://concourse-ci.org/) resources in [Jsonnet](https://jsonnet.org/).

## What's the point?

TODO: link to blog post

## How to use it?

The easiest way is to clone the repository and extend the script that is running `jsonnet`:

```shell
goal_generate-pipeline() {
  jsonnet pipeline.jsonnet -J ../concourse-jsonnet-utils | json2yaml > "${PIPELINE_FILE}"
}
```

Then, the library can be imported and used:

```jsonnet
local concourse = import 'concourse.libsonnet';

local resources = [
  concourse.GitResource('git', 'https://github.com/sirech/example-concourse-pipeline.git'),
  concourse.DockerResource('dev-container', 'registry:5000/dev-container', allow_insecure = true)
];

local Inputs(dependencies = []) = concourse.Parallel([
  concourse.Get(source, dependencies = dependencies),
  concourse.Get(container, dependencies = dependencies),
]);
```

The helpers are kept generic, without making assumptions about how your pipeline needs to be structured. You can build your own abstractions on top of it. [This sample project](https://github.com/sirech/example-concourse-pipeline) shows how to build a _Concourse_ pipeline this way.

## Development

For development, you need the following tools:

- `jsonnet`
- `jsonnetfmt`
- `git`

The entrypoint to every task is by running the `go` script.

### Tests

All the helpers have tests, based on defined fixtures. It is in the [tests](./tests) folder.
