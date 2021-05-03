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
    public partial class MUser : System.Web.UI.Page
    {
        public string conString = "Data Source=DESKTOP-8SAN538;Initial Catalog=Benhurst;Integrated Security=True";
        public string current_user;
        public string contact_input;
        public string pass_input;
        public string access_input;
        public string forename_input;
        public string surname_input;
        public string reg_input;
        protected void Page_Load(object sender, EventArgs e)
        {
            ValidationSettings.UnobtrusiveValidationMode = UnobtrusiveValidationMode.None;
            if (!IsPostBack)
            {
                grid_bind();
            }
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
                string q2 = "SELECT username, password, Access, Forename, Surname, DOB, ContactNo, PlayerRegistrationNo FROM users";
                SqlCommand cmd2 = new SqlCommand(q2, sqlCon);
                SqlDataAdapter sda = new SqlDataAdapter(cmd2);
                DataSet uds = new DataSet();
                sda.Fill(uds);
                sqlCon.Close();

                if(uds.Tables[0].Rows.Count > 0)
                {
                    user_list.DataSource = uds;
                    user_list.DataBind();
                }
                else
                {
                    uds.Tables[0].Rows.Add(uds.Tables[0].NewRow());
                    user_list.DataSource = uds;
                    user_list.DataBind();
                    int numColumn = user_list.Rows[0].Cells.Count;
                    user_list.Rows[0].Cells.Clear();
                    user_list.Rows[0].Cells.Add(new TableCell());
                    user_list.Rows[0].Cells[0].ColumnSpan = numColumn;
                    user_list.Rows[0].Cells[0].Text = "Unable to find records";
                }
            }
        }
        protected void SubmitUser_Click(object sender, EventArgs e)
        {
            string access_det;
            string NUser = "You have submitted a new user";
            if(User.SelectedIndex == 0)
            {
                access_det = "Player";
            }
            else if(User.SelectedIndex == 1)
            {
                access_det = "Manager";
            }
            else
            {
                access_det = "Invalid Member";
            }

            SqlConnection sqlCon = new SqlConnection(conString);
            sqlCon.Open();
            if (sqlCon.State == System.Data.ConnectionState.Open)
            {
                string q1 = "INSERT INTO users (username, LoginStatus, password, Access, Forename, Surname, DOB, ContactNo, PlayerRegistrationNo) Values ('" + email.Text + "','no','" + password.Text + "','" + access_det + "','" + forename.Text + "','" + surname.Text + "','" + DOB.Text + "','" + contact.Text + "','" + PlayerRegistrationNo.Text + "')";
                SqlCommand cmd1 = new SqlCommand(q1, sqlCon);
                SqlDataReader dr = cmd1.ExecuteReader();

            }
            Response.Redirect("http://localhost:62696/MUser.aspx");
        }

        protected void User_Search_Click(object sender, EventArgs e)
        {
            SqlConnection sqlCon = new SqlConnection(conString);
            sqlCon.Open();

            if (sqlCon.State == System.Data.ConnectionState.Open)
            {
                using(SqlCommand cmd5 = new SqlCommand())
                {
                    string q5 = "SELECT username, password, Access, Forename, Surname, DOB, ContactNo, PlayerRegistrationNo FROM users";
                    if (!string.IsNullOrEmpty(user_search_txt.Text.Trim()))
                    {
                        q5 += " WHERE username LIKE @username + '%'";
                        cmd5.Parameters.AddWithValue("@username", user_search_txt.Text.Trim());
                    }
                    cmd5.CommandText = q5;
                    cmd5.Connection = sqlCon;

                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd5))
                    {
                        DataTable user_dt = new DataTable();
                        sda.Fill(user_dt);
                        user_list.DataSource = user_dt;
                        user_list.DataBind();
                    }
                }
            }
        }
        protected void Access_Search_Click(object sender, EventArgs e)
        {
            SqlConnection sqlCon = new SqlConnection(conString);
            sqlCon.Open();

            if (sqlCon.State == System.Data.ConnectionState.Open)
            {
                using (SqlCommand cmd6 = new SqlCommand())
                {
                    string q6 = "SELECT username, password, Access, Forename, Surname, DOB, ContactNo, PlayerRegistrationNo FROM users";
                    if (!string.IsNullOrEmpty(access_search_txt.Text.Trim()))
                    {
                        q6 += " WHERE Access LIKE @Access + '%'";
                        cmd6.Parameters.AddWithValue("@Access", access_search_txt.Text.Trim());
                    }
                    cmd6.CommandText = q6;
                    cmd6.Connection = sqlCon;

                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd6))
                    {
                        DataTable user_dt = new DataTable();
                        sda.Fill(user_dt);
                        user_list.DataSource = user_dt;
                        user_list.DataBind();
                    }
                }
            }
        }

        protected void Fore_Search_Click(object sender, EventArgs e)
        {
            SqlConnection sqlCon = new SqlConnection(conString);
            sqlCon.Open();

            if (sqlCon.State == System.Data.ConnectionState.Open)
            {
                using (SqlCommand cmd7 = new SqlCommand())
                {
                    string q7 = "SELECT username, password, Access, Forename, Surname, DOB, ContactNo, PlayerRegistrationNo FROM users";
                    if (!string.IsNullOrEmpty(fore_search_txt.Text.Trim()))
                    {
                        q7 += " WHERE Forename LIKE @Forename + '%'";
                        cmd7.Parameters.AddWithValue("@Forename", fore_search_txt.Text.Trim());
                    }
                    cmd7.CommandText = q7;
                    cmd7.Connection = sqlCon;

                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd7))
                    {
                        DataTable user_dt = new DataTable();
                        sda.Fill(user_dt);
                        user_list.DataSource = user_dt;
                        user_list.DataBind();
                    }
                }
            }
        }

        protected void Sur_Search_Click(object sender, EventArgs e)
        {
            SqlConnection sqlCon = new SqlConnection(conString);
            sqlCon.Open();

            if (sqlCon.State == System.Data.ConnectionState.Open)
            {
                using (SqlCommand cmd8 = new SqlCommand())
                {
                    string q8 = "SELECT username, password, Access, Forename, Surname, DOB, ContactNo, PlayerRegistrationNo FROM users";
                    if (!string.IsNullOrEmpty(sur_search_txt.Text.Trim()))
                    {
                        q8 += " WHERE Surname LIKE @Surname + '%'";
                        cmd8.Parameters.AddWithValue("@Surname", sur_search_txt.Text.Trim());
                    }
                    cmd8.CommandText = q8;
                    cmd8.Connection = sqlCon;

                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd8))
                    {
                        DataTable user_dt = new DataTable();
                        sda.Fill(user_dt);
                        user_list.DataSource = user_dt;
                        user_list.DataBind();
                    }
                }
            }
        }

        protected void RegNo_Search_Click(object sender, EventArgs e)
        {
            SqlConnection sqlCon = new SqlConnection(conString);
            sqlCon.Open();

            if (sqlCon.State == System.Data.ConnectionState.Open)
            {
                using (SqlCommand cmd9 = new SqlCommand())
                {
                    string q9 = "SELECT username, password, Access, Forename, Surname, DOB, ContactNo, PlayerRegistrationNo FROM users";
                    if (!string.IsNullOrEmpty(regNo_search_txt.Text.Trim()))
                    {
                        q9 += " WHERE PlayerRegistrationNo LIKE @PlayerRegistrationNo + '%'";
                        cmd9.Parameters.AddWithValue("@PlayerRegistrationNo", regNo_search_txt.Text.Trim());
                    }
                    cmd9.CommandText = q9;
                    cmd9.Connection = sqlCon;

                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd9))
                    {
                        DataTable user_dt = new DataTable();
                        sda.Fill(user_dt);
                        user_list.DataSource = user_dt;
                        user_list.DataBind();
                    }
                }
            }
        }

        protected void user_list_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            GridViewRow gvrow = (GridViewRow)user_list.Rows[e.RowIndex];
            Label lbl_delete_id = (Label)gvrow.FindControl("lblID");

            SqlConnection sqlCon = new SqlConnection(conString);
            sqlCon.Open();

            if (sqlCon.State == System.Data.ConnectionState.Open)
            {
                string q3 = "DELETE FROM users where username = '" + user_list.DataKeys[e.RowIndex].Value.ToString() + "'";
                SqlCommand cmd3 = new SqlCommand(q3, sqlCon);
                cmd3.ExecuteNonQuery();
                sqlCon.Close();
            }
            grid_bind();
        }

        protected void user_list_RowEditing(object sender, GridViewEditEventArgs e)
        {
            user_list.EditIndex = e.NewEditIndex;
            Console.WriteLine(user_list.EditIndex);
            grid_bind();
        }

        protected void user_list_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            
            
            string user_username = user_list.DataKeys[e.RowIndex].Value.ToString();
            GridViewRow gvrow = (GridViewRow)user_list.Rows[e.RowIndex];
            Label lbl_id = (Label)gvrow.FindControl("lblID");

            TextBox gvpass = (TextBox)gvrow.Cells[1].Controls[0];
            TextBox gvaccess = (TextBox)gvrow.Cells[2].Controls[0];
            TextBox gvforename = (TextBox)gvrow.Cells[3].Controls[0];
            TextBox gvsurname = (TextBox)gvrow.Cells[4].Controls[0];
            TextBox gvdob = (TextBox)gvrow.Cells[5].Controls[0];
            TextBox gvcontactno = (TextBox)gvrow.Cells[6].Controls[0];
            TextBox gvregno = (TextBox)gvrow.Cells[7].Controls[0];

            var passR = new Regex(@"^.{1,50}$");
            if (passR.IsMatch(gvpass.Text))
            {
                pass_input = gvpass.Text;
            }
            else
            {

                error_lbl.Text += "Invalid Password, please try again";
                pass_input = "";
            }

            var accessR = new Regex(@"^\w+( \w+)*$");
            if (accessR.IsMatch(gvaccess.Text) || gvaccess.Text == "")
            {
                access_input = gvaccess.Text;
            }
            else
            {

                error_lbl.Text += " Invalid Access, please try again";
                access_input = "";
            }

            var forenameR = new Regex(@"^[A-Za-z]*$");
            if (forenameR.IsMatch(gvforename.Text.Trim()))
            {
                forename_input = gvforename.Text;
            }
            else
            {

                error_lbl.Text += " Invalid Forename, please try again";
                forename_input = "";
            }

            var surnameR = new Regex(@"^[A-Za-z]*$");
            if (surnameR.IsMatch(gvsurname.Text.Trim()))
            {
                surname_input = gvsurname.Text;
            }
            else
            {

                error_lbl.Text += " Invalid Surname, please try again";
                surname_input = "";
            }

            var contactR = new Regex(@"^[0-9]*$");
            if(contactR.IsMatch(gvcontactno.Text) || gvcontactno.Text == "")
            {
                contact_input = gvcontactno.Text;
            }
            else
            {
                
                error_lbl.Text += " Invalid Contact Number, please try again";
                contact_input = "";
            }

            var regR = new Regex(@"^[0-9]*$");
            if (regR.IsMatch(gvregno.Text) || gvregno.Text == "")
            {
                reg_input = gvregno.Text;
            }
            else
            {

                error_lbl.Text += " Invalid Registration Number, please try again";
                reg_input = "";
            }

            user_list.EditIndex = -1;

            SqlConnection sqlCon = new SqlConnection(conString);
            sqlCon.Open();

            if (sqlCon.State == System.Data.ConnectionState.Open)
            {
                DateTime strDob = Convert.ToDateTime(gvdob.Text);
                string dob = strDob.ToString("MM/dd/yyyy");
                string q4 = "UPDATE users SET password = '" + pass_input + "', Access = '" + access_input + "', Forename = '" + forename_input + "', Surname = '" + surname_input + "', DOB = '" + dob + "', ContactNo = '" + contact_input + "', PlayerRegistrationNo = '" + reg_input + "' WHERE username ='" + user_username + "'";
                SqlCommand cmd4 = new SqlCommand(q4, sqlCon);
                cmd4.ExecuteNonQuery();
                sqlCon.Close();
            }
            grid_bind();
        }

        protected void user_list_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            user_list.PageIndex = e.NewPageIndex;
            grid_bind();
        }

        protected void user_list_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            user_list.EditIndex = -1;
            grid_bind();
        }
    }
}