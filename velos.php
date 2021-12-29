<?php

function getIp()
{
    $IPaddress = '';
    if (isset($_SERVER)){
        if (isset($_SERVER["HTTP_X_FORWARDED_FOR"])){
            $IPaddress = $_SERVER["HTTP_X_FORWARDED_FOR"];
        } else if (isset($_SERVER["HTTP_CLIENT_IP"])) {
            $IPaddress = $_SERVER["HTTP_CLIENT_IP"];
        } else {
            $IPaddress = $_SERVER["REMOTE_ADDR"];
        }
    } else {
        if (getenv("HTTP_X_FORWARDED_FOR")){
            $IPaddress = getenv("HTTP_X_FORWARDED_FOR");
        } else if (getenv("HTTP_CLIENT_IP")) {
            $IPaddress = getenv("HTTP_CLIENT_IP");
        } else {
            $IPaddress = getenv("REMOTE_ADDR");
        }
    }
    return $IPaddress;
}

$ip = file_get_contents("http://ip-api.com/xml/185.226.17.22");
$xml1 = simplexml_load_string($ip);

set_time_limit(0);
file_put_contents('data/position/position_client.xml', $ip);

$meteo = "https://www.infoclimat.fr/public-api/gfs/xml?_ll=$xml1->lat,$xml1->lon&_auth=ARsDFFIsBCZRfFtsD3lSe1Q8ADUPeVRzBHgFZgtuAH1UMQNgUTNcPlU5VClSfVZkUn8AYVxmVW0Eb1I2WylSLgFgA25SNwRuUT1bPw83UnlUeAB9DzFUcwR4BWMLYwBhVCkDb1EzXCBVOFQoUmNWZlJnAH9cfFVsBGRSPVs1UjEBZwNkUjIEYVE6WyYPIFJjVGUAZg9mVD4EbwVhCzMAMFQzA2JRMlw5VThUKFJiVmtSZQBpXGtVbwRlUjVbKVIuARsDFFIsBCZRfFtsD3lSe1QyAD4PZA%3D%3D&_c=19f3aa7d766b6ba91191c8be71dd1ab2";

$file2 = file_get_contents($meteo);
file_put_contents('data/meteo/meteo.xml', $file2);

$xml2 = new DOMDocument();
$xml2->load('data/meteo/meteo.xml');

$xsl = new DOMDocument();
$xsl->load('data/meteo/meteo1.xsl');

$xslt = new XSLTProcessor();
$xslt->importStylesheet($xsl);

$stringxml = $xslt->transformToXML($xml2);

$convertedXML = simplexml_load_string($stringxml);
$convertedXML->saveXML("data/meteo/meteo1.xml");

include "html/map.html";
include "html/meteo.html";



