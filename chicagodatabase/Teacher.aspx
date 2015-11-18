<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ChicagoRun.Master" AutoEventWireup="true" CodeBehind="Teacher.aspx.cs" Inherits="ChicagoRun.WebUI.Pages.Teacher" %>
<%@ Register Src="~/Controls/ProgressBarSmall.ascx" TagName="Bar" TagPrefix="CR" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyContent" runat="server">
   
   <div style="float: left"  >
   <div id="actionlinks">
      <asp:HyperLink ID="EnterMile" runat="server"><div class="lightbluebutton large" style="font-size:13px;">Add Mileage</div></asp:HyperLink>
      &nbsp;
      <asp:HyperLink ID="MileSearch" runat="server"><div class="button redbutton large" style="font-size:13px;">Edit Mileage</div></asp:HyperLink>
      &nbsp;
      <asp:HyperLink ID="AddClass" runat="server"><div class="button large" style="font-size:13px;">Add Class</div></asp:HyperLink>
   </div>
   <br />
   <br />
   <div id="header"  style="width: 655px;" >
      <table class="contentHeader" cellpadding="0" cellspacing="0">
        <tr>
            <td style="width:45px">&nbsp;</td>
            <td style="width:150px">Class</td>
            <td style="width:90px"># Student</td>
            <td style="width:80px">Goal</td>
            <td style="width:80px">Miles Run</td>
            <td style="width:100px">Last Update</td>           
            <td style="width:110px">Percent of Goal</td>
         </tr>
      </table>
   </div>
   <div class="contentArea"  style="width: 655px;">
      <asp:Repeater ID="TeacherRep" runat="server" OnItemDataBound="TeacherRep_DataBound">
         <HeaderTemplate>
            <table class="content" cellpadding="0" cellspacing="0">
         </HeaderTemplate>
         <ItemTemplate>
            <tr>    
               <td style="width:5px">
                  &nbsp;
               </td>  
               <td style="width:45px">                    
                    <asp:Image ID="DeleteClassLink" runat="server" CssClass="deleteChange" />
               </td>
               
               <td style="width:150px">
                    <asp:HyperLink ID="ClassName" runat="server">HyperLink</asp:HyperLink>             
               </td>
               <td style="width:90px"><asp:Literal ID="NumStudent" runat="server" /></td>
               <td style="width:80px"><asp:Literal ID="Goal" runat="server" /></td>
               <td style="width:80px"><asp:Literal ID="MilesRun" runat="server" /></td>
               <td style="width:100px"><asp:Literal ID="LastUpdate" runat="server" /></td>
               <td style="width:110px"><CR:Bar ID="Progress" runat="server" /></td>
            </tr>
         </ItemTemplate>
         <AlternatingItemTemplate>
            <tr class="contentAlternate">      
               <td style="width:5px">
                  &nbsp;
               </td>  
                <td style="width:45px">                    
                    <asp:Image ID="DeleteClassLink" runat="server" CssClass="deleteChange" />
               </td>
               
               <td style="width:150px"><asp:HyperLink ID="ClassName" runat="server">HyperLink</asp:HyperLink></td>
               <td style="width:90px"><asp:Literal ID="NumStudent" runat="server" /></td>
               <td style="width:80px"><asp:Literal ID="Goal" runat="server" /></td>
               <td style="width:80px"><asp:Literal ID="MilesRun" runat="server" /></td>
               <td style="width:100px"><asp:Literal ID="LastUpdate" runat="server" /></td>
               <td style="width:110px"><CR:Bar ID="Progress" runat="server" /></td>
            </tr>
         </AlternatingItemTemplate>
         <FooterTemplate>
            </table>
         </FooterTemplate>
      </asp:Repeater>
   </div>
   </div>
    <div id="bulletin" style="width: 236px; float: right; margin-right: 13px;">
         <div class="bulletinHeading">BULLETIN BOARD</div>
         <div class="bulletinContent" id="bulletinContentTxt" style="width: 230px; height: 235px; font-family: Arial, Helvetica, sans-serif; font-size: 14px; font-weight: 400;" runat="server">        
         
         </div>
   </div>

   <div class="clear">
   </div>


   <script type="text/javascript" language="javascript">
       function DeleteClass(name, url) {
           if (confirm("Are you sure you would like to delete " + name + "?\nAll users related to this Class will be deleted.")) {
               document.location.href = url;
           }
           return false;
       }
</script>
</asp:Content>
