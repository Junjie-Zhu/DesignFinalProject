int num = 100;
LineUnit[] lUnit = new LineUnit[num]; 
int[][] tmp = new int[num][2];
boolean toInitiate = true;
float weight = 3.0;
String status = "NO FIGURE LOADED!";
PImage styleImage;

void setup() {
    size(800, 1000);
    background(0);
    frameRate(60);
}

void initiateLines() {
    for (int i = 0; i < num; i++) {
        int[] input_cord = {int(random(200, width - 200)), int(random(height/2 + 200, height - 200))};
        lUnit[i] = new LineUnit(input_cord, weight, styleImage);
        lUnit[i].get_pixel();
        tmp[i] = lUnit[i].heritate();
    }
}

void draw() {
    text("Press 's' to select a style image\nPress 'g' to get present image saved\nPresent status: "+status,5,15);

    if(styleImage != null) {
        if (toInitiate) {
            initiateLines();
        }
        image(styleImage,0,0);
        toInitiate = false;
    }

    if (toInitiate == false) {
        float decay = (weight - 0.001 * frameCount) * sin(PI / 480 * frameCount);
        weight = 3.0 + decay;
        for (int i = 0; i < num; i++) {
            lUnit[i] = new LineUnit(tmp[i], weight, styleImage);
            lUnit[i].get_pixel();
            tmp[i] = lUnit[i].heritate();
        }
    }
}

void styleImageSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("selected " + selection.getAbsolutePath());
    status = "FIGURE LOADED SUCCESSFULLY: "+selection.getAbsolutePath();
    styleImage = loadImage(selection.getAbsolutePath());
    // resize image (adjust as needed)
    styleImage.resize(800, height/2 + 30);
  }
}

void keyPressed() {
    if(key == 's') {
        selectInput("Select a style image to process:", "styleImageSelected");
    }
    if(key == 'g') {
        saveFrame("../../getframe-####.png");
    }
}
