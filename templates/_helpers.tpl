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
K2K image reference.
If tag is set explicitly, use repository:tag.
If repository already contains a colon (embedded tag), use it as-is.
Otherwise fall back to repository:appVersion.
*/}}
{{- define "k2k.image" -}}
{{- if .Values.k2k.image.tag -}}
{{- printf "%s:%s" .Values.k2k.image.repository .Values.k2k.image.tag -}}
{{- else if contains ":" .Values.k2k.image.repository -}}
{{- .Values.k2k.image.repository -}}
{{- else -}}
{{- printf "%s:%s" .Values.k2k.image.repository .Chart.AppVersion -}}
{{- end -}}
{{- end -}}

{{/*
Offset mapper image reference.
If tag is set explicitly, use repository:tag.
If repository already contains a colon (embedded tag), use it as-is.
Otherwise fall back to repository:appVersion.
*/}}
{{- define "offsetMapper.image" -}}
{{- if .Values.offsetMapper.image.tag -}}
{{- printf "%s:%s" .Values.offsetMapper.image.repository .Values.offsetMapper.image.tag -}}
{{- else if contains ":" .Values.offsetMapper.image.repository -}}
{{- .Values.offsetMapper.image.repository -}}
{{- else -}}
{{- printf "%s:%s" .Values.offsetMapper.image.repository .Chart.AppVersion -}}
{{- end -}}
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
