using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BoundNET_BusinessLogicLayer
{
    class Profile_InfoBLL
    {
        #region Constructors
        // a default constructor is REQUIRED to support MVC Model Binding!!!
        // because of the DAL Constructor, the default constructor must be explicitly defined
        public Profile_InfoBLL()
        {

        }
        // the mapping between the DAL and the BLL is done through this constructor.
        // the default constuctor must be defined explicity because of the existance of this constructor
        internal Profile_InfoBLL(BoundNET_DataAcesssLayer.Profile_InfoDAL r)
        {
            CustomerID = r.CustomerID;
            Username = r.Username;
            FirstName = r.FirstName;
            LastName = r.LastName;
            RoleType = r.RoleType;
            Email = r.Email;
            Address = r.Address;
            City = r.City;
            State = r.State;
            ZipCode = r.ZipCode;
        }
        #endregion
        public int CustomerID { get; set; }
        public string Username { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string RoleType { get; set; }
        public string Email { get; set; }
        public string Address { get; set; }
        public string City { get; set; }
        public string State { get; set; }
        public int ZipCode { get; set; }
        public override string ToString()
        {
            return $"CustomerID: {CustomerID} Username: {Username} FirstName: {FirstName} LastName: {LastName} " +
                $"RoleType: {RoleType} Email: {Email} Address: {Address} City: {City} State: {State} ZipCode: {ZipCode}";
        }
    }
}
