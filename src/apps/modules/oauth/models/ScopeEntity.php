<?php

namespace App\Oauth\Models;
use League\OAuth2\Server\Entities\ScopeEntityInterface;


class ScopeEntity implements ScopeEntityinterface
{
    /**
     * Get the scope's identifier.
     *
     * @return string
     */
    public function getIdentifier()
    {
        // TODO: Implement getIdentifier() method.
        var_dump('getId Scope');
        die();
    }

    /**
     * Specify data which should be serialized to JSON
     * @link https://php.net/manual/en/jsonserializable.jsonserialize.php
     * @return mixed data which can be serialized by <b>json_encode</b>,
     * which is a value of any type other than a resource.
     * @since 5.4.0
     */
    public function jsonSerialize()
    {
        // TODO: Implement jsonSerialize() method.
        var_dump('json serialize');
        die();
    }
}