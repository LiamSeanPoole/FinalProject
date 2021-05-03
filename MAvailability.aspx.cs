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
using System.Configuration;
using System.Web.Security;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Text.RegularExpressions;

namespace BenhurstV3
{
    public partial class MAvailability : System.Web.UI.Page
    {
        public string conString = "Data Source=DESKTOP-8SAN538;Initial Catalog=Benhurst;Integrated Security=True";
        public string current_user;
        public string ddl_value;
        public string acc_input;
        protected void Page_Load(object sender, EventArgs e)
        {
            ValidationSettings.UnobtrusiveValidationMode = UnobtrusiveValidationMode.None;
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
        protected void grid_bind()
        {
            SqlConnection sqlCon = new SqlConnection(conString);
            sqlCon.Open();

            if (sqlCon.State == System.Data.ConnectionState.Open)
            {
                string q3 = "SELECT Availability.AvailabilityID, Availability.SessionID, Availability.PlayerRegistrationNo, users.Forename, users.Surname, Availability.Decision, Availability.Acceptance FROM Availability INNER JOIN users ON Availability.PlayerRegistrationNo = users.PlayerRegistrationNo";
                SqlCommand cmd3 = new SqlCommand(q3, sqlCon);
                SqlDataAdapter sda = new SqlDataAdapter(cmd3);
                DataSet sds = new DataSet();
                sda.Fill(sds);
                sqlCon.Close();

                if (sds.Tables[0].Rows.Count > 0)
                {
                    session_list.DataSource = sds;
                    session_list.DataBind();
                }
                else
                {
                    sds.Tables[0].Rows.Add(sds.Tables[0].NewRow());
                    session_list.DataSource = sds;
                    session_list.DataBind();
                    int numColumn = session_list.Rows[0].Cells.Count;
                    session_list.Rows[0].Cells.Clear();
                    session_list.Rows[0].Cells.Add(new TableCell());
                    session_list.Rows[0].Cells[0].ColumnSpan = numColumn;
                    session_list.Rows[0].Cells[0].Text = "Unable to find records";
                }
            }
        }

        protected void Submit_Click(object sender, EventArgs e)
        {
            SqlConnection sqlCon = new SqlConnection(conString);
            sqlCon.Open();

            if (sqlCon.State == System.Data.ConnectionState.Open)
            {
                using (SqlCommand cmd7 = new SqlCommand())
                {
                    string q7 = "SELECT Availability.AvailabilityID, Availability.SessionID, Availability.PlayerRegistrationNo, users.Forename, users.Surname, users.ContactNo, Availability.Decision, Availability.Acceptance FROM Availability INNER JOIN users ON Availability.PlayerRegistrationNo = users.PlayerRegistrationNo";
                    if (!string.IsNullOrEmpty(Session_ddl.SelectedItem.Text.Trim()))
                    {
                        q7 += " WHERE Availability.SessionID LIKE @SessionID + '%'";
                        cmd7.Parameters.AddWithValue("@SessionID", Session_ddl.SelectedItem.Text.Trim());
                    }
                    cmd7.CommandText = q7;
                    cmd7.Connection = sqlCon;

                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd7))
                    {
                        DataTable user_dt = new DataTable();
                        sda.Fill(user_dt);
                        session_list.DataSource = user_dt;
                        session_list.DataBind();
                    }
                }
            }
        }
        

        protected void ses_list_RowEditing(object sender, GridViewEditEventArgs e)
        {
            SqlConnection sqlCon = new SqlConnection(conString);
            sqlCon.Open();

            session_list.EditIndex = e.NewEditIndex;
            Console.WriteLine(session_list.EditIndex);
            grid_bind();

            if (sqlCon.State == System.Data.ConnectionState.Open)
            {
                using (SqlCommand cmd8 = new SqlCommand())
                {
                    string q8 = "SELECT Availability.AvailabilityID, Availability.SessionID, Availability.PlayerRegistrationNo, users.Forename, users.Surname, users.ContactNo, Availability.Decision, Availability.Acceptance FROM Availability INNER JOIN users ON Availability.PlayerRegistrationNo = users.PlayerRegistrationNo";
                    if (!string.IsNullOrEmpty(Session_ddl.SelectedItem.Text.Trim()))
                    {
                        q8 += " WHERE Availability.SessionID LIKE @SessionID + '%'";
                        cmd8.Parameters.AddWithValue("@SessionID", Session_ddl.SelectedItem.Text.Trim());
                    }
                    cmd8.CommandText = q8;
                    cmd8.Connection = sqlCon;

                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd8))
                    {
                        DataTable user_dt = new DataTable();
                        sda.Fill(user_dt);
                        session_list.DataSource = user_dt;
                        session_list.DataBind();
                    }
                }
            }
        }

        protected void ses_list_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            string availID_val = session_list.DataKeys[e.RowIndex].Value.ToString();
            GridViewRow gvrow = (GridViewRow)session_list.Rows[e.RowIndex];
            Label lbl_id = (Label)gvrow.FindControl("lblID");

            TextBox gvacc = (TextBox)gvrow.Cells[6].Controls[0];

            var accR = new Regex(@"^(?:Yes|No|yes|no)$");
            if (accR.IsMatch(gvacc.Text) || gvacc.Text == "")
            {
                acc_input = gvacc.Text;
            }
            else
            {

                error_lbl.Text += " Invalid Acceptance, please try again";
                acc_input = "";
            }

            session_list.EditIndex = -1;

            SqlConnection sqlCon = new SqlConnection(conString);
            sqlCon.Open();

            if (sqlCon.State == System.Data.ConnectionState.Open)
            {
               
                string q4 = "UPDATE Availability SET Acceptance = '" + acc_input + "' WHERE AvailabilityID = '" + availID_val + "'";
                SqlCommand cmd4 = new SqlCommand(q4, sqlCon);
                cmd4.ExecuteNonQuery();
                //sqlCon.Close();

               
            }
            grid_bind();
            if (sqlCon.State == System.Data.ConnectionState.Open)
            {
                using (SqlCommand cmd10 = new SqlCommand())
                {
                    string q10 = "SELECT Availability.AvailabilityID, Availability.SessionID, Availability.PlayerRegistrationNo, users.Forename, users.Surname, users.ContactNo, Availability.Decision, Availability.Acceptance FROM Availability INNER JOIN users ON Availability.PlayerRegistrationNo = users.PlayerRegistrationNo";
                    if (!string.IsNullOrEmpty(Session_ddl.SelectedItem.Text.Trim()))
                    {
                        q10 += " WHERE Availability.SessionID LIKE @SessionID + '%'";
                        cmd10.Parameters.AddWithValue("@SessionID", Session_ddl.SelectedItem.Text.Trim());
                    }
                    cmd10.CommandText = q10;
                    cmd10.Connection = sqlCon;

                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd10))
                    {
                        DataTable user_dt = new DataTable();
                        sda.Fill(user_dt);
                        session_list.DataSource = user_dt;
                        session_list.DataBind();
                    }
                }
            }


        }

        protected void ses_list_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            SqlConnection sqlCon = new SqlConnection(conString);
            sqlCon.Open();
            session_list.PageIndex = e.NewPageIndex;
            grid_bind();

            if (sqlCon.State == System.Data.ConnectionState.Open)
            {
                using (SqlCommand cmd11 = new SqlCommand())
                {
                    string q11 = "SELECT Availability.AvailabilityID, Availability.SessionID, Availability.PlayerRegistrationNo, users.Forename, users.Surname, users.ContactNo, Availability.Decision, Availability.Acceptance FROM Availability INNER JOIN users ON Availability.PlayerRegistrationNo = users.PlayerRegistrationNo";
                    if (!string.IsNullOrEmpty(Session_ddl.SelectedItem.Text.Trim()))
                    {
                        q11 += " WHERE Availability.SessionID LIKE @SessionID + '%'";
                        cmd11.Parameters.AddWithValue("@SessionID", Session_ddl.SelectedItem.Text.Trim());
                    }
                    cmd11.CommandText = q11;
                    cmd11.Connection = sqlCon;

                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd11))
                    {
                        DataTable user_dt = new DataTable();
                        sda.Fill(user_dt);
                        session_list.DataSource = user_dt;
                        session_list.DataBind();
                    }
                }
            }
        }

        protected void ses_list_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            SqlConnection sqlCon = new SqlConnection(conString);
            sqlCon.Open();
            session_list.EditIndex = -1;
            grid_bind();

            if (sqlCon.State == System.Data.ConnectionState.Open)
            {
                using (SqlCommand cmd9 = new SqlCommand())
                {
                    string q9 = "SELECT Availability.AvailabilityID, Availability.SessionID, Availability.PlayerRegistrationNo, users.Forename, users.Surname, users.ContactNo, Availability.Decision, Availability.Acceptance FROM Availability INNER JOIN users ON Availability.PlayerRegistrationNo = users.PlayerRegistrationNo";
                    if (!string.IsNullOrEmpty(Session_ddl.SelectedItem.Text.Trim()))
                    {
                        q9 += " WHERE Availability.SessionID LIKE @SessionID + '%'";
                        cmd9.Parameters.AddWithValue("@SessionID", Session_ddl.SelectedItem.Text.Trim());
                    }
                    cmd9.CommandText = q9;
                    cmd9.Connection = sqlCon;

                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd9))
                    {
                        DataTable user_dt = new DataTable();
                        sda.Fill(user_dt);
                        session_list.DataSource = user_dt;
                        session_list.DataBind();
                    }
                }
            }
        }


    }
}