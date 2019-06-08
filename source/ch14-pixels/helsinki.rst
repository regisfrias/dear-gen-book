Helsinki
========

.. figure:: ../assets/14-helsinki.png
  :alt:

This week's challenge was inspired by `M.C. Escher's "Print Gallery" <https://www.mcescher.com/gallery/recognition-success/print-gallery/>`_. In this work Escher creates a loop that spans the art piece in a gallery, the gallery itself, the city, and back to the piece in a gallery. The elements in different levels are merged into a continuum.

.. figure:: ../assets/14-LW410-MC-Escher-Print-Gallery-19561.jpg
  :alt: M.C. Escher: Print Gallery, 1956, Lithograph.

The creative process
--------------------

Pixels are the atoms of computer graphics and I wanted to play with the idea of these elements expanding and contracting in a way that resembled Escher's approach — although orders of magnitude less ambitious. The idea was to start with pixels in "natural size", then increase them at each iteration until they take up a large area. The pixels didn't turn out very large in the final image because the image looked more interesting with a smaller variation, as can be seen on the variation:

.. figure:: ../assets/14-helsinki-001.png
  :alt: Variation of the image with larger increase in pixel size

The biggest loss occurs in the middle of the image, where the sunset would be located in the original image:

.. figure:: ../assets/14-IMG_20160617_224625.jpg
  :alt: Original image

The reason is that this is a visually rich area and all of the small variations are filtered out of the final result.


The algorithm
-------------

We start with an exponential sequence:

.. figure:: ../assets/14-exponential-sequence.png
  :alt: Exponential sequence

.. code:: java

  float incrX = 0.01;
  float deform = 20;

  void setup() {
    size(800, 600);
    noLoop();
    noStroke();
    fill(0);
  }

  void draw() {
    for(float i = 0; i < 1; i += incrX){
      float x1 = pow(i-incrX, deform) * width;
      float ang1 = map(x1, 0, width, PI, TWO_PI);
      ellipse(x1, height/2, 5, 5);
    }
  }

Then we want to repeat that across the vertical axis and expand it in the same way based on its vertical position:

.. figure:: ../assets/14-helsinki-grid.png
  :alt: Simplified version
