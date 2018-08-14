const Discord = require('discord.js');
const client = new Discord.Client();
const config = require("./config.json");
const prefix = config.prefix;

var sqlite3 = require('sqlite3').verbose();
var db = new sqlite3.Database('db/dev.db');
var cardMatcher = new RegExp("^" + prefix + "card ([A-Z1-9]{3,5})$")

function sendImage(message, url) {
  message.channel.send("", {
    file: url
  });
}

client.on('ready', () => {
  console.log(`Logged in as ${client.user.tag}!`);
});


client.on('message', msg => {
  
  console.log("Got message: " + msg.content);
  if (msg.author !== client.user) {

    if (msg.content.toUpperCase().match("^" + prefix + "CARD ([A-Z1-9]{3,5})$")) {
      console.log("matches")

      var match = cardMatcher.exec(msg.content);
      if (match[1] != null) {
        console.log("Blob: " + match[1])
        db.each('SELECT ' +
        'PrimaryWeapons.WeaponName AS PrimaryName, ' + 
        'SecondaryWeapons.WeaponName AS SecondaryName, ' +
        'MeleeWeapons.WeaponName AS MeleeName, ' +
        'Cards.Slot1, Cards.Slot2, Cards.Slot3, Cards.Generation, Mercs.Name AS Merc, ' +
        'Augments1.Name as Augment1, Augments2.Name as Augment2, Augments3.Name as Augment3 ' +
      'FROM Cards ' +
        'INNER JOIN PrimaryWeapons ON Cards.Slot1 = PrimaryWeapons.WeaponID ' +
        'INNER JOIN SecondaryWeapons ON Cards.Slot2 = SecondaryWeapons.WeaponID ' +
        'INNER JOIN MeleeWeapons ON Cards.Slot3 = MeleeWeapons.WeaponID ' +
        'INNER JOIN Mercs ON Cards.MercID = Mercs.MercID ' +
        'INNER JOIN Augments1 ON Cards.Augment1 = Augments1.AugmentID ' +
        'INNER JOIN Augments2 ON Cards.Augment2 = Augments2.AugmentID ' +
        'INNER JOIN Augments3 ON Cards.Augment3 = Augments3.AugmentID ' +
      `WHERE Code = \"${match[1]}\" LIMIT 1`,
        function (err, row) {
          if (err) {
            console.log(err);
          } else {
            msg.channel.send(`${row.Slot1}${row.Slot2}${row.Slot3} ${row.Merc} Gen ${row.Generation}\n` +
                             `${row.PrimaryName}, ${row.SecondaryName}, ${row.MeleeName}\n` +
                             `${row.Augment1}, ${row.Augment2}, ${row.Augment3}`)
          }
        })
      }

    }

  }
});

client.login(config.token);