<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PResultsStatistics.aspx.cs" Inherits="BenhurstV3.PResultsStatistics" %>
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
        <li><a href="Playerhomepage.aspx">Homepage</a></li>
        <li><a href="PAnnouncements.aspx">Announcements</a></li>
        <li><a href="PSessions.aspx">Sessions</a></li>
        <li><a href="PAvailability.aspx">Availability</a></li>
        <li><a href="PPayments.aspx">Payments</a></li>
        <li><a href="PResultsStatistics.aspx">Results and Statistics</a></li>

        
        
	</ul>
         
	</nav>
    <form id="form1" runat="server">
    <asp:Label ID="loggedin" runat="server">
        </asp:Label>
    <div id="logoutlink">
            <asp:Button ID="Logout" runat="server" OnClick="Logout_Click" Text="Logout" />
        </div>
        <div>
        </div>
        <div>
            <div class="table-container">
        <h3>Results</h3>
            <asp:GridView runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1">
                <Columns>
                    <asp:BoundField DataField="Benhurst_Goals" HeaderText="Benhurst" SortExpression="Benhurst_Goals"></asp:BoundField>
                    <asp:BoundField DataField="Opposition_Goals" HeaderText="Opposition" SortExpression="Opposition_Goals"></asp:BoundField>
                    <asp:BoundField DataField="Opponent" HeaderText="Opponent" SortExpression="Opponent"></asp:BoundField>
                    <asp:BoundField DataField="Date" HeaderText="Date" SortExpression="Date" DataFormatString="{0:dd/MM/yyyy}"></asp:BoundField>
                </Columns>
            </asp:GridView>
                </div>
            <h3>Overall Statistics</h3>
            <div class="table-container">
            <asp:GridView runat="server"
                AutoGenerateColumns="False" DataSourceID="SqlDataSource2">
                <Columns>
                    <asp:BoundField DataField="Forename" HeaderText="Forename" SortExpression="Forename"></asp:BoundField>
                    <asp:BoundField DataField="Surname" HeaderText="Surname" SortExpression="Surname"></asp:BoundField>
                    <asp:BoundField DataField="Total Appearances" HeaderText="Total Appearances" ReadOnly="True" SortExpression="Total Appearances"></asp:BoundField>
                    <asp:BoundField DataField="Total Goals" HeaderText="Total Goals" ReadOnly="True" SortExpression="Total Goals"></asp:BoundField>
                    <asp:BoundField DataField="Total Assists" HeaderText="Total Assists" ReadOnly="True" SortExpression="Total Assists"></asp:BoundField>
                    <asp:BoundField DataField="Total Yellow Cards" HeaderText="Total Yellow Cards" ReadOnly="True" SortExpression="Total Yellow Cards"></asp:BoundField>
                    <asp:BoundField DataField="Total Red Cards" HeaderText="Total Red Cards" ReadOnly="True" SortExpression="Total Red Cards"></asp:BoundField>
                    <asp:BoundField DataField="Total Clean Sheets" HeaderText="Total Clean Sheets" ReadOnly="True" SortExpression="Total Clean Sheets"></asp:BoundField>
                </Columns>
            </asp:GridView>
                </div>
            <asp:SqlDataSource runat="server" ID="SqlDataSource2" ConnectionString='<%$ ConnectionStrings:BenhurstConnectionString %>' SelectCommand="SELECT users.Forename, users.Surname, COUNT(Stats.PlayerRegistrationNo) AS [Total Appearances], SUM(Stats.Goal) AS [Total Goals], SUM(Stats.Assist) AS [Total Assists], SUM(Stats.Yellow) AS [Total Yellow Cards], SUM(Stats.Red) AS [Total Red Cards], SUM(Stats.Clean_Sheet) AS [Total Clean Sheets] FROM Stats LEFT OUTER JOIN users ON Stats.PlayerRegistrationNo = users.PlayerRegistrationNo WHERE users.LoginStatus = 'yes' GROUP BY users.Forename, users.Surname"></asp:SqlDataSource>
            <asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString='<%$ ConnectionStrings:BenhurstConnectionString %>' SelectCommand="SELECT Result.Benhurst_Goals, Result.Opposition_Goals, Session.Opponent, Session.Date FROM Result INNER JOIN Session ON Result.SessionID = Session.SessionID WHERE Result.Benhurst_Goals IS NOT NULL ORDER BY Session.Date DESC"></asp:SqlDataSource>
            <div>
            
            
            </label>
        </div>
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
