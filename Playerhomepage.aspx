<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Playerhomepage.aspx.cs" Inherits="BenhurstV3.Playerhompage" %>
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


        <h2>Player Homepage</h2>
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
            
        
        <div>
            
            <p>Welcome to the Player Homepage.</p>
    <p></p>
    <p>You now have access to the following pages</p>
    <ul>
        <li>Announcements
        </li>
        <li>Sessions</li>
        <li>Availability</li>
        <li>Payments</li>
        <li>Results and Statistics</li>
        
    </ul>
    <p>For more information on these pages and for some help regarding the website then please click "<a href ="userguide/PUserGuide.pdf">USER GUIDE</a>"</p>
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
