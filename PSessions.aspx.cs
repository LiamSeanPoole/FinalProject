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
    public partial class PSessions : System.Web.UI.Page
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

        protected void Submit_Click(object sender, EventArgs e)
        {
            SqlConnection sqlCon = new SqlConnection(conString);
            sqlCon.Open();
            if (sqlCon.State == System.Data.ConnectionState.Open)
            {
                string q3 = "SELECT PlayerRegistrationNo FROM users WHERE username = '" + current_user + "'";
                SqlCommand cmd3 = new SqlCommand(q3, sqlCon);
                int reg_no = Convert.ToInt32(cmd3.ExecuteScalar());

                string q4 = "SELECT MAX(AvailabilityID) FROM Availability";
                SqlCommand cmd4 = new SqlCommand(q4, sqlCon);
                int maxID = Convert.ToInt32(cmd4.ExecuteScalar());
                maxID += 1;

                string decision = "yes";

                string q5 = "INSERT INTO Availability (AvailabilityID, SessionID, PlayerRegistrationNo, Decision) Values ('" + maxID + "','" + Session_ddl.SelectedValue + "','" + reg_no + "','" + decision + "')";
                SqlCommand cmd5 = new SqlCommand(q5, sqlCon);
                SqlDataReader dr = cmd5.ExecuteReader();
                Response.Redirect("http://localhost:62696/PSessions.aspx");
            }
        }

    }
}
