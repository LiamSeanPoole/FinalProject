<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MAnnouncements.aspx.cs" Inherits="BenhurstV3.MAnnouncements" %>
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
        <div>
        </div>
        <div>
            <fieldset>
            <legend>Create Announcement</legend>
            <label>Title 
                <asp:TextBox ID="title" runat="server" MaxLength="60"></asp:TextBox>
                <asp:RegularExpressionValidator runat="server" ErrorMessage="Maximum 60 characters" ControlToValidate="title" 
ValidationExpression="^.{1,60}$" ></asp:RegularExpressionValidator>
            </label>
            <label>
                Date 
                <asp:TextBox ID="date" runat="server" type="date"></asp:TextBox>
            </label>
            <label>
                Announcement
                <asp:TextBox ID="announcement" runat="server" MaxLength="500"></asp:TextBox>
                <asp:RegularExpressionValidator runat="server" ErrorMessage="Maximum 500 characters" ControlToValidate="announcement" 
ValidationExpression="^.{1,60}$" ></asp:RegularExpressionValidator>
            </label>
            <p>
                <asp:Button ID="Submit" runat="server" OnClick="Submit_Click" Text="Post"/>
            </p>
            </fieldset>
        </div>
        <fieldset>
        <legend>Delete Announcement</legend>
        <label>Announcement number </label>
                <asp:TextBox ID="AnnNo" runat="server" MaxLength="9"></asp:TextBox>
            <asp:RegularExpressionValidator runat="server" ErrorMessage="Invalid Entry, Maximum 9 characters" ControlToValidate="AnnNo" 
ValidationExpression="^[0-9]*$" ForeColor="Red" ></asp:RegularExpressionValidator>
                <p>
                <asp:Button ID="Delete" runat="server" OnClick="Delete_Click" Text="Delete"/>
                    </p>
        </fieldset>
        <div>
            <div class="table-container">
            <p>
                    <asp:GridView AlternatingRowStyle-CssClass="table-container" ID="AnnView" runat="server" AutoGenerateColumns="False" DataKeyNames="AnnouncementNo" DataSourceID="SqlDataSource1">

                        <Columns>
                            <asp:BoundField DataField="AnnouncementNo" HeaderText="Announcement Number" ReadOnly="True" SortExpression="AnnouncementNo"></asp:BoundField>
                            <asp:BoundField DataField="Date" HeaderText="Date" SortExpression="Date" DataFormatString="{0:dd/MM/yyyy}"></asp:BoundField>
                            <asp:BoundField DataField="Title" HeaderText="Title" SortExpression="Title"></asp:BoundField>
                            <asp:BoundField DataField="Announcement" HeaderText="Announcement" SortExpression="Announcement"></asp:BoundField>
                        </Columns>
                    </asp:GridView>

                    <asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString='<%$ ConnectionStrings:BenhurstConnectionString %>' SelectCommand="SELECT [AnnouncementNo], [Date], [Title], [Announcement] FROM [Announcements] ORDER BY [AnnouncementNo] DESC"></asp:SqlDataSource>
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
