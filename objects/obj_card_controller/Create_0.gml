#region enums, etc
enum e_cardtype
{
	none,
	weather,
	seed,
	resource,
}	

enum e_cardinfo
{
	name,
	growth,
	sun,
	water,
	harvestval,
	range,
	
}	

enum e_plotinfo
{
	plotnr, 
	grow,
	seed,
	death,
	sun, 
	water,
}	

enum e_gamestate
{
	seed_selection,
	weather_selection,
	weather_selected,
	resource_selection,
	resource_selected,
	finish_day,
	buy,
	loss,
}	
gamestate = e_gamestate.seed_selection;
max_weather_hand =3;
max_weather_deck =12;
max_seed_hand =5;
max_seed_deck =12;
max_resource_hand =5;
max_resource_deck =24;
plot_nr = 3;
money = 0;
plot_selection = -1;
card_selection = -1;
card_hand_selection = -1;
money_gained_today = 0;
plants_harvested = 0;
plants_died = 0;
day = 1;
#endregion

#region setting up card grids
weather_cards = load_csv("cards_weather.csv");
resource_cards = load_csv("cards_resource.csv");
seed_cards = load_csv("cards_seed.csv");

#endregion

#region setting up decks
weather_deck = ds_list_create();
weather_deck[| 0] = 1;
weather_deck[| 1] = 2;
weather_deck[| 2] = 3;
weather_deck[| 3] = 1;
weather_deck[| 4] = 2;
weather_deck[| 5] = 3;
weather_deck[| 6] = 1;
weather_deck[| 7] = 2;
weather_deck[| 8] = 3;
weather_deck[| 9] = 1;
weather_deck[| 10] = 2;
weather_deck[| 11] = 3;


seed_deck = ds_list_create();
seed_deck[| 0] = 1;
seed_deck[| 1] = 2;
seed_deck[| 2] = 3;

resource_deck = ds_list_create();
resource_deck[| 0] = 1;
resource_deck[| 1] = 2;
resource_deck[| 2] = 3;
resource_deck[| 3] = 1;
resource_deck[| 4] = 2;
resource_deck[| 5] = 3;


#endregion

#region setting up hands
seed_hand = ds_list_create();
scr_deck_fill_hand(seed_deck, seed_hand, 1);

weather_hand = ds_list_create();
scr_deck_fill_hand(weather_deck, weather_hand, 1);

resource_hand = ds_list_create();
scr_deck_fill_hand(resource_deck, resource_hand, 1);


#endregion

#region setting up plots
plots = ds_grid_create(6, plot_nr);
#endregion

#region setting up shop
seed_shop = load_csv("seed_shop.csv");
resources_shop = load_csv("resource_shop.csv");

enum e_shop
{
	itemid,
	cost, 
	in_deck,
}	

scr_update_shop_indeck();	

#endregion

audio_play_sound(MUSIC, 1, 1);




