using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BoundNET_DataAcesssLayer
{
    //Retrieving the table "[dbo].[Payment_Info]" for the database "BoundNETData". 
    public class Payment_InfoDAL
    {
        public int OrderID { get; set; }
        public int CustomerID { get; set; }
        public string Name { get; set;}
        public int CreditCardNumber { get; set; }
        public DateTime ExpirationDate { get; set; }
        public int CVCcode { get; set; }
        public int ZipCode { get; set; }
        public string ItemPurchased { get; set; }
        public DateTime DatePurchased { get; set; }
        public override string ToString()
        {
            return $"OrderID {OrderID} CustomerID {CustomerID} Name {Name} " +
                $"CreditCardNumber {CreditCardNumber} ExpirationDate {ExpirationDate} CVCcode {CVCcode} " +
                $"ZipCode {ZipCode} ItemPurchased {ItemPurchased}";
        }
    }
}
