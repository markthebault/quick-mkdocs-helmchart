# Helm chart to deploy [mkdocs](https://www.mkdocs.org/) with material theme on the fly
The motivation behind this chart is to be able to expose some quick documentation running inside Kubernetes. This is particullary useful when you need to insert some cluster specific values in the documentation.

## How it works
Basically an init container is building the documentation passed via config map to generate HTML files and an nginx server will expose this documentation

## How to customize the documentation ?
From the `values.yaml` you can change the configuration of **mkdocs** via the value:

```yaml
mkdocConfig:
  site_name: Awesome documentation
  docs_dir: /docs
  theme:
    icon:
      repo: fontawesome/brands/github
    name: material
    features:
      - navigation.tabs
      - toc.integrate
      - navigation.instant
    palette:
      primary: blue
    plugins:
      - search
  markdown_extensions:
    - toc:
        toc_depth: 2
  nav:
    - Index: index.md
    - Hello: hello.md
    - Subpages:
        Subpage 1: sub1.md
        Subpage 2: sub2.md
```
for further information you can refer to [this page](https://www.mkdocs.org/user-guide/configuration/)

To edit the documentation itself you need to edit this variable in `values.yaml`:
```yaml
documentationFiles:
  index.md: |
    # Hello this is a awesome start for a documentation !!!
  hello.md: |
    # Hello here is `hello.md` page!
  sub1.md: |
    ## subpage 1
  sub2.md: |
    ## subpage 2
```
**Bear in mind** that config maps only support a maximum of [1MB](https://kubernetes.io/docs/concepts/configuration/configmap/#:~:text=A%20ConfigMap%20is%20not%20designed,separate%20database%20or%20file%20service.) at this time of writing (Kubernetes <= 1.21.0)

## How to deploy ?
You can deploy it via helm command `helm upgrade -i doc quick-mkdocs --values custom-values.yaml`

quick-mkdocs
============
A Helm chart for Kubernetes

Current chart version is `0.1.0`





## Chart Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` |  |
| autoscaling.enabled | bool | `false` |  |
| autoscaling.maxReplicas | int | `100` |  |
| autoscaling.minReplicas | int | `1` |  |
| autoscaling.targetCPUUtilizationPercentage | int | `80` |  |
| docsGeneratorImage.pullPolicy | string | `"IfNotPresent"` |  |
| docsGeneratorImage.repository | string | `"squidfunk/mkdocs-material"` |  |
| docsGeneratorImage.tag | string | `"7.0.5"` |  |
| documentationFiles."hello.md" | string | `"# Hello here is `hello.md` page!\n"` |  |
| documentationFiles."index.md" | string | `"# Hello this is a awesome start for a documentation !!!\n"` |  |
| documentationFiles."sub1.md" | string | `"## subpage 1\n"` |  |
| documentationFiles."sub2.md" | string | `"## subpage 2"` |  |
| fullnameOverride | string | `""` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"nginx"` |  |
| image.tag | string | `"alpine"` |  |
| imagePullSecrets | list | `[]` |  |
| ingress.annotations | object | `{}` |  |
| ingress.enabled | bool | `false` |  |
| ingress.hosts[0].host | string | `"chart-example.local"` |  |
| ingress.hosts[0].paths | list | `[]` |  |
| ingress.tls | list | `[]` |  |
| mkdocConfig.docs_dir | string | `"/docs"` |  |
| mkdocConfig.markdown_extensions[0].toc.toc_depth | int | `2` |  |
| mkdocConfig.nav[0].Index | string | `"index.md"` |  |
| mkdocConfig.nav[1].Hello | string | `"hello.md"` |  |
| mkdocConfig.nav[2].Subpages."Subpage 1" | string | `"sub1.md"` |  |
| mkdocConfig.nav[2].Subpages."Subpage 2" | string | `"sub2.md"` |  |
| mkdocConfig.site_name | string | `"Awesome documentation"` |  |
| mkdocConfig.theme.features[0] | string | `"navigation.tabs"` |  |
| mkdocConfig.theme.features[1] | string | `"toc.integrate"` |  |
| mkdocConfig.theme.features[2] | string | `"navigation.instant"` |  |
| mkdocConfig.theme.icon.repo | string | `"fontawesome/brands/github"` |  |
| mkdocConfig.theme.name | string | `"material"` |  |
| mkdocConfig.theme.palette.primary | string | `"blue"` |  |
| mkdocConfig.theme.plugins[0] | string | `"search"` |  |
| nameOverride | string | `""` |  |
| nodeSelector | object | `{}` |  |
| podAnnotations | object | `{}` |  |
| podSecurityContext | object | `{}` |  |
| replicaCount | int | `1` |  |
| resources | object | `{}` |  |
| securityContext | object | `{}` |  |
| service.port | int | `80` |  |
| service.type | string | `"ClusterIP"` |  |
| serviceAccount.annotations | object | `{}` |  |
| serviceAccount.create | bool | `true` |  |
| serviceAccount.name | string | `""` |  |
| tolerations | list | `[]` |  |
