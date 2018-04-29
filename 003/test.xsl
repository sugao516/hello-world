<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:x="http://www.w3.org/1999/xhtml"
  xmlns="http://www.w3.org/1999/xhtml"
  exclude-result-prefixes="x"
  >

  <xsl:output method="xml" encoding="utf-8" omit-xml-declaration="yes" cdata-section-elements="style" indent="yes" />
  
  <xsl:param name="p.number"/>

  <xsl:template match="/">
    <div>
<style type="text/css">
<![CDATA[
table,tr,th,td { border: solid thin; }
]]>
</style>
    <xsl:apply-templates/>
    </div>
  </xsl:template> 

  <xsl:template match="会員名簿">
    <table>
      <tr>
        <th>会員番号</th><th>氏名</th><th>性別</th><th>年齢</th><th>職業</th>
      </tr>
      <xsl:apply-templates/>
    </table>
  </xsl:template> 

  <xsl:template match="会員">
    <xsl:variable name="v.color">
      <xsl:if test="@会員番号=$p.number">red</xsl:if>
    </xsl:variable>
    <tr style="background-color: {$v.color};">
      <td>
        <xsl:value-of select="@会員番号"/>
      </td>
      <td>
        <xsl:value-of select="姓"/>
        <xsl:text> </xsl:text>
        <xsl:value-of select="名"/>
      </td>
      <td>
        <xsl:value-of select="性別"/>
      </td>
      <td>
        <xsl:value-of select="年齢"/>
      </td>
      <td>
        <xsl:value-of select="職業"/>
      </td>
    </tr>
  </xsl:template> 

</xsl:stylesheet>
<!--
../msxsl test_in.xml test.xsl -o test_out.xml
-->
