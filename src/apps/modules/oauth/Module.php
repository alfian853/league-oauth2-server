<?php

namespace App\Oauth;

use Phalcon\DiInterface;
use Phalcon\Loader;
use Phalcon\Mvc\ModuleDefinitionInterface;
use Phalcon\Mvc\View;
use Phalcon\Mvc\View\Engine\Volt;

class Module implements ModuleDefinitionInterface
{
    public function registerAutoloaders(DiInterface $di = null)
    {
        $loader = new Loader();

        $loader->registerNamespaces([
            'App\Oauth\Controllers\Web' => __DIR__ . '/controllers/web',
            'App\Oauth\Controllers\Api' => __DIR__ . '/controllers/api',
            'App\Oauth\Models' => __DIR__ . '/models'
        ]);

        $loader->register();
    }

    public function registerServices(DiInterface $di = null)
    {
        $di['view'] = function () {
            $view = new View();
            $view->setViewsDir(__DIR__ . '/views/');

            $view->registerEngines(
                [
                    ".volt" => "voltService",
                ]
            );

            return $view;
        };
    }
}