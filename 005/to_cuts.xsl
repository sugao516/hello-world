<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:x="http://www.w3.org/1999/xhtml"
  xmlns="http://www.w3.org/1999/xhtml"
  exclude-result-prefixes="x"
  >

  <xsl:output method="xml" encoding="utf-8" indent="yes" />

  <xsl:template match="x:title">
    <xsl:copy>
      <xsl:text>単票形式</xsl:text>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="x:table">
    <xsl:apply-templates select="node()|@*" />
  </xsl:template>

  <xsl:template match="x:tr">
    <xsl:if test="x:td">
      <table border="1">
        <xsl:apply-templates select="x:td" />
      </table>
      <xsl:if test=".!=//x:tr[count(//x:tr)]">
        <hr/>
      </xsl:if>
    </xsl:if>
  </xsl:template>

  <xsl:template match="x:td">
    <xsl:variable name="v.pos" select="position()" />
    <tr>
      <xsl:apply-templates select="//x:th[$v.pos]" />
      <xsl:copy>
        <xsl:apply-templates select="node()|@*" />
      </xsl:copy>
    </tr>
  </xsl:template>

  <xsl:template match="x:meta|x:br">
    <xsl:copy-of select="."/>
  </xsl:template>

  <!-- 要素・属性をコピー -->
  <xsl:template match="/|node()|@*">
    <xsl:copy>
      <xsl:apply-templates select="node()|@*" />
    </xsl:copy>
  </xsl:template>

</xsl:stylesheet>
<!--
../msxsl list_in.xml to_cuts.xsl -o cuts_out.xml
-->
