<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">

  <xsl:output method="xml" version="1.0" omit-xml-declaration="yes" encoding="UTF-8" />

  <xsl:template match="/">

    <div id="navigation" class="navigation">
      <div id="navigation_Header" class="navHeader">
        <input id="menu_label" readonly="readonly" type="text" value="" class="navMenu" />
        <input id="nav_hidden" type="hidden" />
      </div>
      <xsl:apply-templates select="/*/*/Result/Item[@type='Tree']" />
    </div>
  </xsl:template>

  <xsl:template match="Item[@type='Tree']">

    <div id="navigation_Panel" class="navPanel">
      <xsl:apply-templates select="root/Item[@type='Tree Node']" />
    </div>

    <div id="navigation_Seperator" class="navSeparator">
      <img class="sepImage" src="../images/Icons/16x16/separator.png" alt="" Title="" />
    </div>

    <div id="navigation_Select" class="navSelect">
      <xsl:attribute name="style">
        <xsl:text>height: </xsl:text>
        <xsl:value-of select="count(//root | //Item [classification='Tree Node/TocCategory'])*24.5" />
        <xsl:text>px;</xsl:text>
      </xsl:attribute>

      <xsl:apply-templates select="root"/>

      <div id="navigation_Footer" class="navBottom">
        <img src="../images/Icons/16x16/nav_link_end.png" alt="" Title="" />
      </div>
    </div>
  </xsl:template>

  <xsl:template match="root">
    <xsl:param name="level">0</xsl:param>

    <xsl:for-each select="Item[@type='Tree Node']">
      <a href="#" onClick="javascript: TocCategory(this.id)">
        <xsl:attribute name="id">
          <xsl:value-of select="name"/>
          <xsl:text>_category</xsl:text>
        </xsl:attribute>

        <img class="navImage">
          <xsl:attribute name="src">
            <xsl:text>../images/Icons/16x16/</xsl:text>
            <xsl:value-of select="name" />
            <xsl:text>.png</xsl:text>
          </xsl:attribute>
          <xsl:attribute name="alt">
            <xsl:text>images/</xsl:text>
            <xsl:value-of select="name" />
            <xsl:text>.png</xsl:text>
          </xsl:attribute>
          <xsl:attribute name="title">
            <xsl:value-of select="name"/>
          </xsl:attribute>
        </img>
        <xsl:text>  </xsl:text>
        <xsl:value-of select="label"/>
      </a>
    </xsl:for-each>
  </xsl:template>


  <xsl:template match="Item[@type='Tree Node'][classification='Tree Node/TocCategory']">
    <xsl:param name="level">0</xsl:param>

    <div style="display: none;">
      <xsl:attribute name="id">
        <xsl:text>div_</xsl:text>
        <xsl:value-of select="name"/>
      </xsl:attribute>
      <xsl:attribute name="name">
        <xsl:text>div_</xsl:text>
        <xsl:value-of select="label"/>
      </xsl:attribute>

      <xsl:apply-templates select="Relationships/Item[@type='Tree Node Child']/related_id/Item[@type='Tree Node']">
        <xsl:with-param name="level" select="$level+1"/>
      </xsl:apply-templates>
    </div>
  </xsl:template>

  <xsl:template match="Item[@type='Tree Node'][classification='Tree Node/ItemTypeInToc']">
    <xsl:param name="level">0</xsl:param>

    <a href="#" onClick="javascript: ItemTypeInToc(this.name)">
      <xsl:attribute name="id">
        <xsl:value-of select="itemtype_id"/>
      </xsl:attribute>
      <xsl:attribute name="name">
        <xsl:value-of select="name"/>
      </xsl:attribute>

      <img class="navImage">
        <xsl:attribute name="src">
          <xsl:value-of select="open_icon"/>
        </xsl:attribute>
        <xsl:attribute name="alt">
          <xsl:value-of select="close_icon"/>
        </xsl:attribute>
      </img>
      <xsl:text>    </xsl:text>
      <xsl:value-of select="label"/>

      <xsl:apply-templates select="Relationships/Item[@type='Tree Node Child']/related_id/Item[@type='Tree Node']">
        <xsl:with-param name="level" select="$level+1"/>
      </xsl:apply-templates>
    </a>
  </xsl:template>

  <xsl:template match="Item[@type='Tree Node'][classification='Tree Node/SavedSearchInToc']">
    <xsl:param name="level">0</xsl:param>
    <a>
      <xsl:attribute name="id">
        <xsl:value-of select="saved_search_id"/>
      </xsl:attribute>
      <xsl:attribute name="value">
        <xsl:value-of select="name"/>
      </xsl:attribute>
      <xsl:attribute name="Key">
        <userdata key="itName">
        </userdata>
      </xsl:attribute>




      <img class="navImage">
        <xsl:attribute name="src">
          <xsl:value-of select="open_icon"/>
        </xsl:attribute>
        <xsl:attribute name="alt">
          <xsl:value-of select="close_icon"/>
        </xsl:attribute>
        <xsl:value-of select="label"/>
      </img>

      <xsl:apply-templates select="Relationships/Item[@type='Tree Node Child']/related_id/Item[@type='Tree Node']">
        <xsl:with-param name="level" select="$level+1"/>
      </xsl:apply-templates>
    </a>
  </xsl:template>

</xsl:stylesheet>
