<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="xml" encoding="utf-8" />

  <xsl:template match="/|node()|@*">
<!--
    <xsl:copy-of select="."/>
-->
    <xsl:copy>
      <xsl:apply-templates select="node()|@*" />
    </xsl:copy>
  </xsl:template>

</xsl:stylesheet>
<!--
./msxsl 001/test_in.xml 001/test.xsl -o 001/test_out.xml
-->
