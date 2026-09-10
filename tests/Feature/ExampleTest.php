<?php

namespace Tests\Feature;

use Tests\TestCase;

class ExampleTest extends TestCase
{
    public function test_registration_page_returns_a_successful_response(): void
    {
        $response = $this->get('/register');

        $response->assertStatus(200);
    }
}
