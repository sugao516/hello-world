<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:x="http://www.w3.org/1999/xhtml"
  >

  <xsl:output method="xml" encoding="utf-8" indent="yes" />

  <!-- 要素・属性をコピー -->
  <xsl:template match="/|node()|@*">
    <xsl:copy>
      <xsl:apply-templates select="node()|@*" />
    </xsl:copy>
  </xsl:template>

  <!-- 属性値を変更 -->
  <xsl:template match="x:div[@id='a_modify']/x:p/@style">
    <xsl:attribute name="style">color:blue;</xsl:attribute>
  </xsl:template>

  <!-- 属性を削除 -->
  <xsl:template match="x:div[@id='a_delete']/x:p/@style">
  </xsl:template>

  <!-- 属性を追加 -->
  <xsl:template match="x:div[@id='a_add']/x:p">
    <xsl:copy>
      <xsl:attribute name="style">color:red;</xsl:attribute>
      <xsl:apply-templates select="node()|@*" />
    </xsl:copy>
  </xsl:template>

</xsl:stylesheet>
<!--
../msxsl test_in.xml test.xsl -o test_out.xml
-->
