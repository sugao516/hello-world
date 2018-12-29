<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:x="http://www.w3.org/1999/xhtml"
  >

  <xsl:output method="xml" encoding="utf-8" indent="yes" />

  <!-- (A)要素・属性をコピー
  1.空要素タグは、開始タグ・終了タグに展開されない 
  2.開始タグ・終了タグは、空要素タグにはならない 
  -->
  <xsl:template match="x:hr|x:br|x:p">
    <xsl:copy-of select="."/>
  </xsl:template>

  <!-- (B)要素・属性をコピー
  1.空要素タグは、開始タグ・終了タグに展開される 
  2.開始タグ・終了タグは、空要素タグにはならない 
  -->
  <xsl:template match="/|node()|@*">
    <xsl:copy>
      <xsl:apply-templates select="node()|@*" />
    </xsl:copy>
  </xsl:template>

</xsl:stylesheet>
<!--
../msxsl test_in.xml test.xsl -o test_out.xml
-->
