var label = func(txt, posx, posy, desc) {
  cDefaultGroup.createChild("text", desc)
                .setTranslation(posx, posy)
                .setAlignment("left-top")
                .setFont("typewriter.txf")
                .setFontSize(40, 1.5)
                .setColor(0,0,0)
                .setText(txt);
};

var variable = func(txt, posy, desc) {
  cDefaultGroup.createChild("text", desc)
                .setTranslation(665, posy)
                .setAlignment("right-top")
                .setFont("DSEG/DSEG7/Classic/DSEG7Classic-BoldItalic.ttf")
                .setFontSize(80, 1.2)
                .setColor(0,0,0)
                .setText(txt);
};

var image = func(path, posx, posy, sizex, sizey) {
  cDefaultGroup.createChild("image")
               .setFile(path)
               .setTranslation(posx, posy)
               .setSize(sizex, sizey);
}

var cDisplay = canvas.new({
  "name": "IQONE",
  "size": [1024, 1024],
  "view": [795, 1024],
  "mipmapping": 1
});
cDisplay.addPlacement({"node": "iq_display"});
cDisplay.set("background", canvas.style.getColor("bg_color"));

var cDefaultGroup = cDisplay.createGroup();

label( "m/s", 670, 120, "mps");
label("ALT1", 600, 270, "alt1");
label(   "m", 670, 380, "m");
label("km/h", 670, 570, "kmph");
label("ALT3", 600, 630, "alt3");
label(   "m", 670, 750, "m");
label("TIME", 425, 790, "time");

var vario_t = variable( "0.0", 130, "vario");
var alt1_t = variable(    "0", 310, "alt");
var speed_t = variable( "0.0", 490, "speed");
var alt3_ = variable(     "0", 670, "alt");

var time_t = variable("00:00:00", 840, "time");

image("Models/display.png", 0,0, 795, 1024);

var rtimer = maketimer(0.2, func {
  var vario_ms = (getprop("velocities/vertical-speed-fps") or 0)* 0.3048;
  vario_t.setText(sprintf("%.1f", vario_ms));

  var glvl = 0;
  var PA_m = (getprop("/instrumentation/altimeter/pressure-alt-ft") or 0) * 0.3048;
  alt1_t.setText(sprintf("%i", PA_m));

  var speed_kmph = (getprop("velocities/airspeed-kt") or 0)* 1.852;
  speed_t.setText(sprintf("%.1f", speed_kmph));

  var hour = getprop("/sim/time/real/hour");
  var minute = getprop("/sim/time/real/minute");
  var second = getprop("/sim/time/real/second");
  time_t.setText(sprintf("%02i:%02i:%02i", hour, minute, second));
});
rtimer.start();
