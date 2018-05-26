## Araucária, Helsinki

![Main render of the code](/.gitbook/assets/01-2018-5-14-20-14-39.png)

I didn't strictly adhere to the theme of the week, in the sense that any base image would work pretty much the same as an Araucária image. Instead, I followed the code wherever it took me.

I started searching for images of araucária trees, which I find beautiful. Then I tried to capture their logic with some algorithm. The first draft is that attempt and can be seen in previous versions of the code \(up to [6dfebaf357587c6513298256939ef758f90f8105](https://github.com/regisfrias/dear-gen/commit/6dfebaf357587c6513298256939ef758f90f8105)\).

I ended up with a fractal structure that resembles some leaf patterns \(not necessarily araucárias only\). Then I decided to use the colors from an actual araucária tree picture. Initially I chose the color based on the position of the ellipse on screen, but I thought that was boring. Then I thought of ordering the colors by hue or brightness and only then use them. The idea was to give some directionality and sense of logic to it.

What I realized during this process was that the reordered pixel array looked very interesting by itself. So I decided to use that instead of the image and trashed the fractal altogether.

The pixel array looks like this:

![Pixel array reordered by hue](/.gitbook/assets/01-hue.png)

I took advantage of the fact that the hue is a bit misleading and doesn't seem to be totally ordered. That is just an optical illusion, the above image varies from reds to blues, greens are \(obviously\) in the middle. Try with a color picker!

For reference, here is the same image reordered by saturation:

![Saturation](/.gitbook/assets/01-saturation.png)

It is more obviously ordered.

And then by brightness:

![Brightness](/.gitbook/assets/01-brightness.png)

Now it's clearly ordered!

### Step-by-step

The code for this sketch can be found on the project repository under 'Week-01'.\[@frias\_sketch\_180514b\_2018\]

Let's now go through the code to see how it works. The first few lines create global variables for the sorted color array, the image that will be loaded and the scale of the output image — i.e., how many times the output image will be bigger than the input.

```java
int[] sortedColors;
PImage img;
int imgScale = 3;
```

Since we're not looking for resolution, but for an array of pixels that looks visually interesting, it's a good idea to keep the input image small. The output image can be arbitrarily large — the point is to see the pixels, not hide them.

Next, we load the image from the data folder \(Processing default\) then use the method `loadPixels()` from the image object. This makes the pixel data available to us as an array.

Finally, we size the applet window to match the input size times the scale, that is the size of the output image. This needs to be the case because we are grabbing the applet view to render the image and thus avoiding creating image buffers.

```java
void settings(){
  String imgName = "img-placeholder.jpg";
  img = loadImage(imgName);
  img.loadPixels();
  size(img.width * imgScale, img.height * imgScale);
}
```

On the setup function we call `noLoop()` because we're really just interested in one frame and we're not doing animation. Then we call `noStroke()` because we want filled ellipses without a stroke.

Then we populate the `sortedColors` array with the pixels from the image retrieved by `loadPixels()` and call the sorting algorithm on it.

```java
void setup(){
  noLoop();
  noStroke();

  sortedColors = new int[img.pixels.length];
  sortedColors = bubbleSort(img.pixels);
}
```

The sorting algorithm was shamelessly ripped off from Adamchik\[@adamchik\_sorting\_2009\] and is simingly simple:

```java
int[] bubbleSort(int ar[]) {
  for (int i = (ar.length - 1); i >= 0; i--){
    for (int j = 1; j <= i; j++){
      if (hue(ar[j-1]) > hue(ar[j])){
        int temp = ar[j-1];
        ar[j-1] = ar[j];
        ar[j] = temp;
      }
    }
  }
  return ar;
}
```

Adamchik\[@adamchik\_sorting\_2009\] explains it so:

> The algorithm works by selecting the smallest unsorted item and then swapping it with the item in the next position to be filled. The selection sort works as follows: you look through the entire array for the smallest element, once you find it you swap it \(the smallest element\) with the first element of the array. Then you look for the smallest element in the remaining array \(an array without the first element\) and swap it with the second element. Then you look for the smallest element in the remaining array \(an array without first and second elements\) and swap it with the third element, and so on.

Line 4 \(`if (hue(ar[j-1]) > hue(ar[j])){`\) — my only modification to the algorithm — first gets the hue value of the pixel before comparing it with the previously found value. Change that to `saturation(...)` or `brightness(...)` to create the previous two images.

This function returns an array, which we will use to create our final image. That is done in `draw()`.

First, we need to change the default color mode to HSB \(Hue, Saturation, Brightness\).

Then we loop through the `sortedColors` array. For each pixel we get the brightness, which we'll use as a parameter for the ellipse color \(`fill()`\) and sizes.

_Note that image arrays in Processing are one-dimensional._ This means that the pixels of an image are placed side-by-side in a single line. That's why we need to do `i % img.width` for x positions and `i / img.width` for y positions. We then multiply the positions with `imgScale` to stretch their locations to match the intended output size.

Brightness varies from 0 to 100 \(as defined in `colorMode()`\), so we need to make this range fall within a useful one for the ellipse size. That is why we use `map()` and reset the range to `imgScale/7`–`imgScale*5`. Using the `imgScale` should keep the proportion for different output sizes.

```java
void draw(){
  colorMode(HSB, 360, 100, 100);

  for(int i = 0; i < sortedColors.length; i++){
    float brightness = brightness(sortedColors[i]);
    fill(sortedColors[i]);
    float x = (i % img.width) * imgScale;
    float y = (i / img.width) * imgScale;
    float ellipseSize = map(brightness, 0, 100, imgScale/7, imgScale*5);
    ellipse(x, y, ellipseSize, ellipseSize);
  }
```

Finally, we save the frame inside a folder called "saved-png" with the time stamp appended to the name. That is just to allow us to create several trial images without worrying about overwriting them. We can then exit the program, since we're not displaying anything.

```java
  saveFrame(
    "saved-png/" +
    year() + "-" +
    month() + "-" +
    day() + "-" +
    hour() + "-" +
    minute() + "-" +
    second() + "-hue.png"
  );
  exit();
}
```
