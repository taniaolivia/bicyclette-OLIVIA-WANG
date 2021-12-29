<?xml version='1.0' encoding="UTF-8" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version='1.0'
                xmlns:date="http://exslt.org/dates-and-times"
                extension-element-prefixes="date">
    <xsl:output method="html" encoding="UTF-8" indent="yes"/>
    <xsl:strip-space elements="*"/>

    <xsl:template match="/">
        <html lang="en">
            <head>
                <meta charset="UTF-8"/>
                <title>Bicyclette</title>
                <link href="./css/style.css" rel="stylesheet"/>
                <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet"/>
                <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet"/>
                <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
            </head>
            <body>
                <div class="container-fluid px-1 px-sm-3 py-5 mx-auto">
                <div class="row d-flex justify-content-center">

                    <xsl:apply-templates select="METEO/previsions/echeance"/>

                </div>
                </div>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="echeance">
            <div class="col-lg-3 col-md-3 card0">
                <div class="card1">
                    <div class="text-center"> <img class="image mt-5" src="https://i.imgur.com/M8VyA2h.png"/> </div>
                    <div class="px-5 mt-1 meteoinfo">
                        <h1 class="large-font mr-3"><xsl:value-of select="format-number(number(temperature/level), '#.##')"/>&#176;</h1>
                        <div class="d-flex flex-column mr-3">
                            <h5><xsl:value-of select="substring(@timestamp, 9, 2)"/>-<xsl:value-of select="substring(@timestamp, 6, 2)"/>-<xsl:value-of select="substring(@timestamp, 1, 4)"/></h5>
                            <h5><xsl:value-of select="substring(@timestamp, 11, 3)"/>h<xsl:value-of select="substring(@timestamp, 15, 2)"/></h5>
                        </div>
                        <div class="d-flex flex-column text-center">
                            <xsl:choose>
                                <xsl:when test="pluie > 0">
                                    <h3 class="fas fa-cloud-showers-heavy mt-4"></h3>
                                    <small>Pluie</small>
                                </xsl:when>
                                <xsl:when test="risque_neige = yes">
                                    <h3 class="far fa-snowflake mt-4"></h3>
                                    <small>Neige</small>
                                </xsl:when>
                                <xsl:otherwise>
                                    <h3 class="far fa-sun mt-4"></h3>
                                    <small>Ensoleillé</small>
                                </xsl:otherwise>

                            </xsl:choose>
                        </div>
                    </div>
                </div>
                <div class="card2">
                    <div class="mr-5">
                        <p>Weather Details</p>
                        <div class="row px-3">
                            <p class="light-text">Humidité</p>
                            <p class="ml-auto"><xsl:value-of select="humidite/level"/>%</p>
                        </div>
                        <div class="row px-3">
                            <p class="light-text">Vent moyen</p>
                            <p class="ml-auto"><xsl:value-of select="vent_moyen/level"/>km/h</p>
                        </div>
                        <div class="row px-3">
                            <p class="light-text">Pluie</p>
                            <p class="ml-auto"><xsl:value-of select="pluie"/>mm</p>
                        </div>
                        <div class="row px-3">
                            <p class="light-text">Pression</p>
                            <p class="ml-auto"><xsl:value-of select="pression/level"/>hPa</p>
                        </div>
                        <div class="line mt-3"></div>
                    </div>
                </div>
            </div>
    </xsl:template>

</xsl:stylesheet>