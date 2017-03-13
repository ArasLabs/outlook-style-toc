<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">

    <xsl:output method="xml" version="1.0" omit-xml-declaration="yes" encoding="UTF-8" />

    <xsl:template match="/">
    <style type="text/css">
        /* COMMON */body, html
        {
            height: 100%;
            margin: 0px auto;
        }
        body
        {
            font-family: Tahoma, Arial, Helvetica, sans-serif;
            font-size: 11px;
            margin: 0px;
            text-align: left;
        }
        /* NAVIGATION */
        .navigation
        {
            border: solid 1px #2557ad; 
            float: left;
            width: 100%;
            height: 100%;
            vertical-align: bottom;
            background-color: #ffffff;
        }
        .navPanel
        {
            height: 300px;
            overflow-y: auto;
            overflow-x: hidden;
        }
        .navPanel a, .navPanel a:visited
        {
            width: 100%;
            padding: 5px 0px 5px 10px;
            display: block;
            color: #000000;
            border: solid 1px #ffffff;
            text-decoration: none;
        }
        .navPanel a:hover
        {
            background-color: #FFE88C;
            border: solid 1px #D69C00;
        }
	.navPanel a:active
	{
	    background-color: #FCEFDE;
	    border: solid 1px #D69C00;
	}
        .navSeparator
        {
            height: 6px;
            margin: 0px;
            padding-bottom: 3px;
            text-align: center;
            vertical-align: middle;
            filter: progid:DXImageTransform.Microsoft.Gradient(GradientType=0,StartColorStr='#CBE1FC',EndColorStr='#6a8ccb');
        }
        .navSelect
        {
            position: absolute;
            bottom: 0px;
            width: 100%;
            top: 350px;
        }
        .navSelect a
        {
            color: #000000;
            width: 100%;
            height: 24.5px;
            display: block;
            font-weight: bold;
            text-decoration: none;
            padding: 5px 5px 0px 5px;
            background-color: #FFFFFF;
            filter:progid:DXImageTransform.Microsoft.Gradient(GradientType=0,StartColorStr='#CBE1FC',EndColorStr='#7DA5E0');
        }
        .navSelect a:hover
        {
            background-color: #FFFFFF;
            border-bottom: solid 1px #B7B7B7;
            filter:progid:DXImageTransform.Microsoft.Gradient(GradientType=0,StartColorStr='#FFAD42',EndColorStr='#FFFFFF');
        }
        .navSelect a:active
        {
            background-color: #FFFFFF;
            border-bottom: solid 1px #B7B7B7;
            filter:progid:DXImageTransform.Microsoft.Gradient(GradientType=0,StartColorStr='#FFD695',EndColorStr='#FFAD42');
        }
        .navBottom
        {
            height: 24.5px;
            width: 100%;
            text-align: right;
            vertical-align: bottom;
            background-color: #FFFFFF;
            filter:progid:DXImageTransform.Microsoft.Gradient(GradientType=0,StartColorStr='#CBE1FC',EndColorStr='#7DA5E0');
        }
        .navBottom a
        {
            float: right;
            color: #000000;
            height: 24.5px;
            display: block;
            font-weight: bold;
            text-decoration: none;
            background-color: #FFFFFF;
            filter:progid:DXImageTransform.Microsoft.Gradient(GradientType=0,StartColorStr='#CBE1FC',EndColorStr='#7DA5E0');
        }
        .navBottom a:hover
        {
            background-color: #FFFFFF;
            filter:progid:DXImageTransform.Microsoft.Gradient(GradientType=0,StartColorStr='#FFAD42',EndColorStr='#FFFFFF');
        }        
        .navHeader
        {
            height: 22px;
            width: 100%;
            vertical-align: middle;
            padding: 1px 5px 0px 5px;
            background-color: #FFFFFF;
            filter:progid:DXImageTransform.Microsoft.Gradient(GradientType=0,StartColorStr='#CBE1FC',EndColorStr='#7DA5E0');
        }
        .navImage
        {
            vertical-align: middle;
            width: 16px;
            height: 16px;
            padding-top: 3px;
            padding-left: 10px;
            border: 0;
        }
        .sepImage
        {
            vertical-align: middle;
            height: 3px;
            padding-top: 3px;
            border: 0;
        }
        .navImageFooter
        {
            vertical-align: middle;
            width: 16px;
            height: 16px;
            padding: 3px 0px 3px 10px;
            border: 0;
        }
        .navMenu
        { 
            font-family: Tahoma, Arial, Helvetica, sans-serif; 
            width: 100%;        
            border: none; 
            font-size: 11px;
            font-weight: bold;
            text-align: center; 
            background: transparent;
        }
    </style>
        <div id="navigation" class="navigation">
            <div id="navigation_Header" class="navHeader">
                <input id="menu_label" type="text" value="" class="navMenu" />
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
                    <xsl:value-of select="name"/>_category
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
                <xsl:value-of select="label"/>
                <xsl:text>div_</xsl:text>
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
