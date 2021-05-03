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
    public partial class PAnnouncements : System.Web.UI.Page
    {
        public string conString = "Data Source=DESKTOP-8SAN538;Initial Catalog=Benhurst;Integrated Security=True";
        public string current_user;
        protected void Page_Load(object sender, EventArgs e)
        {
            SqlConnection sqlCon = new SqlConnection(conString);
            sqlCon.Open();

            if (sqlCon.State == System.Data.ConnectionState.Open)
            {
                string q1 = "SELECT username FROM users WHERE LoginStatus = 'yes'";
                SqlCommand cmd1 = new SqlCommand(q1, sqlCon);


                using (SqlDataReader dr = cmd1.ExecuteReader())
                {
                    while (dr.Read())
                    {
                        current_user = dr[0].ToString();
                    }
                }
                loggedin.Text = "You are currently logged in as: " + current_user;
                if (current_user == null)
                {
                    Response.Redirect("http://localhost:62696/Login.aspx");
                }
            }
        }
        protected void Logout_Click(object sender, EventArgs e)
        {
            SqlConnection sqlCon = new SqlConnection(conString);
            sqlCon.Open();
            if (sqlCon.State == System.Data.ConnectionState.Open)
            {

                string q2 = "UPDATE users SET LoginStatus = 'no' WHERE username = '" + current_user + "'";
                SqlCommand cmd2 = new SqlCommand(q2, sqlCon);
                using (SqlDataReader dr = cmd2.ExecuteReader())
                {
                    /*  while (dr.Read())
                      {
                          pass_check = dr[0].ToString();
                      }*/

                }
                Response.Redirect("http://localhost:62696/Login.aspx");


            }
        }

    }
}