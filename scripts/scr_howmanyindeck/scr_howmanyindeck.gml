// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_howmanyindeck(deck, hand, cardid){

var tot_nr = 0;
for(var d = 0; d < ds_list_size(deck); d++)
{
	if deck[| d] == cardid tot_nr++;
}	

for(var h = 0; h < ds_list_size(hand); h++)
{
	if hand[| h] == cardid tot_nr++;	
}

return(tot_nr);

}