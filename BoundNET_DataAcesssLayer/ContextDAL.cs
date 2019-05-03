using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Data;
using System.Threading.Tasks;

namespace BoundNET_DataAcesssLayer
{
    public class ContextDAL: IDisposable
    {
        #region Functions/Connection strings for Database Connection
        // Creating a connection string with the Sql Connection variable being named "BoundNETDataConnection".
        SqlConnection BoundNETDataConnection = new SqlConnection();
        // Function created to open database "BoundNETData".
        public void open(string cs)
        {
            BoundNETDataConnection.ConnectionString = cs;
            BoundNETDataConnection.Open();
        }
        public void close()
        {
            BoundNETDataConnection.Close();
        }
        /*Implementation of IDisposable to Help other Potential Programmers With Garbage Collection and Prevent "Sloppy Programming"
        From Making the Mistake of not Properly Disposing the Following Connection Strings */
            private System.Data.SqlClient.SqlConnection _connection = new SqlConnection();
            public string ConnectionString
            {
                get { return _connection.ConnectionString; }
                set { _connection.ConnectionString = value; }
            }
            public void Dispose()
            {
                _connection.Dispose();
            }
            public void EnsureConnected()
            {
                try
                {
                    if (_connection.State == System.Data.ConnectionState.Closed)
                    {
                        _connection.Open();
                    }
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
        
        #endregion
        #region SqlCommands Register All Tables (CREATE)
        //Creating a Sql Command to create a new user login upon registration! 
        public void RegisterNewUserLogin(int UserID, string Email, string Password, string RoleType, string Salt)
        {
            SqlConnection connectionToSql = new SqlConnection();
            using (SqlCommand command = new SqlCommand("SP_InsertUserLogin", BoundNETDataConnection))
            {
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.AddWithValue("@UserID", UserID);
                command.Parameters.AddWithValue("@Email", Email);
                command.Parameters.AddWithValue("@Password", Password);
                command.Parameters.AddWithValue("@RoleType", RoleType);
                command.Parameters.AddWithValue("@Salt", Salt);
                try
                {
                    command.ExecuteNonQuery();
                }
                catch (Exception ex)
                {
                    // log the exception in ex
                    throw ex;
                }
            }
        }
        //Creating a Sql Command to create new player statistics upon registration!
        public void RegisterPlayerStats(string Username, int UserID, int InGameRank, int Progression, TimeSpan LongestSurvivalTime, int HighestElevation, int HighScore, TimeSpan TimePlayed)
        {
            SqlConnection connectionToSql = new SqlConnection();
            using (SqlCommand command = new SqlCommand("SP_InsertPlayerStats", BoundNETDataConnection))
            {
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.AddWithValue("@Username", Username);
                command.Parameters.AddWithValue("@UserID", UserID);
                command.Parameters.AddWithValue("@InGameRank", InGameRank);
                command.Parameters.AddWithValue("@Progression", Progression);
                command.Parameters.AddWithValue("@LongestSurvivalTime", LongestSurvivalTime);
                command.Parameters.AddWithValue("@HighestElevation", HighestElevation);
                command.Parameters.AddWithValue("@HighScore", HighScore);
                command.Parameters.AddWithValue("@TimePlayed", TimePlayed);
                try
                {
                    command.ExecuteNonQuery();
                }
                catch (Exception ex)
                {
                    // log the exception in ex
                    throw ex;
                }
            }
        }
        //Creating a Sql Command to create a new profile information upon registration!
        public void RegisterProfileInfo(int CustomerID, string Username, string FirstName, string LastName, string RoleType, string Email, string Address, string City, string State, int ZipCode)
        {
            SqlConnection connectionToSql = new SqlConnection();
            using (SqlCommand command = new SqlCommand("SP_InsertProfileInfo", BoundNETDataConnection))
            {
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.AddWithValue("@CustomerID", CustomerID);
                command.Parameters.AddWithValue("@Username", Username);
                command.Parameters.AddWithValue("@FirstName", FirstName);
                command.Parameters.AddWithValue("@LastName", LastName);
                command.Parameters.AddWithValue("@RoleType", RoleType);
                command.Parameters.AddWithValue("@Email", Email);
                command.Parameters.AddWithValue("@Address", Address);
                command.Parameters.AddWithValue("@City", City);
                command.Parameters.AddWithValue("@State", State);
                command.Parameters.AddWithValue("@ZipCode", ZipCode);
                try
                {
                    command.ExecuteNonQuery();
                }
                catch (Exception ex)
                {
                    // log the exception in ex
                    throw ex;
                }
            }
        }
        //Creating Sql Commands to create payment information upon registration! 
        public void RegisterPaymentInfo(int OrderID, int CustomerID, string Name, int CreditCardNumber, DateTime ExpirationDate, int CVCcode, int ZipCode, string ItemPurchased, DateTime DatePurchased)
        {
            SqlConnection connectionToSql = new SqlConnection();
            using (SqlCommand command = new SqlCommand("SP_InsertPaymentInfo", BoundNETDataConnection))
            {
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.AddWithValue("@OrderID", OrderID);
                command.Parameters.AddWithValue("@CustomerID", CustomerID);
                command.Parameters.AddWithValue("@Name", Name);
                command.Parameters.AddWithValue("@CreditCardNumber", CreditCardNumber);
                command.Parameters.AddWithValue("@ExpirationDate", ExpirationDate);
                command.Parameters.AddWithValue("@CVCcode", CVCcode);
                command.Parameters.AddWithValue("@ZipCode", ZipCode);
                command.Parameters.AddWithValue("@ItemPurchased", ItemPurchased);
                command.Parameters.AddWithValue("@DatePurchased", DatePurchased);
                try
                {
                    command.ExecuteNonQuery();
                }
                catch (Exception ex)
                {
                    // log the exception in ex
                    throw ex;
                }
            }
        }
        #endregion
        #region SqlCommands READ ALL TABLES (READ)
        //Creating a public list to READ all Userlogins utilizing a while loop!
        public List<User_LoginDAL> ViewAllUserLogins()
            {
                //Creating Sql Command variable "CMD".
                SqlCommand CMD = BoundNETDataConnection.CreateCommand();
                //Defining the variable "CMD" as a connection to a stored procedure.
                CMD.CommandType = System.Data.CommandType.StoredProcedure;
                //Identifying stored procedure name. 
                CMD.CommandText = "SP_ViewAllUserlogin";
                //Defining the alias "r" as a function!
                SqlDataReader r = CMD.ExecuteReader();
                //Defining "rv" alias as a returning value for the class "List<>"!
                List<User_LoginDAL> rv = new List<User_LoginDAL>();
                //Defining the values to be inserted into variables for the "GetOrdinal" method!
                int UserIDoffset = r.GetOrdinal("UserID");
                int Emailoffset = r.GetOrdinal("Email");
                int Passwordoffset = r.GetOrdinal("Password");
                int RoleTypeoffset = r.GetOrdinal("RoleType");
                int Saltoffset = r.GetOrdinal("Salt");
                //While loop to read all fields in class "User_loginDAL" for display purposes!
                while (r.Read())
                {
                    User_LoginDAL item = new User_LoginDAL();
                    item.UserID = r.GetInt32(UserIDoffset);
                    item.Email = r.GetString(Emailoffset);
                    item.Password = r.GetString(Passwordoffset);
                    item.RoleType = r.GetString(RoleTypeoffset);
                    item.Salt = r.GetString(Saltoffset);
                    rv.Add(item);
                }
                r.Close();
                return rv;
        }
        //Creating a public list to READ all PlayerStats utilizing a while loop!
        public List<Player_StatsDAL> ViewAllPlayerStats()
            {
                //Creating Sql Command variable "CMD".
                SqlCommand CMD = BoundNETDataConnection.CreateCommand();
                //Defining the variable "CMD" as a connection to a stored procedure. 
                CMD.CommandType = System.Data.CommandType.StoredProcedure;
                //Identifying stored procedure name. 
                CMD.CommandText = "SP_ViewAllPlayerStats";
                //Defining the alias "r" as a function!
                SqlDataReader r = CMD.ExecuteReader();
                //Defining "rv" alias as a returning value for the class "List<>"!
                List<Player_StatsDAL> rv = new List<Player_StatsDAL>();
                //Defining the values to be inserted into variables for the "GetOrdinal" method!
                int UserIDoffset = r.GetOrdinal("UserID");
                int Usernameoffset = r.GetOrdinal("Username");
                int InGameRankoffset = r.GetOrdinal("InGameRank");
                int Progressionoffset = r.GetOrdinal("Progression");
                int LongestSurvivalTimeoffset = r.GetOrdinal("LongestSurvivalTime");
                int HighestElevationoffset = r.GetOrdinal("HighestElevation");
                int HighScoreoffset = r.GetOrdinal("HighScore");
                int TimePlayedoffset = r.GetOrdinal("TimePlayed");
                //While loop to read all fields in class "Player_StatsDAL" for display purposes!
                while (r.Read())
                {
                    Player_StatsDAL item = new Player_StatsDAL();
                    //Remember the field order of the table "Player_Stats" is what RULES!!!!
                    item.UserID = r.GetInt32(UserIDoffset);
                    item.Username = r.GetString(Usernameoffset);
                    item.InGameRank = r.GetInt32(InGameRankoffset);
                    item.Progression = r.GetInt32(Progressionoffset);
                    item.LongestSurvivalTime = r.GetTimeSpan(LongestSurvivalTimeoffset);
                    item.HighestElevation = r.GetInt32(HighestElevationoffset);
                    item.HighScore = r.GetInt32(HighScoreoffset);
                    item.TimePlayed = r.GetTimeSpan(TimePlayedoffset);
                    rv.Add(item);
                }
                r.Close();
                return rv;
            }
        //Creating a public list to READ all ProfileInfos utilizing a while loop!
        public List<Profile_InfoDAL> ViewAllProfileInfos()
            {
                //Creating Sql Command variable "CMD".
                SqlCommand CMD = BoundNETDataConnection.CreateCommand();
                //Defining the variable "CMD" as a connection to a stored procedure. 
                CMD.CommandType = System.Data.CommandType.StoredProcedure;
                //Identifying stored procedure name. 
                CMD.CommandText = "SP_ViewAllProfileInfo";
                //Defining the alias "r" as a function!
                SqlDataReader r = CMD.ExecuteReader();
                //Defining "rv" alias as a returning value for the class "List<>"!
                List<Profile_InfoDAL> rv = new List<Profile_InfoDAL>();
                //Defining the values to be inserted into variables for the "GetOrdinal" method!
                int CustomerIDoffset = r.GetOrdinal("CustomerID");
                int UsernameIDoffset = r.GetOrdinal("Username");
                int FirstNameoffset = r.GetOrdinal("FirstName");
                int LastNameoffset = r.GetOrdinal("LastName");
                int RoleTypeoffset = r.GetOrdinal("RoleType");
                int Emailoffset = r.GetOrdinal("Email");
                int Addressoffset = r.GetOrdinal("Address");
                int Cityoffset = r.GetOrdinal("City");
                int Stateoffset = r.GetOrdinal("State");
                int ZipCodeoffset = r.GetOrdinal("ZipCode");
                //While loop to read all fields in class "Profile_InfoDAL" for display purposes!
                while (r.Read())
                {
                    Profile_InfoDAL item = new Profile_InfoDAL();
                    item.CustomerID = r.GetInt32(CustomerIDoffset);
                    item.Username = r.GetString(UsernameIDoffset);
                    item.FirstName = r.GetString(FirstNameoffset);
                    item.LastName = r.GetString(LastNameoffset);
                    item.RoleType = r.GetString(RoleTypeoffset);
                    item.Email = r.GetString(Emailoffset);
                    item.Address = r.GetString(Addressoffset);
                    item.City = r.GetString(Cityoffset);
                    item.State = r.GetString(Stateoffset);
                    item.ZipCode = r.GetInt32(ZipCodeoffset);
                    rv.Add(item);
                }
                r.Close();
                return rv;
            }
        //Creating a public list to READ all PaymentInfos utilizing a while loop!
        public List<Payment_InfoDAL> ViewAllPaymentInfos()
            {
                //Creating Sql Command variable "CMD".
                SqlCommand CMD = BoundNETDataConnection.CreateCommand();
                //Defining the variable "CMD" as a connection to a stored procedure. 
                CMD.CommandType = System.Data.CommandType.StoredProcedure;
                //Identifying stored procedure name. 
                CMD.CommandText = "SP_ViewAllPaymentInfo";
                //Defining the alias "r" as a function!
                SqlDataReader r = CMD.ExecuteReader();
                //Defining "rv" alias as a returning value for the class "List<>"!
                List<Payment_InfoDAL> rv = new List<Payment_InfoDAL>();
                //Defining the values to be inserted into variables for the "GetOrdinal" method!
                int OrderIDoffset = r.GetOrdinal("OrderID");
                int CustomerIDoffset = r.GetOrdinal("CustomerID");
                int Nameoffset = r.GetOrdinal("Name");
                int CreditCardNumberoffset = r.GetOrdinal("CreditCardNumber");
                int ExpirationDateoffset = r.GetOrdinal("ExpirationDate");
                int CVCcodeoffset = r.GetOrdinal("CVCcode");
                int ZipCodeoffset = r.GetOrdinal("ZipCode");
                int ItemPurchasedoffset = r.GetOrdinal("ItemPurchased");
                int DatePurchasedoffset = r.GetOrdinal("DatePurchased"); 
                //While loop to read all fields in class "Payment_InfoDAL" for display purposes!
                while (r.Read())
                {
                    Payment_InfoDAL item = new Payment_InfoDAL();
                    item.OrderID = r.GetInt32(OrderIDoffset);
                    item.CustomerID = r.GetInt32(CustomerIDoffset);
                    item.Name = r.GetString(Nameoffset);
                    item.CreditCardNumber = r.GetInt32(CreditCardNumberoffset);
                    item.ExpirationDate = r.GetDateTime(ExpirationDateoffset);
                    item.CVCcode = r.GetInt32(CVCcodeoffset);
                    item.ZipCode = r.GetInt32(ZipCodeoffset);
                    item.ItemPurchased = r.GetString(ItemPurchasedoffset);
                    item.DatePurchased = r.GetDateTime(DatePurchasedoffset);
                    rv.Add(item);
                }
                r.Close();
                return rv;
            }
        #endregion
        #region SqlCommands READ USER'S INDIVIDUAL TABLES (READ) 
        //Creating a public list to read an individual's Userlogin!
        public List<User_LoginDAL> ViewIndividualUserLogin()
        {
            //Creating Sql Command variable "CMD".
            SqlCommand CMD = BoundNETDataConnection.CreateCommand();
            //Defining the variable "CMD" as a connection to a stored procedure.
            CMD.CommandType = System.Data.CommandType.StoredProcedure;
            //Identifying stored procedure name. 
            CMD.CommandText = "SP_ViewIndividualUserlogin";
            //Defining the alias "r" as a function!
            SqlDataReader r = CMD.ExecuteReader();
            //Defining "rv" alias as a returning value for the class "List<>"!
            List<User_LoginDAL> rv = new List<User_LoginDAL>();
            //Defining the values to be inserted into variables for the "GetOrdinal" method!
            int UserIDoffset = r.GetOrdinal("UserID");
            int Emailoffset = r.GetOrdinal("Email");
            int Passwordoffset = r.GetOrdinal("Password");
            int RoleTypeoffset = r.GetOrdinal("RoleType");
            int Saltoffset = r.GetOrdinal("Salt");
            //Executing the reader to read all fields in class "User_loginDAL" of a indivdual user!!!
            r.Read();
            {
                User_LoginDAL item = new User_LoginDAL();
                item.UserID = r.GetInt32(UserIDoffset);
                item.Email = r.GetString(Emailoffset);
                item.Password = r.GetString(Passwordoffset);
                item.RoleType = r.GetString(RoleTypeoffset);
                item.Salt = r.GetString(Saltoffset);
                rv.Add(item);
            }
            r.Close();
            return rv;
        }
        //Creating a public list to read an individual's PlayerStats!
        public List<Player_StatsDAL> ViewIndivdualPlayerStats()
        {
            //Creating Sql Command variable "CMD".
            SqlCommand CMD = BoundNETDataConnection.CreateCommand();
            //Defining the variable "CMD" as a connection to a stored procedure. 
            CMD.CommandType = System.Data.CommandType.StoredProcedure;
            //Identifying stored procedure name. 
            CMD.CommandText = "SP_ViewIndividualPlayerStats";
            //Defining the alias "r" as a function!
            SqlDataReader r = CMD.ExecuteReader();
            //Defining "rv" alias as a returning value for the class "List<>"!
            List<Player_StatsDAL> rv = new List<Player_StatsDAL>();
            //Defining the values to be inserted into variables for the "GetOrdinal" method!
            int UserIDoffset = r.GetOrdinal("UserID");
            int Usernameoffset = r.GetOrdinal("Username");
            int InGameRankoffset = r.GetOrdinal("InGameRank");
            int Progressionoffset = r.GetOrdinal("Progression");
            int LongestSurvivalTimeoffset = r.GetOrdinal("LongestSurvivalTime");
            int HighestElevationoffset = r.GetOrdinal("HighestElevation");
            int HighScoreoffset = r.GetOrdinal("HighScore");
            int TimePlayedoffset = r.GetOrdinal("TimePlayed");
            //Executing the reader to read all fields in class "Player_StatsDAL" of a indivdual user!!!
            r.Read();
            {
                Player_StatsDAL item = new Player_StatsDAL();
                item.Username = r.GetString(Usernameoffset);
                item.UserID = r.GetInt32(UserIDoffset);
                item.InGameRank = r.GetInt32(InGameRankoffset);
                item.Progression = r.GetInt32(Progressionoffset);
                item.LongestSurvivalTime = r.GetTimeSpan(LongestSurvivalTimeoffset);
                item.HighestElevation = r.GetInt32(HighestElevationoffset);
                item.HighScore = r.GetInt32(HighScoreoffset);
                item.TimePlayed = r.GetTimeSpan(TimePlayedoffset);
                rv.Add(item);
            }
            r.Close();
            return rv;
        }
        //Creating a public list to read an individual's ProfileInfo!
        public List<Profile_InfoDAL> ViewIndividualProfileInfo()
        {
            //Creating Sql Command variable "CMD".
            SqlCommand CMD = BoundNETDataConnection.CreateCommand();
            //Defining the variable "CMD" as a connection to a stored procedure. 
            CMD.CommandType = System.Data.CommandType.StoredProcedure;
            //Identifying stored procedure name. 
            CMD.CommandText = "SP_ViewIndividualProfileInfo";
            //Defining the alias "r" as a function!
            SqlDataReader r = CMD.ExecuteReader();
            //Defining "rv" alias as a returning value for the class "List<>"!
            List<Profile_InfoDAL> rv = new List<Profile_InfoDAL>();
            //Defining the values to be inserted into variables for the "GetOrdinal" method!
            int CustomerIDoffset = r.GetOrdinal("CustomerID");
            int UsernameIDoffset = r.GetOrdinal("Username");
            int FirstNameoffset = r.GetOrdinal("FirstName");
            int LastNameoffset = r.GetOrdinal("LastName");
            int RoleTypeoffset = r.GetOrdinal("RoleType");
            int Emailoffset = r.GetOrdinal("Email");
            int Addressoffset = r.GetOrdinal("Address");
            int Cityoffset = r.GetOrdinal("City");
            int Stateoffset = r.GetOrdinal("State");
            int ZipCodeoffset = r.GetOrdinal("ZipCode");
            //Executing the reader to read all fields in class "Profile_InfoDAL" of a indivdual user!!!
            r.Read();
            {
                Profile_InfoDAL item = new Profile_InfoDAL();
                item.CustomerID = r.GetInt32(CustomerIDoffset);
                item.Username = r.GetString(UsernameIDoffset);
                item.FirstName = r.GetString(FirstNameoffset);
                item.LastName = r.GetString(LastNameoffset);
                item.RoleType = r.GetString(RoleTypeoffset);
                item.Email = r.GetString(Emailoffset);
                item.Address = r.GetString(Addressoffset);
                item.City = r.GetString(Cityoffset);
                item.ZipCode = r.GetInt32(ZipCodeoffset);
                rv.Add(item);
            }
            if (r.Read()) throw new Exception("Multiple records found only one record expected"); 
            r.Close();
            return rv;
        }
        //Creating a public list to read an individual's PaymentInfo!
        public List<Payment_InfoDAL> ViewIndividualPaymentInfos()
        {
            //Creating Sql Command variable "CMD".
            SqlCommand CMD = BoundNETDataConnection.CreateCommand();
            //Defining the variable "CMD" as a connection to a stored procedure. 
            CMD.CommandType = System.Data.CommandType.StoredProcedure;
            //Identifying stored procedure name. 
            CMD.CommandText = "SP_ViewIndividualPaymentInfo";
            //Defining the alias "r" as a function!
            SqlDataReader r = CMD.ExecuteReader();
            //Defining "rv" alias as a returning value for the class "List<>"!
            List<Payment_InfoDAL> rv = new List<Payment_InfoDAL>();
            //Defining the values to be inserted into variables for the "GetOrdinal" method!
            int OrderIDoffset = r.GetOrdinal("OrderID");
            int CustomerIDoffset = r.GetOrdinal("CustomerID");
            int Nameoffset = r.GetOrdinal("Name");
            int CreditCardNumberoffset = r.GetOrdinal("CreditCardNumber");
            int ExpirationDateoffset = r.GetOrdinal("ExpirationDate");
            int CVCcodeoffset = r.GetOrdinal("CVCcode");
            int ZipCodeoffset = r.GetOrdinal("ZipCode");
            int ItemPurchasedoffset = r.GetOrdinal("ItemPurchased");
            int DatePurchasedoffset = r.GetOrdinal("DatePurchased");
            //Executing the reader to read all fields in class "Profile_InfoDAL" of a indivdual user!!!
            r.Read();
            {
                Payment_InfoDAL item = new Payment_InfoDAL();
                item.OrderID = r.GetInt32(OrderIDoffset);
                item.CustomerID = r.GetInt32(CustomerIDoffset);
                item.Name = r.GetString(Nameoffset);
                item.CreditCardNumber = r.GetInt32(CreditCardNumberoffset);
                item.ExpirationDate = r.GetDateTime(ExpirationDateoffset);
                item.CVCcode = r.GetInt32(CVCcodeoffset);
                item.ZipCode = r.GetInt32(ZipCodeoffset);
                item.ItemPurchased = r.GetString(ItemPurchasedoffset);
                item.DatePurchased = r.GetDateTime(DatePurchasedoffset);
                rv.Add(item);
            }
            r.Close();
            return rv;
        }
        #endregion
        #region SqlCommands Foreign Key Relations (READ)
        //Creating a public list class to read PlayerStats from foriegn key "UserID" for display purposes!  
        public List<Player_StatsDAL> ViewPlayerStatsByUserID(int UserID)
        {
            //Creating Sql Command variable "CMD".
            SqlCommand CMD = BoundNETDataConnection.CreateCommand();
            //Defining the variable "CMD" as a connection to a stored procedure. 
            CMD.CommandType = System.Data.CommandType.StoredProcedure;
            //Identifying stored procedure name. 
            CMD.CommandText = "SP_ViewPlayerStatsByUserID";
            CMD.Parameters.AddWithValue("@UserID", UserID);
            //Defining the alias "r" as a function!
            SqlDataReader r = CMD.ExecuteReader();
            //Defining "rv" alias as a returning value for the class "List<>"!
            List<Player_StatsDAL> rv = new List<Player_StatsDAL>();
            //Defining the values to be inserted into variables for the "GetOrdinal" method!
            int UserIDoffset = r.GetOrdinal("UserID");
            int Usernameoffset = r.GetOrdinal("Username");
            int InGameRankoffset = r.GetOrdinal("InGameRank");
            int Progressionoffset = r.GetOrdinal("Progression");
            int LongestSurvivalTimeoffset = r.GetOrdinal("LongestSurvivalTime");
            int HighestElevationoffset = r.GetOrdinal("HighestElevation");
            int HighScoreoffset = r.GetOrdinal("HighScore");
            int TimePlayedoffset = r.GetOrdinal("TimePlayed");
            //While loop to read all fields in class "Player_StatsDAL" for display purposes!
            while (r.Read())
            {
                Player_StatsDAL item = new Player_StatsDAL();
                //Remember the field order of the table "Player_Stats" is what RULES!!!!
                item.UserID = r.GetInt32(UserIDoffset);
                item.Username = r.GetString(Usernameoffset);
                item.InGameRank = r.GetInt32(InGameRankoffset);
                item.Progression = r.GetInt32(Progressionoffset);
                item.LongestSurvivalTime = r.GetTimeSpan(LongestSurvivalTimeoffset);
                item.HighestElevation = r.GetInt32(HighestElevationoffset);
                item.HighScore = r.GetInt32(HighScoreoffset);
                item.TimePlayed = r.GetTimeSpan(TimePlayedoffset);
                rv.Add(item);
            }
            r.Close();
            return rv;
        }
        //Creating a public list class to read ProfileInfo from foriegn key "Username" for display purposes!
        public List<Profile_InfoDAL> ViewProfileInfosByUsername(string Username)
        {
            //Creating Sql Command variable "CMD".
            SqlCommand CMD = BoundNETDataConnection.CreateCommand();
            //Defining the variable "CMD" as a connection to a stored procedure. 
            CMD.CommandType = System.Data.CommandType.StoredProcedure;
            //Identifying stored procedure name. 
            CMD.CommandText = "SP_ViewProfileInfoByUsername";
            CMD.Parameters.AddWithValue("@Username", Username);
            //Defining the alias "r" as a function!
            SqlDataReader r = CMD.ExecuteReader();
            //Defining "rv" alias as a returning value for the class "List<>"!
            List<Profile_InfoDAL> rv = new List<Profile_InfoDAL>();
            //Defining the values to be inserted into variables for the "GetOrdinal" method!
            int CustomerIDoffset = r.GetOrdinal("CustomerID");
            int UsernameIDoffset = r.GetOrdinal("Username");
            int FirstNameoffset = r.GetOrdinal("FirstName");
            int LastNameoffset = r.GetOrdinal("LastName");
            int RoleTypeoffset = r.GetOrdinal("RoleType");
            int Emailoffset = r.GetOrdinal("Email");
            int Addressoffset = r.GetOrdinal("Address");
            int Cityoffset = r.GetOrdinal("City");
            int Stateoffset = r.GetOrdinal("State");
            int ZipCodeoffset = r.GetOrdinal("ZipCode");
            //While loop to read all fields in class "Profile_InfoDAL" for display purposes!
            while (r.Read())
            {
                Profile_InfoDAL item = new Profile_InfoDAL();
                item.CustomerID = r.GetInt32(CustomerIDoffset);
                item.Username = r.GetString(UsernameIDoffset);
                item.FirstName = r.GetString(FirstNameoffset);
                item.LastName = r.GetString(LastNameoffset);
                item.RoleType = r.GetString(RoleTypeoffset);
                item.Email = r.GetString(Emailoffset);
                item.Address = r.GetString(Addressoffset);
                item.City = r.GetString(Cityoffset);
                item.State = r.GetString(Stateoffset);
                item.ZipCode = r.GetInt32(ZipCodeoffset);
                rv.Add(item);
            }
            r.Close();
            return rv;
        }
        //Creating a public list class to read PaymentInfo from foriegn key "CustomerID" for display purposes!
        public List<Payment_InfoDAL> ViewPaymentInfoByCustomerID(int CustomerID)
        {
            //Creating Sql Command variable "CMD".
            SqlCommand CMD = BoundNETDataConnection.CreateCommand();
            //Defining the variable "CMD" as a connection to a stored procedure. 
            CMD.CommandType = System.Data.CommandType.StoredProcedure;
            //Identifying stored procedure name. 
            CMD.CommandText = "SP_ViewAllPaymentInfo";
            CMD.Parameters.AddWithValue("@CustomerID", CustomerID);
            //Defining the alias "r" as a function!
            SqlDataReader r = CMD.ExecuteReader();
            //Defining "rv" alias as a returning value for the class "List<>"!
            List<Payment_InfoDAL> rv = new List<Payment_InfoDAL>();
            //Defining the values to be inserted into variables for the "GetOrdinal" method!
            int OrderIDoffset = r.GetOrdinal("OrderID");
            int CustomerIDoffset = r.GetOrdinal("CustomerID");
            int Nameoffset = r.GetOrdinal("Name");
            int CreditCardNumberoffset = r.GetOrdinal("CreditCardNumber");
            int ExpirationDateoffset = r.GetOrdinal("ExpirationDate");
            int CVCcodeoffset = r.GetOrdinal("CVCcode");
            int ZipCodeoffset = r.GetOrdinal("ZipCode");
            int ItemPurchasedoffset = r.GetOrdinal("ItemPurchased");
            int DatePurchasedoffset = r.GetOrdinal("DatePurchased");
            //While loop to read all fields in class "Payment_InfoDAL" for display purposes!
            while (r.Read())
            {
                Payment_InfoDAL item = new Payment_InfoDAL();
                item.OrderID = r.GetInt32(OrderIDoffset);
                item.CustomerID = r.GetInt32(CustomerIDoffset);
                item.Name = r.GetString(Nameoffset);
                item.CreditCardNumber = r.GetInt32(CreditCardNumberoffset);
                item.ExpirationDate = r.GetDateTime(ExpirationDateoffset);
                item.CVCcode = r.GetInt32(CVCcodeoffset);
                item.ZipCode = r.GetInt32(ZipCodeoffset);
                item.ItemPurchased = r.GetString(ItemPurchasedoffset);
                item.DatePurchased = r.GetDateTime(DatePurchasedoffset);
                rv.Add(item);
            }
            r.Close();
            return rv;
        }
        #endregion
        #region SqlCommands Update All Tables (UPDATE)
        //Creating a Sql Command to update an individual user's login information!
        public void UpdateUserLogin(string Email, string Password, string RoleType)
        {
            SqlConnection connectionToSql = new SqlConnection();
            using (SqlCommand command = new SqlCommand("SP_UpdateUserLogin", BoundNETDataConnection))
            {
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.AddWithValue("@Email", Email);
                command.Parameters.AddWithValue("@Password", Password);
                command.Parameters.AddWithValue("@RoleType", RoleType);
                try
                {
                    command.ExecuteNonQuery();
                }
                catch (Exception ex)
                {
                    // log the exception in ex
                    throw ex;
                }
            }
        }
        //Creating a Sql Command to update an individual user's player statistics!
        public void UpdatePlayerStats(string Username, int UserID, int InGameRank, int Progression, TimeSpan LongestSurvivalTime, int HighestElevation, int HighScore, TimeSpan TimePlayed)
        {
            SqlConnection connectionToSql = new SqlConnection();
            using (SqlCommand command = new SqlCommand("SP_UpdatePlayerStats", BoundNETDataConnection))
            {
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.AddWithValue("@Username", Username);
                command.Parameters.AddWithValue("@UserID", UserID);
                command.Parameters.AddWithValue("@InGameRank", InGameRank);
                command.Parameters.AddWithValue("@Progression", Progression);
                command.Parameters.AddWithValue("@LongestSurvivalTime", LongestSurvivalTime);
                command.Parameters.AddWithValue("@HighestElevation", HighestElevation);
                command.Parameters.AddWithValue("@HighScore", HighScore);
                command.Parameters.AddWithValue("@TimePlayed", TimePlayed);
                try
                {
                    command.ExecuteNonQuery();
                }
                catch (Exception ex)
                {
                    // log the exception in ex
                    throw ex;
                }
            }
        }
        //Creating a Sql Command to update an individualuser's profile information!
        public void UpdateProfileInfo(int CustomerID, string Username, string FirstName, string LastName, string RoleType, string Email, string Address, string City, string State, int ZipCode)
        {
            SqlConnection connectionToSql = new SqlConnection();
            using (SqlCommand command = new SqlCommand("SP_UpdateProfileInfo", BoundNETDataConnection))
            {
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.AddWithValue("@CustomerID", CustomerID);
                command.Parameters.AddWithValue("@Username", Username);
                command.Parameters.AddWithValue("@FirstName", FirstName);
                command.Parameters.AddWithValue("@LastName", LastName);
                command.Parameters.AddWithValue("@RoleType", RoleType);
                command.Parameters.AddWithValue("@Email", Email);
                command.Parameters.AddWithValue("@Address", Address);
                command.Parameters.AddWithValue("@City", City);
                command.Parameters.AddWithValue("@State", State);
                command.Parameters.AddWithValue("@ZipCode", ZipCode);
                try
                {
                    command.ExecuteNonQuery();
                }
                catch (Exception ex)
                {
                    // log the exception in ex
                    throw ex;
                }
            }
        }
        //Creating a Sql Command to update an individual user's payment information!
        public void UpdatePaymentInfo(int OrderID, int CustomerID, string Name, int CreditCardNumber, DateTime ExpirationDate, int CVCcode, int ZipCode, string ItemPurchased, DateTime DatePurchased)
        {
            SqlConnection connectionToSql = new SqlConnection();
            using (SqlCommand command = new SqlCommand("SP_UpdatePaymentInfo", BoundNETDataConnection))
            {
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.AddWithValue("@OrderID", OrderID);
                command.Parameters.AddWithValue("@CustomerID", CustomerID);
                command.Parameters.AddWithValue("@Name", Name);
                command.Parameters.AddWithValue("@CreditCardNumber", CreditCardNumber);
                command.Parameters.AddWithValue("@ExpirationDate", ExpirationDate);
                command.Parameters.AddWithValue("@CVCcode", CVCcode);
                command.Parameters.AddWithValue("@ZipCode", ZipCode);
                command.Parameters.AddWithValue("@ItemPurchased", ItemPurchased);
                command.Parameters.AddWithValue("@DatePurchased", DatePurchased);
                try
                {
                    command.ExecuteNonQuery();
                }
                catch (Exception ex)
                {
                    // log the exception in ex
                    throw ex;
                }
            }
        }
        #endregion
        #region SqlCommands Delete All Tables (DELETE)
        //Creating a Sql Command to delete an individual user's login upon administrator ban or account deletion!
        public void DeleteNewUserLogin(int UserID, string Email, string Password, string RoleType, string Salt)
        {
            SqlConnection connectionToSql = new SqlConnection();
            using (SqlCommand command = new SqlCommand("SP_DeleteUserLogin", BoundNETDataConnection))
            {
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.AddWithValue("@UserID", UserID);
                command.Parameters.AddWithValue("@Email", Email);
                command.Parameters.AddWithValue("@Password", Password);
                command.Parameters.AddWithValue("@RoleType", RoleType);
                command.Parameters.AddWithValue("@Salt", Salt);
                try
                {
                    command.ExecuteNonQuery();
                }
                catch (Exception ex)
                {
                    // log the exception in ex
                    throw ex;
                    
                }
            }
        }
        //Creating a Sql Command to delete an individual user's player statistics upon administrator ban or account deletion!
        public void DeletePlayerStats(string Username, int UserID, int InGameRank, int Progression, TimeSpan LongestSurvivalTime, int HighestElevation, int HighScore, TimeSpan TimePlayed)
        {
            SqlConnection connectionToSql = new SqlConnection();
            using (SqlCommand command = new SqlCommand("SP_DeletePlayerStats", BoundNETDataConnection))
            {
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.AddWithValue("@Username", Username);
                command.Parameters.AddWithValue("@UserID", UserID);
                command.Parameters.AddWithValue("@InGameRank", InGameRank);
                command.Parameters.AddWithValue("@Progression", Progression);
                command.Parameters.AddWithValue("@LongestSurvivalTime", LongestSurvivalTime);
                command.Parameters.AddWithValue("@HighestElevation", HighestElevation);
                command.Parameters.AddWithValue("@HighScore", HighScore);
                command.Parameters.AddWithValue("@TimePlayed", TimePlayed);
                try
                {
                    command.ExecuteNonQuery();
                }
                catch (Exception ex)
                {
                    // log the exception in ex
                    throw ex;
                }
            }
        }
        //Creating a Sql Command to delete an individual user's profile information upon administrator ban or account deletion!
        public void DeleteProfileInfo(int CustomerID, string Username, string FirstName, string LastName, string RoleType, string Email, string Address, string City, string State, int ZipCode)
        {
            SqlConnection connectionToSql = new SqlConnection();
            using (SqlCommand command = new SqlCommand("SP_DeleteProfileInfo", BoundNETDataConnection))
            {
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.AddWithValue("@CustomerID", CustomerID);
                command.Parameters.AddWithValue("@Username", Username);
                command.Parameters.AddWithValue("@FirstName", FirstName);
                command.Parameters.AddWithValue("@LastName", LastName);
                command.Parameters.AddWithValue("@Email", Email);
                command.Parameters.AddWithValue("@Address", Address);
                command.Parameters.AddWithValue("@City", City);
                command.Parameters.AddWithValue("@State", State);
                command.Parameters.AddWithValue("@ZipCode", ZipCode);
                try
                {
                    command.ExecuteNonQuery();
                }
                catch (Exception ex)
                {
                    // log the exception in ex
                    throw ex;
                }
            }
        }
        //Creating Sql Commands to delete and individual user's payment information upon administrator ban or account deletion! 
        public void DeletePaymentInfo(int OrderID, string Username, string Name, int CreditCardNumber, DateTime ExpirationDate, int CVCcode, int ZipCode, string ItemPurchased, DateTime DatePurchased)
        {
            SqlConnection connectionToSql = new SqlConnection();
            using (SqlCommand command = new SqlCommand("SP_DeletePaymentInfo", BoundNETDataConnection))
            {
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.AddWithValue("@OrderID", OrderID);
                command.Parameters.AddWithValue("@Username", Username);
                command.Parameters.AddWithValue("@Name", Name);
                command.Parameters.AddWithValue("@CreditCardNumber", CreditCardNumber);
                command.Parameters.AddWithValue("@ExpirationDate", ExpirationDate);
                command.Parameters.AddWithValue("@CVCcode", CVCcode);
                command.Parameters.AddWithValue("@ZipCode", ZipCode);
                command.Parameters.AddWithValue("@ItemPurchased", ItemPurchased);
                command.Parameters.AddWithValue("@DatePurchased", DatePurchased);
                try
                {
                    command.ExecuteNonQuery();
                }
                catch (Exception ex)
                {
                    // log the exception in ex
                    throw ex;
                }
            }
        }
        #endregion
    }
}
