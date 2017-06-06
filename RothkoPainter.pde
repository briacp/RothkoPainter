import java.util.Collections;
import java.util.Set;
import java.util.HashSet;
import java.util.List;
import gohai.simpletweet.*;

SimpleTweet simpletweet;

// inspired by http://www.tylerlhobbs.com/writings/watercolor and After Dark screen saver
void setup() {
  size(600, 777);
  simpletweet = new SimpleTweet(this);

  JSONObject json = loadJSONObject("twitter_conf.json");

  simpletweet.setOAuthConsumerKey(json.getString("OAuthConsumerKey"));
  simpletweet.setOAuthConsumerSecret(json.getString("OAuthConsumerSecret"));
  simpletweet.setOAuthAccessToken(json.getString("OAuthAccessToken"));
  simpletweet.setOAuthAccessTokenSecret(json.getString("OAuthAccessTokenSecret"));

  RothkoFrame painting = randomPainting();
  painting = whiteCenter();
  painting.draw();
  println(painting.getTitle());
}

void draw() {
}

void mouseClicked() {
  RothkoFrame painting = randomPainting();
  painting.draw();

  //String tweet = simpletweet.tweetImage(get(), painting.getTitle());
  //println(tweet);
}

RothkoFrame randomPainting() {
  RothkoFrame painting = new RothkoFrame(width, height, randomColor(), null, (int) (15 + random(50)));

  int rectNumbers = (int) ( 2 + random(3) );

  float sizeLeft = 1;
  for (int i = 0; i < rectNumbers; i++) {
    float rectSize = 0.1 + random(sizeLeft);
    painting.addRect(rectSize, randomColor(), (int)(20+random(180)));
    sizeLeft -= rectSize;
  }

  return painting;
}

color randomColor() {
  return color(random(255), random(255), random(255));
}


/** Example painting */
RothkoFrame whiteCenter() {
  RothkoFrame painting = new RothkoFrame(width, height, color(211, 42, 39), "White Center (Yellow, Pink and Lavender on Rose)", 30);

  painting.addRect(0.30, color(255, 152, 40), 40);
  painting.addRect(0.01, color(39, 40, 34), 170);
  painting.addRect(0.20, color(251, 249, 228), 100);
  painting.addRect(0.01, color(39, 40, 34), 120);
  painting.addRect(0.40, color(251, 91, 151), 80);

  return painting;
}