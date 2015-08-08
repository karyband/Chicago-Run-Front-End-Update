<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ChicagoRun.Master" AutoEventWireup="true" CodeBehind="Student.aspx.cs" Inherits="ChicagoRun.WebUI.Pages.Student" EnableViewState="false" %>
<%@ Register TagPrefix="CR" TagName="Map" Src="~/Controls/GoogleMap.ascx" %>
<%@ Register TagPrefix="CR" TagName="UserInfo" Src="~/Controls/UserInfo.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyContent" runat="server">
    <div class="userContent">
        <div class="mainInfo">
            <div class="tabs">
                <div class="routeArrow"><asp:HyperLink runat="server" ID="PreviousRoute" Visible="False"></asp:HyperLink></div>
		        <div class="tab" tab="1" popup="show" style="margin-top: 0px; width: 90px;"><img src="../images/route.png" out="../images/route.png" hover="../images/route_hover.png" class="hoverChange" onclick="showUserRoute()"/></div>
                <div class="tab" tab="1"><img src="../images/landmark.png" out="../images/landmark.png" hover="../images/landmark_hover.png" class="hoverChange" onclick="showLandmarkMarker()"/></div>
                <div class="tab" tab="1"><img src="../images/nutrition.png" out="../images/nutrition.png" hover="../images/nutrition_hover.png" class="hoverChange" onclick="showFactMarker()"/></div>
                <div class="tab" tab="1"><img src="../images/awards.png" out="../images/awards.png" hover="../images/awards_hover.png" class="hoverChange" onclick="showAwards()"/></div>
                <div class="tab" tab="5"><img src="../images/activity.png" out="../images/activity.png" hover="../images/activity_hover.png" class="hoverChange"/></div>
                <div class="routeArrow"><asp:HyperLink runat="server" ID="NextRoute" Visible="False"></asp:HyperLink></div>
            </div>
            <div style="clear:both"></div>
            <div class="tabPanels">
                <div class="tabPanel" id="tabPanel1">
                    <CR:Map ID="RouteMap" runat="server" Visible="false"/>
                </div>
                <div class="tabPanel" id="tabPanel5" style="display:none;padding: 0px 5px;">
                    <div id="header">
                        <table class="contentHeader" cellpadding="0" cellspacing="0">
                            <tr>
                                <td style="width:240px">Activity</td>
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
    </div>
    <div style="clear:both"></div>
    <CR:UserInfo ID="uUserInfo" runat="server"></CR:UserInfo>
    <script language="javascript" type="text/javascript">
        $(document).ready(function () {
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
</asp:Content>
