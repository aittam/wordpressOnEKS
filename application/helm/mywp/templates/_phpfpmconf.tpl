{{- define "phpfpm.config" -}}
[www]

user = {{ .Values.phpfpm.user }}
group = {{ .Values.phpfpm.group }}

listen = {{ .Values.phpfpm.listen }}
listen.mode = 0666

pm = dynamic
pm.max_children = 5

; The number of child processes created on startup.
; Default Value: min_spare_servers + (max_spare_servers - min_spare_servers) / 2
pm.start_servers = 2

; The desired minimum number of idle server processes.
pm.min_spare_servers = 1

; The desired maximum number of idle server processes.
pm.max_spare_servers = 3

; Monitoring
pm.status_path = /status
ping.path = /ping

{{ end }}