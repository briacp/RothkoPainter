

class RothkoRect {
  ArrayList<PVector> poly;

  /* Number of polygon deformations */
  int polyDeforms = 8;

  /* Random coef for each deformation */
  float deformCoef = 10;

  /* Alpha value of each layer */
  int layerAlpha = 9;

  color rectColor;
  int intensity;

  /** initial poly points randomness */
  float randCoef = 20;

  PVector topLeft;
  PVector botRight;

  RothkoRect(PVector topLeft, PVector botRight, color rectColor, int intensity) {
    this(topLeft, botRight, rectColor, intensity, 8, 10, 9, 20);
    //this(topLeft, botRight, rectColor, intensity, 0, 0, 10, 0);
  }

  RothkoRect(PVector topLeft, PVector botRight, color rectColor, int intensity, int polyDeforms, float deformCoef, int layerAlpha, float randCoef) {
    this.rectColor = rectColor;
    this.intensity = intensity;
    this.topLeft = topLeft;
    this.botRight = botRight;

    this.polyDeforms = polyDeforms;
    this.deformCoef = deformCoef;
    this.layerAlpha = layerAlpha;
    this.randCoef = randCoef;
  }

  void draw() {
    float red = red(rectColor);
    float green = green(rectColor);
    float blue = blue(rectColor);

    ArrayList<PVector> poly = new ArrayList<PVector>();

    poly.add( randGauss(topLeft, randCoef ));
    poly.add( randGauss(new PVector(botRight.x, topLeft.y), randCoef ));
    poly.add( randGauss(botRight, randCoef ));
    poly.add( randGauss(new PVector(topLeft.x, botRight.y), randCoef ));

    for (int s = 0; s < intensity; s++) {
      ArrayList<PVector> workPoly = (ArrayList<PVector>) poly.clone();
      fill(red, green, blue, layerAlpha);
      for (int i = 0; i < polyDeforms; i++) {
        deform(workPoly);
      }
      beginShape();
      for (PVector v : workPoly) {
        vertex(v.x, v.y);
      }
      endShape(CLOSE);
    }
  }

  private void deform(ArrayList<PVector> poly) {
    int polySize = poly.size();

    PVector firstMidPoint = randGauss(new PVector(
      (poly.get(0).x + poly.get(polySize-1).x) / 2, 
      (poly.get(0).y + poly.get(polySize-1).y) / 2
      ), randCoef);

    PVector midPoint;
    for (int i = polySize-1; i > 0; i-= 2) {
      midPoint = randGauss(new PVector(
        (poly.get(i).x + poly.get(i-1).x) / 2, 
        (poly.get(i).y + poly.get(i-1).y) / 2
        ), randCoef);
      poly.add(i, midPoint);
    }

    poly.add(firstMidPoint);
  }

  private PVector randGauss (PVector v, float randCoef) {
    v.x += randomGaussian() * randCoef;
    v.y += randomGaussian() * randCoef;

    return v;
  }

  public String toString() {
    return "RothkoRect{\"topLeft\":" + topLeft + ", \"botRight\":" + botRight + ", \"rectColor\":" + rectColor + ", \"intensity\":" + intensity +"}";
  }
}