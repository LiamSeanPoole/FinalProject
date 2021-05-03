 <%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="BenhurstV3.Contact" %>
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


        <h2>Contact</h2>
     <nav class="menu">
    <form id="form1" runat="server">
        <ul>
        <li><a href="homepage.aspx">Homepage</a></li>
            <li><a href="Contact.aspx">Contact</a></li>
		<li><a href="Login.aspx">Login</a></li>
            </ul>
        
        
        </nav>
    <fieldset>
<legend>Please fill in the below information to register your interest in joining the club</legend>

               <label for="name">Name <em>(required)</em> </label>
<asp:TextBox runat="server" type="text" id="name" AutoComplete="off" MaxLength="100" required/>
        <asp:RegularExpressionValidator runat="server" ErrorMessage="Only characters allowed, maximum 100 characters" ControlToValidate="name" 
ValidationExpression="^\w+( \w+)*$" ForeColor="Red"></asp:RegularExpressionValidator>
<label for="email">Email address</label>
<asp:TextBox runat="server" type="text"  id="email" AutoComplete="off" MaxLength="100"/>
        <asp:RegularExpressionValidator runat="server" ErrorMessage="Incorrect Email, Maximum 100 characters" ForeColor="Red" ControlToValidate="email" 
ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ></asp:RegularExpressionValidator>
               <label for="Phonenumber">Phone Number</label>
<asp:TextBox runat="server"  id="Phonenumber" AutoComplete="off" MaxLength="12"/>
        <asp:RegularExpressionValidator runat="server" ErrorMessage="Only characters allowed, maximum 12 characters" ForeColor="Red" ControlToValidate="Phonenumber" 
ValidationExpression="^\w+( \w+)*$" ></asp:RegularExpressionValidator>

        
              <label for="DOB"> Date of Birth<asp:TextBox ID="date" runat="server" type="date" DataFormatString="{0:dd/MM/yyyy}"></asp:TextBox></label>
             

 <legend>Reason why you want to join Benhurst United <em>(required)</em></legend>
  <asp:TextBox runat="server" id="message" AutoComplete="off" MaxLength="500" required></asp:TextBox>
        <asp:RegularExpressionValidator runat="server" ErrorMessage="Maximum 500 characters" ForeColor="Red" ControlToValidate="Phonenumber" 
ValidationExpression="^.{1,500}$" ></asp:RegularExpressionValidator>
        <p></p>
 <asp:Button ID="send" runat="server" OnClick="send_Click" Text="Click to request" />
</fieldset>  

           
       
            

    </form>
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
</body>
</html>
