# k2k

![Version: 2.0.0](https://img.shields.io/badge/Version-2.0.0-informational?style=flat-square) ![AppVersion: 2.0.0](https://img.shields.io/badge/AppVersion-2.0.0-informational?style=flat-square)

A Helm chart for Lenses K2K Replicator

## Introduction

Lenses K2K is an application that allows you to replicate Kafka topics from one Kafka cluster to another.

## Prerequisistes
- Kubernetes 1.23+
- Helm 3.8.0+

## Current Features
✅ Exactly once message delivery.

✅ Schema replication between Schema Registries  when Confluent Schema Registry API compatibility is in place

✅ Flexible topic routing.

✅ Creates the topic if it does not exist, matching the source cluster configuration

## Current Limitations
K2K is in active development, and this is the 1st alpha release.
- Supports only Schema Registries compatible with the Confluent Schema Registry API.
- When using Schema Registry for replication, it is assumed that both the Key and Value content are serialized using Schema Registry.

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

helm install k2k .  --namespace k2k -f examples/k2k-with-plaintext.yaml
```

> Note: You need to substitute the placeholder `.` with a reference to your Helm chart registry and repository. For example, in the case of ex-Lenses, you need to use lensesio/lenses

The command deploys Lenses K2K on the Kubernetes cluster in the example configuration. The Parameters section lists the parameters (#parameters) that can be configured during installation.

## Values

### K2K extras

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| k2k.additionalContainerSpec | object | `nil` | Optionally add arbitrary fields to the main container spec (e.g. tty, stdin, etc) |
| k2k.additionalPodSpec | object | `nil` | Optionally add arbitrary fields to the pod spec (e.g. priorityClassName, priority, etc) |
| k2k.additionalVolumeMounts | list | `[]` | Additional volume mounts |
| k2k.additionalVolumes | list | `[]` | Additional volumes |
| k2k.livenessProbe | string | `{"enabled":false}` | Disables livenessProbe, used while debugging |

### K2K deployment values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| k2k.additionalEnv | list | `[]` | Additional env variables appended to deployment |
| k2k.affinity | dict | `{}` | Deployment affinity rules |
| k2k.annotations | dict | `{}` | Custom deployment annotations |
| k2k.deployment | object | `{"replicas":1,"resources":{"limits":{"memory":"1Gi"},"requests":{"memory":"1Gi"}}}` | Pod resources |
| k2k.image | object | `{"pullPolicy":"IfNotPresent","repository":"lensesio/k2k","tag":"2.0"}` | Image map |
| k2k.image.pullPolicy | string | `"IfNotPresent"` | Image pullPolicy |
| k2k.image.repository | string | `"lensesio/k2k"` | Image repository |
| k2k.labels | dict | `{}` | Deployment labels |
| k2k.nodeSelector | dict | `{}` | Deployment nodeSelector |
| k2k.podTemplateAnnotations | dict | `{}` | Annotations here go into the PodTemplateSpec at deployment.spec.template.annotations. |
| k2k.securityContext | dict | `{}` | Deployment security context |
| k2k.strategy | dict | `{}` | Deployment strategy |
| k2k.tolerations | dict | `[]` | Deployment tolerations |

### K2K OTEL configs

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| k2k.otelConfig | object | `{"logsExporter":"none","metricsExporter":"prometheus","prometheusHost":"0.0.0.0","prometheusPort":9090,"serviceName":"k2k","tracesExporter":"none"}` | Otel configuration section. |

### K2K replication config

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| k2k.replicationConfig | object | `{}` | Replication configuration for k2k. See documentation for structure. |

### K2K deployment service values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| k2k.service.annotations | dict | `{}` | Additional service annotations |
| k2k.service.enabled | bool | `true` | Deciding factor whether K2K service will be created and which type |
| k2k.service.type | string | `"ClusterIP"` | Type of service to be created. |

### K2K permission scope values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| k2k.serviceAccount | object | `{"annotations":{},"create":false,"name":"default"}` | User to be used by K2K to deploy apps |
| k2k.serviceAccount.annotations | dict | `{}` | Additional service account annotations. |
| k2k.serviceAccount.create | bool | `false` | In case "true" new SA will be created with service.name as a SA name. |
| k2k.serviceAccount.name | string | `"default"` | Name of Service Account. In case serviceAccount.create is *false*, existing SA with defined name here will be used. |

### Offset Mapper extras

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| offsetMapper.additionalContainerSpec | object | `nil` | Optionally add arbitrary fields to the main container spec (e.g. tty, stdin, etc) |
| offsetMapper.additionalPodSpec | object | `nil` | Optionally add arbitrary fields to the pod spec (e.g. priorityClassName, priority, etc) |
| offsetMapper.additionalVolumeMounts | list | `[]` | Additional volume mounts |
| offsetMapper.additionalVolumes | list | `[]` | Additional volumes |
| offsetMapper.livenessProbe | string | `{"enabled":false}` | Disables livenessProbe, used while debugging |

### Offset Mapper deployment values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| offsetMapper.additionalEnv | list | `[]` | Additional env variables appended to deployment |
| offsetMapper.affinity | dict | `{}` | Deployment affinity rules |
| offsetMapper.annotations | dict | `{}` | Custom deployment annotations |
| offsetMapper.deployment | object | `{"replicas":1,"resources":{"limits":{"memory":"1Gi"},"requests":{"memory":"1Gi"}}}` | Pod resources |
| offsetMapper.image | object | `{"pullPolicy":"IfNotPresent","repository":"lensesio/k2k-offset-mapper","tag":"2.0"}` | Image map |
| offsetMapper.image.pullPolicy | string | `"IfNotPresent"` | Image pullPolicy |
| offsetMapper.image.repository | string | `"lensesio/k2k-offset-mapper"` | Image repository |
| offsetMapper.labels | dict | `{}` | Deployment labels |
| offsetMapper.nodeSelector | dict | `{}` | Deployment nodeSelector |
| offsetMapper.podTemplateAnnotations | dict | `{}` | Annotations here go into the PodTemplateSpec at deployment.spec.template.annotations. |
| offsetMapper.securityContext | dict | `{}` | Deployment security context |
| offsetMapper.strategy | dict | `{}` | Deployment strategy |
| offsetMapper.tolerations | dict | `[]` | Deployment tolerations |

### Offset Mapper values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| offsetMapper.enabled | bool | `false` | Enable the K2K Offset Mapper deployment |

### Offset Mapper OTEL configs

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| offsetMapper.otelConfig | object | `{"logsExporter":"none","metricsExporter":"prometheus","prometheusHost":"0.0.0.0","prometheusPort":9091,"serviceName":"k2k-offset-mapper","tracesExporter":"none"}` | Otel configuration section. |

### Offset Mapper config

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| offsetMapper.overrideConfig | object | `{}` | Override configuration for offset mapper. Overrides values from the base k2k replicationConfig. |

### Offset Mapper service values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| offsetMapper.service.annotations | dict | `{}` | Additional service annotations |
| offsetMapper.service.enabled | bool | `true` | Deciding factor whether Offset Mapper service will be created and which type |
| offsetMapper.service.type | string | `"ClusterIP"` | Type of service to be created. |

### Offset Mapper permission scope values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| offsetMapper.serviceAccount.annotations | dict | `{}` | Additional service account annotations. |
| offsetMapper.serviceAccount.create | bool | `false` | In case "true" new SA will be created. |
| offsetMapper.serviceAccount.name | string | `"default"` | Name of Service Account. In case serviceAccount.create is *false*, existing SA with defined name here will be used. |

### Other Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| commonLabels | dict | `{}` | Common labels applied to all resources (k2k and offset mapper) |
| fullnameOverride | string | `""` |  |
| nameOverride | string | `""` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
