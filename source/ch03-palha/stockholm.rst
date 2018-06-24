Stockholm
=========

.. figure:: ../assets/03-sto-medium.jpeg
   :alt:

Creative process
----------------
For **Palha** I was initially set in a more literal exploration of the subject, either by drawing a simple product made of straw, such as rural worker straw hat, or simply a weave pattern. 
After watching a video about straw weaving, I spend some time trying to come up with a simple way to mimic the artisans movement with code. The most basic weaving movement involves alternating straw threads, so that they either go above, or under, another thread. 

I decided to abandon this idea when I realized that it would be easier in 3D than 2D. Régis presents a more succinct explanation in his sketch, saying that the thread can be represented by sinodal waves with different phases - meaning waves where the "high" and "low" points are in slightly different locations.

(picture)

Organic threads
---------------
Each thread of the straw weave is composed by 10 individual "lines". The simplest way to draw a line in Processing is to use `line()`, providing the coordinates of the starting and end points.
(code excerpt)

To make the output more organic, we can replace the straight line with smaller line segments which connect points in varying positions.

(schematic drawing, on the left a staight line, on the the right 2 to 4 lines build using noise and segments)

Drawing a mesh
--------------



Other techniques
----------------
* Palette
While drawing the thread, I randomly pick one item from a list of 5 colors. The technique is described in ``. 
