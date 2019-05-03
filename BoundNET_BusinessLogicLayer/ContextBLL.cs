using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using BoundNET_DataAcesssLayer;
using System.Data;

namespace BoundNET_BusinessLogicLayer
{
   public class ContextBLL : IDisposable
   {
        #region Constructors/ Other Stuff
        private ContextDAL contextdal = new ContextDAL(); 
        public ContextBLL()
        {
            contextdal.ConnectionString= @"Data Source=GDC-BC-08\DYLAN;Initial Catalog=BoundNETData;Integrated Security=True";
        }
        public void Dispose()
        {
            contextdal.Dispose();
        }
        #endregion
        public List<User_LoginBLL>
   }
}
