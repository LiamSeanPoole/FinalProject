<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MSessions.aspx.cs" Inherits="BenhurstV3.MSessions" %>
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
            <legend>Enter new location (if required)</legend>
            <label>
                Name
                <asp:TextBox ID="locname" runat="server" MaxLength="50"></asp:TextBox>
                <asp:RegularExpressionValidator runat="server" ErrorMessage="Maximum 50 characters" ControlToValidate="locname" 
ValidationExpression="^.{1,50}$" ></asp:RegularExpressionValidator>
            </label>
            <label>
                Address Line 1
                <asp:TextBox ID="Add1" runat="server" MaxLength="50"></asp:TextBox>
                <asp:RegularExpressionValidator runat="server" ErrorMessage="Maximum 50 characters" ControlToValidate="Add1" 
ValidationExpression="^.{1,50}$" ></asp:RegularExpressionValidator>
            </label>
            <label>
                Address Line 2
                <asp:TextBox ID="Add2" runat="server" MaxLength="50"></asp:TextBox>
                <asp:RegularExpressionValidator runat="server" ErrorMessage="Maximum 50 characters" ControlToValidate="Add2" 
ValidationExpression="^.{1,50}$" ></asp:RegularExpressionValidator>
            </label>
            <label>
                Address Line 3 
                <asp:TextBox ID="Add3" runat="server" MaxLength="50"></asp:TextBox>
                <asp:RegularExpressionValidator runat="server" ErrorMessage="Maximum 50 characters" ControlToValidate="Add3" 
ValidationExpression="^.{1,50}$" ></asp:RegularExpressionValidator>
            </label>
            <label>
                Postcode
                <asp:TextBox ID="post" runat="server" MaxLength="10"></asp:TextBox>
                <asp:RegularExpressionValidator runat="server" ErrorMessage="Maximum 10 characters" ControlToValidate="post" 
ValidationExpression="^.{1,10}$" ></asp:RegularExpressionValidator>
            </label>
            <p>
              <asp:Button ID="SubmitLoc" runat="server" OnClick="SubmitLoc_Click" Text="Submit"/>  
            </p>
                </fieldset>
        </div>
        <div>
            <fieldset>
                <legend>Create session</legend>
            
            <label>
                Type of Session
                <asp:DropDownList ID="Session" runat="server">
                    <asp:ListItem>Training</asp:ListItem>
                    <asp:ListItem>Fixture</asp:ListItem>
                </asp:DropDownList>
            </label>
            <label>
                Date
                <asp:TextBox ID="date" runat="server" type="date"></asp:TextBox>

            </label>
            <label>
                Time
                <asp:TextBox ID="Time" runat="server" type="time"></asp:TextBox>
            </label>
            <label>
                Location
               <asp:DropDownList ID="location_ddl" runat="server" DataSourceID="SqlDataSource1" DataTextField="LocationID" DataValueField="LocationID"></asp:DropDownList>

                <asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString='<%$ ConnectionStrings:BenhurstConnectionString %>' SelectCommand="SELECT [LocationID], [AddressLine1], [Postcode] FROM [Location] ORDER BY [LocationID]"></asp:SqlDataSource>
            </label>
            <label>
                Opposition
                <asp:TextBox ID="opponent" runat="server" MaxLength="50"></asp:TextBox>
                <asp:RegularExpressionValidator runat="server" ErrorMessage="Maximum 50 characters" ControlToValidate="opponent" 
ValidationExpression="^.{1,50}$" ></asp:RegularExpressionValidator>
            </label>
            <label>
                Kit Colour
                <asp:DropDownList ID="kit" runat="server">
                    <asp:ListItem>Blue and White</asp:ListItem>
                    <asp:ListItem>Red and Black</asp:ListItem>
                </asp:DropDownList>
            </label>
            <label>
                Contact Name
                <asp:TextBox ID="cname" runat="server" MaxLength="50"></asp:TextBox>
                <asp:RegularExpressionValidator runat="server" ErrorMessage="Maximum 50 characters" ControlToValidate="cname" 
ValidationExpression="^.{1,50}$" ></asp:RegularExpressionValidator>
            </label>
            <label>
                Contact Number
                <asp:TextBox ID="cnumber" runat="server" MaxLength="12"></asp:TextBox>
                <asp:RegularExpressionValidator runat="server" ErrorMessage="Only characters allowed, maximum 12 characters" ControlToValidate="cnumber" 
ValidationExpression="^\w+( \w+)*$" ></asp:RegularExpressionValidator>
            </label>
            <label>
                Fee £
                <asp:TextBox ID="Fee" runat="server" MaxLength="9"></asp:TextBox>
                <asp:RegularExpressionValidator runat="server" ErrorMessage="Invalid Entry, Maximum 9 characters" ControlToValidate="Fee" 
ValidationExpression="^[0-9]*$" ForeColor="Red" ></asp:RegularExpressionValidator>
            </label>
            <p>
              <asp:Button ID="SubmitSes" runat="server" OnClick="SubmitSes_Click" Text="Submit"/>  
            </p>
                </fieldset>
            </div>
        
        <div>
            
            <h3>Upcoming Sessions</h3>
            <div class="table-container">
                <p>
                
            <asp:GridView ID="gvses" AlternatingRowStyle-CssClass="table-container" runat="server" AutoGenerateColumns="False" DataKeyNames="SessionID" OnRowDeleting="ses_list_RowDeleting" OnRowEditing="ses_list_RowEditing" OnRowUpdating="ses_list_RowUpdating" OnPageIndexChanging="ses_list_PageIndexChanging" OnRowCancelingEdit="ses_list_RowCancelingEdit">
                <Columns>
                    <asp:BoundField DataField="SessionID" HeaderText="Session Number" SortExpression="SessionID" ReadOnly="True"> </asp:BoundField>
                    <asp:BoundField DataField="TypeOfSession" HeaderText="Fixture/Training" SortExpression="TypeOfSession"></asp:BoundField>
                    <asp:BoundField DataField="Date" HeaderText="Date" SortExpression="Date" DataFormatString="{0:dd/MM/yyyy}"></asp:BoundField>
                    <asp:BoundField DataField="Time" HeaderText="Time" SortExpression="Time"></asp:BoundField>
                    <asp:BoundField DataField="LocationID" HeaderText="LocationID" SortExpression="LocationID" ></asp:BoundField>
                    <asp:BoundField DataField="Opponent" HeaderText="Opponent" SortExpression="Opponent"></asp:BoundField>
                    <asp:BoundField DataField="Kit_Colour" HeaderText="Kit Colour" SortExpression="Kit_Colour"></asp:BoundField>
                    <asp:BoundField DataField="ContactName" HeaderText="Contact Name" SortExpression="ContactName"></asp:BoundField>
                    <asp:BoundField DataField="ContactNumber" HeaderText="Contact Number" SortExpression="ContactNumber"></asp:BoundField>
                    <asp:BoundField DataField="Fee" HeaderText="Fee" SortExpression="Fee"></asp:BoundField>
                    <asp:CommandField ShowEditButton="true" />  
                    <asp:CommandField ShowDeleteButton="true" />
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource runat="server" ID="SqlDataSource2" ConnectionString='<%$ ConnectionStrings:BenhurstConnectionString %>' SelectCommand="SELECT [SessionID], [TypeOfSession], [Date], [Time], [LocationID], [Opponent], [Kit_Colour], [ContactName], [ContactNumber], [Fee] FROM [Session] WHERE [Date] >= getdate() ORDER BY [Date]"></asp:SqlDataSource>
            </p>
            </div>
                </div>
        <asp:Label ID="error_lbl" runat="server"></asp:Label>
        
    </form>
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
</body>
</html>
