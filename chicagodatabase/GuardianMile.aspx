<%@ Page Language="C#" MasterPageFile="~/Masters/ChicagoRun.Master" AutoEventWireup="true" CodeBehind="GuardianMile.aspx.cs" Inherits="ChicagoRun.WebUI.Pages.GuardianMile" %>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyContent" runat="server">


<div class="InformationalMsg" id="MessageDiv" runat="server" Visible="false" >
    <asp:Literal ID="Message" runat="server" />
</div>
 
<div style="float:right;"><asp:Image ID="Indicator" runat="server"/></div>
<div style="float:left; width:400px;">
    <asp:HiddenField runat="server" ID="UserName"></asp:HiddenField>
    <asp:HiddenField runat="server" ID="UserId"></asp:HiddenField>
    <asp:Image ID="Icon1" runat="server"/>&nbsp;Choose the speed that best describes your physical activity:
    <div class="contentArea" style="height:350px;padding:0.5em;">
        <ul class="activityList">
            <li>Leisurely Walk -<span>A slower, more relaxed walking speed.  For example – going for a walk with a friend in a park and enjoying the scenery.</span></li> 
            <li>Steady Walk -<span>An average, more typical walking speed.  For example – walking to school or to the grocery store.</span></li>
            <li>Power Walk -<span>A faster, more active walking speed.  For example – faster than your average walk, like when hurrying to the bus stop!</span></li>
            <li>Interval Walk/Jog -<span>When you alternate doing 30 seconds of power walking, and then 30 seconds of jogging.  This is great for keeping your heart rate high throughout the whole workout.</span></li>
            <li>Light Jog -<span>A steady, gentle running speed.  For example – moving at a very relaxed speed where you could easily have a conversation.</span></li>
            <li>Medium Jog -<span>A steady, comfortable running speed.  For example – moving at a pace where deeper breaths are needed.</span></li>
            <li>Run (11 minute pace) -<span>Using a watch, time yourself running one mile to determine what your running pace is.</span></li>
            <li>Run (10 minute pace) -<span>Using a watch, time yourself running one mile to determine what your running pace is.</span></li>
            <li>Run (9 minute pace) -<span>Using a watch, time yourself running one mile to determine what your running pace is.</span></li>
            <li>Run (8 minute pace) -<span>Using a watch, time yourself running one mile to determine what your running pace is.</span></li>
            <li>Run (7 minute pace) -<span>Using a watch, time yourself running one mile to determine what your running pace is.</span></li>
        </ul>
    </div>
</div>
<div style="float:right;width:510px;margin-left:10px">
    <table cellspacing="0" cellpadding="2">
        <tr><td colspan="3"><asp:Image ID="Icon2" runat="server"/>&nbsp;Select Activity Speed</td><td>&nbsp;</td></tr>
        <tr>
            <td style="width:70px">&nbsp;</td><td><asp:DropDownList ID="ActivityDD" runat="server" Width="200"/></td>
            <td style="width:70px"><asp:Label runat="server" ID="ActivityName"></asp:Label></td><td style="width:110px"><asp:TextBox ID="UnitTB" runat="server" Width="70" MaxLength="10">0</asp:TextBox></td>
        </tr>
        
        <tr><td colspan="3"><asp:Image ID="Icon3" runat="server"/>&nbsp;Select Date(s)</td><td>&nbsp;</td></tr>
        <tr><td valign="top">&nbsp;</td><td colspan="2" style="width:280px;"><span id="selectedDate"></span></td>
            <td valign="top"></td></tr>
        <tr><td colspan="4">
            <div id="enterDate" style="height:200px;"></div>
        </td></tr>
         </table>
         
         <table cellspacing="0" cellpadding="2">
           <tr>
                <td align="left">
                  <asp:Image ID="Icon4" runat="server" />
               </td>
               <td align="left" valign="bottom">
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
                <td style="width:150px">Guardian</td>
                <td style="width:300px">Activity Speed</td>
                <td style="width:100px">Minutes</td>
                <td style="width:80px">Miles</td>
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
    var _actrowcount = 0;
    var datemvl;
    function addActivity() {

        var groupid = "";
        var grouptext = "";
        groupid = $("#UserId").val();
        grouptext = $("#UserName").val();
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
                input + "'></div><div style='float:left;width:150px'>" + name[0] + "</div><div style='float:left;width:300px'>" +
                    acttext + "</div><div style='float:left;width:100px'><input type='text' style='width:50px' value='" + unit + "'></div><div style='float:left;width:80px'>" +
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
            document.forms[0].submit();
        }
    }
    $(document).ready(function () {
        var dv = $('#selectedDate').text();
        datemvl = new mvl('selectedDate', ',', dv);

        $("#enterDate").datepicker({ onSelect: function (dateText, inst) { datemvl.addValue(dateText); }, maxDate: "0", minDate: "-2m", numberOfMonths: 2 });
        $("#addActivity").click(addActivity);
        $("#saveActivity").click(saveActivities);
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
