// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_mouse_within_gui(x1, x2, y1, y2){
var mousex = device_mouse_x_to_gui(0);
var mousey = device_mouse_y_to_gui(0);
if mousex > x1 && mousex < x2 && mousey > y1 && mousey < y2
{
	return(true);
}
return(false);
	

}