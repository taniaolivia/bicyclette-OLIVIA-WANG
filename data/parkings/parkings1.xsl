<?xml version='1.0' encoding="UTF-8" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version='1.0'>
    <xsl:output method="xml" indent="yes"/>
    <xsl:strip-space elements="*"/>

    <xsl:template match="/">
        <PARKING>
            <carto>
                <markers>
                    <xsl:apply-templates select="carto/markers/marker"/>
                </markers>
                <xsl:apply-templates select="document('../stations/stations1.xml')/PARKING_INFO/stations"/>
            </carto>
        </PARKING>
    </xsl:template>

    <xsl:template match="carto/markers/marker">
        <marker>
            <xsl:attribute name="name">
                <xsl:value-of select="@name"/>
            </xsl:attribute>
            <xsl:attribute name="number">
                <xsl:value-of select="@number"/>
            </xsl:attribute>
            <xsl:attribute name="station">s<xsl:value-of select="@number"/></xsl:attribute>
            <xsl:attribute name="address">
                <xsl:value-of select="@address"/>
            </xsl:attribute>
            <xsl:attribute name="lat">
                <xsl:value-of select="@lat"/>
            </xsl:attribute>
            <xsl:attribute name="lng">
                <xsl:value-of select="@lng"/>
            </xsl:attribute>
        </marker>
    </xsl:template>

    <xsl:template match="PARKING_INFO/stations">
        <xsl:copy>
            <xsl:copy-of select="*|@*"/>
        </xsl:copy>
    </xsl:template>

</xsl:stylesheet>