{{- define "nginx.config" -}}

server {
    listen 80 default_server;
    # monitoring health check
    location = {{ .Values.deployment.nginx_container.readiness_probe_path }} {
        stub_status on;
        access_log off;
    }
    # Disable access to the applications if HOST header doesn't macth
    # a known vhost
    location / {
        return 404;
    }
}

upstream php {
    server unix:{{ .Values.phpfpm.listen }};
}

server {
    listen 80;
    server_name  {{ .Values.external_name }};
    
    root  /var/www/html;
    index index.php;

    location / {
        # This is cool because no php is touched for static content.
        # include the "?$args" part so non-default permalinks doesn't break when using query string
        try_files $uri $uri/ /index.php?$args;
    }

    # pass the PHP scripts to FastCGI server listening on unix socket
    location ~ \.php$ {
        include fastcgi_params;
        fastcgi_intercept_errors on;
        fastcgi_pass php;
        fastcgi_param  SCRIPT_FILENAME $document_root$fastcgi_script_name;
    }

    #enforce https client side
    #add_header Strict-Transport-Security "max-age=31536000; includeSubdomains;" always;

   # Inject HTTP Header with X-XSS protection to mitigate Cross-Site scripting attack
   add_header X-XSS-Protection "1; mode=block";

   add_header X-Frame-Options sameorigin;

   add_header X-Content-Type-Options nosniff;

    # deny access to .htaccess files, just in case some wp plugins do weird things
    location ~ /\.ht {
       deny  all;
    }

}
{{ end }}