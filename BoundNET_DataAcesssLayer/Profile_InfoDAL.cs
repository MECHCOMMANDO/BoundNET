using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BoundNET_DataAcesssLayer
{
    // Retrieving the table "[dbo].[Profile_Info]" from the database "BoundNETData". 
    public class Profile_InfoDAL
    {
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
