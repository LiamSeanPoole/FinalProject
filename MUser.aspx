<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MUser.aspx.cs" Inherits="BenhurstV3.MUser" %>
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


        <h2>Manage Your Users</h2>
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
    
        <fieldset>
        <legend>Create User</legend>
        
        <div>
            <label>Email Address
                <asp:TextBox ID="email" runat="server" AutoComplete="off" MaxLength="100" ></asp:TextBox>
                <asp:RegularExpressionValidator runat="server" ErrorMessage="Invalid Email Address, maximum 100 characters" ControlToValidate="email" 
ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ForeColor="Red" ></asp:RegularExpressionValidator>
            </label>
            <label>Type of User 
                <asp:DropDownList ID="User" runat="server">
                    <asp:ListItem>Player</asp:ListItem>
                    <asp:ListItem>Manager</asp:ListItem>
                </asp:DropDownList>
            </label>
            <label>
                Password
                <asp:TextBox ID="password" runat="server" value="password" AutoComplete="off" MaxLength="50"></asp:TextBox>
                <asp:RegularExpressionValidator runat="server" ErrorMessage="Invalid Password, Maximum 50 characters" ControlToValidate="password" 
ValidationExpression="^.{1,255}$" ForeColor="Red" ></asp:RegularExpressionValidator>
            </label>
            <label>
                Forename
                <asp:TextBox ID="forename" runat="server" MaxLength="50"></asp:TextBox>
                <asp:RegularExpressionValidator runat="server" ErrorMessage="Invalid Entry, Maximum 50 characters" ControlToValidate="forename" 
ValidationExpression="^[A-Za-z]*$" ForeColor="Red" ></asp:RegularExpressionValidator>
            </label>
            <label>
                Surname
                <asp:TextBox ID="surname" runat="server" MaxLength="50"></asp:TextBox>
                <asp:RegularExpressionValidator runat="server" ErrorMessage="Invalid Entry, Maximum 50 characters" ControlToValidate="surname" 
ValidationExpression="^[A-Za-z]*$" ForeColor="Red" ></asp:RegularExpressionValidator>
            </label>
            <label>
                Date of Birth 
                <asp:TextBox ID="DOB" runat="server" type="date"></asp:TextBox>
            </label>
            <label>
                Contact Number
                <asp:TextBox ID="contact" runat="server" MaxLength="12"></asp:TextBox>
                <asp:RegularExpressionValidator runat="server" ErrorMessage="Invalid Entry, Maximum 12 characters" ControlToValidate="contact" 
ValidationExpression="^[0-9]*$" ForeColor="Red" ></asp:RegularExpressionValidator>
            </label>
            <label>
                Player Registration Number
                <asp:TextBox ID="PlayerRegistrationNo" runat="server" MaxLength="9"></asp:TextBox>
                <asp:RegularExpressionValidator runat="server" ErrorMessage="Invalid Entry, Maximum 9 characters" ControlToValidate="PlayerRegistrationNo" 
ValidationExpression="^[0-9]*$" ForeColor="Red" ></asp:RegularExpressionValidator>
            </label>
            <p>
              <asp:Button ID="SubmitUser" runat="server" OnClick="SubmitUser_Click" Text="Create User"/>  
            </p>
            </fieldset>
            <div>
                <fieldset>
                <legend>Search User</legend>
                <label>Username
                    <asp:TextBox ID="user_search_txt" runat="server" MaxLength="100"></asp:TextBox>
                    <asp:RegularExpressionValidator runat="server" ErrorMessage="Invalid Email Address, maximum 100 characters" ControlToValidate="user_search_txt" 
ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ForeColor="Red" ></asp:RegularExpressionValidator>
                    <p><asp:Button ID="user_search_btn" runat="server" OnClick="User_Search_Click" Text="Search"/></p>
                </label>
                <label>Access
                    <asp:TextBox ID="access_search_txt" runat="server" MaxLength="50"></asp:TextBox>
                    <asp:RegularExpressionValidator runat="server" ErrorMessage="Invalid Access, maximum 50 characters" ControlToValidate="access_search_txt" 
ValidationExpression="^\w+( \w+)*$" ></asp:RegularExpressionValidator>
                    <p><asp:Button ID="access_search_btn" runat="server" OnClick="Access_Search_Click" Text="Search"/></p>
                </label>
                <label>Forename
                    <asp:TextBox ID="fore_search_txt" runat="server" MaxLength="50"></asp:TextBox>
                    <asp:RegularExpressionValidator runat="server" ErrorMessage="Invalid Entry, Maximum 50 characters" ControlToValidate="fore_search_txt" 
ValidationExpression="^[A-Za-z]*$" ForeColor="Red" ></asp:RegularExpressionValidator>
                    <p><asp:Button ID="fore_search_btn" runat="server" OnClick="Fore_Search_Click" Text="Search"/></p>
                </label>
                <label>Surname
                    <asp:TextBox ID="sur_search_txt" runat="server" MaxLength="50"></asp:TextBox>
                    <asp:RegularExpressionValidator runat="server" ErrorMessage="Invalid Entry, Maximum 50 characters" ControlToValidate="sur_search_txt" 
ValidationExpression="^[A-Za-z]*$" ForeColor="Red" ></asp:RegularExpressionValidator>
                    <p><asp:Button ID="sur_search_btn" runat="server" OnClick="Sur_Search_Click" Text="Search"/></p>
                </label>
                <label>Player Registration Number
                    <asp:TextBox ID="regNo_search_txt" runat="server" MaxLength="9"></asp:TextBox>
                     <asp:RegularExpressionValidator runat="server" ErrorMessage="Invalid Entry, Maximum 9 characters" ControlToValidate="regNo_search_txt" 
ValidationExpression="^[0-9]*$" ForeColor="Red" ></asp:RegularExpressionValidator>
                    <p>
                    <asp:Button ID="regNo_search_btn" runat="server" OnClick="RegNo_Search_Click" Text="Search"/>
                        </p>
                </label>
                    </fieldset>
            </div>

            <div class="table-container">
            <p>
            <asp:GridView AlternatingRowStyle-CssClass="table-container" ID="user_list" runat="server" AutoGenerateColumns="false" DataKeyNames="username" OnRowDeleting="user_list_RowDeleting" OnRowEditing="user_list_RowEditing" OnRowUpdating="user_list_RowUpdating" OnPageIndexChanging="user_list_PageIndexChanging" OnRowCancelingEdit="user_list_RowCancelingEdit" >
                <Columns>
                    <asp:BoundField DataField="username" HeaderText="Email/Username" ReadOnly="True" SortExpression="username"></asp:BoundField>
                    <asp:BoundField DataField="password" HeaderText="Password" SortExpression="password"></asp:BoundField>
                    <asp:BoundField DataField="Access" HeaderText="Player/Manager" SortExpression="Access"></asp:BoundField>
                    <asp:BoundField DataField="Forename" HeaderText="Forename" SortExpression="Forename"></asp:BoundField>
                    <asp:BoundField DataField="Surname" HeaderText="Surname" SortExpression="Surname"></asp:BoundField>
                    <asp:BoundField DataField="DOB" HeaderText="Date Of Birth" SortExpression="DOB" DataFormatString="{0:dd/MM/yyyy}"></asp:BoundField>
                    <asp:BoundField DataField="ContactNo" HeaderText="Contact Number" SortExpression="ContactNo"></asp:BoundField>
                    <asp:BoundField DataField="PlayerRegistrationNo" HeaderText="Player Registration Number" SortExpression="PlayerRegistrationNo"></asp:BoundField>
                    <asp:CommandField ShowEditButton="true" />  
                    <asp:CommandField ShowDeleteButton="true" />
                </Columns>
            </asp:GridView>


            <asp:SqlDataSource runat="server" ID="SqlDataSource2" ConnectionString='<%$ ConnectionStrings:BenhurstConnectionString %>' SelectCommand="SELECT [username], [password], [Access], [Forename], [Surname], [DOB], [ContactNo], [PlayerRegistrationNo] FROM [users] ORDER BY [Surname]"></asp:SqlDataSource>
            <asp:SqlDataSource runat="server" ID="SqlDataSource1"></asp:SqlDataSource>
            
                </p>
                </div>
        <asp:Label ID ="error_lbl" runat="server"></asp:Label>
                

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

