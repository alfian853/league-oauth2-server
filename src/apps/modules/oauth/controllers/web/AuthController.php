<?php

namespace App\Oauth\Controllers\Web;

use Phalcon\Mvc\Controller;

class AuthController extends Controller
{
    public function indexAction()
    {
        return $this->view->pick('dashboard/index');
    }


    public function helloAction(){
        return "hell yeah!";
    }
}