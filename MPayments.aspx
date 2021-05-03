<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MPayments.aspx.cs" Inherits="BenhurstV3.MPayments" %>
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
        
            <h3>Outstanding Payments</h3>
            <label>Enter a Player Name Or Player Registration Number
                    <asp:TextBox ID="player_search_txt" runat="server" MaxLength="50"></asp:TextBox>
                <asp:RegularExpressionValidator runat="server" ErrorMessage="Maximum 50 characters" ControlToValidate="player_search_txt" 
ValidationExpression="^.{1,50}$" ></asp:RegularExpressionValidator>
                    <p><asp:Button ID="player_search_btn" runat="server" OnClick="Player_Search_Click" Text="Search"/></p>
                </label>
        
   
        <div class="table-container">
            <p>
        <asp:GridView ID="MPaygv" runat="server" DataKeyNames="PayID" AutoGenerateColumns="False" OnRowDeleting="pay_list_RowDeleting" OnRowEditing="pay_list_RowEditing" OnRowUpdating="pay_list_RowUpdating" OnPageIndexChanging="pay_list_PageIndexChanging" OnRowCancelingEdit="pay_list_RowCancelingEdit">
            <Columns>
                <asp:BoundField DataField="PayID" HeaderText="Pay Number" SortExpression="PayID" ReadOnly="True"></asp:BoundField>
                <asp:BoundField DataField="PlayerRegistrationNo" HeaderText="Player Registration Number" SortExpression="PlayerRegistrationNo" ReadOnly="True"></asp:BoundField>
                <asp:BoundField DataField="Forename" HeaderText="Forename" SortExpression="Forename" ReadOnly="True"></asp:BoundField>
                <asp:BoundField DataField="Surname" HeaderText="Surname" SortExpression="Surname" ReadOnly="True"></asp:BoundField>
                <asp:BoundField DataField="SessionID" HeaderText="Session Number" SortExpression="SessionID" ReadOnly="True"></asp:BoundField>
                <asp:BoundField DataField="TypeOfSession" HeaderText="Fixture/Training" SortExpression="TypeOfSession" ReadOnly="True"></asp:BoundField>
                <asp:BoundField DataField="Date" HeaderText="Date" SortExpression="Date" DataFormatString="{0:dd/MM/yyyy}" ReadOnly="True"></asp:BoundField>
                <asp:BoundField DataField="Time" HeaderText="Time" SortExpression="Time" ReadOnly="True"></asp:BoundField>
                <asp:BoundField DataField="LocationID" HeaderText="LocationID" SortExpression="LocationID" Visible="false" ReadOnly="True"></asp:BoundField>
                <asp:BoundField DataField="Opponent" HeaderText="Opponent" SortExpression="Opponent" Visible="false" ReadOnly="True"></asp:BoundField>
                <asp:BoundField DataField="Kit_Colour" HeaderText="Kit Colour" SortExpression="Kit_Colour" Visible="false" ReadOnly="True"></asp:BoundField>
                <asp:BoundField DataField="ContactName" HeaderText="Contact Name" SortExpression="ContactName" ReadOnly="True"></asp:BoundField>
                <asp:BoundField DataField="ContactNumber" HeaderText="Contact Number" SortExpression="ContactNumber" Visible="false" ReadOnly="True"></asp:BoundField>
                <asp:BoundField DataField="Fee" HeaderText="Fee" SortExpression="Fee" ReadOnly="True"></asp:BoundField>
                <asp:BoundField DataField="Paid" HeaderText="Player Stated Paid" SortExpression="Paid" ReadOnly="True"></asp:BoundField>
                <asp:BoundField DataField="Confirmation" HeaderText="Confirmation payment received (yes/no)" SortExpression="Confirmation"></asp:BoundField>
                <asp:CommandField ShowEditButton="true" />  
                <asp:CommandField ShowDeleteButton="true" />
            </Columns>
        </asp:GridView>
            </p>
        
        <asp:SqlDataSource runat="server" ID="Ppayawaitingconfirmation" ConnectionString='<%$ ConnectionStrings:BenhurstConnectionString %>' SelectCommand="SELECT Payments.PayID, Attendance.PlayerRegistrationNo, users.Forename, users.Surname, Session.SessionID, Session.TypeOfSession, Session.Date, Session.Time, Session.LocationID, Session.Opponent, Session.Kit_Colour, Session.ContactName, Session.ContactNumber, Payments.Fee, Payments.Paid, Payments.Confirmation FROM Attendance INNER JOIN Payments ON Attendance.AttendanceID = Payments.AttendanceID INNER JOIN Session ON Attendance.SessionID = Session.SessionID LEFT OUTER JOIN users ON Attendance.PlayerRegistrationNo = users.PlayerRegistrationNo WHERE Payments.Confirmation = '' OR Payments.Confirmation = 'No'"></asp:SqlDataSource>
    
    </div>
        <asp:Label ID="error_lbl" runat="server"></asp:Label>
        <h3>Historical Payments</h3>
        <div class="table-container">
            <p>
        <asp:GridView runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1">
            <Columns>
                <asp:BoundField DataField="PayID" HeaderText="Pay Number" SortExpression="PayID"></asp:BoundField>
                <asp:BoundField DataField="PlayerRegistrationNo" HeaderText="Player Registration Number" SortExpression="PlayerRegistrationNo"></asp:BoundField>
                <asp:BoundField DataField="Forename" HeaderText="Forename" SortExpression="Forename"></asp:BoundField>
                <asp:BoundField DataField="Surname" HeaderText="Surname" SortExpression="Surname"></asp:BoundField>
                <asp:BoundField DataField="SessionID" HeaderText="Session Number" SortExpression="SessionID"></asp:BoundField>
                <asp:BoundField DataField="TypeOfSession" HeaderText="Fixture/Training" SortExpression="TypeOfSession"></asp:BoundField>
                <asp:BoundField DataField="Date" HeaderText="Date" SortExpression="Date" DataFormatString="{0:dd/MM/yyyy}"></asp:BoundField>
                <asp:BoundField DataField="Time" HeaderText="Time" SortExpression="Time"></asp:BoundField>
                <asp:BoundField DataField="LocationID" HeaderText="LocationID" SortExpression="LocationID" Visible="false"></asp:BoundField>
                <asp:BoundField DataField="Opponent" HeaderText="Opponent" SortExpression="Opponent" Visible="false"></asp:BoundField>
                <asp:BoundField DataField="Kit_Colour" HeaderText="Kit Colour" SortExpression="Kit_Colour" Visible="false"></asp:BoundField>
                <asp:BoundField DataField="ContactName" HeaderText="Contact Name" SortExpression="ContactName" ></asp:BoundField>
                <asp:BoundField DataField="ContactNumber" HeaderText="Contact Number" SortExpression="ContactNumber" Visible="false"></asp:BoundField>
                <asp:BoundField DataField="Fee" HeaderText="Fee" SortExpression="Fee"></asp:BoundField>
                <asp:BoundField DataField="Paid" HeaderText="Paid" SortExpression="Paid" Visible="false"></asp:BoundField>
                <asp:BoundField DataField="Confirmation" HeaderText="Confirmation payment received (yes/no)" SortExpression="Confirmation" Visible="false"></asp:BoundField>
            </Columns>
        </asp:GridView>
            </p>
        
        <asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString='<%$ ConnectionStrings:BenhurstConnectionString %>' SelectCommand="SELECT Payments.PayID, Attendance.PlayerRegistrationNo, users.Forename, users.Surname, Session.SessionID, Session.TypeOfSession, Session.Date, Session.Time, Session.LocationID, Session.Opponent, Session.Kit_Colour, Session.ContactName, Session.ContactNumber, Payments.Fee, Payments.Paid, Payments.Confirmation FROM Attendance INNER JOIN Payments ON Attendance.AttendanceID = Payments.AttendanceID INNER JOIN Session ON Attendance.SessionID = Session.SessionID LEFT OUTER JOIN users ON Attendance.PlayerRegistrationNo = users.PlayerRegistrationNo WHERE Payments.Confirmation = 'yes'"></asp:SqlDataSource>
    
    </div>

        <div>
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
