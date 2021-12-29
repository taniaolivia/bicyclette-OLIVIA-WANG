<?xml version='1.0' encoding="UTF-8" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version='1.0'>

    <xsl:output method="xml" indent="yes"/>
    <xsl:strip-space elements="*"/>

    <xsl:template match="/">
        <METEO>
            <previsions>
                <xsl:apply-templates select="previsions/echeance"/>
            </previsions>
        </METEO>
    </xsl:template>

    <xsl:template match="echeance">
        <echeance>
            <xsl:attribute name="hour">
                <xsl:value-of select="@hour"/>
            </xsl:attribute>
            <xsl:attribute name="timestamp">
                <xsl:value-of select="@timestamp"/>
            </xsl:attribute>
            <temperature>
                <level>
                    <xsl:attribute name="val">
                        <xsl:value-of select="temperature/level/@val"/>
                    </xsl:attribute>
                    <xsl:value-of select="temperature/level[1] - 273.15"/>
                </level>
            </temperature>
            <pression>
                <level>
                    <xsl:attribute name="val">
                        <xsl:value-of select="pression/level/@val"/>
                    </xsl:attribute>
                    <xsl:value-of select="pression * 0.01"/>
                </level>
            </pression>
            <pluie>
                <xsl:attribute name="interval">
                    <xsl:value-of select="pluie/@interval"/>
                </xsl:attribute>
                <xsl:value-of select="pluie"/>
            </pluie>
            <humidite>
                <level>
                    <xsl:attribute name="val">
                        <xsl:value-of select="humidite/level/@val"/>
                    </xsl:attribute>
                    <xsl:value-of select="humidite"/>
                </level>
            </humidite>
            <vent_moyen>
                <level>
                    <xsl:attribute name="val">
                        <xsl:value-of select="vent_moyen/level/@val"/>
                    </xsl:attribute>
                    <xsl:value-of select="vent_moyen"/>
                </level>
            </vent_moyen>
            <risque_neige>
                <xsl:value-of select="risque_neige"/>
            </risque_neige>
        </echeance>
    </xsl:template>

</xsl:stylesheet>