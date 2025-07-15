# lenses-k2k

![Version: 0.0.2](https://img.shields.io/badge/Version-0.0.2-informational?style=flat-square) ![AppVersion: 0.0.2](https://img.shields.io/badge/AppVersion-0.0.2-informational?style=flat-square)

A Helm chart for Lenses K2K Replicator

## Values

### Extras

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| additionalVolumeMounts | list | `nil` | Additional volume mounts to use in Lenses delpoyments, for example to load additional plugins (UDFs) in Lenses Use it in conjuction with lenses.additionalVolumes |
| additionalVolumes | list | `nil` | Additional volumes to use in Lenses delpoyments either by Lenses for other sidecars like Lenses provisioner. |

### Custom deployment values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | dict | `{}` | Deployment affinity rules |
| annotations | dict | `{}` | Custom deployment annotations |
| deployment.resources | object | `{"limits":{"memory":"4Gi"},"requests":{"memory":"2Gi"}}` | Pod resources |
| labels | dict | `{}` | Deployment labels |
| nodeSelector | dict | `{}` | Deployment nodeSelector |
| podTemplateAnnotations | dict | `{}` | Annotations here go into the PodTemplateSpec at deployment.spec.template.annotations. |
| securityContext | dict | `{}` | Deployment security context |
| strategy | dict | `{}` | Deployment strategy |
| tolerations | dict | `[]` | Deployment tolerations |

### Lenses HQ deployment service values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| service.annotations | dict | `{}` | Additional service annotations |
| service.enabled | bool | `true` | Deciding factor whether Lenses HQ service will be created and which type |
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
| deployment.replicas | int | `1` |  |
| fullnameOverride | string | `""` |  |
| image.repository | string | `"lensting/k2k"` |  |
| image.tag | string | `"v0.0.2-alpha"` |  |
| k2k.acceptEULA | bool | `true` |  |
| k2k.monitoring.port | int | `9090` |  |
| k2k.otelConfig.logsExporter | string | `"none"` |  |
| k2k.otelConfig.metricsExporter | string | `"prometheus"` |  |
| k2k.otelConfig.prometheusHost | string | `""` |  |
| k2k.otelConfig.prometheusPort | string | `"9090"` |  |
| k2k.otelConfig.serviceName | string | `"k2k"` |  |
| k2k.otelConfig.tracesExporter | string | `"none"` |  |
| k2k.replicationConfig.coordination.kafka.assignment.fencingMaxParallelism | int | `10` |  |
| k2k.replicationConfig.coordination.kafka.assignment.graceWindow | string | `"15 seconds"` |  |
| k2k.replicationConfig.coordination.kafka.assignment.topic | string | `"__k2k-app-eot-assignment"` |  |
| k2k.replicationConfig.coordination.kafka.charset | string | `"UTF-8"` |  |
| k2k.replicationConfig.coordination.kafka.commit.batchSize | int | `10000` |  |
| k2k.replicationConfig.coordination.kafka.commit.batchTimeout | string | `"30 seconds"` |  |
| k2k.replicationConfig.coordination.kafka.commit.group | string | `"k2k.eot"` |  |
| k2k.replicationConfig.coordination.kafka.commit.syncTimeout | string | `"60 seconds"` |  |
| k2k.replicationConfig.coordination.kafka.commit.topic | string | `"__k2k-app-eot-consumer-offsets"` |  |
| k2k.replicationConfig.coordination.kafka.consumer | string | `nil` |  |
| k2k.replicationConfig.errorHandling.onCommitSyncTimeout | string | `"fail"` |  |
| k2k.replicationConfig.errorHandling.onControlMessageDeserializationError | string | `"fail"` |  |
| k2k.replicationConfig.features.exactlyOnce | string | `"disabled"` |  |
| k2k.replicationConfig.features.headerReplication | string | `"disabled"` |  |
| k2k.replicationConfig.features.offsetCommitOptimizePartition | string | `"disabled"` |  |
| k2k.replicationConfig.features.schemaMapping | string | `"disabled"` |  |
| k2k.replicationConfig.features.tracingHeaders | string | `"disabled"` |  |
| k2k.replicationConfig.name | string | `"simple_pipeline"` |  |
| k2k.replicationConfig.replication[0].source.name | string | `"source"` |  |
| k2k.replicationConfig.replication[0].source.topic[0] | string | `"airline-customers"` |  |
| k2k.replicationConfig.replication[0].source.topic[1] | string | `"airline-customers-name"` |  |
| k2k.replicationConfig.replication[1].sink.name | string | `"sink-source-topic"` |  |
| k2k.replicationConfig.replication[1].sink.partition | string | `"source"` |  |
| k2k.replicationConfig.replication[1].sink.topic.prefix | string | `"k2k.eot."` |  |
| k2k.replicationConfig.source.kafka.connection.servers | string | `"general-dev-1-kafka-bootstrap.kafka-dev.svc.cluster.local:9092"` |  |
| k2k.replicationConfig.source.kafka.consumer."group.id" | string | `"k2k.eot"` |  |
| k2k.replicationConfig.source.kafka.registry.url | string | `"http://schema-registry-1:8081"` |  |
| k2k.replicationConfig.target.kafka.connection.servers | string | `"general-dev-2-kafka-bootstrap.kafka-dev.svc.cluster.local:9092"` |  |
| k2k.replicationConfig.target.kafka.producer | string | `nil` |  |
| k2k.replicationConfig.target.kafka.registry.url | string | `"http://schema-registry-2:8081"` |  |
| nameOverride | string | `""` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
