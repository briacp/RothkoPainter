import java.util.TreeSet;

class RothkoFrame {
  int frameHeight;
  int frameWidth;
  int margin = 30;
  float heightOffset = margin;
  String title;

  ArrayList<RothkoRect> rects = new ArrayList<RothkoRect>();
  color backgroundColor;

  RothkoFrame(int frameWidth, int frameHeight, color backgroundColor) {
    this(frameWidth, frameHeight, (color) backgroundColor, (String) null, 30);
  }

  RothkoFrame(int frameWidth, int frameHeight, color backgroundColor, String title, int margin) {
    this.frameWidth = frameWidth;
    this.frameHeight = frameHeight;
    this.backgroundColor = backgroundColor;
    this.title = title;

    this.margin = margin;
    this.heightOffset = margin;
  }

  /** Add a color rectangle to the frame.
   *  @param rectHeight  Height of this rectangle in percent of the whole painting.
   *  @param color       Color of the rectangle.
   *  @param i           Intensity of the color. This is the number of time this rectangle will be drawn.
   */
  void addRect(float rectHeight, color c, int i) {
    float bottomY = (frameHeight*rectHeight) + heightOffset;

    PVector topLeft  = new PVector(margin, heightOffset);
    PVector botRight = new PVector(frameWidth - margin, bottomY);

    RothkoRect rect = new RothkoRect(topLeft, botRight, c, i);
    rects.add(rect);

    heightOffset = bottomY;
  }

  /** Draw the complete painting. */
  void draw() {
    noStroke();
    //background(backgroundColor);
    //clear();
    fill(backgroundColor);
    rect(0, 0, width, height);
    noFill();

    // randomize rect drawing order
    Collections.shuffle(rects);

    for (RothkoRect rect : rects) {
      rect.draw();
    }
  }

  /** Get the title of the painting. Generate a random title if none was provided. */
  String getTitle() {
    if (title != null) {
      return title;
    }

    ColorNames colorNames = new ColorNames();

    Set<String> names = new TreeSet<String>();

    names.add(colorNames.getColorName(backgroundColor).match.name);

    for (RothkoRect rect : rects) {
      names.add(colorNames.getColorName(rect.rectColor).match.name);
    }

    String[] titleColors = names.toArray(new String[names.size()]);

    String prefix = "";

    if (random(1) > 0.8) {
      return "Untitled";
    }

    if (random(1) > 0.7) {
      prefix = "No. " + ((int)random(50, 120)) + " (";
    }

    title = prefix + String.join(", ", titleColors) + (prefix.isEmpty() ? "" : ")");

    return title;
  }
}