# Charts

[![Release Charts](https://github.com/sakowicz/charts/actions/workflows/release.yaml/badge.svg)](https://github.com/sakowicz/charts/actions/workflows/release.yaml)

A collection of Helm charts.

## Usage

### OCI (Recommended)

```console
helm install <release-name> oci://ghcr.io/sakowicz/charts/<chart-name>
```

### Traditional

Add the repository:

```console
helm repo add sakowicz https://sakowicz.github.io/charts
helm repo update
```

Install a chart:

```console
helm install <release-name> sakowicz/<chart-name>
```

## Available Charts

- [dawarich](./charts/dawarich) - Self-hosted alternative to Google Location History

