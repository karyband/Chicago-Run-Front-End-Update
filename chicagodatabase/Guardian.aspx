<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ChicagoRun.Master" AutoEventWireup="true" CodeBehind="Guardian.aspx.cs" Inherits="ChicagoRun.WebUI.Pages.Guardian" %>
<%@ Register Src="~/Controls/ProgressBarSmall.ascx" TagName="Bar" TagPrefix="CR" %>
<%@ Register TagPrefix="CR" TagName="Map" Src="~/Controls/GoogleMap.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyContent" runat="server">
    <div id="Div1">
      <asp:HyperLink ID="UpdateMile" runat="server"><div class="lightbluebutton large" style="font-size:13px;">Add Mileage</div></asp:HyperLink>
      &nbsp;
      <asp:HyperLink ID="MileSearch" runat="server"><div class="button redbutton large" style="font-size:13px;">Edit Mileage</div></asp:HyperLink>
      &nbsp;
      <asp:HyperLink ID="EditProfile" runat="server"><div class="button large" style="font-size:13px;">Edit Profile</div></asp:HyperLink>
   </div>
   <br />
   <br />
<div class="userContent">
        <div class="mainInfo">
            <div class="tabs"> 
            <div class="routeArrow"><asp:HyperLink runat="server" ID="PreviousRoute" Visible="False"></asp:HyperLink></div>
		        <div class="tab" tab="1"  popup="show" style="margin-top: 0px; width: 90px;"><img src="../images/route.png" out="../images/route.png" hover="../images/route_hover.png" class="hoverChange" onclick="showUserRoute()"/></div>
                <div class="tab" tab="1"><img src="../images/landmark.png" out="../images/landmark.png" hover="../images/landmark_hover.png" class="hoverChange" onclick="showLandmarkMarker()"/></div>
                <div class="tab" tab="1"><img src="../images/nutrition.png" out="../images/nutrition.png" hover="../images/nutrition_hover.png" class="hoverChange" onclick="showFactMarker()"/></div>               
                <div class="tab" tab="5"><img src="../images/activity.png" out="../images/activity.png" hover="../images/activity_hover.png" class="hoverChange"/></div>
                <div class="routeArrow"><asp:HyperLink runat="server" ID="NextRoute" Visible="False"></asp:HyperLink></div>
            </div>
            <div style="clear:both"></div>
            <div class="tabPanels">
                <div class="tabPanel" id="tabPanel1"  >
                    <CR:Map ID="RouteMap"   runat="server" Visible="false"/>
                </div>
	            <div class="tabPanel" id="tabPanel5" style="display:none;padding: 0px 5px;">
                    <div id="header">
                        <table class="contentHeader" cellpadding="0" cellspacing="0">
                            <tr>
                                <td style="width:250px">Activity</td>
                                <td style="width:100px"># Unit</td>
                                <td style="width:100px"># Mile</td>
                                <td style="width:100px">Date</td>
                            </tr>
                        </table>
                    </div>
                    <div id="Entries" class="contentAreaNoBorder" style="height:450px;">
                        <asp:Repeater ID="EntryRep" runat="server" OnItemDataBound="EntryRep_DataBound">
                            <HeaderTemplate>
                                <table class="content" cellpadding="0" cellspacing="0">
                            </HeaderTemplate>
                            <ItemTemplate>
                                <tr> 
                                    <td style="width:250px"><asp:Literal ID="ActivityName" runat="server" /></td>
                                    <td style="width:100px"><asp:Literal ID="NumUnit" runat="server" /></td>
                                    <td style="width:100px"><asp:Literal ID="NumMile" runat="server" /></td>
                                    <td style="width:100px"><asp:Literal ID="EntryDate" runat="server" /></td>
                                </tr>
                            </ItemTemplate>
                            <AlternatingItemTemplate>
                                <tr class="contentAlternate"> 
                                    <td style="width:250px"><asp:Literal ID="ActivityName" runat="server" /></td>
                                    <td style="width:100px"><asp:Literal ID="NumUnit" runat="server" /></td>
                                    <td style="width:100px"><asp:Literal ID="NumMile" runat="server" /></td>
                                    <td style="width:100px"><asp:Literal ID="EntryDate" runat="server" /></td>
                                </tr>
                            </AlternatingItemTemplate>
                            <FooterTemplate>
                                </table>
                            </FooterTemplate>
                        </asp:Repeater>
                    </div>
                </div>
            </div>
        </div>
         <div>
            <div class="sideInfo" style="margin-top:-55px">
                <div id="bulletin" >
                   <div class="bulletinHeading">Chicago Run News</div>
                   <div class="bulletinContent" id="bulletinContentTxt" style="padding: 15px 20px 15px 25px; width: 249px; height: 235px;  font-size: 16px; color: #888888;" runat="server">
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
      
  
    </div>



    
   <div class = "clear"></div>
    <br />
    <br />
  
    <div  style=" font-size: 12px; font-weight: bold; color: #B2B2B2; text-transform: uppercase;"  >
         <asp:Literal  ID="Literal3" runat="server" Text="Enrolled Student(s)"></asp:Literal>    
    </div>
    <hr size="2" style="border: 1px solid #B2B2B2; background-color: #B2B2B2" />   
   <div id="header">
    <table class="contentHeader" cellpadding="0" cellspacing="0">


        <tr style="font-size: 15px">
            <td style="width:25px">&nbsp;</td>
            <td style="width:200px">Class</td>
            <td style="width:280px">Student</td>            
            <td style="width:140px">Goal</td>
            <td style="width:120px">Miles Run</td>           
            <td style="width:150px">Percent of Goal</td>
        </tr>
    </table>
</div>
<div class="contentArea">
    <asp:Repeater ID="StudentClassForGuardian" runat="server" OnItemDataBound="StudentClassForGuardian_Bound">
       <HeaderTemplate>
          <table class="content" cellpadding="0" cellspacing="0">
       </HeaderTemplate>
       <ItemTemplate>
             <tr style="font-size: 14px">      
                <td style="width:25px">&nbsp;</td>     
                <td style="width:200px"><asp:Literal ID="ClassName" runat="server" /></td>
                <td style="width:280px"><asp:HyperLink ID="studentLink" runat="server"></asp:HyperLink></td>                
                <td style="width:140px"><asp:Literal ID="Goal" runat="server" /></td>
                <td style="width:120px"><asp:Literal ID="MilesRun" runat="server" /></td>
                <td style="width:150px"><CR:Bar ID="Progress" runat="server" /></td>
             </tr>
       </ItemTemplate>
       <AlternatingItemTemplate>
           <tr class="contentAlternate" style="font-size: 14px">                   
                <td style="width:25px">&nbsp;</td>     
                <td style="width:200px"><asp:Literal ID="ClassName" runat="server" /></td>
                <td style="width:280px"><asp:HyperLink ID="studentLink" runat="server"></asp:HyperLink></td>                
                <td style="width:140px"><asp:Literal ID="Goal" runat="server" /></td>
                <td style="width:120px"><asp:Literal ID="MilesRun" runat="server" /></td>
                <td style="width:150px"><CR:Bar ID="Progress" runat="server" /></td>
             </tr>
       </AlternatingItemTemplate>
       <FooterTemplate>
          </table>
       </FooterTemplate>


    </asp:Repeater>
</div>


<div id="messageGuardain" class="modalForm">
	<div class="title" id="message"></div>	   
</div>
    
    <asp:HiddenField ID="showMessage" runat="server" />

 <script language="javascript" type="text/javascript">

     $(document).ready(function () {

         var welMess = $("#showMessage").val();

         if (welMess != '') {

             $("#message").html(welMess);
             $("#messageGuardain").dialog({ title: "Message", autoOpen: true, modal: true, width: 300, resizable: false });
            
         }

         $(".mainInfo .tabs .tab").each(function () {
             $(this).click(function () {
                 var tabnum = $(this).attr("tab");
                 $(".mainInfo .tabPanels .tabPanel").hide();
                 var popup = $(this).attr("popup");
                 if (popup != "show") {
                     $(".sideInfo .itemPopup").hide();
                 }
                 $(".mainInfo .tabPanels #tabPanel" + tabnum).show();
             });
         });
         showUserInfo();
     });
     function showUserRoute() {
         showRouteMarker();
         showUserInfo();
     }
     function showUserInfo() {
         infoPopup('<%=UserMessage %>');
     }
     function infoPopup(content) {
         $(".sideInfo .itemPopup").hide();

         if (content != "") {
             $(".sideInfo .itemPopup .popupContent").html(content);
             var height = 0;
             $(".sideInfo .itemPopup").slideUp('fast', function () {
                 height = $(".sideInfo .itemPopup").height();
                 var gap = (height < 500) ? 500 - height : 0;
                 $(".sideInfo .itemPopup").css("margin-top", "10px");
                 $(".sideInfo .itemPopup").slideDown('slow');

             });
         }
     }
    </script>
    </asp:Content>