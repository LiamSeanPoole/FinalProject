<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MAttendance.aspx.cs" Inherits="BenhurstV3.MAttendance" %>
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


        <h2>Attendance</h2>
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
            
            <h3>Previous Sessions</h3>
            <div class="table-container">
                <p>
                
                    <asp:GridView runat="server" AutoGenerateColumns="False" DataKeyNames="SessionID" DataSourceID="SqlDataSource2">
                        <Columns>
                            <asp:BoundField DataField="SessionID" HeaderText="Session Number" ReadOnly="True" SortExpression="SessionID"></asp:BoundField>
                            <asp:BoundField DataField="TypeOfSession" HeaderText="Fixture/Training" SortExpression="TypeOfSession"></asp:BoundField>
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
                    <asp:SqlDataSource runat="server" ID="SqlDataSource2" ConnectionString='<%$ ConnectionStrings:BenhurstConnectionString %>' SelectCommand="SELECT [SessionID], [TypeOfSession], [Date], [Time], [LocationID], [Opponent], [Kit_Colour], [ContactName], [ContactNumber], [Fee] FROM [Session] WHERE [Date] <= getdate() ORDER BY [Date]"></asp:SqlDataSource>
                </p>
            </div>
                </div>
        <fieldset>
                <legend>Select a session to mark which players attended</legend>
                <label>
                Select a Session
                    <asp:DropDownList ID="Session_ddl" runat="server" DataSourceID="SqlDataSource1" DataTextField="SessionID" DataValueField="SessionID"></asp:DropDownList>

                <asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString='<%$ ConnectionStrings:BenhurstConnectionString %>' SelectCommand="SELECT [SessionID], [TypeOfSession], [Date], [Time], [LocationID], [Opponent], [Kit_Colour], [ContactName], [ContactNumber], [Fee] FROM [Session] WHERE [Date] <= getdate() ORDER BY [Date]"></asp:SqlDataSource>
                
            </label>
            
            <asp:Button ID="submit_btn" runat="server" OnClick="Submit_Click" Text="Submit" />
            </fieldset>
        
                <div class="table-container">
            <p>
            <asp:GridView ID="ava_list" runat="server"  AutoGenerateColumns="False" DataKeyNames="AvailabilityID, PlayerRegistrationNo" OnRowEditing="ses_list_RowEditing" OnRowUpdating="ses_list_RowUpdating" OnPageIndexChanging="ses_list_PageIndexChanging" OnRowCancelingEdit="ses_list_RowCancelingEdit">
                <Columns>
                    <asp:BoundField DataField="AvailabilityID" HeaderText="AvailabilityID" ReadOnly="true" SortExpression="AvailabilityID" visible="false"></asp:BoundField>
                    <asp:BoundField DataField="SessionID" HeaderText="SessionID" SortExpression="SessionID" ReadOnly="true"></asp:BoundField>
                    <asp:BoundField DataField="PlayerRegistrationNo" HeaderText="PlayerRegistrationNo" SortExpression="PlayerRegistrationNo" ReadOnly="true"></asp:BoundField>
                    <asp:BoundField DataField="Forename" HeaderText="Forename" SortExpression="Forename" ReadOnly="true"></asp:BoundField>
                    <asp:BoundField DataField="Surname" HeaderText="Surname" SortExpression="Surname" ReadOnly="true"></asp:BoundField>
                    <asp:BoundField DataField="Decision" HeaderText="Decision" SortExpression="Decision" ReadOnly="true" Visible="false"></asp:BoundField>
                    <asp:BoundField DataField="Acceptance" HeaderText="Acceptance" SortExpression="Acceptance" ReadOnly="true" Visible="false"></asp:BoundField>
                    <asp:BoundField DataField="Attended" HeaderText="Did the Player Attend? (yes/no)" SortExpression="Attended" ></asp:BoundField>
                    <asp:CommandField ShowEditButton="true" />
                </Columns>
            </asp:GridView>
                </p>

            <asp:SqlDataSource runat="server" ID="PAvaconn" ConnectionString='<%$ ConnectionStrings:BenhurstConnectionString %>' SelectCommand="SELECT Availability.AvailabilityID, Availability.SessionID, Availability.PlayerRegistrationNo, users.Forename, users.Surname, Availability.Decision, Availability.Acceptance, Availability.Attended FROM Availability INNER JOIN users ON Availability.PlayerRegistrationNo = users.PlayerRegistrationNo"></asp:SqlDataSource>
        </div>
        <asp:Label ID="error_lbl" runat="server"></asp:Label>
        <h3>Click below to confirm player attendance</h3>
        <asp:Button ID="issue_pay_btn" runat="server" OnClick="Payment_Click" Text="confirm" />
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
