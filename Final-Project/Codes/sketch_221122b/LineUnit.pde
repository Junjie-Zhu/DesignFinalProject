class LineUnit {
    float cutoff=random(2, 15);
    float angle=random(2);
    int cord_x, cord_y;
    float weight;
    PImage img;

    LineUnit(int[] crd, float wt, PImage g) {
        cord_x = crd[0];
        cord_y = crd[1];
        weight = wt;
        img = g;
    }

    void get_pixel() {
        int loc = cord_x + (cord_y - height/2) * img.width;
        stroke(img.pixels[loc]);
        strokeWeight(abs(weight));    
    }

    int[] heritate() {
        int delta_x = int(cutoff * cos(angle * PI));
        int delta_y = int(cutoff * sin(angle * PI));

        int[] cord_new={cord_x + delta_x, cord_y + delta_y};
        if (cord_new[0] < 0 || cord_new[0] > width || cord_new[1] < height/2 || cord_new[1] > height) {
            cord_new[0] = int(random(200, width - 200));
            cord_new[1] = int(random(height/2 + 200, height - 200));
            return cord_new;
        }
        line(cord_x, cord_y, cord_new[0], cord_new[1]);
        return cord_new;
    }
}