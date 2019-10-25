ArrayList<Integer> deck = new ArrayList<Integer>();  //Laver arrayerne. 
ArrayList<Integer> hand = new ArrayList<Integer>();  //Laver arrayerne.
ArrayList<String> deck_type = new ArrayList<String>();  //Laver arrayerne.
ArrayList<String> hand_type = new ArrayList<String>();  //Laver arrayerne.

ArrayList<Integer> opp_deck = new ArrayList<Integer>();  //Laver arrayerne. 
ArrayList<Integer> opp_hand = new ArrayList<Integer>();  //Laver arrayerne.
ArrayList<String> opp_deck_type = new ArrayList<String>();  //Laver arrayerne.
ArrayList<String> opp_hand_type = new ArrayList<String>();  //Laver arrayerne.


PImage cardback;  //Finder billedet som er på kortene

int xoffset;  //Laver variablen som styrer hvor listen af dine kort står.
int yoffset;  //Laver variablen som styrer hvor listen af dine kort står.

int decksize = 52;  //Laver størrelsen af dekket.
int decktotal = 0;  //Hvor mange kort der er tilbage i dit deck
int drawtotal = 0;  //Værdien af alle dine kort
int opp_drawtotal = 0;  //Værdien af alle din modstanders kort
int drawnumber;  //Hvilket kort i decket der er trukket
int drawvalue;  //Hvilket værdi det trukkede kort har
boolean mdown = false;  //Styrer musen

int playerpoints = 0, opponentpoints = 0;

int wait = 0;

void refill() { //Funktionen tom tilføjer kort til dekket hvis der ikke er nogle kort i dekket.
  if (deck.size() == 0) {
    for (int i = 1; i < 14; i ++) {  //Tilføjer alle kortene og de tilsvarene korttyper
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
  }
}

boolean mouseoncards() {  //Laver funktionen som finder ud af som musen er på decket
  if ((mouseX > 1200)&&(mouseX < 1200+400+(deck.size()*3))&&(mouseY > 300) && (mouseY < 300+562+3*deck.size())) {
    return true;
  } else
    return false;
}

void setup() {
  size(1920, 1080);
  refill();

  cardback = loadImage("cardback.png"); //Loader billedet som er på kortene
}

void draw() {
  wait --;
  if (wait < 0) {
    clear();
    refill();
    if ((mousePressed) && mouseoncards()) {  //Hvis man trykker på kortene med musen og der er flere kort tilbage i decket. Finder den et tilfældigt kort, Hvilket den tilhøjer til din hånd.
      if ((!mdown) && (deck.size() > 0)) {   //Derefter fjerner den kortet fra decket. Hvorefter den addere værdien du har trukket med værdien af kortet du har trukket
        if (drawtotal < 21) {
          drawnumber = int(  random(0, deck.size()-1  ));  //Finder det tilføldige tal
          drawvalue = deck.get(drawnumber);    //FInder værdien af kortet
          hand.add(drawvalue);                 //TIlføjer kortet til din hånd
          deck.remove(drawnumber);             //Fjerner kortet fra decket
          hand_type.add(deck_type.get(drawnumber)); //Tilføjer korttypen til din hånd
          deck_type.remove(drawnumber);        //Fjerner kortypen fra dit deck

          drawtotal += drawvalue;        //Addere værdien af kortet til værdien af din hånd
          decktotal -= drawvalue;        //Fjerner værdien af kortet fra dit deck
        }
        refill();
        if (opp_drawtotal < 21) {
          //Her trækker modstanderen kort
          drawnumber = int(  random(0, deck.size()-1  ));
          drawvalue = deck.get(drawnumber);
          opp_hand.add(drawvalue);                 //TIlføjer kortet til din hånd
          deck.remove(drawnumber);             //Fjerner kortet fra decket
          opp_hand_type.add(deck_type.get(drawnumber)); //Tilføjer korttypen til din hånd
          deck_type.remove(drawnumber);        //Fjerner kortypen fra dit deck

          opp_drawtotal += drawvalue;
          decktotal -= drawvalue;
        }
        mdown = true;                  //Styrer musen så den ikke trækker 60 kort i sekundet
      }
    }
    if (!mousePressed) {
      mdown = false;
    }

    textSize(40);
    text("This is your hand: ", 100, 100);    //Tegner text
    text("This is your opponents hand: ", 800, 100);
    textSize(20);
    text("You've won " + playerpoints + " Times", 100, 60);
    text("You opponent has won " + opponentpoints + " Times", 800, 60);

    for (int i = 0; i < hand.size(); i ++) {  //Tegner din hånd, og hvis listen er for lang bliver offset stort og den tegner den nye liste ved siden af. 
      if (i > 25) {
        xoffset = 200;
        yoffset = 780;
      } else {
        xoffset = 0;
        yoffset = 0;
      }
      text(hand.get(i), 100+xoffset, 160+30*i-yoffset); //Finder værdien af kortet som skal tegnes 
      text(hand_type.get(i), 140+xoffset, 160+30*i-yoffset);    //Finder typen af kortet som skal tegnes
    }
    for (int i = 0; i < opp_hand.size(); i ++) {  //Tegner din hånd, og hvis listen er for lang bliver offset stort og den tegner den nye liste ved siden af. 
      if (i > 25) {
        xoffset = 200;
        yoffset = 780;
      } else {
        xoffset = 0;
        yoffset = 0;
      }
      text(opp_hand.get(i), 800+xoffset, 160+30*i-yoffset); //Finder værdien af kortet som skal tegnes 
      text(opp_hand_type.get(i), 840+xoffset, 160+30*i-yoffset);    //Finder typen af kortet som skal tegnes
    }
    for (int i = 0; i < deck.size(); i ++) {  //Tegner kortene oven på hinanden
      image(cardback, 1200+3*i, 300+3*i);
    }
    if (drawtotal > 21) {    //Tjekker om du har mere end 21 point
      text("You've got more than 21", 400, 130);
    }

    text("Your opponents total points: "+opp_drawtotal, 800, 130);
    if (opp_drawtotal < 21) {    //Hvis opponent har færre end 21 point
      text("Your opponent got less than 21", 1200, 130);
    }

    text("Your total points: "+drawtotal, 100, 130);
    if (drawtotal < 21) {    //TJekker om du har færre end 21 point
      text("You've got less than 21", 400, 130);
    }

    if (opp_drawtotal > 21) {    //Hvis opponent har mere end 21 point
      text("Your opponent got more than 21", 1200, 130);
    }

    if ((opp_drawtotal >= 21) || (drawtotal >= 21)) {
      if ((opp_drawtotal > 21) && (drawtotal > 21)) {  //Hvis begge taber
        textSize(40);
        text("Neither won", width/2-200, height/2);
        textSize(20);
        wait = 60;
        while (hand.size() > 0) {
          hand.remove(hand.size()-1);
        }
        while (opp_hand.size() > 0) {
          opp_hand.remove(opp_hand.size()-1);
        }
        drawtotal = 0;
        opp_drawtotal = 0;
      } else if (opp_drawtotal == 21) {  //Hvis oppo vinder
        textSize(40);
        text("Opponent won", width/2-200, height/2);
        textSize(20);
        wait = 60;
        while (hand.size() > 0) {
          hand.remove(hand.size()-1);
        }
        while (opp_hand.size() > 0) {
          opp_hand.remove(opp_hand.size()-1);
        }
        drawtotal = 0;
        opp_drawtotal = 0;
        opponentpoints ++;
      } else if (drawtotal == 21) {  //Hvis player vinder
        textSize(40);
        text("You won", width/2-200, height/2);
        textSize(20);
        wait = 60;
        while (hand.size() > 0) {
          hand.remove(hand.size()-1);
        }
        while (opp_hand.size() > 0) {
          opp_hand.remove(opp_hand.size()-1);
        }
        drawtotal = 0;
        opp_drawtotal = 0;
        playerpoints ++;
      }
    }
  }
}
