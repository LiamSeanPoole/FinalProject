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
    public partial class MResultsStatistics : System.Web.UI.Page
    {
        public string conString = "Data Source=DESKTOP-8SAN538;Initial Catalog=Benhurst;Integrated Security=True";
        public string current_user;
        public string goal_input;
        public string assist_input;
        public string yell_input;
        public string red_input;
        public string clean_input;
        public string ben_input;
        public string opp_input;
        protected void Page_Load(object sender, EventArgs e)
        {
            ValidationSettings.UnobtrusiveValidationMode = UnobtrusiveValidationMode.None;
            ManagerMR.Visible = false;
            ManagerPS.Visible = false;
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

        protected void Sgrid_bind()
        {
            SqlConnection sqlCon = new SqlConnection(conString);
            sqlCon.Open();

            if (sqlCon.State == System.Data.ConnectionState.Open)
            {
                string q4 = "SELECT Stats.StatID, Stats.AttendanceID, Stats.PlayerRegistrationNo, users.Forename, users.Surname, Stats.Goal, Stats.Assist, Stats.Yellow, Stats.Red, Stats.Clean_Sheet FROM Stats INNER JOIN Attendance ON Stats.AttendanceID = Attendance.AttendanceID LEFT OUTER JOIN users ON Attendance.PlayerRegistrationNo = users.PlayerRegistrationNo";
                SqlCommand cmd4 = new SqlCommand(q4, sqlCon);
                SqlDataAdapter sda = new SqlDataAdapter(cmd4);
                DataSet sds = new DataSet();
                sda.Fill(sds);
                sqlCon.Close();

                if (sds.Tables[0].Rows.Count > 0)
                {
                    statgv.DataSource = sds;
                    statgv.DataBind();
                }
                else
                {
                    sds.Tables[0].Rows.Add(sds.Tables[0].NewRow());
                    statgv.DataSource = sds;
                    statgv.DataBind();
                    int numColumn = statgv.Rows[0].Cells.Count;
                    statgv.Rows[0].Cells.Clear();
                    statgv.Rows[0].Cells.Add(new TableCell());
                    statgv.Rows[0].Cells[0].ColumnSpan = numColumn;
                    statgv.Rows[0].Cells[0].Text = "Unable to find records";
                }
            }
        }
        protected void Rgrid_bind()
        {
            SqlConnection sqlCon = new SqlConnection(conString);
            sqlCon.Open();

            if (sqlCon.State == System.Data.ConnectionState.Open)
            {
                string q4 = "SELECT [ResultID], [Benhurst_Goals], [Opposition_Goals], [SessionID] FROM [Result]";
                SqlCommand cmd4 = new SqlCommand(q4, sqlCon);
                SqlDataAdapter sda = new SqlDataAdapter(cmd4);
                DataSet sds = new DataSet();
                sda.Fill(sds);
                sqlCon.Close();

                if (sds.Tables[0].Rows.Count > 0)
                {
                    resgv.DataSource = sds;
                    resgv.DataBind();
                }
                else
                {
                    sds.Tables[0].Rows.Add(sds.Tables[0].NewRow());
                    resgv.DataSource = sds;
                    resgv.DataBind();
                    int numColumn = resgv.Rows[0].Cells.Count;
                    resgv.Rows[0].Cells.Clear();
                    resgv.Rows[0].Cells.Add(new TableCell());
                    resgv.Rows[0].Cells[0].ColumnSpan = numColumn;
                    resgv.Rows[0].Cells[0].Text = "Unable to find records";
                }
            }
        }
        protected void DropDown_Click(object sender, EventArgs e)
        {
            ManagerMR.Visible = true;
            ManagerPS.Visible = true;
            SqlConnection sqlCon = new SqlConnection(conString);
            sqlCon.Open();

            if (sqlCon.State == System.Data.ConnectionState.Open)
            {
                string q3 = "SELECT Stats.StatID, Stats.AttendanceID, Stats.PlayerRegistrationNo, users.Forename, users.Surname, Stats.Goal, Stats.Assist, Stats.Yellow, Stats.Red, Stats.Clean_Sheet FROM Stats INNER JOIN Attendance ON Stats.AttendanceID = Attendance.AttendanceID LEFT OUTER JOIN users ON Attendance.PlayerRegistrationNo = users.PlayerRegistrationNo WHERE Attendance.SessionID = '" + Session_ddl.SelectedValue + "'";
                SqlCommand cmd3 = new SqlCommand(q3, sqlCon);
                SqlDataReader dr = cmd3.ExecuteReader();
                dr.Close();

                using (SqlDataAdapter sda = new SqlDataAdapter(cmd3))
                {
                    DataTable stat_dt = new DataTable();
                    sda.Fill(stat_dt);
                    statgv.DataSource = stat_dt;
                    statgv.DataBind();
                }

                string q13 = "SELECT [ResultID], [Benhurst_Goals], [Opposition_Goals], [SessionID] FROM [Result] WHERE SessionID = '" + Session_ddl.SelectedValue + "'";
                SqlCommand cmd13 = new SqlCommand(q13, sqlCon);
                SqlDataReader dr1 = cmd13.ExecuteReader();
                dr1.Close();

                using (SqlDataAdapter sda = new SqlDataAdapter(cmd13))
                {
                    DataTable res_dt = new DataTable();
                    sda.Fill(res_dt);
                    resgv.DataSource = res_dt;
                    resgv.DataBind();
                }
            }
        }
        protected void stat_list_RowEditing(object sender, GridViewEditEventArgs e)
        {
            SqlConnection sqlCon = new SqlConnection(conString);
            sqlCon.Open();

            statgv.EditIndex = e.NewEditIndex;
            Console.WriteLine(statgv.EditIndex);
            Sgrid_bind();

            if (sqlCon.State == System.Data.ConnectionState.Open)
            {
                string q5 = "SELECT Stats.StatID, Stats.AttendanceID, Stats.PlayerRegistrationNo, users.Forename, users.Surname, Stats.Goal, Stats.Assist, Stats.Yellow, Stats.Red, Stats.Clean_Sheet FROM Stats INNER JOIN Attendance ON Stats.AttendanceID = Attendance.AttendanceID LEFT OUTER JOIN users ON Attendance.PlayerRegistrationNo = users.PlayerRegistrationNo WHERE Attendance.SessionID = '" + Session_ddl.SelectedValue + "'";
                SqlCommand cmd5 = new SqlCommand(q5, sqlCon);
                SqlDataReader dr = cmd5.ExecuteReader();
                dr.Close();

                using (SqlDataAdapter sda = new SqlDataAdapter(cmd5))
                {
                    DataTable stat_dt = new DataTable();
                    sda.Fill(stat_dt);
                    statgv.DataSource = stat_dt;
                    statgv.DataBind();
                }
            }
        }

        protected void stat_list_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            string statID_val = statgv.DataKeys[e.RowIndex].Value.ToString();
            GridViewRow gvrow = (GridViewRow)statgv.Rows[e.RowIndex];
            Label lbl_id = (Label)gvrow.FindControl("lblID");

            TextBox gvgoal = (TextBox)gvrow.Cells[5].Controls[0];
            TextBox gvassist = (TextBox)gvrow.Cells[6].Controls[0];
            TextBox gvyell = (TextBox)gvrow.Cells[7].Controls[0];
            TextBox gvred = (TextBox)gvrow.Cells[8].Controls[0];
            TextBox gvclean = (TextBox)gvrow.Cells[9].Controls[0];

            var goalR = new Regex(@"^[0-9]*$");
            if (goalR.IsMatch(gvgoal.Text) || gvgoal.Text == "")
            {
                goal_input = gvgoal.Text;
            }
            else
            {

                error_lblPS.Text += " Invalid Goal, please try again";
                goal_input = "";
            }

            var assistR = new Regex(@"^[0-9]*$");
            if (assistR.IsMatch(gvassist.Text) || gvassist.Text == "")
            {
                assist_input = gvassist.Text;
            }
            else
            {

                error_lblPS.Text += " Invalid Assist, please try again";
                assist_input = "";
            }

            var yellR = new Regex(@"^[0-9]*$");
            if (yellR.IsMatch(gvyell.Text) || gvyell.Text == "")
            {
                yell_input = gvyell.Text;
            }
            else
            {

                error_lblPS.Text += " Invalid Yellow, please try again";
                yell_input = "";
            }

            var redR = new Regex(@"^[0-9]*$");
            if (redR.IsMatch(gvred.Text) || gvred.Text == "")
            {
                red_input = gvred.Text;
            }
            else
            {

                error_lblPS.Text += " Invalid Red, please try again";
                red_input = "";
            }

            var cleanR = new Regex(@"^[0-9]*$");
            if (cleanR.IsMatch(gvclean.Text) || gvclean.Text == "")
            {
                clean_input = gvclean.Text;
            }
            else
            {

                error_lblPS.Text += " Invalid Clean Sheet, please try again";
                clean_input = "";
            }

            statgv.EditIndex = -1;

            SqlConnection sqlCon = new SqlConnection(conString);
            sqlCon.Open();

            if (sqlCon.State == System.Data.ConnectionState.Open)
            {

                string q6 = "UPDATE Stats SET Goal = '" + goal_input + "', Assist = '" + assist_input + "', Yellow = '" + yell_input + "', Red = '" + red_input + "', Clean_Sheet = '" + clean_input + "' WHERE StatID = '" + statID_val + "'";
                SqlCommand cmd6 = new SqlCommand(q6, sqlCon);
                cmd6.ExecuteNonQuery();
                //sqlCon.Close();


            }
            Sgrid_bind();
            if (sqlCon.State == System.Data.ConnectionState.Open)
            {
                string q7 = "SELECT Stats.StatID, Stats.AttendanceID, Stats.PlayerRegistrationNo, users.Forename, users.Surname, Stats.Goal, Stats.Assist, Stats.Yellow, Stats.Red, Stats.Clean_Sheet FROM Stats INNER JOIN Attendance ON Stats.AttendanceID = Attendance.AttendanceID LEFT OUTER JOIN users ON Attendance.PlayerRegistrationNo = users.PlayerRegistrationNo WHERE Attendance.SessionID = '" + Session_ddl.SelectedValue + "'";
                SqlCommand cmd7 = new SqlCommand(q7, sqlCon);
                SqlDataReader dr = cmd7.ExecuteReader();
                dr.Close();

                using (SqlDataAdapter sda = new SqlDataAdapter(cmd7))
                {
                    DataTable stat_dt = new DataTable();
                    sda.Fill(stat_dt);
                    statgv.DataSource = stat_dt;
                    statgv.DataBind();
                }
            }


        }

        protected void stat_list_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            SqlConnection sqlCon = new SqlConnection(conString);
            sqlCon.Open();
            statgv.PageIndex = e.NewPageIndex;
            Sgrid_bind();

            if (sqlCon.State == System.Data.ConnectionState.Open)
            {
                string q8 = "SELECT Stats.StatID, Stats.AttendanceID, Stats.PlayerRegistrationNo, users.Forename, users.Surname, Stats.Goal, Stats.Assist, Stats.Yellow, Stats.Red, Stats.Clean_Sheet FROM Stats INNER JOIN Attendance ON Stats.AttendanceID = Attendance.AttendanceID LEFT OUTER JOIN users ON Attendance.PlayerRegistrationNo = users.PlayerRegistrationNo WHERE Attendance.SessionID = '" + Session_ddl.SelectedValue + "'";
                SqlCommand cmd8 = new SqlCommand(q8, sqlCon);
                SqlDataReader dr = cmd8.ExecuteReader();
                dr.Close();

                using (SqlDataAdapter sda = new SqlDataAdapter(cmd8))
                {
                    DataTable stat_dt = new DataTable();
                    sda.Fill(stat_dt);
                    statgv.DataSource = stat_dt;
                    statgv.DataBind();
                }
            }
        }

        protected void stat_list_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            SqlConnection sqlCon = new SqlConnection(conString);
            sqlCon.Open();
            statgv.EditIndex = -1;
            Sgrid_bind();

            if (sqlCon.State == System.Data.ConnectionState.Open)
            {
                string q9 = "SELECT Stats.StatID, Stats.AttendanceID, Stats.PlayerRegistrationNo, users.Forename, users.Surname, Stats.Goal, Stats.Assist, Stats.Yellow, Stats.Red, Stats.Clean_Sheet FROM Stats INNER JOIN Attendance ON Stats.AttendanceID = Attendance.AttendanceID LEFT OUTER JOIN users ON Attendance.PlayerRegistrationNo = users.PlayerRegistrationNo WHERE Attendance.SessionID = '" + Session_ddl.SelectedValue + "'";
                SqlCommand cmd9 = new SqlCommand(q9, sqlCon);
                SqlDataReader dr = cmd9.ExecuteReader();
                dr.Close();

                using (SqlDataAdapter sda = new SqlDataAdapter(cmd9))
                {
                    DataTable stat_dt = new DataTable();
                    sda.Fill(stat_dt);
                    statgv.DataSource = stat_dt;
                    statgv.DataBind();
                }
            }
        }
        protected void res_list_RowEditing(object sender, GridViewEditEventArgs e)
        {
            SqlConnection sqlCon = new SqlConnection(conString);
            sqlCon.Open();

            resgv.EditIndex = e.NewEditIndex;
            Console.WriteLine(resgv.EditIndex);
            Rgrid_bind();

            if (sqlCon.State == System.Data.ConnectionState.Open)
            {
                string q10 = "SELECT [ResultID], [Benhurst_Goals], [Opposition_Goals], [SessionID] FROM [Result] WHERE SessionID = '" + Session_ddl.SelectedValue + "'";
                SqlCommand cmd10 = new SqlCommand(q10, sqlCon);
                SqlDataReader dr1 = cmd10.ExecuteReader();
                dr1.Close();

                using (SqlDataAdapter sda = new SqlDataAdapter(cmd10))
                {
                    DataTable res_dt = new DataTable();
                    sda.Fill(res_dt);
                    resgv.DataSource = res_dt;
                    resgv.DataBind();
                }
            }
        }

        protected void res_list_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            string resultID_val = resgv.DataKeys[e.RowIndex].Value.ToString();
            GridViewRow gvrow = (GridViewRow)resgv.Rows[e.RowIndex];
            Label lbl_id = (Label)gvrow.FindControl("lblID");

            TextBox gvben = (TextBox)gvrow.Cells[1].Controls[0];
            TextBox gvopp = (TextBox)gvrow.Cells[2].Controls[0];

            var benR = new Regex(@"^[0-9]*$");
            if (benR.IsMatch(gvben.Text) || gvben.Text == "")
            {
                ben_input = gvben.Text;
            }
            else
            {

                error_lblMR.Text += " Invalid Benhurst Goal, please try again";
                ben_input = "";
            }

            var oppR = new Regex(@"^[0-9]*$");
            if (oppR.IsMatch(gvopp.Text) || gvopp.Text == "")
            {
                opp_input = gvopp.Text;
            }
            else
            {

                error_lblMR.Text += " Invalid Opponent Goal, please try again";
                opp_input = "";
            }

            resgv.EditIndex = -1;

            SqlConnection sqlCon = new SqlConnection(conString);
            sqlCon.Open();

            if (sqlCon.State == System.Data.ConnectionState.Open)
            {

                string q11 = "UPDATE Result SET Benhurst_Goals = '" + ben_input + "', Opposition_Goals = '" + opp_input + "' WHERE ResultID = '" + resultID_val + "'";
                SqlCommand cmd11 = new SqlCommand(q11, sqlCon);
                cmd11.ExecuteNonQuery();
                //sqlCon.Close();


            }
            Rgrid_bind();
            if (sqlCon.State == System.Data.ConnectionState.Open)
            {
                string q12 = "SELECT [ResultID], [Benhurst_Goals], [Opposition_Goals], [SessionID] FROM [Result] WHERE SessionID = '" + Session_ddl.SelectedValue + "'";
                SqlCommand cmd12 = new SqlCommand(q12, sqlCon);
                SqlDataReader dr1 = cmd12.ExecuteReader();
                dr1.Close();

                using (SqlDataAdapter sda = new SqlDataAdapter(cmd12))
                {
                    DataTable res_dt = new DataTable();
                    sda.Fill(res_dt);
                    resgv.DataSource = res_dt;
                    resgv.DataBind();
                }
            }


        }

        protected void res_list_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            SqlConnection sqlCon = new SqlConnection(conString);
            sqlCon.Open();
            resgv.PageIndex = e.NewPageIndex;
            Rgrid_bind();

            if (sqlCon.State == System.Data.ConnectionState.Open)
            {
                string q14 = "SELECT [ResultID], [Benhurst_Goals], [Opposition_Goals], [SessionID] FROM [Result] WHERE SessionID = '" + Session_ddl.SelectedValue + "'";
                SqlCommand cmd14 = new SqlCommand(q14, sqlCon);
                SqlDataReader dr1 = cmd14.ExecuteReader();
                dr1.Close();

                using (SqlDataAdapter sda = new SqlDataAdapter(cmd14))
                {
                    DataTable res_dt = new DataTable();
                    sda.Fill(res_dt);
                    resgv.DataSource = res_dt;
                    resgv.DataBind();
                }
            }
        }

        protected void res_list_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            SqlConnection sqlCon = new SqlConnection(conString);
            sqlCon.Open();
            resgv.EditIndex = -1;
            Rgrid_bind();

            if (sqlCon.State == System.Data.ConnectionState.Open)
            {
                string q15 = "SELECT [ResultID], [Benhurst_Goals], [Opposition_Goals], [SessionID] FROM [Result] WHERE SessionID = '" + Session_ddl.SelectedValue + "'";
                SqlCommand cmd15 = new SqlCommand(q15, sqlCon);
                SqlDataReader dr1 = cmd15.ExecuteReader();
                dr1.Close();

                using (SqlDataAdapter sda = new SqlDataAdapter(cmd15))
                {
                    DataTable res_dt = new DataTable();
                    sda.Fill(res_dt);
                    resgv.DataSource = res_dt;
                    resgv.DataBind();
                }
            }
        }
    }
}