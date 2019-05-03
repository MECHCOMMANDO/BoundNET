using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using BoundNET_DataAcesssLayer;

namespace BoundNET
{
    class Program
    {
        //Main program!
        static void Main(string[] args)
        {
            //Reading the connection string from app.config with the name "xxx"
            String cs = System.Configuration.ConfigurationManager.ConnectionStrings["xxx"].ConnectionString;
            //We are making a variable called "CTX" which is of type "ContextDAL" which is the custom class I made!
            //This context gives me all the access I need to the database!
            ContextDAL CTX = new ContextDAL();
            #region Executing SqlCommands from "Register all Tables (CREATE)"!
            
            #endregion
            #region Executing SqlCommands from "READ ALL TABLES (READ)"
            //Opening BoundNETData string connnection!
            //Executing ContextDAL's SqlCommands from region "READ ALL TABLES (READ)"!
            //Executing ContextDAL's method "ViewAllUserLogins"! 
            //------Administrator Power-------//
            CTX.open(cs);
            var l = CTX.ViewAllUserLogins();
            foreach (var x in l)
            {
                Console.WriteLine(x);
            }
            CTX.close();
            //Executing ContextDAL's method "ViewAllPlayerStats"! 
            //------Administrator/Moderator Power-------//
            CTX.open(cs);
            var l2 = CTX.ViewAllPlayerStats();
            foreach (var x in l2)
            {
                Console.WriteLine(x);
            }
            CTX.close();
            //Executing ContextDAL's method "ViewAllProfileInfos"! 
            //------Administrator/Moderator Power-------//
            CTX.open(cs);
            var l3 = CTX.ViewAllProfileInfos();
            foreach (var x in l3)
            {
                Console.WriteLine(x);
            }
            CTX.close();
            //Executing ContextDAL's method "ViewAllPlayerStats"! 
            //------Administrator/Moderator Power-------//
            CTX.open(cs);
            var l4 = CTX.ViewAllPaymentInfos();
            foreach (var x in l4)
            {
                Console.WriteLine(x);
            }
            CTX.close();
            #endregion
        }
    }
}
