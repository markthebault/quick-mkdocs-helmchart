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

