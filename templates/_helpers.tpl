{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Offset mapper fully qualified name.
Truncate the base name to 48 chars (63 - len("-offset-mapper")) so the suffix
is never silently stripped, which would cause name collisions with the k2k resources.
*/}}
{{- define "offsetMapper.fullname" -}}
{{- printf "%s-offset-mapper" (include "fullname" . | trunc 48 | trimSuffix "-") -}}
{{- end -}}

{{/*
Build a fully-qualified image reference from an image map.
Usage: {{ include "k2k.imageRef" (dict "image" .Values.k2k.image "context" .) }}

Registry handling (backwards compatible):
  image.registry is prepended ONLY when image.repository does not already carry
  its own registry host. A "host" is the first path segment when it contains a
  "." or ":" (a domain or host:port) or equals "localhost". This keeps existing
  values that pin a full path (e.g. an air-gapped mirror such as
  "myregistry.internal/lensesio/k2k") working unchanged, and makes an already
  fully-qualified repository idempotent.

  registry defaults to cr.lenses.io even when left empty, so the default pull
  location is sticky. To use a different registry (e.g. Docker Hub) set it
  explicitly (registry: docker.io) or include the host in repository.

Tag handling (unchanged):
  If image.tag is set, use repository:tag.
  Else if the repository's last segment already contains a colon (embedded tag),
  use it as-is.
  Otherwise fall back to repository:appVersion.
*/}}
{{- define "k2k.imageRef" -}}
{{- $image := .image -}}
{{- $registry := $image.registry | default "cr.lenses.io" -}}
{{- $repository := $image.repository -}}
{{- $segments := splitList "/" $repository -}}
{{- $firstSegment := first $segments -}}
{{- $lastSegment := last $segments -}}
{{- $hasHost := or (contains "." $firstSegment) (contains ":" $firstSegment) (eq $firstSegment "localhost") -}}
{{- $fullRepo := $repository -}}
{{- if and $registry (not $hasHost) -}}
{{- $fullRepo = printf "%s/%s" $registry $repository -}}
{{- end -}}
{{- if $image.tag -}}
{{- printf "%s:%s" $fullRepo $image.tag -}}
{{- else if contains ":" $lastSegment -}}
{{- $fullRepo -}}
{{- else -}}
{{- printf "%s:%s" $fullRepo .context.Chart.AppVersion -}}
{{- end -}}
{{- end -}}

{{/*
K2K image reference.
*/}}
{{- define "k2k.image" -}}
{{- include "k2k.imageRef" (dict "image" .Values.k2k.image "context" .) -}}
{{- end -}}

{{/*
Offset mapper image reference.
*/}}
{{- define "offsetMapper.image" -}}
{{- include "k2k.imageRef" (dict "image" .Values.offsetMapper.image "context" .) -}}
{{- end -}}

{{/*
Common labels applied to all resources.
*/}}
{{- define "commonLabels" -}}
chart: {{ printf "%s-%s" .Chart.Name .Chart.Version }}
release: {{ .Release.Name }}
heritage: {{ .Release.Service }}
{{- if .Values.commonLabels }}
{{ toYaml .Values.commonLabels }}
{{- end }}
{{- end -}}
