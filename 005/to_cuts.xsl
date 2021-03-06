<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:x="http://www.w3.org/1999/xhtml"
  xmlns="http://www.w3.org/1999/xhtml"
  exclude-result-prefixes="x"
  >

  <xsl:output method="xml" encoding="utf-8" indent="yes" />

  <xsl:template match="//processing-instruction()">
    <xsl:processing-instruction name="xml-stylesheet">type="text/xsl" href="to_list.xsl"</xsl:processing-instruction>
  </xsl:template>

  <xsl:template match="x:title">
    <xsl:copy>
      <xsl:text>単票形式</xsl:text>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="x:table">
    <xsl:apply-templates select=".//x:tr" />
  </xsl:template>

  <xsl:template match="x:tr">
    <xsl:if test="position()!=1">
      <table border="1">
        <xsl:apply-templates select="x:td" />
      </table>
      <xsl:if test="position()!=last()">
        <hr/>
      </xsl:if>
    </xsl:if>
  </xsl:template>

  <xsl:template match="x:td">
    <xsl:variable name="v.pos" select="position()" />
    <xsl:choose>
      <xsl:when test="false()"></xsl:when>
<!-- 指定項目を表示したくない場合、有効にする。この場合は、5行目（備考）が表示されなくなる
      <xsl:when test="$v.pos= 5"></xsl:when>
-->
      <xsl:otherwise>
        <tr>
          <xsl:apply-templates select="//x:th[$v.pos]" />
          <xsl:copy>
            <xsl:apply-templates select="node()|@*" />
          </xsl:copy>
        </tr>
      </xsl:otherwise>
    </xsl:choose>
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
