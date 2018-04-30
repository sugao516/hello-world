<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:x="http://www.w3.org/1999/xhtml"
  >

  <xsl:output method="xml" encoding="utf-8" indent="yes" />

  <!-- 要素・属性をコピー -->
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
../msxsl test_in.xml test.xsl -o test_out.xml
-->
