<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Managerhomepage.aspx.cs" Inherits="BenhurstV3.Managerhomepage" %>
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


        <h2>Manager Homepage</h2>
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

        <p>Welcome to the Manager Homepage.</p>
    <p></p>
    <p>You now have access to the following pages</p>
    <ul>
        <li>Users
        </li><li>Announcements</li>
        <li>Sessions</li>
        <li>Availability</li>
        <li>Attendance</li>
        <li>Payments</li>
        <li>Results</li>
        
    </ul>
    <p>For more information on these pages and for some help regarding the website then please click "<a href ="userguide/MUserGuide.pdf">USER GUIDE</a>"</p>
            </label>

        <h3>Players requesting to join Benhurst United</h3>
        <fieldset>
        <legend>Delete Request</legend>
        <label>Request Number </label>
                <asp:TextBox ID="AnnNo" runat="server" MaxLength="9"></asp:TextBox>
            <asp:RegularExpressionValidator runat="server" ErrorMessage="Invalid Entry, Maximum 9 characters" ControlToValidate="AnnNo" 
ValidationExpression="^[0-9]*$" ForeColor="Red" ></asp:RegularExpressionValidator>
                <p>
                <asp:Button ID="Delete" runat="server" OnClick="Delete_Click" Text="Delete"/>
                    </p>
        </fieldset>
        <div class="table-container">
            <asp:GridView ID="Reqgv" runat="server" AutoGenerateColumns="False" DataKeyNames="RequestID" DataSourceID="SqlDataSource1">
                <Columns>
                    <asp:BoundField DataField="RequestID" HeaderText="Request Number" ReadOnly="True" InsertVisible="False" SortExpression="RequestID"></asp:BoundField>
                    <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name"></asp:BoundField>
                    <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email"></asp:BoundField>
                    <asp:BoundField DataField="Contact_No" HeaderText="Contact_No" SortExpression="Contact_No"></asp:BoundField>
                    <asp:BoundField DataField="DOB" HeaderText="DOB" SortExpression="DOB" DataFormatString="{0:dd/MM/yyyy}"></asp:BoundField>
                    <asp:BoundField DataField="Reason" HeaderText="Reason" SortExpression="Reason"></asp:BoundField>
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString='<%$ ConnectionStrings:BenhurstConnectionString %>' SelectCommand="SELECT [RequestID], [Name], [Email], [Contact_No], [DOB], [Reason] FROM [Request]"></asp:SqlDataSource>
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
    
    </div>
</html>