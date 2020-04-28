{{- define "wordpress.config" -}}
<?php

define( 'WP_SITEURL', 'http://{{ .Values.external_name }}' );
define( 'WP_HOME', 'http://{{ .Values.external_name }}' );
define( 'DB_NAME', '{{ .Values.wordpress.db_name }}' );
define( 'DB_USER', '{{ .Values.wordpress.db_user }}' );
define( 'DB_PASSWORD', '{{ .Values.wordpress.db_password }}' );
define( 'DB_HOST', '{{ .Values.wordpress.db_host }}' );
define( 'DB_CHARSET', 'utf8' );
define( 'DB_COLLATE', '' );
define( 'AUTH_KEY',         '{{ .Values.wordpress.auth_key }}' );
define( 'SECURE_AUTH_KEY',  '{{ .Values.wordpress.secure_auth_key }}' );
define( 'LOGGED_IN_KEY',    '{{ .Values.wordpress.logged_in_key }}' );
define( 'NONCE_KEY',        '{{ .Values.wordpress.nonce_key }}' );
define( 'AUTH_SALT',        '{{ .Values.wordpress.auth_salt }}' );
define( 'SECURE_AUTH_SALT', '{{ .Values.wordpress.secure_auth_salt }}' );
define( 'LOGGED_IN_SALT',   '{{ .Values.wordpress.logged_in_salt }}' );
define( 'NONCE_SALT',       '{{ .Values.wordpress.nonce_salt }}' );
$table_prefix = 'wp_';
define( 'WP_DEBUG', false );

if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}
require_once ABSPATH . 'wp-settings.php';

{{ end }}