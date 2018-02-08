<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="xml" encoding="utf-8" />

  <xsl:template match="/|node()|@*">
    <xsl:copy>
      <xsl:apply-templates select="node()|@*" />
    </xsl:copy>
  </xsl:template>

  <xsl:template match="@style">
    <xsl:attribute name="style">color:blue;</xsl:attribute>
  </xsl:template>

</xsl:stylesheet>
<!--
./msxsl 002/test_in.xml 002/test.xsl -o 002/test_out.xml
-->
