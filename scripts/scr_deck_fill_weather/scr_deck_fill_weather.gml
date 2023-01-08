// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_deck_fill_weather(deck, hand, _random){

	var maxhand = 0;
	switch(deck)
	{
		case (weather_deck):
		{
			maxhand = max_weather_hand;
		}	
			break;
		
		case (seed_deck):
		{
			maxhand = max_seed_hand;
		}	
			break;
	
		case (resource_deck):
		{
			maxhand = max_resource_hand;
		}	
			break;
	}	
	
	
	if _random = true ds_list_shuffle(deck);
	
	
	for(var i = (0); i < maxhand; i++)
	{
		if ds_list_size(deck) > 0
		{
			hand[| i] = deck[| i];	
		}
		else break;
	}	

}