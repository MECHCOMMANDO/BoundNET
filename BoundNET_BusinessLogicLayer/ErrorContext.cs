using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BoundNET_BusinessLogicLayer
{
    //This is BoundNET's error handling infrastructure! 
    public class ErrorContext
    {
        public void E1()
        {
            throw new Exception("This is E1, exception");
        }
        public void E2()
        {
            throw new DivideByZeroException("This is E2, dividebyzero");
        }
        public void E3()
        {
            throw new InvalidOperationException("this is E3, invalidoperation");
        }
    }
}
