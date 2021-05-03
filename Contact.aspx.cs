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
using System.Windows.Forms;

namespace BenhurstV3
{
    
    public partial class Contact : System.Web.UI.Page
    {
        string complete = "You have submitted a request to join Benhurst United";
        
        public string conString = "Data Source=DESKTOP-8SAN538;Initial Catalog=Benhurst;Integrated Security=True";
        protected void Page_Load(object sender, EventArgs e)
        {
            ValidationSettings.UnobtrusiveValidationMode = UnobtrusiveValidationMode.None;
        }
        protected void send_Click(object sender, EventArgs e)
        {
            SqlConnection sqlCon = new SqlConnection(conString);
            sqlCon.Open();
            if (sqlCon.State == System.Data.ConnectionState.Open)
            {
                string q1 = "INSERT INTO Request (Name, Email, Contact_No, DOB, Reason) Values ('" + name.Text + "','" + email.Text + "','" + Phonenumber.Text + "','" + date.Text + "','" + message.Text + "')";
                SqlCommand cmd1 = new SqlCommand(q1, sqlCon);


                /*using (SqlDataReader dr = cmd1.ExecuteReader())
                {
                    while (dr.Read())
                    {
                        Update_check = dr[0].ToString();
                    }
                   
                }*/

                SqlDataReader dr = cmd1.ExecuteReader();
                dr.Close();

                
            }
            Response.Redirect("http://localhost:62696/Contact.aspx");
            
        }
    }
}