Techniques
==========

.. _techniques-palette:

Using a palette of colors
-------------------------

In several drawings of the Dear Gen project I used a predefined palette of colors, instead of generating the colors with code.
I use services such as `coolors.co <https://coolors.co/>`_ to generate and tweak color palettes, 
and once I find a combination of colors which I like, I simply copy and paste the hexadecimal values to an array in my sketch code. 
I can then pick a color from the palette using :code:`palette[index]` and use it to 
set fill color or stroke color.

.. code-block:: Java
    :caption: Using an array of integers as a color palette

    void setup() {
        //A palette with 5 colors
        int[] palette = new int[]{ 0xFFE28413, 0xFFF56416, 0xFFDD4B1A, 0xFFEF271B, 0xFFEA1744 };
        
        //choosing a 'random' color from my palette
        color c = palette[int(random(5))];
        
        //same as previous, without hard-coding the number
        color c = palette[int(random(palette.length))];
    }

.. TIP:: Remember that in Processing colors are simple integer numbers. Numbers can also be written in hexadecimal, as above. 

If you are interested in a more comprehensive discussion around this subject, I highly recommend the article `Working with 
color in generative art <http://www.tylerlhobbs.com/writings/generative-colors>`_, by the digital artist Tyler Hobbs.

Creating high-resolution images
-------------------------------
To create high-resolution image exports, you can create an off-screen buffer larger than the resolution of your screen. In Processing, you 
do so by instantiating a ``PGraphics`` object with, which in most sketches of this project is named ``buffer``. The basic process is as follows:

1. Declare a PGraphics object as a global variable on the top of the sketch code: 
    ``PGraphics buffer;``

2. In :code:`setup()`, you must use the method `createGraphics()` to instantiate the object. 
      ``buffer = createGraphics(3000, 2000);``

3. In ``setup()`` and ``draw()``, do all drawing operations on the ``buffer`` object. For example, to draw an ellipse, do `buffer.ellipse(x,y,w,h)`

4. Finally, at the end of the ``draw()`` method, show the contents of the buffer with ``image(buffer,0,0,width,height)``.
   This approach scales down the contents of the buffer to the size of your sketch (``width`` and ``height``).

Drawing to an off-screen buffer has other applications too, for example in :doc:Alfabeto uses them extensively.

Saving the file
---------------
In most sketches the code to export the image is inside the :code:`keyPressed()` method, as below.
In line 2, I used the key :kbd:`S` to save the sketch by checking the variable :code:`key`, which is available in Processing 
as a global variable. Then I create the file name using :code:`String.format`, so that each file is saved with the sketch name, 
followed by the date and time. If you call ``save()`` using the same file name, then the exported image is replaced every time you press :kbd:`S`.


.. code-block:: Java
 
    void keyPressed() {
        if (key == 'S' || key == 's') {
            String fileName = String.format("water_color_%02d%02d%02d.tiff", hour(), minute(), second());
            buffer.save(fileName);
            println("Composition saved!");
        }
    }




