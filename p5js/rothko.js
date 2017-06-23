function setup() {
    var canvas = createCanvas(400, 500);

    canvas.parent('museum');

    background(randomColor());
    noLoop();

    document.getElementById('save-btn').onclick = function () {
        saveCanvas('roborothko.png');
    };


    var painting = randomPainting();
    painting.draw();
    document.getElementById('title').innerHTML = painting.getTitle();

}

function randomColor() {
    return color(random(255), random(255), random(255));
}

function randomPainting() {
    var painting = new RothkoFrame(400, 500, randomColor(), null, 10 + random(40));

    var rectNumbers = 2 + random(3);

    var sizeLeft = 0.9;
    for (var i = 0; i < rectNumbers; i++) {
        var rectSize = random(sizeLeft);
        sizeLeft -= rectSize;
        painting.addRect(rectSize, randomColor(), parseInt(20 + random(180), 10));
    }

    return painting;
}

