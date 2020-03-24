# rts Selection and Movement Demo

![banner](rtsSelectMoveDemo/git_content/rect982.png)

## About

A simple GODOT demo to test selection and move with units like in RTS games. 
You can also choose a formation shape for your units and some others parameters.

## Set up the demo in GODOT

- Open Godot
- click on 'import' and choose the "project.godot" file on the project folder
- Them you have access to the project edition, press F5 to launch project !

## In game inputs

- Left click : 
  - Drag to expand a shape to select units.
  - Click on the UI to change parameter in runtime. 
- Right click : Move the selected units around your cursor position. 


## Content

### Selection
In this demo, you can select units with some Control nodes and an Area2D. The esthetic as been customed with the theme asset. When selected, units are changing they underline color.

![name](rtsSelectMoveDemo/git_content/gif_1.gif)

### Movement 

You can also move your units with a path finding system managed by an auto tiled Tilemap. In the ui, you can click some button to change your unit formation shape (square, circle or triangle).

![other_image](rtsSelectMoveDemo/git_content/gif_2.gif)

![other_image](rtsSelectMoveDemo/git_content/gif_3.gif)

### Test with parameters

It is possible to change the number of unit that spawn at the begining of the demo.

![name](rtsSelectMoveDemo/git_content/gif_4.gif)
