const Discord = require('discord.js');
const client = new Discord.Client();
const config = require("./config.json");
const prefix = config.prefix;

var sqlite3 = require('sqlite3').verbose();
var db = new sqlite3.Database('db/dev.db');
var cardMatcher = new RegExp("^" + prefix + "card ([A-Z1-9]{3,5})$")

function cardSearch(){};
function getCard(){};

client.on('ready', () => {
  console.log(`Logged in as ${client.user.tag}!`);
});


client.on('message', msg => {
  
    console.log("Got message: " + msg.content);

  if (msg.content === 'ping') {
    
    msg.reply('Pong!');

  } if (msg.content.toUpperCase().match("^" + prefix + "CARD ([A-Z1-9]{3,5})$")) {
    console.log("matches")

    var match = cardMatcher.exec(msg.content);
    
    var code = match[1]

    db.each("SELECT * FROM Cards WHERE Code = \"" + code + "\"", function (err, row) {
        msg.reply(JSON.stringify(row));
    })
  }
});

client.login(config.token);