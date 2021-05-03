<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PSessions.aspx.cs" Inherits="BenhurstV3.PSessions" %>
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


        <h2>Sessions</h2>
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
            <fieldset>
                <legend>Register for a session</legend>
                <label>
                Select a Session
                    <asp:DropDownList ID="Session_ddl" runat="server" DataSourceID="SqlDataSource1" DataTextField="SessionID" DataValueField="SessionID"></asp:DropDownList>

                <asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString='<%$ ConnectionStrings:BenhurstConnectionString %>' SelectCommand="SELECT [SessionID], [TypeOfSession], [Date], [Time], [LocationID], [Opponent], [Kit_Colour], [ContactName], [ContactNumber], [Fee] FROM [Session] WHERE [Date] >= getdate() ORDER BY [Date]"></asp:SqlDataSource>
                
            </label>
            <asp:Button ID="submit_btn" runat="server" OnClick="Submit_Click" Text="Submit" />
            </fieldset>
            
       <h3>Upcoming Sessions</h3>
            <div class="table-container">
                <p>
                
                    <asp:GridView runat="server" AutoGenerateColumns="False" DataKeyNames="SessionID" DataSourceID="Psessionsconn">
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
                    <asp:SqlDataSource runat="server" ID="Psessionsconn" ConnectionString='<%$ ConnectionStrings:BenhurstConnectionString %>' SelectCommand="SELECT [SessionID], [TypeOfSession], [Date], [Time], [LocationID], [Opponent], [Kit_Colour], [ContactName], [ContactNumber], [Fee] FROM [Session] WHERE [Date] >= getdate() ORDER BY [Date]">

                    </asp:SqlDataSource>
                    </div>
                </p>
                <h3>Sessions registered for</h3>
                <div class="table-container">
            <p>
            <asp:GridView runat="server" DataSourceID="Psessconn" AutoGenerateColumns="False" DataKeyNames="SessionID,username">
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
                    <asp:BoundField DataField="Decision" HeaderText="Registered Interest" SortExpression="Decision"></asp:BoundField>
                    <asp:BoundField DataField="username" HeaderText="username" ReadOnly="True" SortExpression="username" Visible ="false"></asp:BoundField>
                </Columns>
            </asp:GridView>
                </p>

            <asp:SqlDataSource runat="server" ID="Psessconn" ConnectionString='<%$ ConnectionStrings:BenhurstConnectionString %>' SelectCommand="SELECT Session.SessionID, Session.TypeOfSession, Session.Date, Session.Time, Session.LocationID, Session.Opponent, Session.Kit_Colour, Session.ContactName, Session.ContactNumber, Session.Fee, Availability.Decision, users.username FROM Session INNER JOIN Availability ON Session.SessionID = Availability.SessionID INNER JOIN users ON Availability.PlayerRegistrationNo = users.PlayerRegistrationNo WHERE (Session.Date >= GETDATE()) AND (users.LoginStatus = 'yes') ORDER BY Session.Date"></asp:SqlDataSource>
        </div>

             
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
