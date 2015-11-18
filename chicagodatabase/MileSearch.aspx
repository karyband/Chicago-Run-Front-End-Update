<%@ Page Language="C#" MasterPageFile="~/Masters/ChicagoRun.Master" AutoEventWireup="true" CodeBehind="MileSearch.aspx.cs" Inherits="ChicagoRun.WebUI.Pages.MileSearch" EnableViewState="false" %>
<%@ Register Src="~/Controls/ClassStudentSelectionList.ascx" TagName="UserList" TagPrefix="CR" %>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyContent" runat="server">
<div class="InformationalMsg" id="MessageDiv" runat="server" Visible="false">
    <asp:Literal ID="Message" runat="server" />
</div>
<div style="float:left; width:400px;">
    Class / Student:
    <CR:UserList ID="UserList" runat="server" Height="300" />
</div>
<div style="float:left;width:450px;margin-left:10px">
    <table cellspacing="5" cellpadding="5" style="width:100%">
        <tr>
            <td>Activity:</td><td><asp:DropDownList ID="ActivityDD" runat="server" Width="220"/></td>
        </tr>
        <tr><td valign="top">Start Date:</td><td><asp:TextBox ID="FromDate" runat="server" /></td></tr>
        <tr><td valign="top">End Date:</td><td><asp:TextBox ID="ToDate" runat="server" /></td></tr>
        <tr><td colspan="2"><div style="float:right;">
            <div id="searchActivity" class="button">Search Activity</div>
        </div></td></tr>
    </table>
</div>
<div style="clear:both"></div>
<div id="ActivityEntries" style="display:none">
    <div id="header">
        <table class="contentHeader" cellpadding="0" cellspacing="0">
            <tr>
                <td style="width:85px">&nbsp;</td>
                <td style="width:250px">Student</td>
                <td style="width:250px">Activity</td>
                <td style="width:80px"># Unit</td>
                <td style="width:80px"># Mile</td>
                <td style="width:100px">Date</td>
            </tr>
        </table>
    </div>
    <div id="Entries" class="contentArea" style="height:400px;">
    </div>
</div>
<div style="clear:both"></div>
<asp:HiddenField ID="SearchUrl" runat="server" />
<asp:HiddenField ID="EditUrl" runat="server" />
<div id="ActivityEntryEdit" class="modalForm">
	<div class="title">*All form fields are required.</div>
	<label for="Name">Student Name:</label>
	<b><span id="StudentName"></span></b>
	<label for="ActivityEditDD">Activity</label>
	<asp:DropDownList ID="ActivityEditDD" runat="server" Width="250"/>
	<label for="UnitNum"># of <span id="UnitName"></span></label>
	<input type="text" name="UnitNum" id="ActUnitNum" />
    <label for="Date">Date</label>
	<input type="text" name="Date" id="ActDate" />
    <div style="margin: 20px 0px 10px 40px">
        <div class="button" onclick="SaveDialog()">Save</div><div class="button" onclick="CloseDialog()">Cancel</div>
        <div style="clear:both"></div>
    </div>
    <input type="hidden" id="EntryId" value="0"/>
</div>
<script type="text/javascript" language="javascript">
    function MassEdit(){
       $(".editmult").css({"background-color": "red"});
        console.log("click");
    }





    var rowHtml = "";
    function EditActivityEntry(activityValue) {
        $("#ActivityEntryEdit input[type=text]").val('');
        $("#ActivityEntryEdit input[type=hidden]").val('');
        var value = activityValue.split('|');
        if (value.length >= 6) {
            $("#ActivityEntryEdit #EntryId").val(value[0]);
            $("#ActivityEntryEdit #StudentName").text(value[1]);
            var act = GetActivityValue(value[2]);
            $("#ActivityEntryEdit #ActivityEditDD").val(act);
            $("#ActivityEntryEdit #UnitName").text(value[3]);
            $("#ActivityEntryEdit #ActUnitNum").val(value[4]);
            $("#ActivityEntryEdit #ActDate").val(value[5]);
        }
        $("#ActivityEntryEdit").dialog("open");
    }
    function GetActivityValue(value) {
        var returnVal = "";
        $('#ActivityEntryEdit #ActivityEditDD option').each(function () {
            if ($(this).val().indexOf(value + '|') == 0) {
                returnVal = $(this).val();
            }
        });
        return returnVal;
    }
    function generateActRow(entryid, name, unit, actid, uname, acttext, date, mile) {
        var input = entryid + "|" + name + "|" + actid + "|" + uname + "|" + unit + "|" + date;

        var actRow = "<div style='float:left;width:75px;padding-left:5px;'><a href=\"javascript:EditActivityEntry('" + input + "');\" title='Edit'>" +
            "<img style='border-width:0px;width:16px' src='../images/edit.png' class='editChange'></a>&nbsp;<a href=\"javascript:deleteActRow('" + entryid + "');\" title='Delete'>" +
                "<img style='border-width:0px;width:16px' src='../images/delete.png' class='deleteChange'></a></div><div style='float:left;width:245px'>" +
                    name + "</div><div style='float:left;width:250px'>" + acttext +
                        "</div><div style='float:left;width:80px'>" + unit + "</div><div style='float:left;width:80px'>" + mile + "</div><div style='float:left;width:100px'>" + date + "</div>";
        return actRow;
    }
    function SaveDialog() {
        if (ValidateActivityEntry()) {
            var unit = parseFloat(jQuery.trim($("#ActivityEntryEdit #ActUnitNum").val()));
            var act = jQuery.trim($("#ActivityEntryEdit #ActivityEditDD").val()).split('|');
            var actid = act[0];
            var mile = unit / parseFloat(act[1]);
            var acttext = jQuery.trim($("#ActivityEntryEdit #ActivityEditDD option:selected").text());
            var uname = jQuery.trim($("#ActivityEntryEdit #UnitName").text());
            var name = jQuery.trim($("#ActivityEntryEdit #StudentName").text());
            var entryid = $("#ActivityEntryEdit #EntryId").val();
            var date = jQuery.trim($("#ActivityEntryEdit #ActDate").val());
            rowHtml = generateActRow(entryid, name, unit.toFixed(1), actid, uname, acttext, date, mile.toFixed(2));
            editActRow(entryid, actid, unit, date);
            $("#ActivityEntryEdit").dialog("close");
        }
    }
    function CloseDialog() {
        $("#ActivityEntryEdit").dialog("close");
    }
    function ValidateActivityEntry() {
        var unitName = $("#ActivityEntryEdit #UnitName").val();
        var unit = jQuery.trim($("#ActivityEntryEdit #ActUnitNum").val());
        if (isNaN(unit) || unit === "") {
            alert("Invalid # of " + unitName + "!");
            return false;
        }
        if (parseFloat(unit) <= 0) {
            alert("Invalid # of " + unitName + "! Value must be greater than 0.");
            return false;
        }
        var date = jQuery.trim($("#ActivityEntryEdit #ActDate").val());
        if (!isValidDate(date)) {
            alert("Invalid Date.");
            return false;
        }
        return true;
    }
    function deleteActRow(id) {
        if (confirm("Are you sure you would like to delete this entry?")) {
            var url = $("#EditUrl").val() + "?id=" + id;
            $.ajax({
                url: url,
                timeout: 10000
            }).done(function (data) {                
                if (data == id) {
                    alert("Activity entry has been deleted.");
                    $("#e" + id).remove();
                }
            });
        }
    }
    function editActRow(id, aid, unit, date) {
        var url = $("#EditUrl").val() + "?id=" + id + "&aid=" + aid + "&u=" + unit + "&d=" + date;
        $.ajax({
            url: url,
            timeout: 10000
        }).done(function (data) {
            if (data == id) {
                alert("Activity entry has been changed.");
                var actdivid = "e" + id;
                $("#Entries #" + actdivid).html(rowHtml);
                $("#Entries #" + actdivid).css("background-color", "#EEEEEE");
                rowHtml = "";
            }
        });
    }
    function searchActivity() {
        var groupid = CSList_GetSelectedValue();
        var actvalue = $("#ActivityDD").val();
        var fromdate = $("#FromDate").val();
        var todate = $("#ToDate").val();

        if (groupid.length < 3) {
            alert("Please select a class and/or student!");
            return;
        }
        if (!isValidDate(fromdate) || !isValidDate(todate)) {
            alert("Invalid start or end date.");
            return;
        }
        var aDate = Date.parse(fromdate);
        var bDate = Date.parse(todate);
        var today = new Date();
        if (aDate > today || bDate > today) {
            alert("Invalid start or end date.  Dates cannot be greater than today.");
            return;
        }
        if (bDate < aDate) {
            alert("End date must be greater than start date!");
            return;
        }
        var input = groupid + ";" + actvalue + ";" + fromdate + ";" + todate;
        var url = $("#SearchUrl").val() + input;
        $.ajax({
            url: url,
            timeout: 10000
        }).done(function (data) {
            $("#Entries").html(data);
            $("#ActivityEntries").show();
        });
    }
    $(document).ready(function () {
        $("#ActivityEntryEdit").dialog({ title: "Edit Activity Entry", autoOpen: false, modal: true, width: 300, resizable: false });
        $("#FromDate").datepicker({ maxDate: "0", minDate: "-1y", numberOfMonths: 2 });
        $("#ToDate").datepicker({ maxDate: "0", minDate: "-1y", numberOfMonths: 2 });
        $("#searchActivity").click(searchActivity);
    });
</script>
</asp:Content>
