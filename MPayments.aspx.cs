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
    public partial class MPayments : System.Web.UI.Page
    {
        public string conString = "Data Source=DESKTOP-8SAN538;Initial Catalog=Benhurst;Integrated Security=True";
        public string current_user;
        public string test;
        public string conf_input;
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
        protected void grid_bind()
        {
            SqlConnection sqlCon = new SqlConnection(conString);
            sqlCon.Open();

            if (sqlCon.State == System.Data.ConnectionState.Open)
            {
                string q4 = "SELECT Payments.PayID, Attendance.PlayerRegistrationNo, users.Forename, users.Surname, Session.SessionID, Session.TypeOfSession, Session.Date, Session.Time, Session.LocationID, Session.Opponent, Session.Kit_Colour, Session.ContactName, Session.ContactNumber, Payments.Fee, Payments.Paid, Payments.Confirmation FROM Attendance INNER JOIN Payments ON Attendance.AttendanceID = Payments.AttendanceID INNER JOIN Session ON Attendance.SessionID = Session.SessionID LEFT OUTER JOIN users ON Attendance.PlayerRegistrationNo = users.PlayerRegistrationNo WHERE Payments.Confirmation = '' OR Payments.Confirmation = 'No'";
                SqlCommand cmd4 = new SqlCommand(q4, sqlCon);
                SqlDataAdapter sda = new SqlDataAdapter(cmd4);
                DataSet sds = new DataSet();
                sda.Fill(sds);
                sqlCon.Close();

                if (sds.Tables[0].Rows.Count > 0)
                {
                    MPaygv.DataSource = sds;
                    MPaygv.DataBind();
                }
                else
                {
                    sds.Tables[0].Rows.Add(sds.Tables[0].NewRow());
                    MPaygv.DataSource = sds;
                    MPaygv.DataBind();
                    int numColumn = MPaygv.Rows[0].Cells.Count;
                    MPaygv.Rows[0].Cells.Clear();
                    MPaygv.Rows[0].Cells.Add(new TableCell());
                    MPaygv.Rows[0].Cells[0].ColumnSpan = numColumn;
                    MPaygv.Rows[0].Cells[0].Text = "Unable to find records";
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
        protected void Player_Search_Click(object sender, EventArgs e)
        {
            SqlConnection sqlCon = new SqlConnection(conString);
            sqlCon.Open();

            if (sqlCon.State == System.Data.ConnectionState.Open)
            {
                /*string q12 = "SELECT users.PlayerRegistrationNo FROM Attendance INNER JOIN Payments ON Attendance.AttendanceID = Payments.AttendanceID INNER JOIN Session ON Attendance.SessionID = Session.SessionID LEFT OUTER JOIN users ON Attendance.PlayerRegistrationNo = users.PlayerRegistrationNo WHERE CONVERT(VARCHAR(50), users.PlayerRegistrationNo) = '" + player_search_txt.Text.Trim() + "' AND Payments.Confirmation = '' OR Payments.Confirmation = 'No' ";
                SqlCommand cmd12 = new SqlCommand(q12, sqlCon);


                using (SqlDataReader dr1 = cmd12.ExecuteReader())
                {
                    while (dr1.Read())
                    {
                        test = dr1[0].ToString();
                    }
                }

                System.Diagnostics.Debug.WriteLine(test);*/

                string q3 = "SELECT Payments.PayID, Attendance.PlayerRegistrationNo, users.Forename, users.Surname, Session.SessionID, Session.TypeOfSession, Session.Date, Session.Time, Session.LocationID, Session.Opponent, Session.Kit_Colour, Session.ContactName, Session.ContactNumber, Payments.Fee, Payments.Paid, Payments.Confirmation FROM Attendance INNER JOIN Payments ON Attendance.AttendanceID = Payments.AttendanceID INNER JOIN Session ON Attendance.SessionID = Session.SessionID LEFT OUTER JOIN users ON Attendance.PlayerRegistrationNo = users.PlayerRegistrationNo WHERE (CONVERT(VARCHAR(50), users.PlayerRegistrationNo) = '" + player_search_txt.Text.Trim() + "' OR users.Forename = '" + player_search_txt.Text.Trim() + "' OR users.Surname = '" + player_search_txt.Text.Trim() + "' OR (TRIM(users.Forename) + ' ' + TRIM(users.Surname)) = '" + player_search_txt.Text.Trim() + "') AND Payments.Confirmation = '' OR Payments.Confirmation = 'No' ";
                

                SqlCommand cmd3 = new SqlCommand(q3, sqlCon);
                SqlDataReader dr = cmd3.ExecuteReader();
                dr.Close();

                using (SqlDataAdapter sda = new SqlDataAdapter(cmd3))
                {
                        DataTable pay_dt = new DataTable();
                        sda.Fill(pay_dt);
                        MPaygv.DataSource = pay_dt;
                        MPaygv.DataBind();
                }
            }
        }

        protected void pay_list_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            GridViewRow gvrow = (GridViewRow)MPaygv.Rows[e.RowIndex];
            Label lbl_delete_id = (Label)gvrow.FindControl("lblID");

            SqlConnection sqlCon = new SqlConnection(conString);
            sqlCon.Open();

            if (sqlCon.State == System.Data.ConnectionState.Open)
            {
                string q10 = "DELETE FROM Payments where PayID = '" + MPaygv.DataKeys[e.RowIndex].Value.ToString() + "'";
                SqlCommand cmd10 = new SqlCommand(q10, sqlCon);
                cmd10.ExecuteNonQuery();
                //sqlCon.Close();
            }
            grid_bind();
            if (sqlCon.State == System.Data.ConnectionState.Open)
            {


                string q11 = "SELECT Payments.PayID, Attendance.PlayerRegistrationNo, users.Forename, users.Surname, Session.SessionID, Session.TypeOfSession, Session.Date, Session.Time, Session.LocationID, Session.Opponent, Session.Kit_Colour, Session.ContactName, Session.ContactNumber, Payments.Fee, Payments.Paid, Payments.Confirmation FROM Attendance INNER JOIN Payments ON Attendance.AttendanceID = Payments.AttendanceID INNER JOIN Session ON Attendance.SessionID = Session.SessionID LEFT OUTER JOIN users ON Attendance.PlayerRegistrationNo = users.PlayerRegistrationNo WHERE (users.Forename = '" + player_search_txt.Text.Trim() + "' OR users.Surname = '" + player_search_txt.Text.Trim() + "' OR (TRIM(users.Forename) + ' ' + TRIM(users.Surname)) = '" + player_search_txt.Text.Trim() + "') AND Payments.Confirmation = '' OR Payments.Confirmation = 'No' ";


                SqlCommand cmd11 = new SqlCommand(q11, sqlCon);
                SqlDataReader dr = cmd11.ExecuteReader();
                dr.Close();

                using (SqlDataAdapter sda = new SqlDataAdapter(cmd11))
                {
                    DataTable pay_dt = new DataTable();
                    sda.Fill(pay_dt);
                    MPaygv.DataSource = pay_dt;
                    MPaygv.DataBind();
                }
            }
        }
        protected void pay_list_RowEditing(object sender, GridViewEditEventArgs e)
        {
            SqlConnection sqlCon = new SqlConnection(conString);
            sqlCon.Open();

            MPaygv.EditIndex = e.NewEditIndex;
            Console.WriteLine(MPaygv.EditIndex);
            grid_bind();

            if (sqlCon.State == System.Data.ConnectionState.Open)
            {


                string q5 = "SELECT Payments.PayID, Attendance.PlayerRegistrationNo, users.Forename, users.Surname, Session.SessionID, Session.TypeOfSession, Session.Date, Session.Time, Session.LocationID, Session.Opponent, Session.Kit_Colour, Session.ContactName, Session.ContactNumber, Payments.Fee, Payments.Paid, Payments.Confirmation FROM Attendance INNER JOIN Payments ON Attendance.AttendanceID = Payments.AttendanceID INNER JOIN Session ON Attendance.SessionID = Session.SessionID LEFT OUTER JOIN users ON Attendance.PlayerRegistrationNo = users.PlayerRegistrationNo WHERE (users.Forename = '" + player_search_txt.Text.Trim() + "' OR users.Surname = '" + player_search_txt.Text.Trim() + "' OR (TRIM(users.Forename) + ' ' + TRIM(users.Surname)) = '" + player_search_txt.Text.Trim() + "') AND Payments.Confirmation = '' OR Payments.Confirmation = 'No' ";


                SqlCommand cmd5 = new SqlCommand(q5, sqlCon);
                SqlDataReader dr = cmd5.ExecuteReader();
                dr.Close();

                using (SqlDataAdapter sda = new SqlDataAdapter(cmd5))
                {
                    DataTable pay_dt = new DataTable();
                    sda.Fill(pay_dt);
                    MPaygv.DataSource = pay_dt;
                    MPaygv.DataBind();
                }
            }
        }

        protected void pay_list_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            string payID_val = MPaygv.DataKeys[e.RowIndex].Value.ToString();
            GridViewRow gvrow = (GridViewRow)MPaygv.Rows[e.RowIndex];
            Label lbl_id = (Label)gvrow.FindControl("lblID");

            TextBox gvconf = (TextBox)gvrow.Cells[15].Controls[0];

            var confR = new Regex(@"^(?:Yes|No|yes|no)$");
            if (confR.IsMatch(gvconf.Text) || gvconf.Text == "")
            {
                conf_input = gvconf.Text;
            }
            else
            {
                error_lbl.Text += " Invalid Confirmation, please try again";
                conf_input = "";
            }

            MPaygv.EditIndex = -1;

            SqlConnection sqlCon = new SqlConnection(conString);
            sqlCon.Open();

            if (sqlCon.State == System.Data.ConnectionState.Open)
            {

                string q6 = "UPDATE Payments SET Confirmation = '" + conf_input + "' WHERE PayID = '" + payID_val + "'";
                SqlCommand cmd6 = new SqlCommand(q6, sqlCon);
                cmd6.ExecuteNonQuery();
                //sqlCon.Close();


            }
            grid_bind();
            if (sqlCon.State == System.Data.ConnectionState.Open)
            {


                string q7 = "SELECT Payments.PayID, Attendance.PlayerRegistrationNo, users.Forename, users.Surname, Session.SessionID, Session.TypeOfSession, Session.Date, Session.Time, Session.LocationID, Session.Opponent, Session.Kit_Colour, Session.ContactName, Session.ContactNumber, Payments.Fee, Payments.Paid, Payments.Confirmation FROM Attendance INNER JOIN Payments ON Attendance.AttendanceID = Payments.AttendanceID INNER JOIN Session ON Attendance.SessionID = Session.SessionID LEFT OUTER JOIN users ON Attendance.PlayerRegistrationNo = users.PlayerRegistrationNo WHERE (users.Forename = '" + player_search_txt.Text.Trim() + "' OR users.Surname = '" + player_search_txt.Text.Trim() + "' OR (TRIM(users.Forename) + ' ' + TRIM(users.Surname)) = '" + player_search_txt.Text.Trim() + "') AND Payments.Confirmation = '' OR Payments.Confirmation = 'No' ";


                SqlCommand cmd7 = new SqlCommand(q7, sqlCon);
                SqlDataReader dr = cmd7.ExecuteReader();
                dr.Close();

                using (SqlDataAdapter sda = new SqlDataAdapter(cmd7))
                {
                    DataTable pay_dt = new DataTable();
                    sda.Fill(pay_dt);
                    MPaygv.DataSource = pay_dt;
                    MPaygv.DataBind();
                }
            }
            

        }

        protected void pay_list_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            SqlConnection sqlCon = new SqlConnection(conString);
            sqlCon.Open();
            MPaygv.PageIndex = e.NewPageIndex;
            grid_bind();

            if (sqlCon.State == System.Data.ConnectionState.Open)
            {


                string q8 = "SELECT Payments.PayID, Attendance.PlayerRegistrationNo, users.Forename, users.Surname, Session.SessionID, Session.TypeOfSession, Session.Date, Session.Time, Session.LocationID, Session.Opponent, Session.Kit_Colour, Session.ContactName, Session.ContactNumber, Payments.Fee, Payments.Paid, Payments.Confirmation FROM Attendance INNER JOIN Payments ON Attendance.AttendanceID = Payments.AttendanceID INNER JOIN Session ON Attendance.SessionID = Session.SessionID LEFT OUTER JOIN users ON Attendance.PlayerRegistrationNo = users.PlayerRegistrationNo WHERE (users.Forename = '" + player_search_txt.Text.Trim() + "' OR users.Surname = '" + player_search_txt.Text.Trim() + "' OR (TRIM(users.Forename) + ' ' + TRIM(users.Surname)) = '" + player_search_txt.Text.Trim() + "') AND Payments.Confirmation = '' OR Payments.Confirmation = 'No' ";


                SqlCommand cmd8 = new SqlCommand(q8, sqlCon);
                SqlDataReader dr = cmd8.ExecuteReader();
                dr.Close();

                using (SqlDataAdapter sda = new SqlDataAdapter(cmd8))
                {
                    DataTable pay_dt = new DataTable();
                    sda.Fill(pay_dt);
                    MPaygv.DataSource = pay_dt;
                    MPaygv.DataBind();
                }
            }
        }

        protected void pay_list_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            SqlConnection sqlCon = new SqlConnection(conString);
            sqlCon.Open();
            MPaygv.EditIndex = -1;
            grid_bind();

            if (sqlCon.State == System.Data.ConnectionState.Open)
            {


                string q9 = "SELECT Payments.PayID, Attendance.PlayerRegistrationNo, users.Forename, users.Surname, Session.SessionID, Session.TypeOfSession, Session.Date, Session.Time, Session.LocationID, Session.Opponent, Session.Kit_Colour, Session.ContactName, Session.ContactNumber, Payments.Fee, Payments.Paid, Payments.Confirmation FROM Attendance INNER JOIN Payments ON Attendance.AttendanceID = Payments.AttendanceID INNER JOIN Session ON Attendance.SessionID = Session.SessionID LEFT OUTER JOIN users ON Attendance.PlayerRegistrationNo = users.PlayerRegistrationNo WHERE (users.Forename = '" + player_search_txt.Text.Trim() + "' OR users.Surname = '" + player_search_txt.Text.Trim() + "' OR (TRIM(users.Forename) + ' ' + TRIM(users.Surname)) = '" + player_search_txt.Text.Trim() + "') AND Payments.Confirmation = '' OR Payments.Confirmation = 'No' ";


                SqlCommand cmd9 = new SqlCommand(q9, sqlCon);
                SqlDataReader dr = cmd9.ExecuteReader();
                dr.Close();

                using (SqlDataAdapter sda = new SqlDataAdapter(cmd9))
                {
                    DataTable pay_dt = new DataTable();
                    sda.Fill(pay_dt);
                    MPaygv.DataSource = pay_dt;
                    MPaygv.DataBind();
                }
            }
        }
    }
}