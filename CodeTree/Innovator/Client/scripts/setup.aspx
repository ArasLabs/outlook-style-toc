<%@ Page CodePage="65001" Language="VB" Explicit="True" Strict="True" %>
<%@ Import Namespace="Aras.Client.Core" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<!-- (c) Copyright by Aras Corporation, 2004-2009. -->
<!-- #INCLUDE FILE="include/utils.aspx" -->
<html>
<head>
  <title></title>

  <script type="text/javascript" src="../javascript/include.aspx?classes=XmlUtils,CultureInfo,Solution,ResourceManager&files=AddConfigurationLink"></script>

</head>

<script type="text/javascript">

  var its = new Array();
  var rm = new ResourceManager(new Solution("core"), "ui_resources.xml");

  onbeforeunload = function onbeforeunload_handler()
  {
    var res = top.aras.dirtyItemsHandler();
    if (res == undefined || res.logout_confirmed)
    {
      //do nothing
    } else if (!res.logout_confirmed)
    {
      return rm.getString("setup.cancel_return");
    }

    res = false;
    top.aras.isFirstCall_of_openedWindowsHandler = true;

    while (!res)
    {
      res = top.aras.openedWindowsHandler("onbeforeunload");
      if (res && !res.logout_confirmed)
      {
        return rm.getString("setup.cancel_return");
      }
    }
  }

  onload = function onload_handler()
  {
    var userID = top.aras.getUserID();
    var userNd = top.aras.getLoggedUserItem(true);
    if (!userNd)
    {
      window.onbeforeunload = '';
      top.close();
      return false;
    }

    document.frames["statusbar"].location.replace("statusbar.html?xmlfile=statusbar.xml");
    document.frames["menu"].location.replace("mainMenu.aspx?UserType=" + top.aras.getUserType());
    document.frames["tree"].location.replace("mainTree.html");

    var currDir = top.aras.getItemProperty(userNd, 'working_directory');

    var setWD_res = false;
    try
    {
      setWD_res = top.aras.vault.setWorkingDir(currDir);
      if (currDir == '' || !setWD_res)
      {
        if (currDir) top.aras.AlertError(rm.getString("setup.invalid_working_dir_choose_another"));
        currDir = top.aras.vault.selectFolder();
        if (!currDir)
        {
          top.aras.AlertError(rm.getString("setup.specified_working_dir"));
        }
        else
        {
          top.aras.setItemProperty(userNd, 'working_directory', currDir);
          top.aras.setUserWorkingDirectory(userID, currDir);
          top.aras.vault.setWorkingDir(currDir);
        }
      }
    }
    catch (e)
    {
      if (e.message == "IO operation outside WriteableFolderPath in IE with turned on Protected mode.")
      {
        top.aras.AlertError(rm.getString("setup.turn_off_ie_protected_mode"));
      }
    }

  var F5 = 116;
  top.utils.HideKeyboardInput(F5, true, 0, window);
  var loadMetaDataProp = top.aras.getPreferenceItemProperty("Core_GlobalLayout", null, "core_load_favorite_metadata");
  if (loadMetaDataProp == "1")
  {
    top.aras.semaphore = top.utils.CreateBGSemaphore();
    top.aras.commonProperties.favoriteMetaData.populateFromPrefs( top.aras, its );
    preload_its();
  }
}

  function preload_its()
  {
    if (its.length > 0)
    {
      var next = its[0];
      var ltype = next.substring(0, 2);
      var lname = next.substring(3);
      var criteria = "name";
      if (lname.substring(0, 3) == "id=")
      {
        criteria = "id";
        lname = lname.substring(3);
      }

      var semaphore = (top.aras ? top.aras.semaphore : null);

      if (semaphore && semaphore.SetBGRequest(true))
      {
        try
        {
          if (ltype == "IT")
          {
            top.aras.getItemTypeForClient(lname, criteria, true);
          }
          else if (ltype == "RT")
          {
            var rid = lname;
            if (criteria == "name")
              rid = top.aras.getRelationshipTypeId(lname);
            top.aras.getRelationshipType(rid);

            // Relationship types currently are NOT loaded asynchronously,
            // so the flag has to be reset here instead of a callback function.
            SetBGRequest(false);
          }
          else if (ltype == "FR")
          {
            var alertError;
            if (criteria == "name")
              top.aras.getFormForDisplay(lname, "by-name", alertError, true);
            else
              top.aras.getFormForDisplay(lname, null, alertError, true);
          }
          else if (ltype == "LT")
          {
            top.aras.getListValues(lname, true);
          }
          else if (ltype == "FL")
          {
            top.aras.getListFilterValues(lname, true);
          }
        }
        catch (excep)
        {
          semaphore.SetBGRequest(false);
        }
        finally
        {
          its.shift();
        }
        setTimeout("preload_its()", 500);
      }
      else
      {
        setTimeout("preload_its()", 1000);
      }
    }
    else
    {
      // In case all meta-data is already preloaded, monitor the 
      // stack every few seconds as the stack could be populated
      // again (for example, in case client cache is cleared and
      // we would like to start preloading meta-data again)
      setTimeout("preload_its()", 10000);
    }
  }
</script>

<%
  Dim ICC As ClientConfig = ClientConfig.GetServerConfig()
  If String.IsNullOrEmpty(ICC.BannerUrl) Then
    Response.Write( _
      "<frameset rows='54,*,20' frameborder='no' framespacing='0' scrolling='no'>" + vbCrLf + _
      "<frameset rows='51,3' frameborder='no' framespacing='2' scrolling='no'>" + vbCrLf + _
        "<frame name='menu' src='..\scripts\blank.html' scrolling='no' />" & vbCrLf + _
        "<frame name='space' src='..\scripts\blank.html' scrolling='no' noresize />" & vbCrLf + _
      "</frameset>")
  Else
    Response.Write( _
      "<frameset rows='" + ICC.BannerHeight.ToString() + ",54,*,20' frameborder='no' framespacing='0' scrolling='no'>" + vbCrLf + _
        "<frame name='banner' src='" + ICC.BannerUrl + "' scrolling='no' noresize />" + _
      "<frameset rows='51,3' frameborder='no' framespacing='2' scrolling='no'>" + vbCrLf + _
        "<frame name='menu' src='..\scripts\blank.html' scrolling='no' noresize />" & vbCrLf + _
        "<frame name='space' src='..\scripts\blank.html' scrolling='no' noresize />" & vbCrLf + _
      "</frameset>")
  End If
%>
    <frameset cols="220,*" name="tree_work_layer" frameborder="no" framespacing="7">
      <frame name="tree" src="..\scripts\blank.html" scrolling="no" style="border: solid 1px #B7B7B7;" />
      <frame name="work" src="..\scripts\blank.html" scrolling="auto" style="border: solid 1px #B7B7B7;" />
    </frameset>
    <frame name="statusbar" src="..\scripts\blank.html" frameborder="no" scrolling="no" marginwidth="0" marginheight="0" noresize />
</frameset>
</html>
