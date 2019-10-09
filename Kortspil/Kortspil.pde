ArrayList<Integer> deck = new ArrayList<Integer>();
ArrayList<Integer> hand = new ArrayList<Integer>();
ArrayList<String> deck_type = new ArrayList<String>();
ArrayList<String> hand_type = new ArrayList<String>();
PImage cardback;

int xoffset;
int yoffset;

int decksize = 52;
int decktotal = 0;
int drawtotal = 0;
int drawnumber;
int drawvalue;
boolean mdown = false;


boolean mouseoncards() {
  if ((mouseX > 1200)&&(mouseX < 1200+400+(deck.size()*3))&&(mouseY > 300) && (mouseY < 300+562+3*deck.size())) {
    return true;
  } else
    return false;
}

void setup() {
  size(1920, 1080);
  for (int i = 1; i < 14; i ++) {
    deck.add(i);
    deck_type.add("Heart");

    deck.add(i);
    deck_type.add("Spades");

    deck.add(i);
    deck_type.add("Clubs");

    deck.add(i);
    deck_type.add("Diamonds");

    decktotal += i;
  }
  cardback = loadImage("cardback.png");
}

void draw() {
  clear();
  if ((mousePressed) && mouseoncards()) {
    if ((!mdown) && (deck.size() > 0)) {
      drawnumber = int(  random(0, deck.size()-1  ));
      drawvalue = deck.get(drawnumber);
      deck.remove(drawnumber);
      hand_type.add(deck_type.get(drawnumber));
      deck_type.remove(drawnumber);


      hand.add(drawvalue);

      drawtotal += drawvalue;
      decktotal -= drawvalue;
      mdown = true;
      println(hand_type);
    }
  }
  if (!mousePressed) {
    mdown = false;
  }

  textSize(40);
  text("This is your hand: ", 100, 100);
  //text("This is your deck", 1000, 100);

  textSize(20);
  for (int i = 0; i < hand.size(); i ++) {
    if (i > 25) {
      xoffset = 200;
      yoffset = 760;
    } else {
      xoffset = 0;
      yoffset = 0;
    }
    text(hand.get(i), 100+xoffset, 160+30*i-yoffset);
    text(hand_type.get(i), 140+xoffset, 160+30*i-yoffset);
  }
  for (int i = 0; i < deck.size(); i ++) {
    image(cardback, 1200+3*i, 300+3*i);
    /*
    text(deck.get(i), 1000, 160+30*i);
     text(deck_type.get(i), 1040, 160+30*i);
     */
  }
  text("Your total points: "+drawtotal, 100, 130);
  if (drawtotal == 21) {
    text("You've got 21", 400, 130);
  }

  if (drawtotal >= 22) {
    text("You've got more than 21", 400, 130);
  }
}
