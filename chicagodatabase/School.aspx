<%@ Page Language="C#" MasterPageFile="~/Masters/ChicagoRun.Master" AutoEventWireup="true" CodeBehind="School.aspx.cs" Inherits="ChicagoRun.WebUI.Pages.SchoolAdmin" EnableViewState="false" %>
<%@ Register TagPrefix="CR" TagName="Bar" Src="~/Controls/ProgressBarSmall.ascx" %>
<%@ Register TagPrefix="CR" TagName="RouteOrder" Src="~/Controls/RouteOrder.ascx" %>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyContent" runat="server">
<div class="InformationalMsg" id="MessageDiv" runat="server" Visible="false">
    All Changes have been saved!
</div>
<div class="WarningMsg" style="display: none;">
    Changes to activity types will not be saved until you've pressed the "Save School" button.
</div>
<div id="SchoolMain" style="float:left;width:400px;margin-right:20px">
    <table cellspacing="5" cellpadding="5">
        <tr><td>School&nbsp;Name</td><td colspan="4"><asp:TextBox ID="Name" runat="server" Width="285" MaxLength="150" /></td></tr>
        <tr><td>Address</td><td colspan="4"><asp:TextBox ID="Address1" runat="server" Width="285" MaxLength="150" /></td></tr>
        <tr><td></td><td colspan="4"><asp:TextBox ID="Address2" runat="server" Width="285" MaxLength="150" /></td></tr>
        <tr><td>City</td><td><asp:TextBox ID="City" runat="server" Width="105" MaxLength="100" /></td><td>IL</td><td>Zip&nbsp;Code</td><td><asp:TextBox ID="Zip" runat="server" Width="70" MaxLength="10" /></td></tr>
        <tr><td>Incentive&nbsp;Package</td><td colspan="4"><asp:DropDownList ID="RewardPackage" runat="server" Width="292"/></td></tr>
        <tr><td>Latitude</td><td><asp:TextBox ID="Latitude" runat="server" Width="105" MaxLength="50" /></td><td colspan="2">Longtitude</td><td><asp:TextBox ID="Longtitude" runat="server" Width="70" MaxLength="50" /></td></tr>
    </table>
</div>
<div style="float:right; width:500px">
    <div class="header">
        <div class="title" style="float:left;">Activity Type</div><div id="addItem" class="button" style="float:right">Add Activity Type</div>
        <div style="clear:both;"></div>
        <table class="contentHeader" cellpadding="0" cellspacing="0">
            <tr>
                <td style="width:60px">&nbsp;</td>
                <td style="width:130px">Name</td>
                <td style="width:150px">Description</td>
                <td style="width:70px">Unit&nbsp;Name</td>
                <td style="width:80px;text-align:center">Unit/Mile</td>
            </tr>
        </table>
    </div>
    <div id="ActivityHolder" class="contentArea" style="height:200px;">
        <asp:Repeater ID="ActivityRep" runat="server" OnItemDataBound="ActivityRep_DataBound">
           <ItemTemplate>
              <asp:Literal ID="DivOpenTag" runat="server" />
                <div style="width:50px;">
                    <asp:HyperLink ID="EditActivity" runat="server" />
                    <asp:HyperLink ID="DeleteActivity" runat="server" />
                    <asp:HiddenField ID="ActValue" runat="server" />
                </div>
                <div style="width:125px"><asp:Literal ID="ActName" runat="server" /></div>
                <div style="width:145px"><asp:Literal ID="Description" runat="server" /></div>
                <div style="width:70px;text-align:center"><asp:Literal ID="UnitName" runat="server" /></div>
                <div style="width:65px;text-align:center"><asp:Literal ID="UnitMile" runat="server" /></div>
              </div>
           </ItemTemplate>
        </asp:Repeater>
    </div>
</div>
<div style="clear:both"></div>
<CR:RouteOrder ID="RouteOrder" runat="server"/>
<div class="header" style="margin-top: 15px">
    <div class="title">School Adminstrators</div>
</div>
<div id="SchoolAdmin" class="contentArea" style="height:40px;padding:5px 3px">
    <asp:Repeater runat="server" ID="AdminRep" OnItemDataBound="AdminRep_DataBound">
        <ItemTemplate>
            <asp:CheckBox runat="server" ID="IsAdmin"/><asp:Literal runat="server" ID="AdminName"></asp:Literal>
        </ItemTemplate>
    </asp:Repeater>
    <asp:HiddenField runat="server" ID="SchoolAdminID"/>
</div>
<div id="saveSchool" class="button" style="margin: 20px 0px 0px 0px;width:120px;float:right;">Save School</div>
<div style="clear:both; height:10px;"></div>
<asp:Panel ID="ClassPanel" runat="server" Visible="false">
<div id="actionlinks">
    <asp:HyperLink ID="EnterMile" runat="server" ImageUrl="../Images/update_milage.png" hover="../Images/update_milage_rollover.png" >   </asp:HyperLink>
    &nbsp;&nbsp;
   <!-- <asp:HyperLink ID="MileSearch" runat="server" ImageUrl="../Images/edit_mile.png" hover="../Images/edit_mile_rollover.png"> </asp:HyperLink>-->

    <asp:HyperLink ID="AddClass" runat="server"  ImageUrl="../Images/add_class.png" hover="../Images/add_class_rollover.png"></asp:HyperLink>
</div>
<div class="header">
    <table class="contentHeader" cellpadding="0" cellspacing="0">
        <tr>
            <td style="width:50px">&nbsp;</td>
            <td style="width:180px">Class</td>
            <td style="width:100px"># Student</td>
            <td style="width:150px">Goal</td>
            <td style="width:150px">Miles Run</td>
            <td style="width:150px">Last Update</td>           
            <td style="width:140px">Percent of Goal</td>
        </tr>
    </table>
</div>
<div class="contentArea" style="height:200px">
    <asp:Repeater ID="ClassRep" runat="server" OnItemDataBound="ClassRep_DataBound">
       <HeaderTemplate>
          <table class="content" cellpadding="0" cellspacing="0">
       </HeaderTemplate>
       <ItemTemplate>
            <tr> 
                <td style="width:5px">&nbsp;</td>   
                <td style="width:45px">                    
                    <asp:Image ID="DeleteClassLink" runat="server" CssClass="deleteChange" />
               </td>
                <td style="width:180px"><asp:HyperLink ID="ClassName" runat="server" /></td>
                <td style="width:100px"><asp:Literal ID="NumStudent" runat="server" /></td>
                <td style="width:150px"><asp:Literal ID="Goal" runat="server" /></td>
                <td style="width:150px"><asp:Literal ID="MilesRun" runat="server" /></td>
                <td style="width:150px"><asp:Literal ID="LastUpdate" runat="server" /></td>
                <td style="width:140px"><CR:Bar ID="Progress" runat="server" /></td>
            </tr>
       </ItemTemplate>
       <AlternatingItemTemplate>
           <tr class="contentAlternate"> 
                <td style="width:5px">&nbsp;</td>   
                <td style="width:45px">                    
                    <asp:Image ID="DeleteClassLink" runat="server" CssClass="deleteChange" />
               </td>
                <td style="width:180px"><asp:HyperLink ID="ClassName" runat="server" /></td>
                <td style="width:100px"><asp:Literal ID="NumStudent" runat="server" /></td>
                <td style="width:150px"><asp:Literal ID="Goal" runat="server" /></td>
                <td style="width:150px"><asp:Literal ID="MilesRun" runat="server" /></td>
                <td style="width:150px"><asp:Literal ID="LastUpdate" runat="server" /></td>
                <td style="width:140px"><CR:Bar ID="Progress" runat="server" /></td>
             </tr>
       </AlternatingItemTemplate>
       <FooterTemplate>
          </table>
       </FooterTemplate>
    </asp:Repeater> 
</div>
</asp:Panel>
<div style="clear:both"></div>
<input type="hidden" id="AllActivityValue" runat="server"/>
<input type="hidden" id="DoSaveSchool" runat="server" value="0"/>
<div id="ActivityType" class="modalForm">
	<div class="title">*All form fields are required.</div>
	<label for="Name">Name</label>
	<input type="text" name="Name" id="ActName" />
	<label for="Description">Description</label>
	<input type="text" name="Description" id="ActDescription" />
	<label for="UnitToMile"># of Units to a Mile</label>
	<input type="text" name="UnitToMile" id="ActUnitToMile" />
    <label for="UnitName">Unit Name</label>
	<input type="text" name="UnitName" id="ActUnitName" />
    <div style="margin: 20px 0px 10px 40px">
        <div class="button" onclick="SaveDialog()">Add</div><div class="button" onclick="CloseDialog()">Cancel</div>
        <div style="clear:both"></div>
    </div>
    <input type="hidden" id="ActId" value="0"/>
    <input type="hidden" id="ActDivId" value=""/>
</div>
<script type="text/javascript" language="javascript">
    var _actcount = <asp:Literal ID="ActCount" runat="server" />;
    function SaveSchool() {
        if (ValidateSchool()) {
            WriteAllActivities();
            $('#DoSaveSchool').val("1");
            document.forms[0].submit();
        }
    }
    function ValidateSchool() {
        var name = jQuery.trim($("#SchoolMain #Name").val());
        if (name === "") {
            alert("School Name is required.");
            return false;
        }
        var lat = jQuery.trim($("#SchoolMain #Latitude").val());
        if (isNaN(lat) && lat !== "") {
            alert("Invalid school latitude!");
            return false;
        }
        var ilong = jQuery.trim($("#SchoolMain #Longtitude").val());
        if (isNaN(ilong) && ilong !== "") {
            alert("Invalid school longtitude!");
            return false;
        }
        var zip = jQuery.trim($("#SchoolMain #Zip").val());
        if (isNaN(zip) || zip === "") {
            alert("Invalid zip!");
            return false;
        }
        return true;
    }
    function ValidateActivityType() {
        var name = jQuery.trim($("#ActivityType #ActName").val());
        if (name === "") {
            alert("Name is required.");
            return false;
        }
        var description = jQuery.trim($("#ActivityType #ActDescription").val());
        if (description === "") {
            alert("Description is required.");
            return false;
        }
        var unit = jQuery.trim($("#ActivityType #ActUnitToMile").val());
        if (isNaN(unit) || unit === "") {
            alert("Invalid # of unit!");
            return false;
        }
        if (parseInt(unit) <= 0) {
            alert("Invalid # of unit! Unit must be greater than 0.");
            return false;
        }
        var unitname = jQuery.trim($("#ActivityType #ActUnitName").val());
        if (unitname === "") {
            alert("Unit Name is required.");
            return false;
        }
        return true;
    }
    function WriteAllActivities() {
        var allActivities = "";
        $("#ActivityHolder .contentDiv input[type=hidden]").each(function() {
            allActivities += $(this).val() + ";";
        });
        $("#AllActivityValue").val(allActivities);
        var adminId = "";
        $("#SchoolAdmin :checked").each(function() {
            adminId += $(this).parent().attr('userid') + "|";
        });
        $("#SchoolAdminID").val(adminId);
    }
    function generateActRow(name, desc, unit, actid, rowid, uname) {
        var actRow = "";
        if (rowid == "") {
            rowid = "ActDiv" + _actcount;
            _actcount++;
        }
        if (actid == "") {
            actid = "0";
            actRow = "<div class='contentDiv' id='" + rowid + "'>";
        }
        var input = actid + "|" + name + "|" + desc + "|" + unit + "|" + rowid + "|" + uname;
        var deleteInput = rowid + "|" + name;

        actRow += "<div style='width:50px;'><a href=\"javascript:EditActivity('" + input + 
            "')\" title='Edit'><img style='border-width:0px;width:16px' src='../images/edit.png' class='editChange'></a>&nbsp;<a href=\"javascript:DeleteActivity('" + deleteInput +
            "')\" title='Delete'><img style='border-width:0px;width:16px' src='../images/delete.png' class='deleteChange'></a><input type='hidden' value='" + input + "'></div>" +
            "&nbsp;<div style='width:125px'>" + name + "</div>&nbsp;<div style='width:145px'>" + desc + "</div>&nbsp;<div style='width:70px;text-align:center'>" +
            uname +"</div>&nbsp;<div style='width:65px;text-align:center'>" + unit +"</div>";
        if (actid == "0") {
            actRow += "</div>";
        }
        return actRow;
    }
    function SaveDialog() {
        if (ValidateActivityType()) {
            var name = jQuery.trim($("#ActivityType #ActName").val());
            var desc = jQuery.trim($("#ActivityType #ActDescription").val());
            var unit = parseFloat(jQuery.trim($("#ActivityType #ActUnitToMile").val())).toFixed(1); 
            
            var actid = jQuery.trim($("#ActivityType #ActId").val());
            var actdivid = jQuery.trim($("#ActivityType #ActDivId").val());
            var uname = jQuery.trim($("#ActivityType #ActUnitName").val());
            var rowhtml = generateActRow(name, desc, unit, actid, actdivid, uname);
            if (actdivid != "") {
                $("#ActivityHolder #" + actdivid).html(rowhtml);
            } 
            else {
                $("#ActivityHolder").append(rowhtml);
            }
            $("#ActivityType").dialog("close");
            $(".WarningMsg").show("fast");
            $(".InformationalMsg").hide();
        }
    }
    function CloseDialog() {
        $("#ActivityType").dialog("close");
    }
    function EditActivity(activityValue) {
        $("#ActivityType input[type=text]").val('');
        $("#ActivityType input[type=hidden]").val('');
        var value = activityValue.split('|');
        if (value.length >= 5) {
            $("#ActivityType #ActId").val(value[0]);
            $("#ActivityType #ActName").val(value[1]);
            $("#ActivityType #ActDescription").val(value[2]);
            $("#ActivityType #ActUnitToMile").val(value[3]); 
            $("#ActivityType #ActDivId").val(value[4]); 
            $("#ActivityType #ActUnitName").val(value[5]);
        }
        $("#ActivityType").dialog("open");
    }
    function DeleteActivity(activityValue) {
        var value = activityValue.split('|');
        if (value.length >= 2) {
            if (confirm('Are you sure you would like to delete activity type \"' + value[1] + '\"?\nAll activities with this type will be deleted!')) {
                $("#ActivityHolder #" + value[0]).remove();
            }
        }
    }
    function OpenDialog() {
        $("#ActivityType input[type=text]").val('');
        $("#ActivityType input[type=hidden]").val('');
        $("#ActivityType").dialog("open");
    }
    $(document).ready(function () {
        $("#ActivityType").dialog({ title: "Create/Edit Activity type", autoOpen: false, modal: true, width: 300, resizable: false });
        $("#addItem").click(OpenDialog);
        $("#saveSchool").click(SaveSchool);
    });

    function DeleteClass(name, url) {
        if (confirm("Are you sure you would like to delete " + name + "?\nAll users related to this Class will be deleted.")) {
            document.location.href = url;
        }
        return false;
    }

</script>
</asp:Content>