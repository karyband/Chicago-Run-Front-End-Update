<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ChicagoRun.Master" AutoEventWireup="true" CodeBehind="Class.aspx.cs" Inherits="ChicagoRun.WebUI.Pages.Class" %>
<%@ Import Namespace="ChicagoRun.WebUI.Helpers" %>
<%@ Register Src="~/Controls/ProgressBarSmall.ascx" TagName="Bar" TagPrefix="CR" %>
<%@ Register TagPrefix="CR" TagName="Map" Src="~/Controls/GoogleMap.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyContent" runat="server">
<asp:Panel runat="server" ID="ClassMapDiv" Visible="False">
<script type="text/javascript" language="javascript">
    $(document).ready(function () {
        $('#ShowMap').click(function () {
            if ($('.tabPanel #map').length == 0) {
                window.top.location = '<%=ClassLinkWithMap %>';
            }
            else {
                if ($('#ClassMap').css('display') == 'none') {
                    $('#ClassMap').show('fast');
                    $(this).html("Close Class Map");
                } else {
                    $('.sideInfo .itemPopup').hide();
                    $('#ClassMap').hide();
                    $(this).html("Show Class Map");
                }
            }
        });
    });
    function infoPopup(content) {
        $(".sideInfo .itemPopup").hide();
        $(".sideInfo .itemPopup .popupContent").html(content);
        var height = 0;
        $(".sideInfo .itemPopup").slideUp('fast', function () {
            height = $(".sideInfo .itemPopup").height();
            var gap = (height < 500) ? 500 - height : 0;
            $(".sideInfo .itemPopup").css("margin-top", gap + "px");
            $(".sideInfo .itemPopup").slideDown('slow');
        });
    }
</script>
<div id="ShowMap" class="button" style="float:right;margin-top:-40px;" runat="server">Show Class Map</div>
<div id="ClassMap" style="display:none" runat="server">
    <div class="userContent">
        <div class="mainInfo">
            <div class="tabs">
                <div class="routeArrow"><asp:HyperLink runat="server" ID="PreviousRoute" Visible="False"></asp:HyperLink></div> 
		        <div class="tab" tab="1" style="margin-top: 0px; width: 90px;"><img src="../images/route.png" out="../images/route.png" hover="../images/route_hover.png" class="hoverChange" onclick="showRouteMarker();$('.sideInfo .itemPopup').hide();"/></div>
                <div class="tab" tab="1"><img src="../images/landmark.png" out="../images/landmark.png" hover="../images/landmark_hover.png" class="hoverChange" onclick="showLandmarkMarker();$('.sideInfo .itemPopup').hide();"/></div>
                <div class="tab" tab="1"><img src="../images/nutrition.png" out="../images/nutrition.png" hover="../images/nutrition_hover.png" class="hoverChange" onclick="showFactMarker();$('.sideInfo .itemPopup').hide();"/></div>
                <div class="tab" tab="1"><img src="../images/awards.png" out="../images/awards.png" hover="../images/awards_hover.png" class="hoverChange" onclick="showAwards();$('.sideInfo .itemPopup').hide();"/></div>
                <div class="routeArrow"><asp:HyperLink runat="server" ID="NextRoute" Visible="False"></asp:HyperLink></div>
            </div>
            <div style="clear:both"></div>
            <div class="tabPanels">
                <div class="tabPanel" id="tabPanel1">
                    <CR:Map ID="RouteMap" runat="server" Visible="false"/>
                </div>
            </div>
        </div>
        <div class="sideInfo">
            <div class="awardInfo">
                <div class="title">Unlocked Awards</div>
                <div class="awardItem">
                <asp:Repeater ID="AwardRep" runat="server" OnItemDataBound="AwardRep_DataBound">
                    <ItemTemplate>
                        <div><asp:Image runat="server" ID="AwardItem"/></div>
                    </ItemTemplate>
                </asp:Repeater>
                </div>
            </div>
            <div style="clear:both; height:10px;"></div>
            <div class="itemPopup" style="display:none">
                <div class="popupTop"></div>
                <div class="popupContent"></div>
                <div class="popupBottom"></div>
            </div>
        </div>
    </div>
    <div style="clear:both"></div>
</div>
</asp:Panel>
<div class="InformationalMsg" id="MessageDiv" runat="server" Visible="false">
    <asp:Literal ID="Message" runat="server" />
</div>
<div style="float:left;width:920px;">
    <table>
        <tr>
            <td  align="left" style="font-weight: bold; font-size: 14px; width: 120px;" >School Year:</td>
            <td  style="width: 170px"> <asp:Literal ID="litSchoolYear"  runat="server" /></td>
            <td align="left"  style="font-weight: bold; font-size: 14px; width: 130px;" >Grade Level:</td>
            <td> <asp:DropDownList ID="dropdownGradeLevel" runat="server" Width="230px" AutoPostBack="false"
                             onchange="ShowClassDesc()">
                   <asp:ListItem Value="13" >Pre-K</asp:ListItem>
                   <asp:ListItem Value="14" >Kindergarten</asp:ListItem>                        
                   <asp:ListItem Value="1" >1st</asp:ListItem>
                   <asp:ListItem Value="2">2nd</asp:ListItem>
                   <asp:ListItem Value="3">3rd </asp:ListItem>
                   <asp:ListItem Value="4">4th</asp:ListItem>
                   <asp:ListItem Value="5">5th</asp:ListItem>
                   <asp:ListItem Value="6">6th</asp:ListItem>
                   <asp:ListItem Value="7">7th</asp:ListItem>
                   <asp:ListItem Value="8">8th</asp:ListItem>
                   <asp:ListItem Value="9">9th</asp:ListItem>
                   <asp:ListItem Value="10">10th</asp:ListItem>
                   <asp:ListItem Value="11">11th</asp:ListItem>
                   <asp:ListItem Value="12">12th</asp:ListItem>      
                   <asp:ListItem Value="15">Multi-Grade</asp:ListItem>   
                   <asp:ListItem Value="16">Other</asp:ListItem>                                              
                </asp:DropDownList>
               
            </td>
          
           
            <td style="width: 60px">
              <div class="button" id="saveClass" runat="server">Save</div>
                
            </td>
           
       </tr>
       <tr style="height: 35px"  >
        <td align="left" style="font-weight: bold; font-size: 14px; width: 120px;">Teacher:
        </td>
            <td style="width: 170px"  > 
             <%-- <asp:Literal ID="litTeacher" runat="server" /> --%>
                 <asp:DropDownList ID="newClassTeacherDropDown"  Width = "150px" runat="server" AutoPostBack="false">
                 </asp:DropDownList>
            </td>
             <td >
              <div id="ClassLabel" runat = "server" style="font-weight: bold; font-size: 14px; width: 130px; display: none" >
                  Class Name:
               </div>
            </td>
              <td > 
             
               <div id="ClassInfo"  runat="server" style="display: none" >
                  <asp:TextBox ID="ClassDesc" name="ClassDesc" runat="server" Width = "225px"></asp:TextBox>
              </div>
             
            </td>
            <td style="width: 60px">
            &nbsp;</td>
            
       </tr>
       <tr style="height: 25px" >
          <td>
             <asp:HyperLink ID="AddUser" runat="server" Visible="false">User Maintenance</asp:HyperLink>
          </td>
       </tr>
    </table>
</div>
<div style="clear:both"></div> 


 <div id="header" name="header" runat="server" style="display: none"> 
    
    <div id="printStudentBtn" class="button" style="width:120px;">Print Roster</div> 
    <table id="studentHeader" class="contentHeader" cellpadding="0" cellspacing="0" >
        <tr>         
            <td style="width:60px">&nbsp;</td>
            <td style="width:160px">Student</td>
            <td style="width:130px">Login Name</td>
            <td style="width:120px">Password</td>
            <td style="width:70px">Gender</td>
            <td style="width:60px">Goal</td>
            <td style="width:100px">Miles Run </td> 
            <td style="width:190px">Percent of Goal</td>                      
        </tr>
    </table>

    <div id="studentArea" class="contentArea" style="height: 250px;padding: 5px;">
       <asp:Repeater ID="StudentRep" runat="server" OnItemDataBound="StudentRep_DataBound">        
          <ItemTemplate>
               <asp:Literal ID="DivOpenTag" runat="server" />
               <div style="width: 55px; float: left;">
                   &nbsp;
                   <asp:HyperLink ID="HyperLink1" runat="server" Visible="False">HyperLink</asp:HyperLink>                   
                </div>
               <div style="width:160px; float: left;">
                  <asp:HyperLink ID="studentLink" runat="server"></asp:HyperLink> </div>              
               <div style="width:130px; float: left;"><asp:Literal ID="StudentloginName" runat="server" /></div>
               <div style="width:130px; float: left;"><asp:Literal ID="studentPassword" runat="server" /></div>
               <div style="width:60px; float: left;"><asp:Literal ID="Gender" runat="server" /></div>
               <div style="width:70px; float: left;"><asp:Literal ID="Goal" runat="server" /></div>
               <div style="width:90px; float: left;"><asp:Literal ID="MilesRun" runat="server" /></div>
               <div style="width:190px; float: left;"><CR:Bar ID="Progress" runat="server" /></div>
            </div>
            <div class="clear"></div>
       </ItemTemplate>
     </asp:Repeater>
  </div>
   
 
 </div>

 <br />
 <br />
 <br />

 <div id="header1" name="header1" runat="server" style="display: none">
   <h2 style="color: #F85B17">Preview</h2>
     <table class="contentHeader" cellpadding="0" cellspacing="0" >
        <tr>
            <td style="width:85px">&nbsp;</td>
            <td style="width:200px">Student</td> 
            <td style="width:180px">Gender</td> 
            <td style="width:160px">Birthday</td> 
            <td style="width:100px">Goal</td> 
            <td style="width:180px">&nbsp;</td>                      
        </tr> 
    </table>
     <div id="Entries" runat="server" class="contentArea" style="height:150px;"></div>
    <div style="float:left; width:100%;" > 
      <table align="left" cellspacing="5" cellpadding="5"> 
        <tr>
            <td align="left"> <asp:FileUpload ID="FileUploadStudent" Width="200px" runat="server" /></td>
             <td align="left"><div id="previewRoster"  class="buttonMile" style="width:120px;">Load File</div></td>
              <td align="left"><div id="addStudent" class="buttonMile" style="width:120px;">Add Student</div> </td>
       
         </tr>    
        
    </table>
    
    <div id="saveStudent" class="button large" style="width:120px;float:right;margin-top:8px;">Save All</div>
    </div>

 
    <div class="clear"></div>

 </div>

 <div id="studentDialog" class="modalForm">
	<div class="title">*All form fields are required.</div>
	<label for="addFirstName">First Name</label>
	<input type="text" name="addFirstName" id="addFirstName" />
	<label for="addLastName">Last Name</label>
	<input type="text" name="addLastName" id="addLastName" />
	<label for="addGender">Gender</label>
     <select id="addGender" name="addGender" >
      <option value=""></option>
         <option value="F">Female</option>
         <option value="M">Male</option>
     </select>
	<label for="addBirthday">Birthday - <span style="color: #FF0000">(Optional)</span></label>
	<input type="text" name="addBirthday" id="addBirthday" />
   <label for="addGoal">Goal</label>
	<input type="text" name="addGoal" id="addGoal"  /> 

    <div style="margin: 20px 0px 10px 40px">
        <div class="button" onclick="SaveDialog()">Add</div><div class="button" onclick="CloseDialog()">Cancel</div>
        <div style="clear:both"></div>
    </div>
   
</div>

  

<div class="clear"></div>
  <asp:HiddenField id="addStudentNum"  value="0" runat="server" /> 
  <asp:HiddenField id="entriesHTML"   runat="server" /> 
  <asp:HiddenField id="CurrentClassID"  runat="server" /> 
  <asp:HiddenField id="CurrentGradeLevel"  runat="server" />

   <asp:HiddenField id="CurrentClassNm"  runat="server" />
  

  <input type="hidden" id="delStudent" name="delStudent" />
  <input type="hidden" id="allStudents" name="allStudents" />
  <input type="hidden" id="ClassInfoChange" name="ClassInfoChange" />
  
  


    
<script type="text/javascript">
    var delStudentID = "";

    function ChangeClassInfo() {
//        var selectGrade = $("#dropdownGradeLevel option:selected").val();
//        var selectTeacher = $("#dropdownGradeLevel option:selected").val();
//        var curVal = $("#CurrentGradeLevel").val();
        
//        if (selectval == curVal) {
//            alert("Grade not change");
//            return false;
//        }

        $("#ClassInfoChange").val("1");    
        document.forms[0].submit();
    }

    function printStudent() {

        var gradeLevel = $("#dropdownGradeLevel option:selected").text();
        var classNm = $('#CurrentClassNm').val();
        var headstr = "<html><head><title></title></head><body>";
        var footstr = "</body>";

//        var newstr = "<h1>Class Roster</h1> <br \>" +
//                     "<div style=\"width: 55px; float: left;\"><p></p></div>" +
//                     "<div style=\"width:160px; float: left;\"><h3>Student</h3></div>" +
//                     "<div style=\"width:130px; float: left;\"><h3>Login Name</h3></div>" +
//                     "<div style=\"width:120px; float: left;\"><h3>Password</h3></div>" +
//                     "<div style=\"width:70px; float: left;\"><h3>Gender</h3></div>" +
//                     "<div style=\"width:60px; float: left;\"><h3>Goal</h3></div>" +
//                     "<div style=\"width:100px; float: left;\"><h3>Miles Run</h3></div>" +
//                     "<div style=\"width:190px; float: left;\"><h3>Percent of Goal</h3></div>" +
        //                     "<br \>" + document.all.item("studentArea").innerHTML;

        var newstr = "<h1>Class Roster</h1> <br \>" +
                     "<h2>Class Name: " + classNm + "</h2> <br \>" +
                     "<h2>Grade: " + gradeLevel + "</h2> <br \>" +
                     "<div style=\"width: 55px; float: left;\"><p></p></div>" +
                     "<div style=\"width:160px; float: left;\"><h3>Student</h3></div>" +
                     "<div style=\"width:130px; float: left;\"><h3>Login Name</h3></div>" +
                     "<div style=\"width:120px; float: left;\"><h3>Password</h3></div>" +
                     "<div style=\"width:70px; float: left;\"><h3>Gender</h3></div>" +
                     "<div style=\"width:60px; float: left;\"><h3>Goal</h3></div>" +
                     "<div style=\"width:100px; float: left;\"><h3>Miles Run</h3></div>" +
                     "<div style=\"width:190px; float: left;\"><h3>Percent of Goal</h3></div>" +
                     "<br \>" + document.all.item("studentArea").innerHTML;
        var oldstr = document.body.innerHTML;
       
        document.body.innerHTML = headstr + newstr + footstr;
        window.print();

        window.location = window.location;

        return false;
      


    }
    function ShowClassDesc() {
        var selectval = $("#dropdownGradeLevel option:selected").val();

       
        if (selectval == "16") {
            $("#ClassLabel").css("font-weight",  "bold");
            $("#ClassLabel").css("font-size",  "14px");
            $("#ClassLabel").css("display",  "block");
            
          
            $("#ClassInfo").css("display", "block");
            $("#ClassInfo").focus();
        }
        else {
            $("#ClassLabel").css("display", "none");
            $("#ClassInfo").css("display", "none");
        }        
    }

    function DeleteStudent(id) 
    {

        var value = id.split('|');

        if (value.length >= 2)
        {
            if (confirm("Are you sure you want to delete student " + value[1] + "?")) 
            {            
                $("#delStudent").val(value[2]);
                document.forms[0].submit();
            }
        }
    }

    function DeleteAddNewStudentRow(id) {
        var x = $("#" + id).prop('title');

        if (confirm("Are you sure you want to delete student " + x + " from the preview list?")) {
            $("#" + id).remove();
        }

    }
      
    function PreviewStudent() {
        
        var x = $("#Entries").html().toString();
        $("#entriesHTML").val(x);
        document.forms[0].submit();
    }
       
    function SaveStudent() {
        var allstudent = "";         

          
        var teacher = $("#newClassTeacherDropDown option:selected").val();
        if ($("#newClassTeacherDropDown").is(":visible"))
        {  if (teacher == "") 
        {
               alert ("Please select a teacher");
               return false;
           }
        }


        $("#Entries .activityEntry :hidden").each(function () {
            allstudent += $(this).val() + ";";
        });

        allstudent = unescape(allstudent)
        if(allstudent == "")
        {
            alert("No student to add");
            return;
        }
                    

        $("#allStudents").val(allstudent);
        document.forms[0].submit();
    }

    function GenerateAddStudent(firstName, lastName, gender, birthday, goal){

        birthday = (birthday == "") ? "&nbsp" : birthday;
        gender = (gender == "") ? "&nbsp" : gender;
        input = firstName + "," + lastName + "," + gender + "," + birthday + "," + goal;
      
        input = escape(input);

        var rowid = $("#addStudentNum").val();

        var studentRow = "<div id='" + rowid.toString() + "' title='" + firstName + " " + lastName + "' class='activityEntry'><div style='float:left;width:80px;'><a href=\"javascript:DeleteAddNewStudentRow('" +
            rowid.toString() + "')\"><img src='../Images/delete.png' onmouseover=\"this.src='../Images/delete_hover.png'\" onmouseout=\"this.src='../Images/delete.png'\"></a><input type='hidden' value='" +
                input + "'></div><div style='float:left;width:200px'>" + firstName + " " + lastName + "</div><div style='float:left;width:180px'>" +
                    gender + "</div><div style='float:left;width:160px'>" + birthday + "</div><div style='float:left;width:100px'>" + goal + "</div></div>";

        rowid++;
        $("#addStudentNum").val(rowid.toString()); 
        return studentRow;
    }


    function SaveDialog() {

        if (ValidateStudentInputs()) {
            var firstName = jQuery.trim($("#studentDialog #addFirstName").val());
            var lastName = jQuery.trim($("#studentDialog #addLastName").val());
            var gender = jQuery.trim($("#studentDialog #addGender").val());
            var birthday = jQuery.trim($("#studentDialog #addBirthday").val());
           
            var goal = parseFloat(jQuery.trim($("#studentDialog #addGoal").val())).toFixed(1); 

            var html = $("#Entries").html().toString();

           

            html += GenerateAddStudent(firstName, lastName, gender, birthday, goal);
            $("#Entries").html(html);
            $("#studentDialog").dialog("close");
        }
    }


    function ValidateStudentInputs() {


        var firstname = jQuery.trim($("#studentDialog #addFirstName").val());
        if (firstname == "") {
            alert("Please enter the First Name.");
            return false;
        }

        var lastname = jQuery.trim($("#studentDialog #addLastName").val());
        if (lastname == "") {
            alert("Please enter the Last Name.");
            return false;
        }

        var gender = jQuery.trim($("#studentDialog #addGender").val());
        if (gender == "") {
            alert("Please select the gender.");
            return false;
        }

        var goal = jQuery.trim($("#addGoal").val());
        
        
        if (isNaN(goal) || goal == "")  {
            alert("Invalid # of goal.");
           return false;
        }
        
        return true;
    }

    function OpenDialog() {

        $("#studentDialog #addFirstName").val("");
        $("#studentDialog #addLastName").val("");
        $("#studentDialog #addGender").val("");
        $("#studentDialog #addBirthday").val("");        
        $('#addGoal').val("26.2");
        $("#studentDialog").dialog("open");
        
    }

    function CloseDialog() {
        $("#studentDialog").dialog("close");
    }

    $(document).ready(function () {
        $("#studentDialog").dialog({ title: "Add Student", autoOpen: false, modal: true, width: 300, resizable: false });        
        $("#addStudent").click(OpenDialog);
        $("#previewRoster").click(PreviewStudent);
        $("#saveStudent").click(SaveStudent);
        $("#saveClass").click(ChangeClassInfo);
        $("#printStudentBtn").click(printStudent);
        
      
    });
</script>

</asp:Content>
