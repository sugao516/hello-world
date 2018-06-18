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
      <xsl:text>一覧形式</xsl:text>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="x:body">
    <xsl:copy>
      <table border="1">
        <!-- 見出し行 -->
        <tr>
          <xsl:apply-templates select="//x:table[1]/x:tr/x:th" />
        </tr>
        <!-- データ行 -->
        <xsl:apply-templates select="node()|@*" />
      </table>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="x:table">
    <!-- データ行 -->
    <tr>
      <xsl:apply-templates select=".//x:tr/x:td" />
    </tr>
  </xsl:template>

  <!-- hr タグは破棄する -->
  <xsl:template match="x:hr">
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
../msxsl cuts_in.xml to_list.xsl -o list_out.xml
-->
