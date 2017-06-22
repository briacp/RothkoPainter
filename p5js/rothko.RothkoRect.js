class RothkoRect {
    // ArrayList<PVector> poly;

    // /* Number of polygon deformations */
    // int polyDeforms = 8;

    // /* Random coef for each deformation */
    // float deformCoef = 10;

    // /* Alpha value of each layer */
    // int layerAlpha = 9;

    // color rectColor;
    // int intensity;

    // /** initial poly points randomness */
    // float randCoef = 20;

    // PVector topLeft;
    // PVector botRight;

    constructor(topLeft, botRight, rectColor, intensity, polyDeforms, deformCoef, layerAlpha, randCoef) {
        this.rectColor = rectColor;
        this.intensity = intensity;
        this.topLeft = topLeft;
        this.botRight = botRight;

        this.polyDeforms = polyDeforms || 8;
        this.deformCoef = deformCoef || 10;
        this.layerAlpha = layerAlpha || 9;
        this.randCoef = randCoef || 5;

        //this.polyDeforms = 1;
        //this.deformCoef = 0;
        //this.layerAlpha = 10;
        //this.randCoef = 0;
    }

    draw() {
        var r = red(this.rectColor);
        var g = green(this.rectColor);
        var b = blue(this.rectColor);

        var poly = [
          this.randGauss(this.topLeft, this.randCoef),
          this.randGauss(createVector(this.botRight.x, this.topLeft.y), this.randCoef),
          this.randGauss(this.botRight, this.randCoef),
          this.randGauss(createVector(this.topLeft.x, this.botRight.y), this.randCoef)
        ];

        for (var s = 0; s < this.intensity; s++) {
            var workPoly = poly.slice(0);
            fill(r, g, b, this.layerAlpha);
            for (var i = 0; i < this.polyDeforms; i++) {
                this.deform(workPoly);
            }
            beginShape();
            for (i = 0; i < workPoly.length; i++) {
                var v = workPoly[i];
                vertex(v.x, v.y);
            }
            endShape(CLOSE);
        }
    }

    deform(poly) {
        var polySize = poly.length;

        var firstMidPoint = this.randGauss(
              createVector((poly[0].x + poly[polySize - 1].x) / 2, (poly[0].y + poly[polySize - 1].y) / 2), 
              this.randCoef);

        var midPoint;
        for (var i = polySize - 1; i > 0; i -= 2) {
            midPoint = this.randGauss(createVector(
            (poly[i].x + poly[i - 1].x) / 2, (poly[i].y + poly[i - 1].y) / 2), this.randCoef);

            poly.splice(i, 0, midPoint);
        }

        poly.push(firstMidPoint);
    }

    randGauss(v, randCoef) {
        v.x += randomGaussian() * randCoef;
        v.y += randomGaussian() * randCoef;

        return v;
    }

    toString() {
        return "RothkoRect{\"topLeft\":" + topLeft + ", \"botRight\":" + botRight + ", \"rectColor\":" + rectColor + ", \"intensity\":" + intensity + "}";
    }
}
