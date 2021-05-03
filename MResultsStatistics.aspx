<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MResultsStatistics.aspx.cs" Inherits="BenhurstV3.MResultsStatistics" %>
<link href="css/stylesheetv3.css" rel="stylesheet" type="text/css" />
<link href="css/normalize.css" rel="stylesheet" type="text/css">
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
    <div id="wrapper">
<body>
    <header class="banner-clipped">              
<img src="images/BenhurstHeader.jpg"  width="1000" height="250"                
alt="Benhurst"/></header>


        <h2>Results and Statistics</h2>
     <nav class="menu">
	        
	<ul>
        <li><a href="Managerhomepage.aspx">Homepage</a></li>
		<li><a href="MUser.aspx">Users</a></li>
        <li><a href="MAnnouncements.aspx">Announcements</a></li>
        <li><a href="MSessions.aspx">Sessions</a></li>
        <li><a href="MAvailability.aspx">Availabilty</a></li>
        <li><a href="MAttendance.aspx">Attendance</a></li>
        <li><a href="MPayments.aspx">Payments</a></li>
        <li><a href="MResultsStatistics.aspx">Results</a></li>

        
        
	</ul>
         
	</nav>
    <form id="form1" runat="server">
    <asp:Label ID="loggedin" runat="server">
        </asp:Label>
    <div id="logoutlink">
            <asp:Button ID="Logout" runat="server" OnClick="Logout_Click" Text="Logout" />
        </div>
        <h3>Previous matches</h3>
            <div class="table-container">
                <p>
                
                    <asp:GridView runat="server" AutoGenerateColumns="False" DataKeyNames="SessionID" DataSourceID="SqlDataSource2">
                        <Columns>
                            <asp:BoundField DataField="SessionID" HeaderText="Match Number" ReadOnly="True" SortExpression="SessionID"></asp:BoundField>
                            <asp:BoundField DataField="TypeOfSession" HeaderText="Fixture/Training" SortExpression="TypeOfSession" Visible="false"></asp:BoundField>
                            <asp:BoundField DataField="Date" HeaderText="Date" SortExpression="Date" DataFormatString="{0:dd/MM/yyyy}"></asp:BoundField>
                            <asp:BoundField DataField="Time" HeaderText="Time" SortExpression="Time"></asp:BoundField>
                            <asp:BoundField DataField="LocationID" HeaderText="LocationID" SortExpression="LocationID"></asp:BoundField>
                            <asp:BoundField DataField="Opponent" HeaderText="Opponent" SortExpression="Opponent"></asp:BoundField>
                            <asp:BoundField DataField="Kit_Colour" HeaderText="Kit Colour" SortExpression="Kit_Colour"></asp:BoundField>
                            <asp:BoundField DataField="ContactName" HeaderText="Contact Name" SortExpression="ContactName"></asp:BoundField>
                            <asp:BoundField DataField="ContactNumber" HeaderText="Contact Number" SortExpression="ContactNumber"></asp:BoundField>
                            <asp:BoundField DataField="Fee" HeaderText="Fee" SortExpression="Fee"></asp:BoundField>
                        </Columns>
                    </asp:GridView>
                    <asp:SqlDataSource runat="server" ID="SqlDataSource2" ConnectionString='<%$ ConnectionStrings:BenhurstConnectionString %>' SelectCommand="SELECT [SessionID], [TypeOfSession], [Date], [Time], [LocationID], [Opponent], [Kit_Colour], [ContactName], [ContactNumber], [Fee] FROM [Session] WHERE [Date] <= getdate() AND [TypeOfSession] = 'Fixture' ORDER BY [Date]"></asp:SqlDataSource>
                </p>
            </div>
        <h3>Input Results and Statistics</h3>
          <p>Select a Match Number
                    <asp:DropDownList ID="Session_ddl" runat="server" DataSourceID="SqlDataSource1" DataTextField="SessionID" DataValueField="SessionID"></asp:DropDownList>

                <asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString='<%$ ConnectionStrings:BenhurstConnectionString %>' SelectCommand="SELECT [SessionID], [TypeOfSession], [Date], [Time], [LocationID], [Opponent], [Kit_Colour], [ContactName], [ContactNumber], [Fee] FROM [Session] WHERE [Date] <= getdate() AND [TypeOfSession] = 'Fixture' ORDER BY [Date]"></asp:SqlDataSource></p>
              <p><asp:Button ID="ddl_btn" runat="server" OnClick="DropDown_Click" Text="Select"/></p>

        <h3 runat="server" id ="ManagerMR">Match Result</h3><asp:GridView ID="resgv" runat="server" AutoGenerateColumns="False" DataKeyNames="ResultID" OnRowEditing="res_list_RowEditing" OnRowUpdating="res_list_RowUpdating" OnPageIndexChanging="res_list_PageIndexChanging" OnRowCancelingEdit="res_list_RowCancelingEdit">
            <Columns>
                <asp:BoundField DataField="ResultID" HeaderText="ResultID" ReadOnly="True" SortExpression="ResultID" Visible="false"></asp:BoundField>
                <asp:BoundField DataField="Benhurst_Goals" HeaderText="Benhurst Goals Scored" SortExpression="Benhurst_Goals"></asp:BoundField>
                <asp:BoundField DataField="Opposition_Goals" HeaderText="Opposition Goals Scored" SortExpression="Opposition_Goals"></asp:BoundField>
                <asp:BoundField DataField="SessionID" HeaderText="SessionID" SortExpression="SessionID" Visible="false" ReadOnly="True"></asp:BoundField>
                <asp:CommandField ShowEditButton="true" />
            </Columns>
        </asp:GridView>
        <asp:Label ID="error_lblMR" runat="server"></asp:Label>
        
        <asp:SqlDataSource runat="server" ID="SqlDataSource5" ConnectionString='<%$ ConnectionStrings:BenhurstConnectionString %>' SelectCommand="SELECT [ResultID], [Benhurst_Goals], [Opposition_Goals], [SessionID] FROM [Result]"></asp:SqlDataSource>
        <h3 runat="server" id="ManagerPS">Player Statistics</h3>
        <asp:GridView ID="statgv" runat="server" AutoGenerateColumns="False" DataKeyNames="StatID" OnRowEditing="stat_list_RowEditing" OnRowUpdating="stat_list_RowUpdating" OnPageIndexChanging="stat_list_PageIndexChanging" OnRowCancelingEdit="stat_list_RowCancelingEdit">
            <Columns>
                <asp:BoundField DataField="StatID" HeaderText="StatID" ReadOnly="True" SortExpression="StatID"></asp:BoundField>
                <asp:BoundField DataField="AttendanceID" HeaderText="AttendanceID" SortExpression="AttendanceID"></asp:BoundField>
                <asp:BoundField DataField="PlayerRegistrationNo" HeaderText="PlayerRegistrationNo" SortExpression="PlayerRegistrationNo"></asp:BoundField>
                <asp:BoundField DataField="Forename" HeaderText="Forename" SortExpression="Forename"></asp:BoundField>
                <asp:BoundField DataField="Surname" HeaderText="Surname" SortExpression="Surname"></asp:BoundField>
                <asp:BoundField DataField="Goal" HeaderText="Goal" SortExpression="Goal"></asp:BoundField>
                <asp:BoundField DataField="Assist" HeaderText="Assist" SortExpression="Assist"></asp:BoundField>
                <asp:BoundField DataField="Yellow" HeaderText="Yellow" SortExpression="Yellow"></asp:BoundField>
                <asp:BoundField DataField="Red" HeaderText="Red" SortExpression="Red"></asp:BoundField>
                <asp:BoundField DataField="Clean_Sheet" HeaderText="Clean_Sheet" SortExpression="Clean_Sheet"></asp:BoundField>
                <asp:CommandField ShowEditButton="true" />
            </Columns>
        </asp:GridView>

        <asp:SqlDataSource runat="server" ID="SqlDataSource4" ConnectionString='<%$ ConnectionStrings:BenhurstConnectionString %>' SelectCommand="SELECT Stats.StatID, Stats.AttendanceID, Stats.PlayerRegistrationNo, users.Forename, users.Surname, Stats.Goal, Stats.Assist, Stats.Yellow, Stats.Red, Stats.Clean_Sheet FROM Stats INNER JOIN Attendance ON Stats.AttendanceID = Attendance.AttendanceID LEFT OUTER JOIN users ON Attendance.PlayerRegistrationNo = users.PlayerRegistrationNo"></asp:SqlDataSource>
        <asp:SqlDataSource runat="server" ID="SqlDataSource3"></asp:SqlDataSource>
        <div>
            <asp:Label ID="error_lblPS" runat="server"></asp:Label>
            <p class="clear"><a href="#top" class="top">Go to Top</a></p>
 
    <footer>
        <p>
                    <a href="https://twitter.com/benhurstunited?lang=en">
                        <img src="images/twitter.png" class="in_social_media" id="in_twitter" alt="Benhurst United Twitter"/>
                    </a>
                
            
                
                    <a href="https://www.instagram.com/benhurstunited/?hl=en">
                        <img src="images/instagram.png" class="in_social_media" id="in_insta" alt="Benhurst United Instagram"/>
                    </a>
                
            
                
                    <a href="https://fulltime-league.thefa.com/displayTeam.html?divisionseason=869758076&teamID=296986300">
                        <img src="images/league.png" class="in_social_media" id="in_yt" alt="League"/>
                    </a>
                
            </p>
        <small>© 2021, By Liam Poole. <a href="l.poole@uni.brighton.ac.uk" class="email">email</a></small>
	</footer>
        </div>
    </form>
</body>
</html>
