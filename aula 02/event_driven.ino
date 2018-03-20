#include "event_driven.h"
#include "app.h"
#include "pindefs.h"

static int interesse_botao[3];
static int timer_end;
static int last_pressed[3];
static int last_state[3];

void button_listen(int pin)
{
  //verificar qual botao interessa
  //e indicar o interesse nele
  if (pin == KEY1) {
    interesse_botao[0] = 1;
  }
  else if (pin == KEY2) {
    interesse_botao[1] = 1;
  }
  else if (pin == KEY3) {
    interesse_botao[2] = 1;
  }
}

void timer_set(int ms)
{
  timer_end = millis() + ms;
}

void setup() {
  // put your setup code here, to run once:
  
  Serial.begin(9600);
  
  //inicializar sem interesse em botoes
  int i;
  for (i=0;i<3;i++) {
    interesse_botao[i] = 0;
  }
  
  //inicializar o final do timer
  timer_end = -1;
  
  int now = millis();
  
  //inicializar ultima vez que os botoes
  //foram pressionados
  //tambem inicializa o ultimo estado
  //de cada botao
  for (i=0;i<3;i++) {
    last_pressed[i] = now;
    last_state[i] = 1;
  }
  
  pinMode(KEY1, INPUT_PULLUP);
  pinMode(KEY2, INPUT_PULLUP);
  pinMode(KEY3, INPUT_PULLUP);
  
  //inicializa aplicacao
  appinit();
}

void loop() {
  // put your main code here, to run repeatedly:
  
  int now = millis();
  int but;
  
  //verificar interesse em botoes
  //e informar se foi pressionado
  //caso interesse
  
  if (interesse_botao[0]) {
    but = digitalRead(KEY1);
    if(but != last_state[0] && now > last_pressed[0] + 100) {
      last_pressed[0] = now;
      last_state[0] = but;
      button_changed(KEY1, but);
    }
  }
  
  if (interesse_botao[1]) {
    but = digitalRead(KEY2);
    if(but != last_state[0] && now > last_pressed[1] + 100) {
      last_pressed[1] = now;
      last_state[1] = but;
      button_changed(KEY2, but);
    }
  }
  
  if (interesse_botao[2]) {
    but = digitalRead(KEY3);
    if(but != last_state[0] && now > last_pressed[2] + 100) {
      last_pressed[2] = now;
      last_state[2] = but;
      button_changed(KEY3, but);
    }
  }
  
  //verificar se o tempo do timer
  //terminou
  
  if (timer_end != -1 && now > timer_end) {
    timer_end = -1;
    timer_expired();
  }
}
