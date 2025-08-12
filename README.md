# k2k

![Version: 0.1.0](https://img.shields.io/badge/Version-0.0.11-informational?style=flat-square) ![AppVersion: 0.1.0](https://img.shields.io/badge/AppVersion-0.0.11-informational?style=flat-square)

A Helm chart for Lenses K2K Replicator

## Introduction

Lenses K2K is an application that allows you to replicate Kafka topics
from one Kafka cluster to another.

## Prerequisistes

- Kubernetes 1.23+
- Helm 3.8.0+

## Current Features

✅ Exactly once message delivery.

✅ Schema replication between Schema Registries when Confluent Schema
Registry API compatibility is in place

✅ Flexible topic routing.

✅ Creates the topic if it does not exist, matching the source cluster
configuration

## Current Limitations

K2K is in active development, and this is the 1st alpha release.

- Supports only Schema Registries compatible with the Confluent Schema
  Registry API.
- When using Schema Registry for replication, it is assumed that both
  the Key and Value content are serialized using Schema Registry.

## Roadmap

- Filtering, masking & obfuscation, reshaping the payloads.
- Kafka records content based routing
- Replicate consumer group offsets.
- Support for AWS Glue Schema Registries.
- Integration into Lenses for self-service deployment and observation.
- Continuously sync topic configuration
- Continuously sync topic partitions

## Installation

```console

helm install k2k . --namespace k2k -f examples/k2k-with-plaintext.yaml
```

> Note: You need to substitute the placeholder `.` with a reference to
> your Helm chart registry and repository. For example, in the case of
> ex-Lenses, you need to use lensesio/lenses

The command deploys Lenses K2K on the Kubernetes cluster in the
example configuration. The Parameters section lists the parameters
(#parameters) that can be configured during installation.

## Values

### Extras

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| additionalContainerSpec | list | `nil` | # Optionally add arbitrary fields to the main container spec (e.g. tty, stdin, etc) |
| additionalPodSpec | list | `nil` | Optionally add arbitrary fields to the pod spec (e.g. priorityClassName, priority, etc) |
| additionalVolumeMounts | list | `[]` | Additional volume mounts to use in Lenses delpoyments, for example to load additional plugins (UDFs) in Lenses Use it in conjuction with lenses.additionalVolumes |
| additionalVolumes | list | `[]` | Additional volumes to use in Lenses delpoyments either by Lenses for other sidecars like Lenses provisioner. |
| k2k.livenessProbe | string | `{"enabled":false}` | Disables livenessProbe, used while debugging |

### Custom deployment values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | dict | `{}` | Deployment affinity rules |
| annotations | dict | `{}` | Custom deployment annotations |
| deployment | object | `{"replicas":1,"resources":{"limits":{"memory":"1Gi"},"requests":{"memory":"1Gi"}}}` | Pod resources |
| image | object | `{"pullPolicy":"IfNotPresent","repository":"lensesio/k2k"}` | Image map |
| image.pullPolicy | string | `"IfNotPresent"` | Image pullPolicy |
| image.repository | string | `"lensesio/k2k"` | Image repository |
| k2k.additionalEnv | list | `nil` | Additional env variables appended to deployment Additional env variables appended to deployment |
| labels | dict | `{}` | Deployment labels |
| nodeSelector | dict | `{}` | Deployment nodeSelector |
| podTemplateAnnotations | dict | `{}` | Annotations here go into the PodTemplateSpec at deployment.spec.template.annotations. |
| securityContext | dict | `{}` | Deployment security context |
| strategy | dict | `{}` | Deployment strategy |
| tolerations | dict | `[]` | Deployment tolerations |

### K2K OTEL configs

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| k2k.otelConfig | object | `{"logsExporter":"none","metricsExporter":"prometheus","prometheusHost":"0.0.0.0","prometheusPort":9090,"serviceName":"k2k","tracesExporter":"none"}` | Otel configuration section. |

### K2K replication config

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| k2k.replicationConfig | object | `{}` | Replication configuration for k2k. See documentation for structure. |

### Lenses K2K deployment service values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| service.annotations | dict | `{}` | Additional service annotations |
| service.enabled | bool | `true` | Deciding factor whether Lenses K2K service will be created and which type |
| service.type | string | `"ClusterIP"` | Type of service to be created. |

### Permission scope values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| serviceAccount | object | `{"annotations":{},"create":false,"name":"default"}` | User to be used by Lenses to deploy apps |
| serviceAccount.annotations | dict | `{}` | Additional service account annotations. |
| serviceAccount.create | bool | `false` | In case "true" new SA will be created with service.name as a SA name. |
| serviceAccount.name | string | `"default"` | Name of Service Account. In case serviceAccount.create is *false*, existing SA with defined name here will be used. |

### Other Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| fullnameOverride | string | `""` |  |
| nameOverride | string | `""` |  |

---
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
