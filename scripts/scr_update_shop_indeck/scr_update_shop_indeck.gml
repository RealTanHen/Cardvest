// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_update_shop_indeck(){
for(var ss = 0; ss < ds_grid_height(seed_shop); ss++)
{
	var i_id_ = seed_shop[# e_shop.itemid, ss];
	seed_shop[# e_shop.in_deck, ss] = scr_howmanyindeck(seed_deck, seed_hand, i_id_);	
}	

for(var rs = 0; rs < ds_grid_height(resources_shop); rs++)
{
	var i_id_ = resources_shop[# e_shop.itemid, ss];
	resources_shop[# e_shop.in_deck, rs] = scr_howmanyindeck(resource_deck, resource_hand, i_id_);	
}
}