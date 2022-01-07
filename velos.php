<?php

/**
 * Fonction pour récupérer l'adresse IP basé sur la position du client
 */
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


/**
 * API et XML pour la position du client
 */
$ip = file_get_contents("http://ip-api.com/xml/185.226.17.22");
$xml1 = simplexml_load_string($ip);

set_time_limit(0);
file_put_contents('data/position/position_client.xml', $ip);


/**
 * API et XML pour la météo
 */
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


$xml3 = new DOMDocument();
$xml3->load('data/meteo/meteo1.xml');

$xsl2 = new DOMDocument();
$xsl2->load('data/meteo/meteo2.xsl');

$xslt2 = new XSLTProcessor();
$xslt2->importStylesheet($xsl2);

$html = $xslt2->transformToXML($xml3);
file_put_contents('html/meteo.html', $html);



/**
 * API et XML pour avoir les informations pour chauqe station ou parking du vélo
 */
$stations_xml = '<stations>';
for($i = 1; $i <= 34; $i++ )
{
    $stations_xml .= file_get_contents("http://www.velostanlib.fr/service/stationdetails/nancy/$i");
}
$stations_xml = str_replace('<?xml version="1.0" encoding="utf-8"?>', '', $stations_xml);
$stations_xml .= '</stations>';
file_put_contents('data/stations/stations.xml', '<?xml version="1.0" encoding="utf-8"?>');
file_put_contents('data/stations/stations.xml', $stations_xml, FILE_APPEND);


$xml4 = new DOMDocument();
$xml4->load('data/stations/stations.xml');

$xsl3 = new DOMDocument();
$xsl3->load('data/stations/stations1.xsl');

$xslt3 = new XSLTProcessor();
$xslt3->importStylesheet($xsl3);

$stringxml2 = $xslt3->transformToXML($xml4);

$convertedXML2 = simplexml_load_string($stringxml2);
$convertedXML2->saveXML("data/stations/stations1.xml");



/**
 * API et XML pour les parkings du vélo
 */
$parkings = 'http://www.velostanlib.fr/service/carto';
$file3 = file_get_contents($parkings);
file_put_contents('data/parkings/parkings.xml', $file3);

$xml5 = new DOMDocument();
$xml5->load('data/parkings/parkings.xml');

$xsl4 = new DOMDocument();
$xsl4->load('data/parkings/parkings1.xsl');

$xslt4 = new XSLTProcessor();
$xslt4->importStylesheet($xsl4);

$stringxml3 = $xslt4->transformToXML($xml5);

$convertedXML3 = simplexml_load_string($stringxml3);
$convertedXML3->saveXML("data/parkings/parkings1.xml");



$xml6 = new DOMDocument();
$xml6->load('data/parkings/parkings1.xml');

$xsl5 = new DOMDocument();
$xsl5->load('data/parkings/parkings2.xsl');

$xslt5 = new XSLTProcessor();
$xslt5->importStylesheet($xsl5);

$stringxml4 = $xslt5->transformToXML($xml6);

$convertedXML4 = simplexml_load_string($stringxml4);
$convertedXML4->saveXML("data/parkings/parkings2.xml");




include "html/map.html";
include "html/meteo.html";



