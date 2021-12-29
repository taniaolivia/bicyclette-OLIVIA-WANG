<?xml version='1.0' encoding="UTF-8" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version='1.0'>
    <xsl:output method="xml" indent="yes"/>
    <xsl:strip-space elements="*"/>

    <xsl:template match="/">
        <PARKING_INFO>
            <stations>
                <xsl:apply-templates select="stations/station"/>
            </stations>
        </PARKING_INFO>
    </xsl:template>

    <xsl:template match="station">
        <station>
            <xsl:attribute name="ID">s<xsl:number value="position()"/></xsl:attribute>
            <available>
                <xsl:value-of select="available"/>
            </available>
            <free>
                <xsl:value-of select="free"/>
            </free>
            <total>
                <xsl:value-of select="total"/>
            </total>
        </station>
    </xsl:template>

</xsl:stylesheet>