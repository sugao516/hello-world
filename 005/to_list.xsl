<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:x="http://www.w3.org/1999/xhtml"
  xmlns="http://www.w3.org/1999/xhtml"
  exclude-result-prefixes="x"
  >

  <xsl:output method="xml" encoding="utf-8" indent="yes" />

  <xsl:template match="//processing-instruction()">
    <xsl:processing-instruction name="xml-stylesheet">type="text/xsl" href="to_cuts.xsl"</xsl:processing-instruction>
  </xsl:template>

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
          <xsl:apply-templates select="//x:table[1]//x:tr" >
            <xsl:with-param name="p.th" select="true()"/>
          </xsl:apply-templates>
        </tr>
        <!-- データ行 -->
        <xsl:apply-templates select="node()|@*" />
      </table>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="x:table">
    <!-- データ行 -->
    <tr>
      <!-- tbodyがある場合を考慮して、"//"としておく -->
      <xsl:apply-templates select=".//x:tr" />
    </tr>
  </xsl:template>

  <xsl:template match="x:tr">
    <xsl:param name="p.th"/>
    <xsl:choose>
      <xsl:when test="false()"></xsl:when>
<!-- 指定項目を表示したくない場合、有効にする。この場合は、5列目（備考）が表示されなくなる
      <xsl:when test="position()= 5"></xsl:when>
-->
      <xsl:otherwise>
        <xsl:choose>
          <xsl:when test="$p.th">
            <xsl:apply-templates select="x:th" />
          </xsl:when>
          <xsl:otherwise>
            <xsl:apply-templates select="x:td" />
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
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
