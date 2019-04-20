<?php

use Phalcon\Config;

return new Config(
    [
        'mode' => 'DEVELOPMENT', //DEVELOPMENT, PRODUCTION, DEMO

        'database' => [
            'adapter' => 'Phalcon\Db\Adapter\Pdo\Mysql',
            'host' => getenv("DB_HOST"),
            'port' => getenv("DB_PORT"),
            'username' => getenv("DB_USERNAME"),
            'password' => getenv("DB_PASS"),
            'dbname' => getenv("DB_NAME")
        ],   
        
        'application' => [
            'libraryDir' => APP_PATH . "/lib/",
            'cacheDir' => APP_PATH . "/cache/",
        ],

        'version' => '0.1',
    ]
);
    