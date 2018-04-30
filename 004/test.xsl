<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:x="http://www.w3.org/1999/xhtml"
  xmlns="http://www.w3.org/1999/xhtml"
  exclude-result-prefixes="x"
  >

  <xsl:output method="xml" encoding="utf-8" cdata-section-elements="style" indent="yes" />

  <!-- 要素・属性をコピー -->
  <xsl:template match="/|node()|@*">
    <xsl:copy>
      <xsl:apply-templates select="node()|@*" />
    </xsl:copy>
  </xsl:template>

  <!-- head要素にstyle要素を追加 -->
  <xsl:template match="x:head">
    <xsl:copy>
      <xsl:apply-templates select="node()|@*" />
<style type="text/css">
<![CDATA[
table,tr,th,td { border: solid thin; }
]]>
</style>
    </xsl:copy>
  </xsl:template>

  <!-- 表に変換 -->
  <xsl:template match="x:body">
    <xsl:copy>
      <h1>表に変換</h1>
      <table>
        <tr>
          <th>章番号</th>
          <th>見出し</th>
          <th>本文</th>
        </tr>
        <xsl:apply-templates select="x:div" />
      </table>
    </xsl:copy>
  </xsl:template>

  <!-- 章ごとに行に変換 -->
  <xsl:template match="x:div">
    <tr>
      <td><xsl:value-of select="position()" /></td>
      <td><xsl:value-of select="x:h1" /></td>
      <td><xsl:value-of select="x:p" /></td>
    </tr>
  </xsl:template>

</xsl:stylesheet>
<!--
../msxsl test_in.xml test.xsl -o test_out.xml
-->
