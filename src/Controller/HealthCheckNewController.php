<?php


namespace App\Controller;


use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

/**
 * Class HealthCheckController
 * @package App\Controller
 *
 * @Route("/")
 */
class HealthCheckNewController
{
    /**
     * @Route("/health-check-new", name="app_health_check_new")
     */
    public function get(): Response
    {
        return new JsonResponse("Ok");
    }
}