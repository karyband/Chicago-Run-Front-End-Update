<%@ Page Language="C#" MasterPageFile="~/Masters/ChicagoRun.Master" AutoEventWireup="true" CodeBehind="Admin.aspx.cs" Inherits="ChicagoRun.WebUI.Pages.Admin" EnableViewState="false" %>
<%@ Import Namespace="ChicagoRun.WebUI.Helpers" %>
<%@ Register Src="~/Controls/ProgressBarSmall.ascx" TagName="Bar" TagPrefix="CR" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyContent" runat="server">
<div class="InformationalMsg" id="MessageDiv" runat="server" Visible="false">
    <asp:Literal ID="Message" runat="server" />
</div>

<div id="actionlinks">
    <asp:HyperLink ID="AddSchool" runat="server" CssClass="buttonAdmin">Add School</asp:HyperLink>
    &nbsp;&nbsp;    &nbsp;&nbsp;
    <asp:HyperLink ID="AddUser" runat="server" CssClass="buttonAdmin">User Maintenance</asp:HyperLink>
    &nbsp;&nbsp;    &nbsp;&nbsp;
    <asp:HyperLink ID="RouteMarker" runat="server" CssClass="buttonAdmin">Route Marker Maintenance</asp:HyperLink>
    &nbsp;&nbsp;    &nbsp;&nbsp;
    <asp:HyperLink ID="updateBulletin" runat="server" CssClass="buttonAdmin">Update Bulletin Board</asp:HyperLink>
    &nbsp;&nbsp;    &nbsp;&nbsp;
    <asp:HyperLink ID="SendGuardianMail" runat="server" CssClass="buttonAdmin">Send Guardian Mail</asp:HyperLink>
</div>

<div id="header">
    <table class="contentHeader" cellpadding="0" cellspacing="0">
        <tr>
            <td style="width:85px">&nbsp;</td>
            <td style="width:245px">School</td>
            <td style="width:75px"># Class</td>
            <td style="width:80px"># Student</td>
            <td style="width:100px">Goal</td>
            <td style="width:100px">Miles Run</td>
            <td style="width:100px">Last Update</td>
            <td style="width:120px">Percent of Goal</td>
        </tr>
    </table>
</div>
<div class="contentArea" style="height:300px">
    <asp:Repeater ID="School" runat="server" OnItemDataBound="School_DataBound">
        <HeaderTemplate>
            <table class="content" cellpadding="0" cellspacing="0">
        </HeaderTemplate>
        <ItemTemplate>
            <tr>
                <td style="width:80px;padding-left:5px;">
                    <asp:HyperLink ID="EditSchool" runat="server" />
                    <asp:Image ID="DeleteSchoolLink" runat="server" CssClass="deleteChange" />
                </td>
                <td style="width:250px"><asp:HyperLink ID="SchoolName" runat="server" /></td>
                <td style="width:80px"><asp:Literal ID="NumClass" runat="server" /></td>
                <td style="width:70px"><asp:Literal ID= "NumStudent" runat="server" /></td>
                <td style="width:100px"><asp:Literal ID="Goal" runat="server" /></td>
                <td style="width:100px"><asp:Literal ID="MilesRun" runat="server" /></td>
                <td style="width:100px"><asp:Literal ID="LastUpdate" runat="server" /></td>
                <td style="width:120px"><CR:Bar ID="Progress" runat="server" /></td>
            </tr>
        </ItemTemplate>
        <AlternatingItemTemplate>
            <tr class="contentAlternate">
                <td style="width:80px;padding-left:5px;">
                    <asp:HyperLink ID="EditSchool" runat="server" />
                    <asp:Image ID="DeleteSchoolLink" runat="server" CssClass="deleteChange" />
                </td>
                <td style="width:250px"><asp:HyperLink ID="SchoolName" runat="server" /></td>
                <td style="width:80px"><asp:Literal ID="NumClass" runat="server" /></td>
                <td style="width:70px"><asp:Literal ID="NumStudent" runat="server" /></td>
                <td style="width:100px"><asp:Literal ID="Goal" runat="server" /></td>
                <td style="width:100px"><asp:Literal ID="MilesRun" runat="server" /></td>
                <td style="width:100px"><asp:Literal ID="LastUpdate" runat="server" /></td>
                <td style="width:120px"><CR:Bar ID="Progress" runat="server" /></td>
            </tr>
        </AlternatingItemTemplate>
        <FooterTemplate>
            </table>
        </FooterTemplate>
    </asp:Repeater>
    
</div>


 <div id="bulletinDialog" class="modalForm">
   
    
    <div>
        <input onclick="uncheckbox(this,'student');" id="guardian" name="guardian" checked="checked" type="checkbox" style="width: 20px" /> 
           <label for="guardian" style="display: inline"> Guardian Bulletin </label>
    </div>
     <br />
    <div>
        <input onclick="uncheckbox(this,'guardian');" id="student" name="student"  type="checkbox" style="width: 20px"/>
           <label for="student" style="display: inline">Student Bulletin</label>
    </div>
     
    <br />
    <br />
 
   
	<div id="guardiandiv" style="display: none;"><textarea id="guardianbulletin" name="guardianbulletin" cols="20"  rows = "200" runat ="server" style="width: 240px; height: 400px; overflow: scroll"></textarea></div>
    
    <div id="studentdiv" style="display: block;"><textarea id="studentbulletin" name="studentbulletin" cols="20"  rows = "200" runat ="server" style="width: 240px; height: 400px; overflow: scroll" ></textarea></div>

    <div style="margin: 20px 0px 10px 20px">
        <div class="button" onclick="SaveDialog()">Save</div>
        <div class="button" onclick="CloseDialog()">Cancel</div>
        <div style="clear:both"></div>
    </div>
   
</div>

<asp:HiddenField ID="HiddenField1" runat="server" />
<input type="hidden" id="saveBulletin" name="saveBulletin" />
<input type="hidden" id="bulletinBoard" name="bulletinBoard" />

<script type="text/javascript" language="javascript">

    function uncheckbox(el, n) {

     if (el.checked == false)       
     {   el.checked = true;             
         return ; 
     }

     document.getElementById(n).checked=false;
          
     document.getElementById('studentdiv').style.display = 'none';
     document.getElementById('guardiandiv').style.display = 'none';     
     document.getElementById(n + 'div').style.display = 'block';
    }

    function DeleteSchool(name, url) {
        if (confirm("Are you sure you would like to delete " + name + "?\nAll users related to this school will be deleted.")) {
            document.location.href = url;
        }
        return false;
    }

    function CloseDialog() {
        $("#bulletinDialog").dialog("close");
    }

    function OpenBulletinDialog() {
        $("#bulletinDialog").dialog("open");
    }
    
     function SaveDialog() {       
        var value = escape($("#guardianbulletin").val()) + "^" + escape($("#studentbulletin").val());      
        $("#bulletinBoard").val(value);
        document.forms[0].submit();   
    }

    function SendRewardEmail() {
        $.ajax({
            url: '<%=UrlHelper.GetAbsoluteUrl("services/report.ashx?id=1") %>',
            cache: false,
            type: 'GET',
            timeout: 10000,
            async: true
        }).done(function (html) {
            // do nothing;
        });
    }

    $(document).ready(function () {
        $("#bulletinDialog").dialog({ title: "Update Bulletin Board", autoOpen: false, modal: true, width: 270, resizable: false });
        $("#updateBulletin").click(OpenBulletinDialog);
        <asp:Literal ID="CallSendEmail" runat="server" Visible="False" Text="SendRewardEmail();"/>
    });
</script>
</asp:Content>
