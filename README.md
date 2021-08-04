# kubemod-helm

For hosting kubemod-helm to allow for the deployment of kubemod/kubemod

## Helm Chart

[![Artifact HUB](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/kubemod)](https://artifacthub.io/packages/search?repo=kubemod)

__repository:__ https://kubemod.github.io/kubemod-helm

__name:__ kubemod

Linting/validation uses the [helm/chart-testing tool](https://github.com/helm/chart-testing). To run it locally you need to place [two schema files](https://github.com/helm/chart-testing/blob/master/etc/lintconf.yaml) in `~/.ct` or `/etc/ct`.

```bash
ct lint --all --config ct.yaml
ct install --all --config ct.yaml
```
