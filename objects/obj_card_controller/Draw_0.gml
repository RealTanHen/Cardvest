var card_w = sprite_get_width(spr_card_base);
var card_h = sprite_get_height(spr_card_base);
var plot_w = sprite_get_width(spr_plot);
var plot_h = sprite_get_height(spr_plot);
var rm_w = room_width;
var rm_h = room_height;
var mx = mouse_x;
var my = mouse_y;

var current_hand;
var cardtype_;
var spr_item_;
var help_text_ = -1;
if gamestate == e_gamestate.seed_selection 
{
	current_hand = seed_hand;	
	cardtype_ = e_cardtype.seed;
	spr_item_ = spr_card_seed_item;
	if card_selection = -1 help_text_ = "Select a seed to grow from the cards above.";
	else help_text_ = "Click on a plot below to plant the seed or right click to deselect.";
}	

if gamestate == e_gamestate.weather_selection || gamestate == e_gamestate.weather_selected
{
	current_hand = weather_hand;
	cardtype_ = e_cardtype.weather;
	spr_item_ = spr_card_weather_item;
	help_text_ = "Select the weather from the cards above. The effect will be applied to all cards.";
}	

if gamestate == e_gamestate.resource_selection || gamestate == e_gamestate.resource_selected
{	
	current_hand = resource_hand;
	cardtype_ = e_cardtype.resource;
	spr_item_ = spr_card_resource_item;
	if card_selection = -1 help_text_ = "Select a resource to use on one of the plants below or FINISH DAY.";
	else help_text_ = "Click on a plot below to use the resource on the plant or right click to deselect.";
}	

if help_text_ != -1
{

	if gamestate == e_gamestate.resource_selection && card_selection == -1
	{
		var full_str_len_ = string_width(help_text_);
		var str_len_ = string_width("Select a resource to use on one of the plants below or ");
		draw_sprite_ext(spr_finish_day_button, 0, room_width*0.5-0.5*full_str_len_ +str_len_, 0.5*rm_h, 1, 1, 0, c_white, 1);
		var button_w_ = sprite_get_width(spr_finish_day_button);
		var button_h_ = sprite_get_height(spr_finish_day_button);
		if scr_mouse_within(room_width*0.5-0.5*full_str_len_ +str_len_, room_width*0.5-0.5*full_str_len_ +str_len_ + button_w_, 0.5*rm_h, 0.5*rm_h + button_h_) && gamestate == e_gamestate.resource_selection
		{
			gpu_set_blendmode(bm_add);
			draw_sprite_ext(spr_finish_day_button, 0, room_width*0.5-0.5*full_str_len_ +str_len_, 0.5*rm_h, 1, 1, 0, c_white, 0.2);
			gpu_set_blendmode(bm_normal);
			if mouse_check_button_pressed(mb_left)
			{
				gamestate = e_gamestate.resource_selected;	
			}	
		}	
	}
	
	draw_set_halign(fa_center);
	draw_text(0.5*rm_w, 0.5*rm_h, help_text_);
	draw_set_halign(fa_left);
	
}	

if gamestate != e_gamestate.finish_day && gamestate != e_gamestate.buy && gamestate != e_gamestate.loss
{
	//DRAWING TOP OF DECK
	var current_hand_size = ds_list_size(current_hand);
	var current_hand_init_x, current_hand_init_y, current_hand_x, current_hand_y, buffer;
	buffer = 5;
	current_hand_init_x = 0.5*(rm_w - (current_hand_size*card_w + (current_hand_size-1)*buffer));
	current_hand_y = 0.1*rm_h;
	for(var i = 0; i < current_hand_size; i++)
	{
		current_hand_x = current_hand_init_x + i*(card_w+buffer);
		var current_card_ = real(current_hand[| i]);
		draw_sprite_ext(spr_card_base, 1, current_hand_x, current_hand_y, 1, 1, 0, c_white, 1);	
		draw_sprite_ext(spr_card_type, cardtype_, current_hand_x, current_hand_y, 1, 1, 0, c_white, 1);	
		draw_sprite_ext(spr_item_, current_card_, current_hand_x, current_hand_y, 1, 1, 0, c_white, 1);	
	
		#region SEED CARD TYPE
		if cardtype_ == e_cardtype.seed
		{
		
			draw_sprite_ext(spr_card_base, 1, current_hand_x, current_hand_y, 1, 1, 0, c_white, 1);	
			draw_sprite_ext(spr_card_type, e_cardtype.seed, current_hand_x, current_hand_y, 1, 1, 0, c_white, 1);
			draw_sprite_ext(spr_card_seed_item, current_card_, current_hand_x, current_hand_y, 1, 1, 0, c_white, 1);
			var stat_icon_x = current_hand_x;
			var stat_icon_init_y = current_hand_y + 0.65*card_h;
			var range = seed_cards[# e_cardinfo.range, current_card_];
			var growth_ = seed_cards[# e_cardinfo.growth, current_card_];
			var sun_ = seed_cards[# e_cardinfo.sun, current_card_];
			var water_ = seed_cards[# e_cardinfo.water, current_card_];
			var harvestval_ = seed_cards[# e_cardinfo.harvestval, current_card_];
		
			//HARVESTVAL
			draw_set_color(c_black);
			draw_set_font(font_cards_number);
			var str_len_ = string_length("+" + string(harvestval_));
			draw_set_halign(fa_center);
			var val_x_ = current_hand_x + 0.5*card_w - 0.5*(str_len_ + sprite_get_width(spr_coin));
			var val_y_ = current_hand_y + card_h*0.55 - buffer;
			draw_text(val_x_, val_y_, "+" + string(harvestval_));
			draw_set_halign(fa_left);
			draw_sprite_ext(spr_coin, 0, val_x_+ 3*str_len_, val_y_+buffer, 1, 1, 0, c_white, 1);
			draw_set_color(c_white);
		
			//GROWTH BAR
			draw_sprite_ext(spr_bar_type, 1, stat_icon_x+buffer, stat_icon_init_y, 1, 1, 0, c_white, 1);
			draw_sprite_ext(spr_bar, 0, stat_icon_x + buffer*2, stat_icon_init_y, 1, 1, 0, c_white, 1);
			draw_sprite_ext(spr_bar, 1, stat_icon_x + buffer*2, stat_icon_init_y, 0, 1, 0, c_white, 1);
			var bar_length_ = sprite_get_width(spr_bar);
			var sep_amount_ = bar_length_/growth_;
			for(var g = 1; g < growth_; g++)
			{
				draw_sprite_ext(spr_seperator_bar, 0, stat_icon_x + buffer*2 + sep_amount_*g, stat_icon_init_y, 1, 1, 0, c_white, 1);
			}	
		
			//SUN BAR
			var bar_max = 10;
			stat_icon_init_y += 10;
			draw_sprite_ext(spr_bar_type, 2, stat_icon_x+buffer, stat_icon_init_y, 1, 1, 0, c_white, 1);
			draw_sprite_ext(spr_bar, 0, stat_icon_x + buffer*2, stat_icon_init_y, 1, 1, 0, c_white, 1);
			draw_sprite_ext(spr_bar, 2, stat_icon_x + buffer*2, stat_icon_init_y, 0, 1, 0, c_white, 1);
			var bar_length_ = sprite_get_width(spr_bar);
			var sep_amount_ = bar_length_/bar_max;
			for(var g = 1; g < bar_max; g++)
			{
				draw_sprite_ext(spr_seperator_bar, 0, stat_icon_x + buffer*2 + sep_amount_*g, stat_icon_init_y, 1, 1, 0, c_white, 1);
			}	
			var draw_range_init_x = stat_icon_x + buffer*2 + bar_length_*((sun_-range)/10);
			var draw_range_end_x = stat_icon_x + buffer*2 + bar_length_*((sun_+range)/10);
			if sun_ - range < 0 draw_range_init_x = stat_icon_x + buffer*2;
			if sun_ + range > 10 draw_range_end_x = stat_icon_x + buffer*2  + bar_length_;
			var bar_ratio = ((real(range)*2)/10);
			draw_sprite_ext(spr_bar_range, 0, draw_range_init_x, stat_icon_init_y, bar_ratio, 1, 0, c_white, 1);
		
			//WATER BAR
			var bar_max = 10;
			stat_icon_init_y += 10;
			draw_sprite_ext(spr_bar_type, 3, stat_icon_x+buffer, stat_icon_init_y, 1, 1, 0, c_white, 1);
			draw_sprite_ext(spr_bar, 0, stat_icon_x + buffer*2, stat_icon_init_y, 1, 1, 0, c_white, 1);
			draw_sprite_ext(spr_bar, 3, stat_icon_x + buffer*2, stat_icon_init_y, 0, 1, 0, c_white, 1);
			var bar_length_ = sprite_get_width(spr_bar);
			var sep_amount_ = bar_length_/bar_max;
			for(var g = 1; g < bar_max; g++)
			{
				draw_sprite_ext(spr_seperator_bar, 0, stat_icon_x + buffer*2 + sep_amount_*g, stat_icon_init_y, 1, 1, 0, c_white, 1);
			}	
			var draw_range_init_x = stat_icon_x + buffer*2 + bar_length_*((water_-range)/10);
			var draw_range_end_x = stat_icon_x + buffer*2 + bar_length_*((water_+range)/10);
			if water_ - range < 0 draw_range_init_x = stat_icon_x + buffer*2;
			if water_ + range > 10 draw_range_end_x = stat_icon_x + buffer*2  + bar_length_;
			var bar_ratio = ((real(range)*2)/10);
			draw_sprite_ext(spr_bar_range, 0, draw_range_init_x, stat_icon_init_y, bar_ratio, 1, 0, c_white, 1);
		}
		#endregion
		#region WEATHER CARD TYPE
		if cardtype_ == e_cardtype.weather
		{
			var stat_pos_x, stat_pos_y;
			var stat_w = sprite_get_width(spr_stat_type);
			var stat_h = sprite_get_height(spr_stat_type);
			stat_pos_x = current_hand_x + 0.5*card_w - 0.5*stat_w;
			stat_pos_y = current_hand_y + 0.55*card_h;
			for(var s = 1; s <= e_cardinfo.water; s++)
			{
				var stat_change = weather_cards[# s, current_card_]
				if stat_change != 0
				{
					var stat_string_;
					if stat_change > 0 stat_string_ = "+" + string(stat_change);
					if stat_change < 0 stat_string_ = string(stat_change);
					draw_set_font(font_cards_number);
					stat_pos_x -= 0.5*string_width(stat_string_);
				
					draw_set_color(c_black);
				
					draw_text(stat_pos_x, stat_pos_y, stat_string_);
					draw_sprite_ext(spr_stat_type, s, stat_pos_x+ string_width(stat_string_), stat_pos_y, 1, 1, 0, c_white, 1);
					draw_set_color(c_white);
					stat_pos_y += stat_h*1.2;
				}	
			}	
		}	
		#endregion
		#region RESOURCE CARD TYPE
		if cardtype_ == e_cardtype.resource
		{
			var stat_pos_x, stat_pos_y;
			var stat_w = sprite_get_width(spr_stat_type);
			var stat_h = sprite_get_height(spr_stat_type);
			stat_pos_x = current_hand_x + 0.5*card_w - 0.5*stat_w;
			stat_pos_y = current_hand_y + 0.55*card_h;
			for(var s = 1; s <= e_cardinfo.water; s++)
			{
				var stat_change = resource_cards[# s, current_card_]
				if stat_change != 0
				{
					var stat_string_;
					if stat_change > 0 stat_string_ = "+" + string(stat_change);
					if stat_change < 0 stat_string_ = string(stat_change);
					draw_set_font(font_cards_number);
					stat_pos_x -= 0.5*string_width(stat_string_);
				
					draw_set_color(c_black);
				
					draw_text(stat_pos_x, stat_pos_y, stat_string_);
					draw_sprite_ext(spr_stat_type, s, stat_pos_x+ string_width(stat_string_), stat_pos_y, 1, 1, 0, c_white, 1);
					draw_set_color(c_white);
					stat_pos_y += stat_h*1.2;
				}	
			}	
		
		}
		#endregion
	
		if scr_mouse_within(current_hand_x, current_hand_x + card_w, current_hand_y, current_hand_y + card_h) && card_selection = -1
		{
			gpu_set_blendmode(bm_add);
			draw_sprite_ext(spr_card_base, 1, current_hand_x, current_hand_y, 1, 1, 0, c_white, 0.2);	
			gpu_set_blendmode(bm_normal);
		
			if mouse_check_button_pressed(mb_left) 
			{
				card_selection = current_card_;
				card_hand_selection = i;	
				
			}	
		}
	
		if mouse_check_button_pressed(mb_right) && card_selection != -1 
		{
			card_selection = -1;
			card_hand_selection = -1;
		}
	}	

	//DRAWING PLOTS
	var p_buffer = 5;
	var current_plot_init_x, current_plot_x, current_plot_y;
	current_plot_init_x = 0.5*(rm_w - (plot_nr*plot_w + (plot_nr-1)*p_buffer));
	current_plot_y = 0.6*rm_h;
	for(var p = 0; p < plot_nr; p++)
	{
		current_plot_x = current_plot_init_x + p*(plot_w+p_buffer);
		draw_sprite_ext(spr_plot, 0, current_plot_x, current_plot_y, 1, 1, 0, c_white, 1);
	
		var seed_ = plots[# e_plotinfo.seed, p];
		if seed_ != 0
		{
			draw_sprite_ext(spr_card_base, 1, current_plot_x + buffer, current_plot_y + buffer, 1, 1, 0, c_white, 1);	
			draw_sprite_ext(spr_card_type, e_cardtype.seed, current_plot_x + buffer, current_plot_y + buffer, 1, 1, 0, c_white, 1);
			draw_sprite_ext(spr_card_seed_item, seed_, current_plot_x + buffer, current_plot_y + buffer, 1, 1, 0, c_white, 1);
			var stat_icon_x = current_plot_x + buffer;
			var stat_icon_init_y = current_plot_y + buffer + 0.65*card_h;
			var range = seed_cards[# e_cardinfo.range, seed_];
			var growth_ = seed_cards[# e_cardinfo.growth, seed_];
			var sun_ = seed_cards[# e_cardinfo.sun, seed_];
			var water_ = seed_cards[# e_cardinfo.water, seed_];
			var harvestval_ = seed_cards[# e_cardinfo.harvestval, seed_];
			var plot_growth = plots[# e_plotinfo.grow, p];
			var plot_sun = plots[# e_plotinfo.sun, p];
			var plot_water = plots[# e_plotinfo.water, p];
		
			//HARVESTVAL
			draw_set_color(c_black);
			draw_set_font(font_cards_number);
			var str_len_ = string_width("+" + string(harvestval_));
			var val_x_ = current_plot_x + buffer + 0.5*card_w - 0.5*(str_len_ + sprite_get_width(spr_coin));
			var val_y_ = current_plot_y + card_h*0.55;
			draw_text(val_x_, val_y_, "+" + string(harvestval_));
			draw_sprite_ext(spr_coin, 0, val_x_+ str_len_*1.05, val_y_+buffer, 1, 1, 0, c_white, 1);
			draw_set_color(c_white);
		
			//GROWTH BAR
			var g_ratio = plot_growth/growth_;
			draw_sprite_ext(spr_bar_type, 1, stat_icon_x+buffer, stat_icon_init_y, 1, 1, 0, c_white, 1);
			draw_sprite_ext(spr_bar, 0, stat_icon_x + buffer*2, stat_icon_init_y, 1, 1, 0, c_white, 1);
			draw_sprite_ext(spr_bar, 1, stat_icon_x + buffer*2, stat_icon_init_y, g_ratio, 1, 0, c_white, 1);
			var bar_length_ = sprite_get_width(spr_bar);
			var sep_amount_ = bar_length_/growth_;
			for(var g = 1; g < growth_; g++)
			{
				draw_sprite_ext(spr_seperator_bar, 0, stat_icon_x + buffer*2 + sep_amount_*g, stat_icon_init_y, 1, 1, 0, c_white, 1);
			}	
		
			//SUN BAR
			var bar_max = 10;
			var g_ratio = plot_sun/10;
			stat_icon_init_y += 10;
			draw_sprite_ext(spr_bar_type, 2, stat_icon_x+buffer, stat_icon_init_y, 1, 1, 0, c_white, 1);
			draw_sprite_ext(spr_bar, 0, stat_icon_x + buffer*2, stat_icon_init_y, 1, 1, 0, c_white, 1);
			draw_sprite_ext(spr_bar, 2, stat_icon_x + buffer*2, stat_icon_init_y, g_ratio, 1, 0, c_white, 1);
			var bar_length_ = sprite_get_width(spr_bar);
			var sep_amount_ = bar_length_/bar_max;
			for(var g = 1; g < bar_max; g++)
			{
				draw_sprite_ext(spr_seperator_bar, 0, stat_icon_x + buffer*2 + sep_amount_*g, stat_icon_init_y, 1, 1, 0, c_white, 1);
			}	
		
			var draw_range_init_x = stat_icon_x + buffer*2 + bar_length_*((sun_-range)/10);
			var draw_range_end_x = stat_icon_x + buffer*2 + bar_length_*((sun_+range)/10);
			if sun_ - range < 0 draw_range_init_x = stat_icon_x + buffer*2;
			if sun_ + range > 10 draw_range_end_x = stat_icon_x + buffer*2 + bar_length_;
			var bar_ratio = ((real(range)*2)/10);
			draw_sprite_ext(spr_bar_range, 0, draw_range_init_x, stat_icon_init_y, bar_ratio, 1, 0, c_white, 1);
		
			//WATER BAR
			var bar_max = 10;
			var g_ratio = plot_water/10;
			stat_icon_init_y += 10;
			draw_sprite_ext(spr_bar_type, 3, stat_icon_x+buffer, stat_icon_init_y, 1, 1, 0, c_white, 1);
			draw_sprite_ext(spr_bar, 0, stat_icon_x + buffer*2, stat_icon_init_y, 1, 1, 0, c_white, 1);
			draw_sprite_ext(spr_bar, 3, stat_icon_x + buffer*2, stat_icon_init_y, g_ratio, 1, 0, c_white, 1);
			var bar_length_ = sprite_get_width(spr_bar);
			var sep_amount_ = bar_length_/bar_max;
			for(var g = 1; g < bar_max; g++)
			{
				draw_sprite_ext(spr_seperator_bar, 0, stat_icon_x + buffer*2 + sep_amount_*g, stat_icon_init_y, 1, 1, 0, c_white, 1);
			}
			var draw_range_init_x = stat_icon_x + buffer*2 + bar_length_*((water_-range)/10);
			var draw_range_end_x = stat_icon_x + buffer*2 + bar_length_*((water_+range)/10);
			if water_ - range < 0 draw_range_init_x = stat_icon_x + buffer*2;
			if water_ + range > 10 draw_range_end_x = stat_icon_x + buffer*2 + bar_length_;
			var bar_ratio = ((real(range)*2)/10);
			draw_sprite_ext(spr_bar_range, 0, draw_range_init_x, stat_icon_init_y, bar_ratio, 1, 0, c_white, 1);
		
			if gamestate == e_gamestate.weather_selection && card_selection != -1
			{
					plots[# e_plotinfo.sun, p] += weather_cards[# e_cardinfo.sun, card_selection];	
					if plots[# e_plotinfo.sun, p] > 10 plots[# e_plotinfo.sun, p] = 10;
					if plots[# e_plotinfo.sun, p] < 0 plots[# e_plotinfo.sun, p] = 0;
				
					plots[# e_plotinfo.water, p] += weather_cards[# e_cardinfo.water, card_selection];	
					if plots[# e_plotinfo.water, p] > 10 plots[# e_plotinfo.water, p] = 10;
					if plots[# e_plotinfo.water, p] < 0 plots[# e_plotinfo.water, p] = 0;
				
				
			}
		
			if gamestate == e_gamestate.resource_selection && card_selection != -1
			{
				if scr_mouse_within(current_plot_x, current_plot_x + plot_w, current_plot_y, current_plot_y + plot_h)
				{
					draw_sprite_ext(spr_plot, 1, current_plot_x, current_plot_y, 1, 1, 0, c_white, 1);	
					if mouse_check_button_pressed(mb_left)
					{
						plots[# e_plotinfo.sun, p] += resource_cards[# e_cardinfo.sun, card_selection];	
						if plots[# e_plotinfo.sun, p] > 10 plots[# e_plotinfo.sun, p] = 10;
						if plots[# e_plotinfo.sun, p] < 0 plots[# e_plotinfo.sun, p] = 0;
				
						plots[# e_plotinfo.water, p] += resource_cards[# e_cardinfo.water, card_selection];	
						if plots[# e_plotinfo.water, p] > 10 plots[# e_plotinfo.water, p] = 10;
						if plots[# e_plotinfo.water, p] < 0 plots[# e_plotinfo.water, p] = 0;
					
						card_selection = -1;
						ds_list_delete(resource_hand, card_hand_selection);
						card_hand_selection = -1;
					}		
				}	
			}	
		

		}
		else
		{
			if gamestate == e_gamestate.seed_selection
			{
				if card_selection != -1 && scr_mouse_within(current_plot_x, current_plot_x + plot_w, current_plot_y, current_plot_y + plot_h)
				{
					draw_sprite_ext(spr_plot, 1, current_plot_x, current_plot_y, 1, 1, 0, c_white, 1);
					if mouse_check_button_pressed(mb_left)
					{
						plots[# e_plotinfo.seed, p] = card_selection;
						card_selection = -1;
						ds_list_delete(seed_hand, card_hand_selection);
						card_hand_selection = -1;
						scr_deck_fill_hand(seed_deck, seed_hand, false);
						if (scr_check_plots_full() == 1 || ds_list_size(seed_hand) <= 0)
						{
							gamestate = e_gamestate.weather_selection;
						}	
					}	
				}	
			}	
		
		}	
	
	}	

	if gamestate == e_gamestate.weather_selection && card_selection != -1
	{
		gamestate = e_gamestate.weather_selected;	
	}	

	if gamestate = e_gamestate.weather_selected
	{
	
		card_hand_selection = -1;
		card_selection = -1;
		gamestate = e_gamestate.resource_selection;	
	}	
}


if gamestate == e_gamestate.resource_selected
{
	scr_harvest();
	scr_deck_fill_hand(seed_deck, seed_hand, 0);
	scr_deck_fill_hand(weather_deck, weather_hand, 1);
	scr_deck_fill_hand(resource_deck, resource_hand, 0);
	gamestate = e_gamestate.finish_day;
}	

if gamestate == e_gamestate.finish_day
{
	draw_set_font(font_bigger);
	draw_set_halign(fa_center);
	draw_text(0.5*rm_w, 0.2*rm_h, "Day " + string(day) + " Finished");
	draw_set_halign(fa_left);
	
	draw_set_font(font_cards_number);
	draw_text(0.43*rm_w, 0.4*rm_h, string(money_gained_today) + "G Gained Today");
	draw_text(0.43*rm_w, 0.45*rm_h, string(plants_harvested) + " Plants Harvested Today");
	draw_text(0.43*rm_w, 0.5*rm_h, string(plants_died) + " Plants Died Today");
	
	var button_x1, button_x2, button_dist, button_y, button_w, button_h, button_tot_w;
	button_w = sprite_get_width(spr_finish_day_largebuttons);
	button_h = sprite_get_height(spr_finish_day_largebuttons);
	button_dist = 50;
	button_tot_w = button_w*2 + button_dist;
	button_x1 = (rm_w - button_tot_w)/2;
	button_x2 = rm_w - (rm_w - button_tot_w)/2 - button_w;
	button_y = 0.7*rm_h;
	draw_sprite_ext(spr_finish_day_largebuttons, 0, button_x1, button_y, 1, 1, 0, c_white, 1);
	draw_text(button_x1+0.2*button_w, button_y, "Next Day");
	draw_sprite_ext(spr_finish_day_largebuttons, 0, button_x2, button_y, 1, 1, 0, c_white, 1);
	draw_text(button_x2+0.2*button_w, button_y, "Buy Cards");
	
	if ds_list_empty(seed_hand) == false || scr_check_plots_full() != -1
	{
		if scr_mouse_within(button_x1, button_x1 + button_w, button_y, button_y + button_h)
		{
			gpu_set_blendmode(bm_add);
			draw_sprite_ext(spr_finish_day_largebuttons, 0, button_x1, button_y, 1, 1, 0, c_white, 1);
			gpu_set_blendmode(bm_normal);
		
			if mouse_check_button_pressed(mb_left)
			{
				if (scr_check_plots_full() == 1 || ds_list_empty(seed_hand)) 
				{
					money_gained_today = 0;
					plants_died = 0;
					plants_harvested = 0;
					gamestate = e_gamestate.weather_selection;
				}		
				else gamestate = e_gamestate.seed_selection;
			}	
		
		}	
	}
	else
	{
		if money < 3 gamestate = e_gamestate.loss;
		else
		{
			draw_set_font(font_cards_number);
			draw_set_halign(fa_center);
			draw_text(0.5*rm_w, 0.6*rm_h, string(money_gained_today) + "Need to buy more seeds to sew tomorrow");	
			draw_set_halign(fa_left);
		}	
	}	
	
	if scr_mouse_within(button_x2, button_x2 + button_w, button_y, button_y + button_h)
	{
		gpu_set_blendmode(bm_add);
		draw_sprite_ext(spr_finish_day_largebuttons, 0, button_x2, button_y, 1, 1, 0, c_white, 1);
		gpu_set_blendmode(bm_normal);
		
		if mouse_check_button_pressed(mb_left)
		{
			gamestate = e_gamestate.buy;
			scr_update_shop_indeck();
		}	
		
	}	
	
}	

if gamestate == e_gamestate.buy
{
	
	
	
	draw_sprite_ext(spr_shop_template, 0, 0, 0, 1, 1, 0, c_white, 1);
	draw_text(100, 10, "SEEDS");
	var shop_init_x = 0 + 10;
	var shop_init_y = 0 + 40;
	var shop_x = shop_init_x;
	var shop_y = shop_init_y;
	var selection_w = sprite_get_width(spr_shop_selection);
	var selection_h = sprite_get_height(spr_shop_selection);
	for(var s = 1; s < ds_grid_height(seed_shop); s++)
	{
		draw_sprite_ext(spr_shop_selection, 1, shop_x, shop_y, 1, 1, 0, c_white, 1);
		var i_id = real(seed_shop[# e_shop.itemid, s]);
		var i_cost = real(seed_shop[# e_shop.cost, s]);
		var i_alreadyowned = real(seed_shop[# e_shop.in_deck, s]);
		var name_ = seed_cards[# e_cardinfo.name, i_id];
		var i_grow_days_ = seed_cards[# e_cardinfo.growth, i_id];
		var i_harvestamount = seed_cards[# e_cardinfo.harvestval, i_id];
		draw_text(shop_x, shop_y, name_);
		
		draw_text(shop_x + 50, shop_y, string(i_cost) + "G / " + string(i_grow_days_) + "Days / earns " + string(i_harvestamount) + "G / " + string(i_alreadyowned) + " owned");

		
		if scr_mouse_within(shop_x, shop_x + selection_w, shop_y, shop_y + selection_h)
		{
			gpu_set_blendmode(bm_add);
			draw_sprite_ext(spr_shop_selection, 1, shop_x, shop_y, 1, 1, 0, c_white, 0.2);
			gpu_set_blendmode(bm_normal);
			
			if mouse_check_button_pressed(mb_left) && ds_list_size(seed_deck) < max_seed_deck && money >= i_cost
			{
				ds_list_add(seed_deck, i_id);
				money -= i_cost;
				scr_update_shop_indeck();
				
			}	
		}	
		
		shop_y += selection_h;
	}	
	
	
	draw_sprite_ext(spr_shop_template,  0, 0.5*rm_w, 0, 1, 1, 0, c_white, 1);
	draw_text(300, 10, "RESOURCES");
	var shop_init_x = rm_w*0.5 + 10;
	var shop_init_y = 0 + 40;
	var shop_x = shop_init_x;
	var shop_y = shop_init_y;
	var selection_w = sprite_get_width(spr_shop_selection);
	var selection_h = sprite_get_height(spr_shop_selection);
	for(var s = 1; s < ds_grid_height(resources_shop); s++)
	{
		draw_sprite_ext(spr_shop_selection, 1, shop_x, shop_y, 1, 1, 0, c_white, 1);
		var i_id = real(resources_shop[# e_shop.itemid, s]);
		var i_cost = real(resources_shop[# e_shop.cost, s]);
		var i_alreadyowned = real(resources_shop[# e_shop.in_deck, s]);
		var name_ = resource_cards[# e_cardinfo.name, i_id];
		var sun_given_ = resource_cards[# e_cardinfo.sun, i_id];
		var water_given_ = resource_cards[# e_cardinfo.water, i_id];
		var growth_given_ = resource_cards[# e_cardinfo.growth, i_id];
		var sunstr_, growstr_, waterstr_;
		sunstr_ = "";
		growstr_ = "";
		waterstr_ = "";
		if sun_given_ != 0 sunstr_ = string(sun_given_) + " Sun / ";
		if water_given_ != 0 waterstr_ = string(water_given_) + " Water / ";
		if growth_given_ != 0 growstr_ = string(growth_given_) + " Growth / ";
		
		draw_text(shop_x, shop_y, name_);
		draw_text(shop_x + 60, shop_y, string(i_cost) + "G / " + growstr_ + sunstr_ + waterstr_ + string(i_alreadyowned) + " owned");

		if scr_mouse_within(shop_x, shop_x + selection_w, shop_y, shop_y + selection_h)
		{
			gpu_set_blendmode(bm_add);
			draw_sprite_ext(spr_shop_selection, 1, shop_x, shop_y, 1, 1, 0, c_white, 0.2);
			gpu_set_blendmode(bm_normal);
			
			if mouse_check_button_pressed(mb_left) && ds_list_size(resource_deck) < max_resource_deck && money >= i_cost
			{
				ds_list_add(resource_deck, i_id);
				money -= i_cost;
				scr_update_shop_indeck();
				
			}	
		}	
		
		shop_y += selection_h;
	}
	
	
	draw_set_halign(fa_center);
	draw_text(rm_w*0.5, 0, string(money) + "G available to spend");
	draw_set_halign(fa_left);
	
	draw_sprite_ext(spr_backbutton, 0, rm_w*0.85, 0, 1, 1, 0, c_white, 1); 
	draw_text(rm_w*0.85, 0, "Exit Shop");
	var backbutton_w = sprite_get_width(spr_backbutton);
	var backbutton_h = sprite_get_height(spr_backbutton);
	if scr_mouse_within(rm_w*0.85, rm_w*0.85 + backbutton_w, 0, backbutton_h)
	{
		gpu_set_blendmode(bm_add);
		draw_sprite_ext(spr_backbutton, 0, rm_w*0.85, 0, 1, 1, 0, c_white, 1);
		gpu_set_blendmode(bm_normal);
		
		if mouse_check_button_pressed(mb_left)
		{
			gamestate = e_gamestate.finish_day;	
		}	
	}
	
}	

if gamestate == e_gamestate.loss
{
	draw_set_font(font_bigger);
	draw_set_halign(fa_center);
	draw_text(0.5*rm_w, 0.2*rm_h, "Your Farm ran out of Money...");
	draw_set_font(font_cards_number);
	draw_text(0.5*rm_w, 0.4*rm_h, "Press ENTER to start again, or ESC to Exit");
	draw_set_halign(fa_left);
	draw_set_font(font_cards_number);
	if keyboard_check_pressed(vk_enter) game_restart();
}	
