<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PPayments.aspx.cs" Inherits="BenhurstV3.PPayments" %>
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

    <h2>Payments</h2>

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
    <h3>Payments yet to be confirmed by Manager</h3>
	<div class="table-container">
            <p>
        <asp:GridView runat="server" AutoGenerateColumns="False" DataSourceID="Ppayawaitingconfirmation">
            <Columns>
                <asp:BoundField DataField="PayID" HeaderText="Pay Number" SortExpression="PayID"></asp:BoundField>
                <asp:BoundField DataField="PlayerRegistrationNo" HeaderText="Player Registration Number" SortExpression="PlayerRegistrationNo" Visible="false"></asp:BoundField>
                <asp:BoundField DataField="Forename" HeaderText="Forename" SortExpression="Forename" Visible="false"></asp:BoundField>
                <asp:BoundField DataField="Surname" HeaderText="Surname" SortExpression="Surname" Visible="false"></asp:BoundField>
                <asp:BoundField DataField="SessionID" HeaderText="Session Number" SortExpression="SessionID"></asp:BoundField>
                <asp:BoundField DataField="TypeOfSession" HeaderText="Fixture/Training" SortExpression="TypeOfSession"></asp:BoundField>
                <asp:BoundField DataField="Date" HeaderText="Date" SortExpression="Date" DataFormatString="{0:dd/MM/yyyy}"></asp:BoundField>
                <asp:BoundField DataField="Time" HeaderText="Time" SortExpression="Time"></asp:BoundField>
                <asp:BoundField DataField="LocationID" HeaderText="LocationID" SortExpression="LocationID"></asp:BoundField>
                <asp:BoundField DataField="Opponent" HeaderText="Opponent" SortExpression="Opponent"></asp:BoundField>
                <asp:BoundField DataField="Kit_Colour" HeaderText="Kit_Colour" SortExpression="Kit_Colour" Visible="false"></asp:BoundField>
                <asp:BoundField DataField="ContactName" HeaderText="ContactName" SortExpression="ContactName" Visible="false"></asp:BoundField>
                <asp:BoundField DataField="ContactNumber" HeaderText="ContactNumber" SortExpression="ContactNumber" Visible="false"></asp:BoundField>
                <asp:BoundField DataField="Fee" HeaderText="Fee" SortExpression="Fee"></asp:BoundField>
                <asp:BoundField DataField="Paid" HeaderText="Paid" SortExpression="Paid"></asp:BoundField>
                <asp:BoundField DataField="Confirmation" HeaderText="Confirmation" SortExpression="Confirmation"></asp:BoundField>
            </Columns>
        </asp:GridView>
            </p>
        
        <asp:SqlDataSource runat="server" ID="Ppayawaitingconfirmation" ConnectionString='<%$ ConnectionStrings:BenhurstConnectionString %>' SelectCommand="SELECT Payments.PayID, Attendance.PlayerRegistrationNo, users.Forename, users.Surname, Session.SessionID, Session.TypeOfSession, Session.Date, Session.Time, Session.LocationID, Session.Opponent, Session.Kit_Colour, Session.ContactName, Session.ContactNumber, Payments.Fee, Payments.Paid, Payments.Confirmation FROM Attendance INNER JOIN Payments ON Attendance.AttendanceID = Payments.AttendanceID INNER JOIN Session ON Attendance.SessionID = Session.SessionID LEFT OUTER JOIN users ON Attendance.PlayerRegistrationNo = users.PlayerRegistrationNo WHERE users.LoginStatus = 'yes' AND Payments.Confirmation = '' OR Payments.Confirmation = 'No'"></asp:SqlDataSource>
    
    </div>
            <label>
                Please input the PayID for the session you have paid for:
                <asp:TextBox ID="PayIDbox" runat="server" MaxLength="100"></asp:TextBox>
                <asp:RegularExpressionValidator runat="server" ErrorMessage="Invalid PayID, maximum 100 characters" ControlToValidate="PayIDbox" 
ValidationExpression="^P.*" ForeColor="Red" ></asp:RegularExpressionValidator>
                <asp:Label ID="Label1" runat="server"></asp:Label>
            </label>
            <p>
              <asp:Button ID="SubmitUser" runat="server" OnClick="SubmitPay_Click" Text="Submit"/>  
            </p>
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
