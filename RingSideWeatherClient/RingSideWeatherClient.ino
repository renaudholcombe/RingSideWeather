
/*
 * A simple sketch that uses WiServer to serve a web page
 */


#include <WiServer.h>

#define WIRELESS_MODE_INFRA	1
#define WIRELESS_MODE_ADHOC	2

// Wireless configuration parameters ----------------------------------------
unsigned char local_ip[] = {192,168,168,12};	// IP address of WiShield
unsigned char gateway_ip[] = {192,168,168,1};	// router or gateway IP address
unsigned char subnet_mask[] = {255,255,255,0};	// subnet mask for the local network
const prog_char ssid[] PROGMEM = {"frejus"};		// max 32 bytes
unsigned char security_type = 2;	// 0 - open; 1 - WEP; 2 - WPA; 3 - WPA2

// WPA/WPA2 passphrase
const prog_char security_passphrase[] PROGMEM = {"cosbysnack"};	// max 64 characters

// WEP 128-bit keys
// sample HEX keys
prog_uchar wep_keys[] PROGMEM = { 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d,	// Key 0
				  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	// Key 1
				  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	// Key 2
				  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	// Key 3
				};

// setup the wireless mode
// infrastructure - connect to AP
// adhoc - connect to another WiFi device
unsigned char wireless_mode = WIRELESS_MODE_INFRA;

unsigned char ssid_len;
unsigned char security_passphrase_len;
// End of wireless configuration parameters ----------------------------------------

//weather values
String lightValue = "GREEN";
boolean isSnowing = false;
boolean isRaining = false;
boolean isWindy = false;

boolean isFirstRun = true;

const int LED_POWER = A3;
const int LED_WIFI = 7;
const int LED_SNOW = 6;
const int LED_RAIN = A2;
const int LED_WIND = A0;

const int LAMP_GREEN = 5;
const int LAMP_YELLOW = 9;
const int LAMP_RED = 3;
const int LAMP_POWERLEVEL = 145;

const int PIR_INPUT = 19;

unsigned long currentMillis;
boolean currentlyDisplaying = false;


// This is our page serving function that generates web pages
boolean sendMyPage(char* URL) {
  
  // Check if the requested URL matches "/"
  // This is the default 'heartbeat' page.
    if (strcmp(URL, "/") == 0) { 
        // Use WiServer's print and println functions to write out the page content
        WiServer.println("<html>");
        WiServer.print("<br>Light Value: ");
        WiServer.println(lightValue);
        WiServer.print("<br>Is it raining?: ");
        WiServer.println(isRaining);
        WiServer.print("<br>Is it snowing?: ");
        WiServer.println(isSnowing);
        WiServer.print("<br>Is it windy?: ");
        WiServer.println(isWindy);
        WiServer.println("</html>");
        Serial.println("renaud test sendMyPage");
        // URL was recognized
        return true;
    }
    parseURL(URL);
    return true;
}

void parseURL(char* URL)
{
  Serial.println(URL);
  //This method will the non-heartbeat case.
  String URLString = URL;
  if(URLString=="/diag")
  {
    displayDiagnosticMode();
    WiServer.println("Entered diagnostic mode");
    return;    
  }    
  if(validateInput(URL))
  {
      boolean tempIsRaining = (URL[2] == 48) ? 0 : 1;
      boolean tempIsSnowing = (URL[3] == 48) ? 0 : 1;
      boolean tempIsWindy = (URL[4] == 48) ? 0 : 1;
      updateWeather(int(URL[1]), tempIsRaining, tempIsSnowing, tempIsWindy);
      WiServer.println("OK, weather updated!");
  } else
  {
    WiServer.println("BAD INPUT!");
  }  
}

void updateWeather(int newLightValue, boolean newIsRaining, boolean newIsSnowing, boolean newIsWindy)
{
  switch(newLightValue)
  {
    case 48:
      lightValue = "GREEN";
      break;
    case 49: 
      lightValue = "YELLOW";
      break;
    default:
      lightValue = "RED";
  }
  
  isRaining = newIsRaining;
  isSnowing = newIsSnowing;
  isWindy = newIsWindy;
}

void turnOffLights()
{
  analogWrite(LAMP_GREEN,0);
  analogWrite(LAMP_YELLOW,0);
  analogWrite(LAMP_RED,0);
  digitalWrite(LED_RAIN,LOW);
  digitalWrite(LED_SNOW,LOW);
  digitalWrite(LED_WIND,LOW);
}

void displayDiagnosticMode()
{
  analogWrite(LAMP_GREEN, LAMP_POWERLEVEL);
  analogWrite(LAMP_YELLOW, LAMP_POWERLEVEL);
  analogWrite(LAMP_RED, LAMP_POWERLEVEL);
  digitalWrite(LED_RAIN, HIGH);
  digitalWrite(LED_SNOW, HIGH);
  digitalWrite(LED_WIND, HIGH);
  delay(3000);
  turnOffLights();
}

void displayWeather()
{
  

  if(lightValue == "GREEN")
    analogWrite(LAMP_GREEN, LAMP_POWERLEVEL);
  if(lightValue == "YELLOW")
    analogWrite(LAMP_YELLOW, LAMP_POWERLEVEL);
  if(lightValue == "RED")
    analogWrite(LAMP_RED, LAMP_POWERLEVEL);
  if(isRaining)
    digitalWrite(LED_RAIN, HIGH);
  if(isSnowing)
    digitalWrite(LED_SNOW, HIGH);
  if(isWindy)
    digitalWrite(LED_WIND, HIGH);
  
}

boolean validateInput(char* input)
{
  //URLS should come in this format: "/2011"
  //This means that we should be showing: RED, not raining, snowing and windy.
  
  //validating light value
  if(input[1] > 50 || input[1] < 48)
    return false;
  //validating isRaining value
  if(input[2] != 48 && input[2] != 49)
    return false;
  //validating isSnowing value
  if(input[3] != 48 && input[3] != 49)
    return false;
  //validating isWindy value
  if(input[4] != 48 && input[4] != 49)
    return false;
  
  return true;
}


void setup() {
  // Initialize WiServer and have it use the sendMyPage function to serve pages
  //digitalWrite(13,HIGH);
  
  Serial.begin(57600);
  Serial.println("WiServer Initialized");
  preparePinModes();
  Serial.print("Initial PIR value: ");
  Serial.println(digitalRead(PIR_INPUT));
  
  WiServer.init(sendMyPage);
  // Enable Serial output and ask WiServer to generate log messages (optional)
  WiServer.enableVerboseMode(true);
}

void preparePinModes()
{
  pinMode(LED_POWER, OUTPUT);
  digitalWrite(LED_POWER,HIGH);

  pinMode(LED_WIFI,OUTPUT);
  
  pinMode(LAMP_RED,OUTPUT);
  analogWrite(LAMP_RED, LAMP_POWERLEVEL);
  pinMode(LAMP_YELLOW,OUTPUT);
  analogWrite(LAMP_YELLOW, LAMP_POWERLEVEL);
  pinMode(LAMP_GREEN,OUTPUT);
  analogWrite(LAMP_GREEN, LAMP_POWERLEVEL);

  pinMode(PIR_INPUT,INPUT);
  digitalWrite(PIR_INPUT,HIGH);

  pinMode(LED_SNOW, OUTPUT);
  digitalWrite(LED_SNOW, HIGH);
  pinMode(LED_RAIN, OUTPUT);
  digitalWrite(LED_RAIN, HIGH);
  pinMode(LED_WIND, OUTPUT);
  digitalWrite(LED_WIND, HIGH);
  
  pinMode(18,OUTPUT);
}

void loop(){
  // Run WiServer
  if(isFirstRun)
  {
    Serial.println("Entered FirstRun");
    Serial.print("Initial FirstRun PIR value: ");
    Serial.println(digitalRead(PIR_INPUT));

    currentMillis = millis();
    //put some more stuff in here to properly handle some sort of startup sequence (maybe a special LED for wifi connection).
    digitalWrite(LED_WIFI,HIGH);
    turnOffLights();
    isFirstRun = false; 
    digitalWrite(18,LOW);
  }

  int inputVal = digitalRead(PIR_INPUT);
  WiServer.server_task();
  if(inputVal == LOW && !currentlyDisplaying)
  {
    
    Serial.print("Motion Detected! ");
    Serial.print(inputVal);
    Serial.print(" : ");
    Serial.println(digitalRead(PIR_INPUT));
    displayWeather();
    currentlyDisplaying = true;
    Serial.print("Motion detected after ");
    Serial.print(millis()-currentMillis);
    Serial.println(" millis");
    currentMillis = millis();
    digitalWrite(18,HIGH);
    
  } 
  if(millis()-currentMillis > 5000 && currentlyDisplaying)
  {
    Serial.print("Lights out after ");
    Serial.print(millis()-currentMillis);
    Serial.println(" millis");
    turnOffLights();
    currentlyDisplaying = false;
    currentMillis = millis();
    digitalWrite(18,LOW);
  }
  
 
}


