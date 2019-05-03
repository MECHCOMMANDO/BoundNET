using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BoundNET_BusinessLogicLayer
{

    class User_LoginBLL
    {
        #region Constructors
        // a default constructor is REQUIRED to support MVC Model Binding!!!
        // because of the DAL Constructor, the default constructor must be explicitly defined
        public User_LoginBLL()
        {

        }
        // the mapping between the DAL and the BLL is done through this constructor.
        // the default constuctor must be defined explicity because of the existance of this constructor
        internal User_LoginBLL(BoundNET_DataAcesssLayer.User_LoginDAL r)
        {
            UserID = r.UserID;
            Email = r.Email;
            Password = r.Password;
            RoleType = r.RoleType;
            Salt = r.Salt;
        }
        #endregion
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

