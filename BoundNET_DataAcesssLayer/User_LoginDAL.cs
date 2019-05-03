using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BoundNET_DataAcesssLayer
{
    //Retrieving the table "[dbo].[User_login]" from the database "BoundNETData". 
    public class User_LoginDAL
    {
        public int UserID { get; set; }
        public string Email { get; set; }
        public string Password { get; set; }
        public string RoleType { get; set; }
        public string Salt { get; set; }
        public override string ToString()
        {
            return $"UserId: {UserID} Email: {Email} Password: {Password} RoleType: {RoleType} Salt {Salt}";
        }
    }
}
