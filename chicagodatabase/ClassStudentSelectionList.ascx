<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ClassStudentSelectionList.ascx.cs" Inherits="ChicagoRun.WebUI.Controls.ClassStudentSelectionList" EnableViewState="false" %>
<div class="contentArea" id="CLListContainer" runat="server">
    <div style="padding: 3px;">
    <asp:Repeater ID="ClassRepeater" runat="server" OnItemDataBound="Class_DataBound">
        <ItemTemplate>
            <div class="ClassCheckBox">
                <asp:CheckBox runat="server" ID="ClassCheck"></asp:CheckBox><div class="Open">+</div>
                <div class="StudentList">
                    <asp:Repeater ID="StudentRepeater" runat="server" OnItemDataBound="Student_DataBound">
                        <ItemTemplate>
                        <asp:CheckBox runat="server" ID="StudentCheck"></asp:CheckBox><br/>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>
        </ItemTemplate>
    </asp:Repeater>
    </div>
</div>
<script type="text/javascript" language="javascript">
    function CSList_GetSelectedValue() {
        var selectedvalue = "|";
        $("#CLListContainer input:checked").each(function () {
            var id = $(this).parent().attr("vid");
            if (selectedvalue.indexOf('|' + id + '|') < 0) {
                selectedvalue += id + "|";
            }
        });
        return selectedvalue;
    }
    function CSList_GetSelectedLeafValue() {
        var selectedvalue = "|";
        $("#CLListContainer input:checked").each(function () {
            var id = $(this).parent().attr("vid");  
            if (id.substr(0, 1) !== "C") {
                if (selectedvalue.indexOf('|' + id + '|') < 0) {
                    selectedvalue += id + "|";
                }
            }
        });
        return selectedvalue;
    }
    function CSList_GetSelectedLeafText() {
        var selectedvalue = "|";
        $("#CLListContainer input:checked").each(function () {
            var id = $(this).parent().attr("vid");
            if (id.substr(0, 1) !== "C") {
                var label = $(this).siblings("label").text();
                var classname = $(this).parent().attr("cn");
                if (selectedvalue.indexOf('|' + label + '!' + classname + '|') < 0) {
                    selectedvalue += label + '!' + classname + '|';
                }
            }
        });
        return selectedvalue;
    }
    function CSList_GetSelectedText() {
        var selectedvalue = "|";
        $("#CLListContainer input:checked").each(function () {
            var label = $(this).siblings("label").text();
            if (selectedvalue.indexOf('|' + label + '|') < 0) {
                selectedvalue += label + "|";
            }
        });
        return selectedvalue;
    }
    $(document).ready(function () {
        $("#CLListContainer .ClassCheckBox .Open").click(function () {
            var studentlist = $(this).parent().find(".StudentList");
            if (studentlist.css("display") == "none") {
                $(this).html("-");
                studentlist.show('fast');
            }
            else {
                $(this).html("+");
                studentlist.hide();
            }
        });
        $("#CLListContainer .ClassCheckBox :checkbox").change(function () {
            var id = $(this).parent().attr('vid');
            if (id.substr(0, 1) === "C") {
                var studentlist = $(this).parent().parent().find(".StudentList");
                $(this).parent().siblings(".Open").text("-");
                if (studentlist.css('display') == 'none') {
                    studentlist.show('fast');
                }
                if ($(this).is(':checked')) {
                    studentlist.find(":checkbox").prop("checked", true);
                } else {
                    studentlist.find(":checkbox").prop("checked", false);
                }
            }
            else {
                if (!$(this).is(':checked')) {
                    var classCK = $(this).parent().parent().siblings("span").find(":checkbox");
                    if (classCK) {
                        classCK.prop("checked", false);
                    }
                }
            }
        });
    });
</script>