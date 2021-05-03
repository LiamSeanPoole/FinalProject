using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Threading.Tasks;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Security.Principal;

namespace BenhurstV3
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ValidationSettings.UnobtrusiveValidationMode = UnobtrusiveValidationMode.None;
        }

        public string conString = "Data Source=DESKTOP-8SAN538;Initial Catalog=Benhurst;Integrated Security=True";
        public string user_check;
        public string pass_check;
        public string access_check;
        public string status_check;
        protected void Button1_Click(object sender, EventArgs e)
        {
            SqlConnection sqlCon = new SqlConnection(conString);
            sqlCon.Open();

            if(sqlCon.State==System.Data.ConnectionState.Open)
            {
                string q1 = "SELECT username FROM users WHERE username = '"+TextBox1.Text+"'";
                SqlCommand cmd1 = new SqlCommand(q1, sqlCon);
                

                using(SqlDataReader dr = cmd1.ExecuteReader())
                {
                    while(dr.Read())
                    {
                        user_check = dr[0].ToString();
                    }
                }

                Label1.Text = user_check;
                
                string q2 = "SELECT password FROM users WHERE password = '" + TextBox2.Text + "'";
                SqlCommand cmd2 = new SqlCommand(q2, sqlCon);
               

                using (SqlDataReader dr = cmd2.ExecuteReader())
                {
                    while (dr.Read())
                    {
                        pass_check = dr[0].ToString();
                    }
                }

                Label2.Text = pass_check;

                if (user_check != null && pass_check != null)
                {
                    string q4 = "UPDATE users SET LoginStatus = 'yes' WHERE username = '" + TextBox1.Text + "' AND password = '" + TextBox2.Text + "'";
                    SqlCommand cmd4 = new SqlCommand(q4, sqlCon);


                    using (SqlDataReader dr = cmd4.ExecuteReader())
                    {
                        while (dr.Read())
                        {
                            status_check = dr[0].ToString();
                        }
                    }
                    string q3 = "SELECT Access FROM users WHERE username = '" + TextBox1.Text + "' AND password = '" + TextBox2.Text + "'";
                    SqlCommand cmd3 = new SqlCommand(q3, sqlCon);
                   

                    using (SqlDataReader dr = cmd3.ExecuteReader())
                    {
                        while (dr.Read())
                        {
                            access_check = dr[0].ToString();
                        }
                    }



                    Label3.Text = access_check;

                    string player = "Player";
                    string manager = "Manager";

                    if (access_check != null && access_check.Equals(player))
                    {

                        Response.Redirect("http://localhost:62696/Playerhomepage.aspx");
                    }
                    else if (access_check != null && access_check.Equals(manager))
                    {

                        Response.Redirect("http://localhost:62696/Managerhomepage.aspx");
                    }
                    else
                    {
                        Label1.Text = "Invalid login details please try again";
                        Label2.Text = "";
                        TextBox1.Text = string.Empty;
                        TextBox2.Text = string.Empty;
                    }
                }
                else
                {
                    Label1.Text = "Invalid login details please try again";
                    Label2.Text = "";
                    TextBox1.Text = string.Empty;
                    TextBox2.Text = string.Empty;
                }
            }
        }
    }
}