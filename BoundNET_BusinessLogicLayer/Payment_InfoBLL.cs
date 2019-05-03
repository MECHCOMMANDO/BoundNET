using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BoundNET_BusinessLogicLayer
{
    class Payment_InfoBLL
    {
        #region Constructors
        // a default constructor is REQUIRED to support MVC Model Binding!!!
        // because of the DAL Constructor, the default constructor must be explicitly defined
        Payment_InfoBLL()
        {

        }
        // the mapping between the DAL and the BLL is done through this constructor.
        // the default constuctor must be defined explicity because of the existance of this constructor
        internal Payment_InfoBLL(BoundNET_DataAcesssLayer.Payment_InfoDAL r)
        {
            OrderID = r.OrderID;
            CustomerID = r.CustomerID;
            Name = r.Name;
            CreditCardNumber = r.CreditCardNumber;
            ExpirationDate = r.ExpirationDate;
            CVCcode = r.CVCcode;
            ZipCode = r.ZipCode;
            ItemPurchased = r.ItemPurchased;
            DatePurchased = r.DatePurchased;
        }
        #endregion
        public int OrderID { get; set; }
        public int CustomerID { get; set; }
        public string Name { get; set; }
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
