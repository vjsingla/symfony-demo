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
class HealthCheckController
{
    #[Route('/health-check', name: 'app_health_check', methods: ['GET'])]
    public function get(): Response
    {
        return new JsonResponse("Ok");
    }
}