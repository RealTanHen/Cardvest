if keyboard_check_pressed(ord("F")) 
{
	var fs_ = window_get_fullscreen()
	window_set_fullscreen(!fs_);
}	

if keyboard_check_pressed(vk_escape) game_end();
