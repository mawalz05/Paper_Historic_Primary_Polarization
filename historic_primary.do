*Upload the .dta file historic_primary dataset
use historic_primary /* Can be found on Git Hub Repository */


****************************************************************
*********************FIGURES*************************************
****************************************************************

*Code for Figure 1: Mean Party First Dimension NOMINATE Scores
set scheme s1mono
#delimit;
tw (line nom_dem date2, lcolor(gs10))
(line nom_rep date2, lcolor(gs2))
(scatteri .2 1920 "Republican", mlabcolor(black) mcolor(white))
(scatteri -.2 1920 "Democrat", mlabcolor(black) mcolor(white)), 
xlabel(1900(20)2020)
xline(1968, lpattern(dash))
ytitle("Mean NOMINATE Scores")
xtitle("Year")
legend(off)
;
*******************************************************************

*Code for Figure 2: The Effects of the Number of Primaries on Divergence
#delimit;
tw (scatter diff num_primaries, msymbol(cirlce) mcolor(gs4))
(lfit diff num_primaries, lcolor(gs4))
(scatter smooth_diff num_primaries, msymbol(X) mcolor(gs10))
(lfit smooth_diff num_primaries, lcolor(gs10)),
legend(order(1 "CMP Scores" 3 "Smoothed CMP"))
xtitle("Number of Primaries")
ytitle("Level of Divergence")
name("CMP")
;

#delimit;
tw (scatter diff_nom num_primaries, msymbol(plus) mcolor(gs8))
(lfit diff_nom num_primaries, lcolor(gs8)),
legend(order(1 "NOMINATE Scores"))
xtitle("Number of Primaries")
ytitle("Level of Divergence")
name("NOMINATE")
;
graph combine CMP NOMINATE
*************************************************************

*Code for Figure 3: CMP Left-Riht Ideology Over Time
set scheme s1mono
#delimit;
tw(line smooth_rile_d date2, lcolor(gs10))
(line smooth_rile_r date2, lcolor(gs2))
(line rile_d date2, lpattern(dash) lcolor(gs10))
(line rile_r date2, lpattern(dash) lcolor(gs2))
(scatteri 39 1900 "Early", mlabcolor(black) mcolor(white))
(scatteri 39 1918 "Ebbtide", mlabcolor(black) mcolor(white))
(scatteri 39 1945 "Reawakened", mlabcolor(black) mcolor(white))
(scatteri 39 1972 "Great Leap Forward", mlabcolor(black) mcolor(white))
(scatteri 19 1920 "Republican", mlabcolor(black) mcolor(white))
(scatteri -20 1920 "Democrat", mlabcolor(black) mcolor(white)), 
xline(1917 1945 1971, lpattern(dash))
xlabel(1900(20)2020)
ytitle("CMP Party Scores")
xtitle("Year")
legend(order(1 "Smoothed CMP" 3 "CMP"))
;
****************************************************************


**************************************************************
*******************REGRESSIONS********************************
***************************************************************

****************TABLE 2 REGRESSIONS*************************
*CMP column regresions in order
reg diff num_primaries
reg diff group2 if date2 > 1910

*Smoothed CMP column regressions in order
reg smooth_diff num_primaries
reg smooth_diff group2

*NOMINATE column regressions in order
reg diff_nom num_primaries
reg diff_nom group2 if date2 > 1910
******************************************************

***************TABLE 3 REGRESSIONS***************************
*CMP column regresions in order
reg diff num_primaries wealth 
reg diff num_primaries wealth per_south_rep

*Smoothed CMP column regressions in order
reg smooth_diff num_primaries wealth
reg smooth_diff num_primaries wealth per_south_rep

*NOMINATE column regressions in order
reg diff_nom num_primaries wealth
reg diff_nom num_primaries wealth per_south_rep
************************************************************

**************TABLE 4 REGRESSIONS***************************
*CMP column regresions
reg diff i.group if date2 > 1910

*Smoothed CMP column regressions 
reg smooth_diff i.group 

*NOMINATE column regressions 
reg diff_nom ib1.group if date2 > 1910
*****************************************************

**************TABLE 5 ERROR CORRECTION REGRESSIONS**********
*Setting Data as Time Series
tset date2, delta(4)

*CMP column regresions
reg d.diff l.diff d.num_primaries l.num_primaries

*Smoothed CMP column regressions 
reg d.smooth_diff l.smooth_diff d.num_primaries l.num_primaries

*NOMINATE column regressions 
reg d.diff_nom l.diff_nom d.num_primaries l.num_primaries
**************************************************
