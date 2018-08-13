require "sqlite3"
db = SQLite3::Database.new "db/dev.db"

def wipe(db)
    File.open('db/dev.db', 'w') {|file| file.truncate(0) }
    puts("Wiped database")
end

def create_tables(db)
    db.execute("CREATE TABLE IF NOT EXISTS WeaponTypes (" +
        "TypeID integer PRIMARY KEY," +
        "TypeName varchar(30)" +
        ");")

 db.execute("CREATE TABLE IF NOT EXISTS PrimaryWeapons (" +
        "WeaponID varchar(3) PRIMARY KEY," +
        "WeaponName varchar(25)," +
        "TypeID integer," +
        "FOREIGN KEY (TypeID) REFERENCES WeaponTypes (TypeID));")

 db.execute("CREATE TABLE IF NOT EXISTS SecondaryWeapons (" +
        "WeaponID integer PRIMARY KEY," +
        "WeaponName varchar(25));")

 db.execute("CREATE TABLE IF NOT EXISTS MeleeWeapons (" +
        "WeaponID integer PRIMARY KEY," +
        "WeaponName varchar(25));")

 db.execute("CREATE TABLE IF NOT EXISTS Mercs (" +
        "MercID integer PRIMARY KEY," +
        "Name varchar(20), " +
        "MercRole varchar(20)," +
        "HP integer," +
        "Speed integer);")

 db.execute("CREATE TABLE IF NOT EXISTS Cards (" +
        "Slot1 varchar(3)," +
        "Slot2 integer," +
        "Slot3 integer," +
        "Generation integer," +
        "MercID integer,"+
        "Augment1 integer,"+
        "Augment2 integer,"+
        "Augment3 integer,"+
        "FOREIGN KEY (Slot1) REFERENCES PrimaryWeapons (WeaponID),"+
        "FOREIGN KEY (Slot2) REFERENCES SecondaryWeapons(WeaponID),"+
        "FOREIGN KEY (Slot3) REFERENCES MeleeWeapons (WeaponID),"+
        "FOREIGN KEY (MercID) REFERENCES Mercs(MercID),"+
        "FOREIGN KEY (Augment1) REFERENCES Augments(AugmentID)," +
        "FOREIGN KEY (Augment2) REFERENCES Augments(AugmentID)," +
        "FOREIGN KEY (Augment3) REFERENCES Augments(AugmentID)," +
        "PRIMARY KEY (Slot1, Slot2, Slot3, Generation, MercID));"
        )

db.execute("CREATE TABLE IF NOT EXISTS Augments1 (" +
        "AugmentID integer PRIMARY KEY," +
        "Name varchar(15)," +
        "Description varchar(60));"
)

db.execute("CREATE TABLE IF NOT EXISTS Augments2 (" +
    "AugmentID integer PRIMARY KEY," +
    "Name varchar(15)," +
    "Description varchar(60));"
)
db.execute("CREATE TABLE IF NOT EXISTS Augments3 (" +
           "AugmentID integer PRIMARY KEY," +
           "Name varchar(15)," +
           "Description varchar(60));"
)
       puts("Tables created")
end

def insert_data(db)

    db.execute("INSERT INTO WeaponTypes (\"TypeID\", \"TypeName\")" +
            "VALUES" +
            "(1, \"Assault Rifle\")," +
            "(2, \"LMG\")," +
            "(3, \"Burst Rifle\")," +
            "(4, \"SMG\")," +
            "(5, \"Shotgun\")," +
            "(6, \"Rifle & Sniper\")," +
            "(7, \"Machine Pistol\");")

    db.execute("INSERT INTO PrimaryWeapons (\"WeaponID\",\"WeaponName\", \"TypeID\")" +
           "VALUES" +
           "( \"HU\", \"Hurtsall 2K\", 1)," +
           "( \"M\", \"M4A1\", 1)," +
           "( \"SH\", \"SHAR-C\", 1)," +
           "( \"T\", \"Timik-47\", 1)," +

           "( \"K\", \"K-121\", 2)," +
           "( \"MA\", \"MK46\", 2)," +

           "( \"B\", \"BR-16\", 3)," +
           "( \"S\", \"Stark AR\", 3)," +

           "( \"BL\", \"Blishlok\", 4)," +
           "( \"CR\", \"Crotzni\", 4)," +
           "( \"KE\", \"Hochfir\", 4)," +
           "( \"C\", \"KEK-10\", 4)," +
           "( \"SM\", \"SMG-9\", 4)," +

           "( \"A\", \"Ahnuhld-12\", 5)," +
           "( \"H\", \"Hollunds 880\", 5)," +
           "( \"R\", \"Remburg 7\", 5)," +

           "( \"D\", \"Dreiss AR\", 6)," +
           "( \"G\", \"Grandeur SR\", 6)," +
           "( \"P\", \"PDP-70\", 6)," +
           "( \"F\", \"Fel-ix\", 6)," +
           "( \"MO\", \"MOA SNPR-1\", 6),"  +
           
           "( \"1\", \"MP400\", 7)," +
           "( \"2\", \"Tolen MP\", 7)," +
           "( \"3\", \"Empire-9\", 7)," +
           "( \"4\", \"Ryburn MP\", 7)"  +
           
           ";")

    # Note: The M9 and the Ryburn MP both use 4 for
    #       weapon card codes. In the database the ryburn is 99
    #       (Since the next pistol might use 12, and 99 
    #       is easy to recognise for when an exception is written for it)
    db.execute("INSERT INTO SecondaryWeapons (\"WeaponID\", \"WeaponName\")" +
           "VALUES" +
           "(1, \"MP400\")," +
           "(2, \"Tolen MP\")," +
           "(3, \"Empire-9\")," +
           "(4, \"M9\")," +
           "(5, \"DE .50\")," +
           "(6, \"Simeon .357\")," +
           "(7, \"Caulden\")," +
           "(8, \"Selbstadt .40\")," +
           "(9, \"Smjüth & Whetsman .40\")," +
           "(10, \"Hoigat .224\")," +
           "(11, \"Arevarov 9\")," +
           "(99, \"Ryburn MP\");")

    # Note: The Tactical Combat Axe and the Stun Batons both use 6 for
    #       weapon card codes. In the database the Stun Batons are 99
    #       (For the same reason as the ryburn)
    db.execute("INSERT INTO MeleeWeapons (\"WeaponID\", \"WeaponName\")" +
           "VALUES" +
           "(1, \"Beckhill Combat Knife\")," +
           "(2, \"Stilnotto Stiletto\")," +
           "(3, \"Cricket Bat\")," +
           "(4, \"Katana\")," +
           "(5, \"Kukri\")," +
           "(6, \"Tactical Combat Axe\")," +
           "(7, \"Ulu\")," +
           "(99, \"Stun Batons\");")

    db.execute("INSERT INTO Mercs (\"MercID\", \"Name\", \"MercRole\", \"HP\", \"Speed\")" +
           "VALUES" +
           "(1, \"Aura\", \"Medic\", 80, 470)," +
           "(2, \"Guardian\", \"Medic\", 110, 430)," +
           "(3, \"Phoenix\", \"Medic\", 100, 430)," +
           "(4, \"Sawbonez\", \"Medic\", 110, 410)," +
           "(5, \"Sparks\", \"Medic\", 80, 470)," +

           "(6, \"Bushwhacker\", \"Specialist\", 110, 410)," +
           "(7, \"Fletcher\", \"Specialist\", 110, 420)," +
           "(8, \"Proxy\", \"Specialist\", 90, 450)," +
           "(9, \"Turtle\", \"Specialist\", 110, 410)," +

           "(10, \"Arty\", \"Fire Support\", 120, 400)," +
           "(11, \"Javelin\", \"Fire Support\", 120, 400)," +
           "(12, \"Kira\", \"Fire Support\", 90, 440)," +
           "(13, \"Skyhammer\", \"Fire Support\", 120, 400)," +
           "(14, \"Stoker\", \"Fire Support\", 120, 400)," +

           "(15, \"Fragger\", \"Assault\", 130, 390)," +
           "(16, \"Nader\", \"Assault\", 120, 410)," +
           "(17, \"Rhino\", \"Assault\", 200, 360)," +
           "(18, \"Thunder\", \"Assault\", 160, 380)," +
           
           "(19, \"Aimee\", \"Recon\", 90, 440)," +
           "(20, \"Hunter\", \"Recon\", 110, 420)," +
           "(21, \"Phantom\", \"Recon\", 120, 410)," +
           "(22, \"Redeye\", \"Recon\", 120, 400)," +
           "(23, \"Vassili\", \"Recon\", 110, 420);")

    db.execute("INSERT INTO Augments1 (\"AugmentID\", \"Name\", \"Description\")" +
               "VALUES" + 
               "(1, \"Ammo Reach\", \"25% increase to ammo station radius\")," +
               "(2, \"Big Ears \", \"Enemy footsteps and other appropriate noises are 50% \")," +
               "(3, \"Bigger Blast\", \"10% increase to blast radius to AoE weapons. \")," +
               "(4, \"Bomb Squad \", \"Makes enemy deployables, such as Proxmity Mines, more visible. \")," +
               "(5, \"Chopper\", \"15% increase to melee damage.\")," +
               "(6, \"Cool\", \"Doubles the time it takes Mounted MGs to overheat.\")," +
               "(7, \"Double Time\", \"Allows you to reload whilst sprinting\")," +
               "(8, \"Drilled\", \"20% reduction to reload time\")," +
               "(9, \"Enigma\", \"Reduced duration of being spotted by 60%.\")," +
               "(10, \"Explodydendron\", \"10% increase to blast radius to AoE abilities\")," +
               "(11, \"Extra Ammo\", \"Increase the max number of ammo packs by one\")," +
               "(12, \"Extra Supplies\", \"20% cooldown reduction to support abilities\")," +
               "(13, \"Extender\", \"Extends the size of the shield by 25% on turtle and 20% on guardian\")," +
               "(14, \"Fail Safe\", \"Reduces the effect taken from your own explosives by 30%\")," +
               "(15, \"Flying Pig\", \"Increases Long Jump distance by 10% and removes falling damage\")," +
               "(16, \"Focus\", \"Reduces Flinching when hit while iron sighting or scoped by 30%\")," +
               "(17, \"Get up\", \"30% increase to health given on revive\")," +
               "(18, \"Guardian Angel\", \"Receive an audio warning whenever a nearby enemy air support is a danger to you and 20% reduced damage from air support abilities\")," +
               "(19, \"Healing Reach\", \"15% increase to size of healing radius\")," +
               "(20, \"Ice Cold\", \"40% increase in time until overheating\")," +
               "(21, \"Lock on\", \"Turrets, Mines and other automated defences react 30% more quickly\")," +
               "(22, \"Looter\", \"Killing an enemy Fire Support Merc will drop a small Ammo Pack, killing an enemy Medic will drop a small Health Pack\")," +
               "(23, \"Mechanic\", \"Improves any repair tools and disarm rates by 20%\")," +
               "(24, \"Nitros\", \"50% increase to barrel acceleration\")," +
               "(25, \"Pineapple Juggler\", \"Allows you to melee hit back mid-air grenades and other projectiles\")," +
               "(26, \"Potent Packs\", \"20% increase to health regen rate given by healing abilities\")," +
               "(27, \"Quick Draw\", \"30% faster weapon/item switching\")," +
               "(28, \"Quick Charge\", \"10% increase to round charge rate\")," +
               "(29, \"Quick Eye\", \"35% faster movement speed and raise/lower times when Iron Sighting\")," +
               "(30, \"Quick Slash\", \"Increases melee slash speed by 15%\")," +
               "(31, \"Recharge\", \"10% reduction to ability cooldown\")," +
               "(32, \"Sneaky\", \"Reduces the amount of sound you generate when running by 50%\")," +
               "(33, \"Spares\", \"Increases the maximum number of magazines that can be carried by 1\")," +
               "(34, \"Spotter\", \"20% increase to the detection radius\")," +
               "(35, \"Springy\", \"Reduces jumping and Long Jump penalties by 35%\")," +
               "(36, \"Steady\", \"22% Increase to deployables health\")," +
               "(37, \"Tough\", \"Reduces the delay untill health regen starts by 66%\")," +
               "(38, \"Try Hard\", \"Gain 10HP for each death you suffer without getting a kill, up to a maximum of 30HP\")," +
               "(39, \"Undercover\", \"10% increase to ability duration\")," +
               "(40, \"Unshakeable\", \"Reduces the damage you take from explosives by 15%\")," +
               "(41, \"Untrackable\", \"Turrets, Mines and other automated defenses react 35% more slowly to your presence\")"
               
        )

        db.execute("INSERT INTO Augments2 (\"AugmentID\", \"Name\", \"Description\")" +
               "VALUES" + 
               "(1, \"Ammo Reach\", \"25% increase to ammo station radius\")," +
               "(2, \"Big Ears \", \"Enemy footsteps and other appropriate noises are 50% \")," +
               "(3, \"Bigger Blast\", \"10% increase to blast radius to AoE weapons. \")," +
               "(4, \"Bomb Squad \", \"Makes enemy deployables, such as Proxmity Mines, more visible. \")," +
               "(5, \"Chopper\", \"15% increase to melee damage.\")," +
               "(6, \"Cool\", \"Doubles the time it takes Mounted MGs to overheat.\")," +
               "(7, \"Double Time\", \"Allows you to reload whilst sprinting\")," +
               "(8, \"Drilled\", \"20% reduction to reload time\")," +
               "(9, \"Enigma\", \"Reduced duration of being spotted by 60%.\")," +
               "(10, \"Explodydendron\", \"10% increase to blast radius to AoE abilities\")," +
               "(11, \"Extra Ammo\", \"Increase the max number of ammo packs by one\")," +
               "(12, \"Extra Supplies\", \"20% cooldown reduction to support abilities\")," +
               "(13, \"Extender\", \"Extends the size of the shield by 25% on turtle and 20% on guardian\")," +
               "(14, \"Fail Safe\", \"Reduces the effect taken from your own explosives by 30%\")," +
               "(15, \"Flying Pig\", \"Increases Long Jump distance by 10% and removes falling damage\")," +
               "(16, \"Focus\", \"Reduces Flinching when hit while iron sighting or scoped by 30%\")," +
               "(17, \"Get up\", \"30% increase to health given on revive\")," +
               "(18, \"Guardian Angel\", \"Receive an audio warning whenever a nearby enemy air support is a danger to you and 20% reduced damage from air support abilities\")," +
               "(19, \"Healing Reach\", \"15% increase to size of healing radius\")," +
               "(20, \"Ice Cold\", \"40% increase in time until overheating\")," +
               "(21, \"Lock on\", \"Turrets, Mines and other automated defences react 30% more quickly\")," +
               "(22, \"Looter\", \"Killing an enemy Fire Support Merc will drop a small Ammo Pack, killing an enemy Medic will drop a small Health Pack\")," +
               "(23, \"Mechanic\", \"Improves any repair tools and disarm rates by 20%\")," +
               "(24, \"Nitros\", \"50% increase to barrel acceleration\")," +
               "(25, \"Pineapple Juggler\", \"Allows you to melee hit back mid-air grenades and other projectiles\")," +
               "(26, \"Potent Packs\", \"20% increase to health regen rate given by healing abilities\")," +
               "(27, \"Quick Draw\", \"30% faster weapon/item switching\")," +
               "(28, \"Quick Charge\", \"10% increase to round charge rate\")," +
               "(29, \"Quick Eye\", \"35% faster movement speed and raise/lower times when Iron Sighting\")," +
               "(30, \"Quick Slash\", \"Increases melee slash speed by 15%\")," +
               "(31, \"Recharge\", \"10% reduction to ability cooldown\")," +
               "(32, \"Sneaky\", \"Reduces the amount of sound you generate when running by 50%\")," +
               "(33, \"Spares\", \"Increases the maximum number of magazines that can be carried by 1\")," +
               "(34, \"Spotter\", \"20% increase to the detection radius\")," +
               "(35, \"Springy\", \"Reduces jumping and Long Jump penalties by 35%\")," +
               "(36, \"Steady\", \"22% Increase to deployables health\")," +
               "(37, \"Tough\", \"Reduces the delay untill health regen starts by 66%\")," +
               "(38, \"Try Hard\", \"Gain 10HP for each death you suffer without getting a kill, up to a maximum of 30HP\")," +
               "(39, \"Undercover\", \"10% increase to ability duration\")," +
               "(40, \"Unshakeable\", \"Reduces the damage you take from explosives by 15%\")," +
               "(41, \"Untrackable\", \"Turrets, Mines and other automated defenses react 35% more slowly to your presence\")"
               
        )

        db.execute("INSERT INTO Augments3 (\"AugmentID\", \"Name\", \"Description\")" +
               "VALUES" + 
               "(1, \"Ammo Reach\", \"25% increase to ammo station radius\")," +
               "(2, \"Big Ears \", \"Enemy footsteps and other appropriate noises are 50% \")," +
               "(3, \"Bigger Blast\", \"10% increase to blast radius to AoE weapons. \")," +
               "(4, \"Bomb Squad \", \"Makes enemy deployables, such as Proxmity Mines, more visible. \")," +
               "(5, \"Chopper\", \"15% increase to melee damage.\")," +
               "(6, \"Cool\", \"Doubles the time it takes Mounted MGs to overheat.\")," +
               "(7, \"Double Time\", \"Allows you to reload whilst sprinting\")," +
               "(8, \"Drilled\", \"20% reduction to reload time\")," +
               "(9, \"Enigma\", \"Reduced duration of being spotted by 60%.\")," +
               "(10, \"Explodydendron\", \"10% increase to blast radius to AoE abilities\")," +
               "(11, \"Extra Ammo\", \"Increase the max number of ammo packs by one\")," +
               "(12, \"Extra Supplies\", \"20% cooldown reduction to support abilities\")," +
               "(13, \"Extender\", \"Extends the size of the shield by 25% on turtle and 20% on guardian\")," +
               "(14, \"Fail Safe\", \"Reduces the effect taken from your own explosives by 30%\")," +
               "(15, \"Flying Pig\", \"Increases Long Jump distance by 10% and removes falling damage\")," +
               "(16, \"Focus\", \"Reduces Flinching when hit while iron sighting or scoped by 30%\")," +
               "(17, \"Get up\", \"30% increase to health given on revive\")," +
               "(18, \"Guardian Angel\", \"Receive an audio warning whenever a nearby enemy air support is a danger to you and 20% reduced damage from air support abilities\")," +
               "(19, \"Healing Reach\", \"15% increase to size of healing radius\")," +
               "(20, \"Ice Cold\", \"40% increase in time until overheating\")," +
               "(21, \"Lock on\", \"Turrets, Mines and other automated defences react 30% more quickly\")," +
               "(22, \"Looter\", \"Killing an enemy Fire Support Merc will drop a small Ammo Pack, killing an enemy Medic will drop a small Health Pack\")," +
               "(23, \"Mechanic\", \"Improves any repair tools and disarm rates by 20%\")," +
               "(24, \"Nitros\", \"50% increase to barrel acceleration\")," +
               "(25, \"Pineapple Juggler\", \"Allows you to melee hit back mid-air grenades and other projectiles\")," +
               "(26, \"Potent Packs\", \"20% increase to health regen rate given by healing abilities\")," +
               "(27, \"Quick Draw\", \"30% faster weapon/item switching\")," +
               "(28, \"Quick Charge\", \"10% increase to round charge rate\")," +
               "(29, \"Quick Eye\", \"35% faster movement speed and raise/lower times when Iron Sighting\")," +
               "(30, \"Quick Slash\", \"Increases melee slash speed by 15%\")," +
               "(31, \"Recharge\", \"10% reduction to ability cooldown\")," +
               "(32, \"Sneaky\", \"Reduces the amount of sound you generate when running by 50%\")," +
               "(33, \"Spares\", \"Increases the maximum number of magazines that can be carried by 1\")," +
               "(34, \"Spotter\", \"20% increase to the detection radius\")," +
               "(35, \"Springy\", \"Reduces jumping and Long Jump penalties by 35%\")," +
               "(36, \"Steady\", \"22% Increase to deployables health\")," +
               "(37, \"Tough\", \"Reduces the delay untill health regen starts by 66%\")," +
               "(38, \"Try Hard\", \"Gain 10HP for each death you suffer without getting a kill, up to a maximum of 30HP\")," +
               "(39, \"Undercover\", \"10% increase to ability duration\")," +
               "(40, \"Unshakeable\", \"Reduces the damage you take from explosives by 15%\")," +
               "(41, \"Untrackable\", \"Turrets, Mines and other automated defenses react 35% more slowly to your presence\")"
               
        )

           puts("Basic data inserted")
end

def insert_aura(db, i)
    db.execute("INSERT INTO Cards (\"Slot1\", \"Slot2\", \"Slot3\", \"Generation\", \"MercID\", \"Augment1\", \"Augment2\", \"Augment3\")" +
               "VALUES" +
               #Gen1
               "(\"BL\", 4, 1, 1, #{i}, 17, 7, 12)," +
               "(\"BL\", 7, 2, 1, #{i}, 29, 17, 6)," +
               "(\"BL\", 8, 1, 1, #{i}, 6, 19, 27)," +

               "(\"R\", 4, 2, 1, #{i}, 15, 32, 5)," +
               "(\"R\", 7, 3, 1, #{i}, 35, 9, 19)," +
               "(\"R\", 8, 1, 1, #{i}, 8, 29, 5)," +
               
               "(\"H\", 4, 2, 1, #{i}, 32, 19, 7)," +
               "(\"H\", 7, 2, 1, #{i}, 26, 9, 5)," +
               "(\"H\", 8, 3, 1, #{i}, 35, 19, 17)," +
               
               #Gen 2
               "(\"BL\", 4, 1, 2, #{i}, 17, 7, 12)," +
               "(\"BL\", 7, 2, 2, #{i}, 35, 26, 8)," +
               "(\"BL\", 8, 3, 2, #{i}, 40, 19, 27)," +

               "(\"H\", 4, 3, 2, #{i}, 33, 27, 7)," +
               "(\"H\", 7, 1, 2, #{i}, 26, 4, 12)," +
               "(\"H\", 8, 2, 2, #{i}, 35, 19, 17)," +

               "(\"R\", 4, 2, 2, #{i}, 15, 7, 26)," +
               "(\"R\", 7, 3, 2, #{i}, 12, 41, 19)," +
               "(\"R\", 8, 1, 2, #{i}, 8, 17, 4);"
            
    )
end

def insert_guardian(db, i)
    db.execute("INSERT INTO Cards (\"Slot1\", \"Slot2\", \"Slot3\", \"Generation\", \"MercID\", \"Augment1\", \"Augment2\", \"Augment3\")" +
               "VALUES" +
               
               #Gen 2
               "(\"HU\", 5, 2, 2, #{i}, 31, 17, 16)," +
               "(\"HU\", 7, 3, 2, #{i}, 33, 40, 27)," +
               "(\"HU\", 10, 99, 2, #{i}, 36, 29, 7)," +

               "(\"M\", 5, 99, 2, #{i}, 40, 7, 31)," +
               "(\"M\", 7, 2, 2, #{i}, 17, 36, 33)," +
               "(\"M\", 10, 3, 2, #{i}, 8, 16, 29)," +

               "(\"T\", 5, 3, 2, #{i}, 16, 12, 36)," +
               "(\"T\", 7, 99, 2, #{i}, 7, 13, 17)," +
               "(\"T\", 10, 2, 2, #{i}, 27, 31, 8);"

               
            
    )
end

def insert_sawbonez(db, i)
    db.execute("INSERT INTO Cards (\"Slot1\", \"Slot2\", \"Slot3\", \"Generation\", \"MercID\", \"Augment1\", \"Augment2\", \"Augment3\")" +
               "VALUES" +
               #Gen1
               "(\"SM\", 7, 2, 1, #{i}, 17, 12, 5)," +
               "(\"SM\", 8, 1, 1, #{i}, 27, 8, 16)," +
               "(\"SM\", 4, 1, 1, #{i}, 17, 6, 37)," +

               "(\"CR\", 7, 3, 1, #{i}, 26, 23, 17)," +
               "(\"CR\", 4, 2, 1, #{i}, 26, 16, 8)," +
               "(\"CR\", 8, 1, 1, #{i}, 12, 16, 5)," +
               
               "(\"BL\", 7, 1, 1, #{i}, 40, 26, 33)," +
               "(\"BL\", 4, 3, 1, #{i}, 23, 6, 8)," +
               "(\"BL\", 8, 2, 1, #{i}, 23, 37, 27)," +
               
               #Gen2
               "(\"SM\", 7, 2, 2, #{i}, 17, 12, 41)," +
               "(\"SM\", 8, 3, 2, #{i}, 27, 40, 16)," +
               "(\"SM\", 4, 1, 2, #{i}, 26, 8, 4)," +

               "(\"CR\", 7, 3, 2, #{i}, 26, 23, 17)," +
               "(\"CR\", 4, 2, 2, #{i}, 33, 27, 8)," +
               "(\"CR\", 8, 1, 2, #{i}, 12, 4, 40)," +
               
               "(\"BL\", 7, 1, 2, #{i}, 12, 26, 33)," +
               "(\"BL\", 4, 3, 2, #{i}, 23, 40, 8)," +
               "(\"BL\", 8, 2, 2, #{i}, 7, 17, 27);"
    
    )
end

def insert_phoenix(db, i)
    db.execute("INSERT INTO Cards (\"Slot1\", \"Slot2\", \"Slot3\", \"Generation\", \"MercID\", \"Augment1\", \"Augment2\", \"Augment3\")" +
               "VALUES" +
               #Gen1
               "(\"CR\", 4, 3, 1, #{i}, 17, 6, 8)," +
               "(\"CR\", 7, 1, 1, #{i}, 4, 26, 27)," +
               "(\"CR\", 8, 2, 1, #{i}, 23, 2, 26)," +

               "(\"KE\", 4, 2, 1, #{i}, 41, 19, 6)," +
               "(\"KE\", 7, 3, 1, #{i}, 8, 27, 17)," +
               "(\"KE\", 8, 1, 1, #{i}, 6, 12, 26)," +
               
               "(\"C\", 4, 1, 1, #{i}, 27, 6, 12)," +
               "(\"C\", 7, 2, 1, #{i}, 12, 23, 4)," +
               "(\"C\", 8, 3, 1, #{i}, 19, 5, 8)," +
               
               #Gen2
               "(\"C\", 4, 1, 2, #{i}, 27, 7, 26)," +
               "(\"C\", 7, 2, 2, #{i}, 12, 23, 4)," +
               "(\"C\", 8, 3, 2, #{i}, 19, 17, 9)," +

               "(\"CR\", 4, 3, 2, #{i}, 17, 7, 33)," +
               "(\"CR\", 8, 1, 2, #{i}, 18, 19, 26)," +
               "(\"CR\", 7, 2, 2, #{i}, 12, 23, 4)," +
               
               "(\"KE\", 4, 2, 2, #{i}, 23, 19, 40)," +
               "(\"KE\", 7, 3, 2, #{i}, 8, 27, 17)," +
               "(\"KE\", 8, 1, 2, #{i}, 41, 12, 26);"
    
    )
end

def insert_sparks(db, i)
    db.execute("INSERT INTO Cards (\"Slot1\", \"Slot2\", \"Slot3\", \"Generation\", \"MercID\", \"Augment1\", \"Augment2\", \"Augment3\")" +
               "VALUES" +
               #Gen1
               "(\"1\", 4, 3, 1, #{i}, 6, 8, 17)," +
               "(\"1\", 7, 2, 1, #{i}, 29, 7, 12)," +
               "(\"1\", 8, 1, 1, #{i}, 15, 27, 35)," +

               "(\"2\", 7, 3, 1, #{i}, 8, 27, 9)," +
               "(\"2\", 8, 1, 1, #{i}, 26, 28, 6)," +
               
               #Sparks actually has 4 gen 1 emp-9 cards, huh.
               "(\"3\", 4, 3, 1, #{i}, 17, 5, 15)," +
               "(\"3\", 7, 3, 1, #{i}, 27, 5, 7)," +
               "(\"3\", 8, 2, 1, #{i}, 12, 26, 32)," +
               "(\"3\", 8, 3, 1, #{i}, 17, 28, 26)," +
               
               #Gen2
               "(\"1\", 4, 3, 2, #{i}, 28, 16, 17)," +
               "(\"1\", 7, 2, 2, #{i}, 40, 17, 12)," +
               "(\"1\", 8, 1, 2, #{i}, 26, 27, 28)," +

               "(\"2\", 4, 1, 2, #{i}, 17, 16, 26)," +
               "(\"2\", 7, 3, 2, #{i}, 28, 27, 12)," +
               "(\"2\", 8, 2, 2, #{i}, 40, 28, 17)," +
               
               "(\"3\", 4, 2, 2, #{i}, 12, 16, 28)," +
               "(\"3\", 7, 3, 2, #{i}, 27, 17, 40)," +
               "(\"3\", 8, 3, 2, #{i}, 17, 28, 26);"
    
    )
end

def insert_nader(db, i)
    db.execute("INSERT INTO Cards (\"Slot1\", \"Slot2\", \"Slot3\", \"Generation\", \"MercID\", \"Augment1\", \"Augment2\", \"Augment3\")" +
               "VALUES" +
               #Gen1
               "(\"SM\", 7, 2, 1, #{i}, 8, 5, 33)," +
               "(\"SM\", 4, 3, 1, #{i}, 8, 32, 16)," +
               "(\"SM\", 4, 1, 1, #{i}, 40, 35, 3)," +

               "(\"CR\", 7, 2, 1, #{i}, 7, 16, 6)," +
               "(\"CR\", 8, 1, 1, #{i}, 3, 14, 29)," +
               "(\"CR\", 8, 3, 1, #{i}, 27, 33, 9)," +
               
               "(\"KE\", 7, 2, 1, #{i}, 7, 33, 16)," +
               "(\"KE\", 4, 3, 1, #{i}, 15, 9, 37)," +
               "(\"KE\", 8, 1, 1, #{i}, 27, 14, 16)," +
               
               #Gen2
               "(\"SM\", 7, 2, 2, #{i}, 7, 4, 9)," +
               "(\"SM\", 8, 3, 2, #{i}, 8, 27, 16)," +
               "(\"SM\", 4, 1, 2, #{i}, 40, 35, 3)," +

               "(\"CR\", 7, 3, 2, #{i}, 27, 40, 9)," +
               "(\"CR\", 4, 2, 2, #{i}, 7, 8, 18)," +
               "(\"CR\", 8, 1, 2, #{i}, 3, 40, 9)," +
               
               "(\"KE\", 7, 2, 2, #{i}, 7, 33, 40)," +
               "(\"KE\", 4, 3, 2, #{i}, 3, 9, 16)," +
               "(\"KE\", 8, 2, 2, #{i}, 27, 40, 4);"
    
    )
end

def insert_cards(db)
    insert_aura(db, 1)
    insert_guardian(db, 2)
    insert_phoenix(db, 3)
    insert_sawbonez(db, 4)
    insert_sparks(db, 5)

    insert_nader(db, 16)
    
end

wipe(db)
create_tables(db)
insert_data(db)
insert_cards(db)