<%@ Page Language="C#" MasterPageFile="~/Masters/ChicagoRun.Master" AutoEventWireup="true" CodeBehind="Mile.aspx.cs" Inherits="ChicagoRun.WebUI.Pages.Mile" EnableViewState="false" %>
<%@ Register Src="~/Controls/ClassStudentSelectionList.ascx" TagName="UserList" TagPrefix="CR" %>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyContent" runat="server">


<div class="InformationalMsg" id="MessageDiv" runat="server" Visible="false" >
    <asp:Literal ID="Message" runat="server" />
</div>

<!--<div id="editExisting" class="button" style="font-size:16px">Edit Existing Mileage &#8594;</div>
   
<div class="page-title"><h2>New Entry</h2></div>
-->   
<div style="float:right;"><asp:Image ID="Indicator" runat="server"/></div>
<div style="float:left; width:400px;">
    <asp:Image ID="Icon1" runat="server"/>&nbsp;Select Class/Students
    <asp:Label runat="server" ID="UserName"></asp:Label>
    <asp:HiddenField runat="server" ID="UserId"></asp:HiddenField>
    <CR:UserList ID="UserList" runat="server" Height="360" />
</div>


        
<div style="float:right;width:510px;margin-left:10px">
    <table cellspacing="0" cellpadding="2">
        <tr><td colspan="3"><asp:Image ID="Icon2" runat="server"/>&nbsp;Select Activity/Unit</td><td>&nbsp;</td></tr>
        <tr>
            <td style="width:70px">&nbsp;</td><td><asp:DropDownList ID="ActivityDD" runat="server" Width="200"/></td>
            <td style="width:70px"><asp:Label runat="server" ID="ActivityName"></asp:Label></td><td style="width:110px"><asp:TextBox ID="UnitTB" runat="server" Width="70" MaxLength="10">0</asp:TextBox></td>
        </tr>
        
        <tr><td colspan="3"><asp:Image ID="Icon3" runat="server"/>&nbsp;Select Date</td><td>&nbsp;</td></tr>
        <tr><td valign="top">&nbsp;</td><td colspan="2" style="width:280px;"><span id="selectedDate"></span></td>
            <td valign="top"></td></tr>
        <tr><td colspan="4">
            <div id="enterDate" style="height:200px;"></div>
        </td></tr>
         </table>
         
         <table cellspacing="0" cellpadding="2">
           <tr>
               <td align="right" >
                   <asp:Image ID="Icon4" runat="server" />
               </td>
               <td align="right" valign="bottom">
                   <div id="addActivity" class="button large" style="width: 140px;">Add Activity</div>
               </td>
           </tr>        
       </table>
</div>
<div style="clear:both"></div>
<br />
<br />
<div id="ActivityEntries" style="display:none">
    <div class="InformationalMsg" id="clientMessageDiv"  style="visibility: hidden">
   <div id="clientMessage"> </div>

</div>
    <div id="header">
        <table class="contentHeader" cellpadding="0" cellspacing="0">
            <tr>
                <td style="width:55px">&nbsp;</td>
                <td style="width:150px">Student</td>
                <td style="width:90px">Class</td>
                <td style="width:250px">Activity</td>
                <td style="width:80px"># Unit</td>
                <td style="width:80px"># Mile</td>
                <td style="width:100px">Date</td>
            </tr>
        </table>
    </div>
    <div id="Entries" class="contentArea" style="height:250px;"></div>
    <div style="clear:both"></div>
    <div id="saveActivity" class="button large" style="width: 140px; float: right;margin:5px;">Save Activity</div>
    <div id="clearActivity" class="bluebutton" style="width: 140px;float: right;margin:5px;" >Clear Activity</div> 
    
    
</div>
<div style="clear:both"></div>
<input type="hidden" id="allActivities" name="allActivities" />
<script type="text/javascript" language="javascript">
//get id value of school if it's from the admin account for editing existing button
function editexistingMileage(){
    var schoolid=getQueryVariable("id");
    if(schoolid==false){
        window.location.href="milesearch.aspx"
    }
    else{
        window.location.href="milesearch.aspx?id="+schoolid;
    }
}


function getQueryVariable(variable){
       var query = window.location.search.substring(1);
       console.log(query);
       var vars = query.split("&");
       for (var i=0;i<vars.length;i++) {
               var pair = vars[i].split("=");
               if(pair[0] == variable){return pair[1];}
       }
       return(false);
}







    var _actrowcount = 0;
    var datemvl;
    function addActivity() {

        var groupid = "";
        var grouptext = "";
        if (jQuery.isFunction(window.CSList_GetSelectedValue)) {
            groupid = CSList_GetSelectedLeafValue();
            grouptext = CSList_GetSelectedLeafText();
        }
        else {
            groupid = $("#UserId").val();
            grouptext = $("#UserName").text();
        }
        var actvalue = $("#ActivityDD").val().split('|');
        var acttext = $("#ActivityDD option:selected").text();
        var unit = jQuery.trim($("#UnitTB").val());
        var date = datemvl.toString();
        var actid = actvalue[0];
        var uMile = actvalue[1];
        if (date == "") {
            alert("Please select a date for the activity!");
            return;
        }
        if (grouptext.length < 3) {
            alert("Please select a class and/or student!");
            return;
        }
        if (isNaN(unit)) {
            alert("Invalid # of unit!");
            return;
        }
        if (parseInt(unit) < 1) {
            alert("Invalid # of unit! Unit must be greater than 0.");
            return;
        }

        unit = parseFloat(unit).toFixed(1);
        uMile = parseFloat(uMile).toFixed(1);
        var gid = groupid.split('|');
        var tid = grouptext.split('|');
        var dates = date.split(',');
        for (var j = 0; j < dates.length; j++) {
            var sDate = jQuery.trim(dates[j]);
            for (var i = 0; i < gid.length; i++) {
                if (gid[i] !== "") {
                    input = gid[i] + "|" + actid;
                    var html = generateActRow(input, tid[i], acttext, unit, uMile, sDate);
                    $("#Entries").append(html);
                }
            }
        }
        
        $("#ActivityEntries").css({display:"block"});
        //window.location.hash="ActivityEntries";
        $("html, body").animate({ scrollTop: $('#ActivityEntries').offset().top }, 1000);
        setTimeout(function(){$("#clientMessage").html("Please don't forget to save the activity.");$("#clientMessageDiv").css({ visibility: "visible" });},500);

        
        $("#MessageDiv").hide();
        
        return;

    }
    function generateActRow(input, group, acttext, unit, uMile, date) {
        var rowid = "actrow" + _actrowcount;
        if (uMile === 0) {
            uMile = 1.00;
        }
        _actrowcount++;
        var name = group.split('!');
        var classname = name.length > 1 ? name[1] : "";

        var actRow = "<div id='" + rowid + "' class='activityEntry'><div style='float:left;width:40px;padding-left:5px;'><a href=\"javascript:deleteActRow('" +
            rowid + "')\"><img src='../images/delete.png' class='deleteChange'></a><input type='hidden' value='" +
                input + "'></div><div style='float:left;width:150px'>" + name[0] + "</div><div style='float:left;width:90px'>" + classname + "</div><div style='float:left;width:250px'>" +
                    acttext + "</div><div style='float:left;width:80px'><input type='text' style='width:50px' value='" + unit + "'></div><div style='float:left;width:80px'>" +
                        parseFloat(unit / uMile).toFixed(1) + "</div><div style='float:left;width:100px'><input type='text' style='width:80px' value='" + date + "'></div></div>";
        return actRow;
    }
    function deleteActRow(id) {
        $("#" + id).remove();
    }
    function clearActivities() {
        if (confirm("Are you sure you want to clear all activities?")) {
            $("#Entries").html('');
            
            $("#clientMessage").html("");
            $("#clientMessageDiv").css({ visibility: "hidden" });
            $("#ActivityEntries").css({display:"none"});
             
            window.location.hash="";
        }
    }
    function saveActivities() {
        var allacts = "";
        var bSubmit = true;
        $("#Entries .activityEntry").each(function () {
            $(this).css('background-color', 'none');
            var act = $(this).find(':hidden').first().val();
            var unit = $(this).find(':text').first().val();
            var date = $(this).find(':text').last().val();
            if (isNaN(unit) || !isValidDate(date)) {
                alert("Invalid unit number or date in activity item!");
                $(this).css('background-color', '#EEEEEE');
                bSubmit = false;
                return false;
            }
            allacts += act + "|" + unit + "|" + date + ";";
        });
        if (bSubmit) {
            $("#allActivities").val(allacts);
            $("#Entries").html("");
            $("#saveActivity").html('Saving...').unbind("click");
            document.forms[0].submit();
        }
    }
    $(document).ready(function () {
        var dv = $('#selectedDate').text();
        datemvl = new mvl('selectedDate', ',', dv);

        $("#enterDate").datepicker({ onSelect: function (dateText, inst) { datemvl.addValue(dateText); }, maxDate: "0", minDate: "-2m", numberOfMonths: 2 });
        $("#addActivity").click(addActivity);
        $("#saveActivity").click(saveActivities);
        $("#editExisting").click(editexistingMileage);
        $("#clearActivity").click(clearActivities);
        $("#ActivityDD").change(function () {
            var actvalue = $(this).val().split('|');
            if (actvalue.length >= 2) {
                $("#ActivityName").text("# of " + actvalue[2]);
            }
        });
    });
</script>
</asp:Content>
