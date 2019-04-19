<?php

use App\Oauth\Repository\AuthCodeRepository;
use App\Oauth\Repository\RefreshTokenRepository;
use League\OAuth2\Server\Grant\AuthCodeGrant;
use League\OAuth2\Server\Grant\ClientCredentialsGrant;
use League\OAuth2\Server\Grant\ImplicitGrant;
use League\OAuth2\Server\Grant\RefreshTokenGrant;
use Phalcon\Session\Adapter\Files as Session;
use Phalcon\Security;
use Phalcon\Mvc\Dispatcher;
use Phalcon\Flash\Direct as FlashDirect;
use Phalcon\Flash\Session as FlashSession;
use App\Oauth\Repository\AccessTokenRepository;
use App\Oauth\Repository\ScopeRepository;
use Defuse\Crypto\Key;
use App\Oauth\Repository\ClientRepository;
use League\OAuth2\Server\AuthorizationServer;

$di = new \Phalcon\Di\FactoryDefault();
$di['config'] = function() use ($config) {
	return $config;
};

$di['session'] = function() {
    $session = new Session();
	$session->start();

	return $session;
};

$di['dispatcher'] = function() use ($di, $defaultModule) {

    $eventsManager = $di->getShared('eventsManager');
    $dispatcher = new Dispatcher();
    $dispatcher->setEventsManager($eventsManager);

    return $dispatcher;
};

$di['url'] = function() use ($config, $di) {
	$url = new \Phalcon\Mvc\Url();

    $url->setBaseUri($config->url['baseUrl']);

	return $url;
};

$di['voltService'] = function($view, $di) use ($config) {
    $volt = new \Phalcon\Mvc\View\Engine\Volt($view, $di);
    if (!is_dir($config->application->cacheDir)) {
        mkdir($config->application->cacheDir);
    }

    $compileAlways = $config->mode == 'DEVELOPMENT' ? true : false;

    $volt->setOptions(array(
        "compiledPath" => $config->application->cacheDir,
        "compiledExtension" => ".compiled",
        "compileAlways" => $compileAlways
    ));
    return $volt;
};

$di->set(
    'security',
    function () {
        $security = new Security();
        $security->setWorkFactor(12);

        return $security;
    },
    true
);

$di->set(
    'flash',
    function () {
        $flash = new FlashDirect(
            [
                'error'   => 'alert alert-danger',
                'success' => 'alert alert-success',
                'notice'  => 'alert alert-info',
                'warning' => 'alert alert-warning',
            ]
        );

        return $flash;
    }
);

$di->set(
    'flashSession',
    function () {
        $flash = new FlashSession(
            [
                'error'   => 'alert alert-danger',
                'success' => 'alert alert-success',
                'notice'  => 'alert alert-info',
                'warning' => 'alert alert-warning',
            ]
        );

        $flash->setAutoescape(false);
        
        return $flash;
    }
);

$di->setShared('database', function() use ($di) {
    $config = require APP_PATH.'/config/config.php';

    $type = $config->database->adapter;
    $creds = array(
        'host' => $config->database->host,
        'username' => $config->database->username,
        'password' => $config->database->password,
        'dbname' => $config->database->dbname
    );

    if ($type == 'Phalcon\Db\Adapter\Pdo\Mysql') {
        $connection =  new \Phalcon\Db\Adapter\Pdo\Mysql($creds);
    }
    else {
        throw new Exception('Bad Database Adapter');
    }

    return $connection;
});

$di->setShared('oauth2Server',function () use ($di){

    $clientRepository = new ClientRepository();
    $accessTokenRepository = new AccessTokenRepository();
    $scopeRepository = new ScopeRepository();
    $authCodeRepository = new AuthCodeRepository();
    $refreshTokenRepository = new RefreshTokenRepository();
    $server = new AuthorizationServer(
        $clientRepository,
        $accessTokenRepository,
        $scopeRepository,
        APP_PATH.'/private.key',
        Key::loadFromAsciiSafeString('def000007b563c22b8980cda772eb3e550f6bf6b9c54dbf769474edf155a103995f04a3602a58dbc2905a45075236fe7fc0a503bab6ea4c2618850e5e7bd6992a9ec0003')
    );

    $authCodeGrant =new AuthCodeGrant(
        $authCodeRepository,
        $refreshTokenRepository,
        new \DateInterval('PT1H')
    );

    $refreshTokenGrant = new RefreshTokenGrant(
        $refreshTokenRepository
    );
    $refreshTokenGrant->setRefreshTokenTTL(new \DateInterval('PT1H'));

    $server->enableGrantType(
        $authCodeGrant, new \DateInterval('PT1H')
    );
    $server->enableGrantType(
        $refreshTokenGrant, new \DateInterval('PT1H')
    );
    $server->enableGrantType(
        new ClientCredentialsGrant(), new \DateInterval('PT1H')
    );
    $server->enableGrantType(
        new ImplicitGrant(new \DateInterval('PT1H')), new \DateInterval('PT1H')
    );

    return $server;
});

