using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BoundNET_DataAcesssLayer
{
    //Retrieving table "[dbo].[Player_Stats]" from the database "BoundNETData".
    public class Player_StatsDAL
    {
        public string Username { get; set; }
        public int UserID { get; set; }
        public int InGameRank { get; set; }
        public int Progression { get; set; }
        public TimeSpan LongestSurvivalTime { get; set; }
        public int HighestElevation {get; set;} 
        public int HighScore { get; set; }
        public TimeSpan TimePlayed { get; set; }
        public override string ToString()
        {
            return $"Username {Username} UserID: {UserID} InGameRank: {InGameRank} Progression: {Progression} LongestSurvivalTime: {LongestSurvivalTime} HighestElevation: {HighestElevation} HighScore: {HighScore} TimePlayed {TimePlayed}";
        }
    }
}
