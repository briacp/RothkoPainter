//=== RothkoFrame =======================================================================
class RothkoFrame {
    constructor(frameWidth, frameHeight, backgroundColor, title, margin) {
        this.frameWidth = frameWidth;
        this.frameHeight = frameHeight;
        this.backgroundColor = backgroundColor;
        this.title = title;
        this.margin = margin;
        this.heightOffset = margin;
        this.rects = [];
    }

    /** Add a color rectangle to the frame.
     *  @param rectHeight  Height of this rectangle in percent of the whole painting.
     *  @param color       Color of the rectangle.
     *  @param i           Intensity of the color. This is the number of time this rectangle will be drawn.
     */
    addRect(rectHeight, c, i) {
        var bottomY = (this.frameHeight * rectHeight) + this.heightOffset;

        var topLeft = createVector(this.margin, this.heightOffset);
        var botRight = createVector(this.frameWidth - this.margin, bottomY);

        var rect = new RothkoRect(topLeft, botRight, c, i);
        this.rects.push(rect);

        this.heightOffset = bottomY;
    }

    /** Draw the complete painting. */
    draw() {
        noStroke();
        //background(backgroundColor);
        //clear();
        fill(this.backgroundColor);
        rect(0, 0, this.width, this.height);
        noFill();

        // randomize rect drawing order
        this.rects =  this._shuffle(this.rects);

        for (var i = 0; i < this.rects.length; i++) {
            this.rects[i].draw();
        }
    }

    _shuffle(a) {
        var j = 0;
        var valI = '';
        var valJ = valI;
        var l = a.length - 1;
        while (l > -1) {
            j = Math.floor(Math.random() * l);
            valI = a[l];
            valJ = a[j];
            a[l] = valJ;
            a[j] = valI;
            l = l - 1;
        }
        return a;
    }


    /** Get the title of the painting. Generate a random title if none was provided. */
    getTitle() {
        if (this.title != null) {
            return title;
        }

        //return "No. " + parseInt(random(50, 120), 10);

        var colorNames = new ColorNames();
        var names = [];
        names.push(colorNames.getColorName(this.backgroundColor).match.name);
        for (var i = 0; i < this.rects.length; i++) {
            names.push(colorNames.getColorName(this.rects[i].rectColor).match.name);
        }

        var prefix = "";

        if (random(1) > 0.8) {
            return "Untitled";
        }

        if (random(1) > 0.7) {
            prefix = "No. " + parseInt(random(50, 120), 10) + " (";
        }

        this.title = prefix + names.join(', ') + (prefix === "" ? "" : ")");

        return this.title;
    }
}
