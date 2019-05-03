//Bound Survival: The Endless Jumper
//Author: Dylan Quinones Mattei
//Date: 4/23/2019
//Defining variables for the character
var context, controller, rectangle, loop; 

context = document.getElementById("canvas")
context1 = document.querySelector("canvas");
context = context1.getContext("2d");

context.canvas.height = 180;
context.canvas.width = 320; 
//The Rectangle Function 
rectangle = {
    //height of the rectangle
    height:32,  
    //keeps track of the rectangle when it is on the air or on the ground. 
    jumping:true, 
    //width of the rectangle
    width:32,  
    //Center of the canvas where rectangle starts!
    x:144, 
    //Keeps track of the speed from the right and left
    x_velocity:0, 
    //Point of origin on the canvas' y axis where the rectangle starts.
    y:0,
    //keeps track of the speed from the right and left
    y_velocity:0
};
//The Controller Function!
controller = {
    left:false,
    right:false,
    up:false,
    keyListener:function(event) {
        var key_state = (event.type == "keydown")?true:false;

        switch(event.keyCode) {
            case 37: // left key
                controller.left = key_state;
            break;
            case 38: // up key 
                controller.up = key_state;
            break;
            case 39: // right key
                controller.right = key_state;
            break; 
        }
    }
};
//The Loop Funtion!
loop = function() {
    //If the up key is pressed and the rectangle is not currently jumping
    //we will set the y velocity to -20 to make it appear to jump and the 
    //jumping variable to true to make sure it lands on the ground again. 
    if (controller.up && rectangle. jumping == false) {
        rectangle.y_velocity -= 20;
        rectangle.jumping = true; 
    }
    //If the rectangle moves left on the canvas the x velocity gets subtracted by 0.5!
    if (controller.left) {
        rectangle.x_velocity -= 0.5;
    }
    //If the rectangle moves left on the canvas the x velocity gets added by 0.5!
    if (controller.right) {
        rectangle.x_velocity += 0.5;
    }
    //The physics!
    rectangle.y_velocity += 1.5;//gravity
    rectangle.x += rectangle.x_velocity;
    rectangle.y += rectangle.y_velocity;
    rectangle.x_velocity *= 0.9;// friction
    rectangle.y_velocity *= 0.9;// friction

    // if rectangle is falling below floor line
    if (rectangle.y > 180 - 16 - 32) {
  
      rectangle.jumping = false;
      rectangle.y = 180 - 16 - 32;
      rectangle.y_velocity = 0;    
    }

    // if rectangle is going off the left of the screen
    if (rectangle.x < -32) {

    rectangle.x = 320;

    } else if (rectangle.x > 320) {// if rectangle goes past right boundary

    rectangle.x = -32;
    }

    context.fillStyle = "#202020";
    context.fillRect(0, 0, 320, 180);// x, y, width, height
    context.fillStyle = "#ff0000";// hex for red
    context.beginPath();
    context.rect(rectangle.x, rectangle.y, rectangle.width, rectangle.height);
    context.fill();
    // Bottom line is drawn!
    context.strokeStyle = "#202830";
    context.lineWidth = 4;
    context.beginPath();
    context.moveTo(0, 164);
    context.lineTo(320, 164);
    context.stroke();

    // call update when the browser is ready to draw again
    window.requestAnimationFrame(loop);
};
window.addEventListener("keydown", controller.keyListener)
window.addEventListener("keyup", controller.keyListener);
window.requestAnimationFrame(loop);