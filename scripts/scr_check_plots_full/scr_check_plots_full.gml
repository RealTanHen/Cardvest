// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_check_plots_full(){

	var allplotsempty = true;
	var someplotsempty = false;
	for(var p = 0; p < plot_nr; p++)
	{
		if plots[# e_plotinfo.seed, p] == 0
		{
			someplotsempty = true;
		}	
		else
		{
			allplotsempty = false;	
		}	
	}	
	
	if allplotsempty == true return(-1);
	if someplotsempty == true return(0);
	return(1);

}