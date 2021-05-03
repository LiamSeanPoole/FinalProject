<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PAnnouncements.aspx.cs" Inherits="BenhurstV3.PAnnouncements" %>
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


        <h2>Announcements</h2>
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
            
        <div>
            <div class="table-container">
            <p>
                    <asp:GridView AlternatingRowStyle-CssClass="table-container" ID="AnnView" runat="server" AutoGenerateColumns="False" DataKeyNames="AnnouncementNo" DataSourceID="SqlDataSource1">

                        <Columns>

                            <asp:BoundField DataField="Date" HeaderText="Date" SortExpression="Date" DataFormatString="{0:dd/MM/yyyy}"></asp:BoundField>
                            <asp:BoundField DataField="Title" HeaderText="Title" SortExpression="Title"></asp:BoundField>
                            <asp:BoundField DataField="Announcement" HeaderText="Announcement" SortExpression="Announcement"></asp:BoundField>
                        </Columns>
                    </asp:GridView>

                    <asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString='<%$ ConnectionStrings:BenhurstConnectionString %>' SelectCommand="SELECT [AnnouncementNo], [Date], [Title], [Announcement] FROM [Announcements] ORDER BY [Date] DESC"></asp:SqlDataSource>
                 </p>
                </div>

        </div>
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
