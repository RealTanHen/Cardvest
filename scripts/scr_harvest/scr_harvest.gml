// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_harvest(){

	for(var p = 0; p < plot_nr; p++)
	{
		var seed_ = plots[# e_plotinfo.seed, p];
		if seed_ != 0
		{
			var sun_, water_, range_, psun_, pwater_;
			sun_ = real(seed_cards[# e_cardinfo.sun, seed_]);
			water_ = real(seed_cards[# e_cardinfo.water, seed_]);
			range_ = real(seed_cards[# e_cardinfo.range, seed_]);
			
			psun_ = plots[# e_plotinfo.sun, p];
			pwater_ = plots[# e_plotinfo.water, p];
			
			if psun_ >= (sun_ - range_) && psun_ <= (sun_ + range_) && pwater_ >= (water_ - range_) && pwater_ <= (water_ + range_)
			{
				plots[# e_plotinfo.grow, p] += 1;
				plots[# e_plotinfo.death, p] = 0;
			}	
			else
			{
				plots[# e_plotinfo.death, p] += 1;	
				if plots[# e_plotinfo.death, p] >= 2 
				{
					for(var i = 0; i < ds_grid_width(plots); i++)
					{
						plots[# i, p] = 0;	
					}	
					plants_died += 1;
				}	
			}	
			
			var growthmax = seed_cards[# e_cardinfo.growth, seed_];
			var growth_ = plots[# e_plotinfo.grow, p];
			if growth_ >= growthmax
			{
				var seedval_ = seed_cards[# e_cardinfo.harvestval, seed_];
				money += seedval_;
				money_gained_today += seedval_;
				plants_harvested += 1;
				for(var i = 0; i < ds_grid_width(plots); i++)
				{
					plots[# i, p] = 0;	
				}	
			}	
		}	
	
	}	

}