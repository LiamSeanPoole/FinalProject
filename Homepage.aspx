<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Homepage.aspx.cs" Inherits="BenhurstV3.Homepage" %>
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


        <h2>BENHURST UNITED</h2>
     <nav class="menu">
    <form id="form1" runat="server">
        <ul>
        <li><a href="homepage.aspx">Homepage</a></li>
            <li><a href="Contact.aspx">Contact</a></li>
		<li><a href="Login.aspx">Login</a></li>
            </ul>
        </nav>
        <div>
            <h3>Who are Benhurst United?</h3>
            <p>Benhurst United (Nicknamed the Pandas) is a Sunday League Football Club who competes in the 5th Division of the Orpington & Bromley Sunday Football League. Please click on the badge below for more details on the League including League Table, League Fixtures and results. </p><a href="https://fulltime-league.thefa.com/displayTeam.html?divisionseason=869758076&teamID=296986300">
                      <p>  <img src="images/league.png" class="in_social_media" id="in_yt" alt="League"/></p>
                    </a>
            <h3>What are the Origins of Benhurst United?</h3>
            <p>Benhurst United was established in 2019, by the owner and manager Ryan Fellows. The team consists of players who are friends, family and ex 5 a side teammates.</p>
            <h3>Recent Results</h3>

            <asp:GridView AlternatingRowStyle-CssClass="table-container" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1">
                <Columns>
                    <asp:BoundField DataField="Benhurst_Goals" HeaderText="Benhurst" SortExpression="Benhurst_Goals"></asp:BoundField>
                    <asp:BoundField DataField="Opposition_Goals" HeaderText="Opposition" SortExpression="Opposition_Goals"></asp:BoundField>
                    <asp:BoundField DataField="Opponent" HeaderText="Opponent" SortExpression="Opponent"></asp:BoundField>
                    <asp:BoundField DataField="Date" HeaderText="Date" SortExpression="Date" DataFormatString="{0:dd/MM/yyyy}"></asp:BoundField>
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString='<%$ ConnectionStrings:BenhurstConnectionString %>' SelectCommand="SELECT Result.Benhurst_Goals, Result.Opposition_Goals, Session.Opponent, Session.Date FROM Result INNER JOIN Session ON Result.SessionID = Session.SessionID WHERE Result.Benhurst_Goals IS NOT NULL ORDER BY Session.Date DESC"></asp:SqlDataSource>
            <h3>Where does Benhurst United play?</h3>
            <p>Benhurst United train in a variety of locations in and around the Sesldon area (South Croydon). 
             Their current home pitch is: Norman Park, Hayes Lane, BR2 9EF.</p>
            
    <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d2489.8193748086182!2d0.02407821576558759!3d51.387997679615665!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x47d8aa60d779a7d7%3A0x177290fb3f8f0b02!2sNorman%20Park!5e0!3m2!1sen!2suk!4v1618824724198!5m2!1sen!2suk" width="600" height="450" style="border:0;" allowfullscreen="" loading="lazy"></iframe>
   <h3>Can I join Benhurst United?</h3>
            <p>Benhurst United is always on the look out for adding new players, please click on our contact link at the top of the page and fill in a submission. Alternatively, you can also contact us on our social media pages which can be found at the bottom of the screen (Twitter and Instagram)</p>
        </div>
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
