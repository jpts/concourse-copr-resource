# copr resource for Concourse CI

With this resource you can upload and download packages from [Fedora
copr](https://copr.fedorainfracloud.org/)

To use this resource, you need to get a token for the copr api from the [api
website](https://copr.fedorainfracloud.org/api/) and store it in your
credential store, e.g. vault.

```
vault write concourse/main/copr-token value=@copr.conf
```

This token is only valid for 180 days and requires a manual refresh :disappointed:

## Source configuration

Here is an example of how to configure and use a copr source.

```
---
resource_types:
  - name: copr
    type: docker-image
    source:
      repository: seveas/concourse-copr-resource

resources:
  - name: copr-repository
    type: copr
    source:
      project: yourlogin/yourproject
      package: yourpackage
      api_token: ((copr-token))

jobs:
  - name: copr-consumer
    - get: copr-repository
      trigger: true
    - inputs:
      - name: copr-repository

  - name: copr-producer
    - put: copr-repository
      params:
        glob: source-rpms/*.src.rpm
```
