<?php

namespace App\Oauth\Controllers\Api;

use App\Oauth\Repository\AccessTokenRepository;
use App\Oauth\Repository\ScopeRepository;
use Defuse\Crypto\Key;
use App\Oauth\Repository\ClientRepository;
use GuzzleHttp\Psr7\ServerRequest;
use League\OAuth2\Server\AuthorizationServer;
use Phalcon\Db\Adapter\Pdo\Mysql;
use Phalcon\Http\Response;
use Phalcon\Mvc\Controller;

/**
 * Class AuthController
 * @property \League\OAuth2\Server\AuthorizationServer oauth2Server injected into DI
 * @package App\Controllers
 */

 /*
 * Expectation
 * @method POST
 * @required body : grant_type client_credentials
 * @required body : client_id
 * @optional body : client_secret
 * @optional body : scope *Space delimited*
 */
class AuthController extends Controller
{
    
    public function clientGrantAction()
    {
        $serverResponse = new \GuzzleHttp\Psr7\Response();
        $request = ServerRequest::fromGlobals();
        $response = $this->oauth2Server->respondToAccessTokenRequest(ServerRequest::fromGlobals(), $serverResponse);
        $httpResponse = new Response();
        $httpResponse->setContentType('application/json');
        $httpResponse->setContent($response->getBody());
        $httpResponse->send();
    }
}