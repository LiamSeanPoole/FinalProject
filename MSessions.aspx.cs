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
using System.Globalization;
using System.Text.RegularExpressions;

namespace BenhurstV3
{
    public partial class MSessions : System.Web.UI.Page
    {
        public string conString = "Data Source=DESKTOP-8SAN538;Initial Catalog=Benhurst;Integrated Security=True";
        public string current_user;
        public string tos_input;
        public string loc_input;
        public string opp_input;
        public string kit_input;
        public string conname_input;
        public string connum_input;
        public string fee_input;
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
                string q6 = "SELECT SessionID, TypeOfSession, Date, Time, LocationID, Opponent, Kit_Colour, ContactName, ContactNumber, Fee FROM Session WHERE Date >= getdate() ORDER BY [Date]";
                SqlCommand cmd6 = new SqlCommand(q6, sqlCon);
                SqlDataAdapter sda = new SqlDataAdapter(cmd6);
                DataSet sds = new DataSet();
                sda.Fill(sds);
                sqlCon.Close();

                if (sds.Tables[0].Rows.Count > 0)
                {
                    gvses.DataSource = sds;
                    gvses.DataBind();
                }
                else
                {
                    sds.Tables[0].Rows.Add(sds.Tables[0].NewRow());
                    gvses.DataSource = sds;
                    gvses.DataBind();
                    int numColumn = gvses.Rows[0].Cells.Count;
                    gvses.Rows[0].Cells.Clear();
                    gvses.Rows[0].Cells.Add(new TableCell());
                    gvses.Rows[0].Cells[0].ColumnSpan = numColumn;
                    gvses.Rows[0].Cells[0].Text = "Unable to find records";
                }
            }
        }

        
        protected void SubmitLoc_Click(object sender, EventArgs e)
        {
            SqlConnection sqlCon = new SqlConnection(conString);
            sqlCon.Open();
            if (sqlCon.State == System.Data.ConnectionState.Open)
            {
               /* string q2 = "SELECT MAX(LocationID) FROM Location";
                SqlCommand cmd2 = new SqlCommand(q2, sqlCon);
                int maxID = Convert.ToInt32(cmd2.ExecuteScalar());
                maxID += 1; */
                string q1 = "INSERT INTO Location (LocationID,  AddressLine1, AddressLine2, AddressLine3, Postcode) Values ('" + locname.Text + "','" + Add1.Text + "','" + Add2.Text + "','" + Add3.Text + "','" + post.Text + "')";

                SqlCommand cmd1 = new SqlCommand(q1, sqlCon);
                SqlDataReader dr = cmd1.ExecuteReader();
            }
            Response.Redirect("http://localhost:62696/MSessions.aspx");
        }
        protected void SubmitSes_Click(object sender, EventArgs e)
        {
            SqlConnection sqlCon = new SqlConnection(conString);
            sqlCon.Open();
            if (sqlCon.State == System.Data.ConnectionState.Open)
            {
                string q3 = "SELECT MAX(SessionID) FROM Session";
                SqlCommand cmd3 = new SqlCommand(q3, sqlCon);
                int maxID = Convert.ToInt32(cmd3.ExecuteScalar());
                maxID += 1;

                string q5 = "INSERT INTO Session (SessionID, TypeOfSession, Date, Time, LocationID, Opponent, Kit_Colour, ContactName, ContactNumber, Fee) Values ('" + maxID + "','" + Session.SelectedValue + "','" + date.Text + "','" + Time.Text + "','" + location_ddl.SelectedValue + "','" + opponent.Text + "', '" + kit.SelectedValue + "','" + cname.Text + "','" + cnumber.Text + "', '" + Fee.Text+ "')";

                SqlCommand cmd5 = new SqlCommand(q5, sqlCon);
                SqlDataReader dr = cmd5.ExecuteReader();
                dr.Close();

                if(Session.SelectedValue.Equals("Fixture"))
                {
                    string q10 = "SELECT MAX(ResultID) FROM Result";
                    SqlCommand cmd10 = new SqlCommand(q10, sqlCon);
                    int maxRID = Convert.ToInt32(cmd10.ExecuteScalar());
                    maxRID += 1;

                    string q11 = "INSERT INTO Result(ResultID, SessionID) VALUES('" + maxRID + "', '" + maxID + "')";
                    SqlCommand cmd11 = new SqlCommand(q11, sqlCon);
                    SqlDataReader dr1 = cmd11.ExecuteReader();
                }
            }
            Response.Redirect("http://localhost:62696/MSessions.aspx");
        }

        protected void ses_list_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            GridViewRow gvrow = (GridViewRow)gvses.Rows[e.RowIndex];
            Label lbl_delete_id = (Label)gvrow.FindControl("lblID");

            SqlConnection sqlCon = new SqlConnection(conString);
            sqlCon.Open();

            if (sqlCon.State == System.Data.ConnectionState.Open)
            {
                string q7 = "DELETE FROM Session where SessionID = '" + gvses.DataKeys[e.RowIndex].Value.ToString() + "'";
                SqlCommand cmd7 = new SqlCommand(q7, sqlCon);
                cmd7.ExecuteNonQuery();
                sqlCon.Close();
            }
            grid_bind();
        }

        protected void ses_list_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvses.EditIndex = e.NewEditIndex;
            Console.WriteLine(gvses.EditIndex);
            grid_bind();
        }

        protected void ses_list_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            string sessionID_val = gvses.DataKeys[e.RowIndex].Value.ToString();
            GridViewRow gvrow = (GridViewRow)gvses.Rows[e.RowIndex];
            Label lbl_id = (Label)gvrow.FindControl("lblID");

            TextBox gvtos = (TextBox)gvrow.Cells[1].Controls[0];
            TextBox gvdate = (TextBox)gvrow.Cells[2].Controls[0];
            TextBox gvtime = (TextBox)gvrow.Cells[3].Controls[0];
            TextBox gvloc = (TextBox)gvrow.Cells[4].Controls[0];
            TextBox gvopp = (TextBox)gvrow.Cells[5].Controls[0];
            TextBox gvkit = (TextBox)gvrow.Cells[6].Controls[0];
            TextBox gvconname = (TextBox)gvrow.Cells[7].Controls[0];
            TextBox gvconnum = (TextBox)gvrow.Cells[8].Controls[0];
            TextBox gvfee = (TextBox)gvrow.Cells[9].Controls[0];

            var tosR = new Regex(@"^(?:Training|Fixture)$");
            if (tosR.IsMatch(gvtos.Text))
            {
                tos_input = gvtos.Text;
            }
            else
            {

                error_lbl.Text += "Invalid Type of Session, please try again";
                tos_input = "";
            }

            var locR = new Regex(@"^.{1,50}$");
            if (locR.IsMatch(gvloc.Text))
            {
               loc_input = gvloc.Text;
            }
            else
            {

                error_lbl.Text += " Invalid Location, please try again";
                loc_input = "";
            }

            var oppR = new Regex(@"^.{1,50}$");
            if (oppR.IsMatch(gvopp.Text) || gvopp.Text == "")
            {
                opp_input = gvopp.Text;
            }
            else
            {

                error_lbl.Text += " Invalid Opponent, please try again";
                opp_input = "";
            }

            var kitR = new Regex(@"^.{1,50}$");
            if (kitR.IsMatch(gvkit.Text) || gvkit.Text == "")
            {
                kit_input = gvkit.Text;
            }
            else
            {

                error_lbl.Text += " Invalid Kit, please try again";
                kit_input = "";
            }

            var connameR = new Regex(@"^.{1,50}$");
            if (connameR.IsMatch(gvconname.Text) || gvconname.Text == "")
            {
                conname_input = gvconname.Text;
            }
            else
            {

                error_lbl.Text += " Invalid Contact Name, please try again";
                conname_input = "";
            }

            var connumR = new Regex(@"^[0-9]*$");
            if (connumR.IsMatch(gvconnum.Text) || gvconnum.Text == "")
            {
                connum_input = gvconnum.Text;
            }
            else
            {

                error_lbl.Text += " Invalid Contact Number, please try again";
                connum_input = "";
            }

            var feeR = new Regex(@"^[0-9]*$");
            if (feeR.IsMatch(gvfee.Text) || gvfee.Text == "")
            {
                fee_input = gvfee.Text;
            }
            else
            {

                error_lbl.Text += " Invalid Fee, please try again";
                fee_input = "";
            }

            gvses.EditIndex = -1;

            SqlConnection sqlCon = new SqlConnection(conString);
            sqlCon.Open();

            if (sqlCon.State == System.Data.ConnectionState.Open)
            {
                DateTime strDate = Convert.ToDateTime(gvdate.Text);
                string date = strDate.ToString("MM/dd/yyyy");
                /*System.Diagnostics.Debug.WriteLine(strDate);
                string dtDate = DateTime.ParseExact(strDate, "dd/MM/yy", CultureInfo.InvariantCulture).ToString("MM/dd/yyyy", CultureInfo.InvariantCulture);*/
                string q9 = "UPDATE Session SET TypeOfSession = '" + tos_input + "', Date = '" + date + "', Time = '" + gvtime.Text + "', LocationID = '" + loc_input + "', Opponent = '" + opp_input + "', Kit_Colour = '" + kit_input + "', ContactName = '" + conname_input + "', ContactNumber = '" + connum_input + "', Fee = '" + fee_input + "' WHERE SessionID = '" + sessionID_val + "'";
                SqlCommand cmd9 = new SqlCommand(q9, sqlCon);

                //SqlDataReader dr = cmd9.ExecuteReader();

                cmd9.ExecuteNonQuery();
                sqlCon.Close();
            }
            grid_bind();
        }

        protected void ses_list_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvses.PageIndex = e.NewPageIndex;
            grid_bind();
        }

        protected void ses_list_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvses.EditIndex = -1;
            grid_bind();
        }
    }
}