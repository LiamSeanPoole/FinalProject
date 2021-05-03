<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="BenhurstV3.WebForm1" %>
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


        <h2>Login</h2>
     <nav class="menu">
    <form id="form1" runat="server">
        <ul>
        <li><a href="homepage.aspx">Homepage</a></li>
            <li><a href="Contact.aspx">Contact</a></li>
		<li><a href="Login.aspx">Login</a></li>
            </ul>
        </nav>
       
        <p>
            Username: <asp:TextBox ID="TextBox1" runat="server" AutoComplete="off" MaxLength="100"></asp:TextBox>
            <asp:RegularExpressionValidator runat="server" ErrorMessage="Invalid Username, maximum 100 characters" ControlToValidate="TextBox1" 
ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ></asp:RegularExpressionValidator>
        </p>
        <p>
            Password: <asp:TextBox ID="TextBox2" runat="server" AutoComplete="off" TextMode="Password" MinLength="5" MaxLength="50"></asp:TextBox>
            <asp:RegularExpressionValidator runat="server" ErrorMessage="Invalid Password, Maximum 50 characters" ControlToValidate="TextBox2" 
ValidationExpression="^.{1,50}$" ></asp:RegularExpressionValidator>
        </p>
        <p>
            <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Submit" />
        </p>
        <asp:Label ID="Label1" runat="server"></asp:Label>
        <br />
        <br />
        <asp:Label ID="Label2" runat="server"></asp:Label>
        <p>
            <asp:Label ID="Label3" runat="server"></asp:Label>
        </p>
    </form>
</body>
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
</html>
