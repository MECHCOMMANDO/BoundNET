using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BoundNET_BusinessLogicLayer
{
    class Player_StatsBLL
    {
        #region Constructors
        // a default constructor is REQUIRED to support MVC Model Binding!!!
        // because of the DAL Constructor, the default constructor must be explicitly defined
        public Player_StatsBLL()
        {

        }
        // the mapping between the DAL and the BLL is done through this constructor.
        // the default constuctor must be defined explicity because of the existance of this constructor
        internal Player_StatsBLL(BoundNET_DataAcesssLayer.Player_StatsDAL r)
        {
            Username = r.Username;
            UserID = r.UserID;
            InGameRank = r.InGameRank;
            Progression = r.Progression;
            LongestSurvivalTime = r.LongestSurvivalTime;
            HighestElevation = r.HighestElevation;
            HighScore = r.HighScore;
            TimePlayed = r.TimePlayed;
        }
        #endregion
        public string Username { get; set; }
        public int UserID { get; set; }
        public int InGameRank { get; set; }
        public int Progression { get; set; }
        public TimeSpan LongestSurvivalTime { get; set; }
        public int HighestElevation { get; set; }
        public int HighScore { get; set; }
        public TimeSpan TimePlayed { get; set; }
        public override string ToString()
        {
            return $"Username {Username} UserID: {UserID} InGameRank: {InGameRank} Progression: {Progression} " +
                $"LongestSurvivalTime: {LongestSurvivalTime} HighestElevation: {HighestElevation} HighScore: {HighScore} " +
                $"TimePlayed {TimePlayed}";
        }
    }
}
