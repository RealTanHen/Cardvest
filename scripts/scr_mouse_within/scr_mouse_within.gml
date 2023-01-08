// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_mouse_within(x1, x2, y1, y2){
if mouse_x > x1 && mouse_x < x2 && mouse_y > y1 && mouse_y < y2
{
	return(true);
}
return(false);
	

}