Helsinki
========

.. figure:: ../assets/11-helsinki.png
   :alt: Final drawing

   Final drawing

Inspiration
-----------

Time makes me think of music (which probably raised the idea for the following chapter); music makes me think of a score. For some reason the first thing that came to my mind within this subject was Iannis Xenakis's notation of orchestral glissandi:

.. figure:: ../assets/11-Xenakis-Iannis-1200x926.jpg
   :alt: Metastasis (1953), strings glissandi

   Metastasis (1953), strings glissandi

He also realised these forms visually in his work as an architect :cite:`xenakis_philips_pavilion`.

.. figure:: ../assets/11-xenakis-philips-pavilion.jpg
   :alt: Drawing by Xenakis Philips pavilion, 1956, 1957.

   Drawing by Xenakis Philips pavilion, 1956, 1957.

I decided to explore this theme and create an algorithmic representation of those glissandi.

The algorithm
-------------

The logic can be easily deduced from Xenakis's drawings:

1. start from the bottom left of the canvas;
2. draw a line to the top;
3. go to the bottom again, but jump up one unit;
4. draw a line to the top, but one unit to the right;
5. repeat

.. role:: raw-html(raw)
   :format: html

If the lines always end up at the top of the image this means that the vertical axis is static. The top point of the line is, thus, just a sequence of equidistant points:

.. code:: javascript

  function setup() {
    createCanvas(600, 400);
    fill(0);
  }

  function draw() {
    background(220);

    for(x = 0; x <= width; x += width/10){
      ellipse(x, 0, 10, 10);
    }
  }

:raw-html:`<iframe width="600" height="400" src="https://editor.p5js.org/regisfrias/embed/k-jb8QdKA"></iframe>`

The flip side of the line follows the same logic, except that it walks backwards from bottom to top. Since the canvas width is not equal to the height we have to remap ``x`` to the range 0–height. And since we the ``y`` to move in the opposite direction we do ``map(x, 0, width, height, 0)``.

:raw-html:`<iframe width="600" height="400" src="https://editor.p5js.org/regisfrias/embed/KLLXKBbkD"></iframe>`

.. code:: javascript

  function setup() {
    createCanvas(600, 400);
  }

  function draw() {
    background(220);

    for(x = 0; x <= width; x += width/10){
      const y = map(x, 0, width, height, 0);
      line(x, 0, 0, y);
    }
  }

Since we don't want the lines to take up all of the vertical space let's modify the contents of the loop so that it only takes half of the canvas.

:raw-html:`<iframe width="600" height="400" src="https://editor.p5js.org/regisfrias/embed/mXCnESv42"></iframe>`

.. code:: javascript

  function setup() {
    createCanvas(600, 400);
  }

  function draw() {
    background(220);

    const h = height/2;

    for(x = 0; x <= width; x += width/20){
      const mapX = map(x, 0, width, h, 0);
      const y = mapX + h;
      line(x, h, 0, y);
    }
  }

During the process I departed from Xenakis's asymetrical lines and decided to make a mirror image of the glissandi. If we modify the ``y`` value to be ``h - mapX`` we get the inverse of the drawing.

:raw-html:`<iframe width="600" height="400" src="https://editor.p5js.org/regisfrias/embed/GhIgQrxXI"></iframe>`

Let's wrap this in a function so it's easier to do both drawings. Also, instead of changing the value of ``y`` in each version of the drawing, let's change the sign of ``h`` by multiplying it by ``-1``.

:raw-html:`<iframe width="600" height="400" src="https://editor.p5js.org/regisfrias/embed/Ex59V2pZ1"></iframe>`

.. code:: javascript

  function setup() {
    createCanvas(600, 400);
  }

  function draw() {
    background(220);
    xenakis(1);
    xenakis(-1);
  }

  function xenakis(direction){
    const h = height/2;

    for(x = 0; x <= width; x += width/20){
      const mapX = map(x, 0, width, h * direction, 0);
      const y = h - mapX;
      line(x, h, 0, y);
    }
  }

Colors
------

You will have noticed that these are not shapes, but lines. So if we want to paint them — like the final image at the top of the chapter — we need to convert them to shapes.

.. code:: javascript

  beginShape();
  vertex(x, h);
  vertex(0, y);
  vertex(0, h);
  endShape(CLOSE);

The first two vertices are the same ones we had for the line in the above example ( ``line(x, h, 0, y)`` ). The last one closes the triangle.

To make the fill color vary from left to right we can map the values of ``x`` to a certain color range ( ``const hue = map(x, 0, width, 30, 50);`` ). Let's now switch to HSB color mode by adding this to the ``setup()`` function: ``colorMode(HSB, 360, 100, 100, 100);``.

`View code in p5.js Editor <https://editor.p5js.org/regisfrias/sketches/ycBQdJlBG>`_

References
----------

.. bibliography:: references.bib
