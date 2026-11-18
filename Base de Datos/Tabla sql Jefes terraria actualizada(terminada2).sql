DROP DATABASE IF EXISTS Jefes_Terraria;
CREATE DATABASE Jefes_Terraria;
USE Jefes_Terraria;

CREATE TABLE `Attack` (
  `ID_ATTACK` integer PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `Attack_Name` varchar(255) NOT NULL,
  `Type` varchar(255) NOT NULL,
  `Damage` integer NOT NULL
);

CREATE TABLE `Minion` (
  `ID_MINION` integer PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `Minion_Name` varchar(255) NOT NULL,
  `Life_Amount` integer NOT NULL,
  `Defense` integer,
  `ID_ATTACK` integer,
  CONSTRAINT fk_id_attack FOREIGN KEY (ID_ATTACK) REFERENCES Attack(ID_ATTACK)
);

CREATE TABLE `Boss` (
  `ID_BOSS` integer PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `Boss_Name` varchar(255) NOT NULL,
  `Life_Amount` integer NOT NULL,
  `Defense` integer NOT NULL,
  `ID_MINION` integer,
  `ID_ATTACK` integer,
  `Image_URL` varchar(500),
  CONSTRAINT fk_id_minion FOREIGN KEY (ID_MINION) REFERENCES Minion(ID_MINION),
  CONSTRAINT fk_id_attack2 FOREIGN KEY (ID_ATTACK) REFERENCES Attack(ID_ATTACK)
);

CREATE TABLE `Treasure_Bag` (
  `ID_TREASUREBAG` integer PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `Treasure_Bag_Name` varchar(255) NOT NULL,
  `ID_BOSS` integer,
  CONSTRAINT fk_id_boss FOREIGN KEY (ID_BOSS) REFERENCES Boss(ID_BOSS)
);

CREATE TABLE `Item` (
  `ID_ITEM` integer PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `Item_Name` varchar(255) NOT NULL,
  `Type` varchar(255) NOT NULL,
  `Amount` integer NOT NULL,
  `ID_TREASUREBAG` integer,
  CONSTRAINT fk_id_treasure_bag FOREIGN KEY (ID_TREASUREBAG) REFERENCES Treasure_Bag(ID_TREASUREBAG)
);

CREATE TABLE `Segment` (
  `ID_SEGMENT` integer PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `Segment_Name` varchar(255) NOT NULL,
  `Life_Amount` integer NOT NULL,
  `Defense` integer NOT NULL,
  `ID_BOSS` integer,
  CONSTRAINT fk_id_boss2 FOREIGN KEY (ID_BOSS) REFERENCES Boss(ID_BOSS)
);



INSERT INTO Attack(Attack_Name, Type, Damage)
VALUES
('Jump', 'Melee', 40),
('Charge', 'Melee', 60),
('Bite', 'Melee', 55),
('Rush', 'Melee', 65),
('Stinger', 'Projectile', 50),
('Stomp', 'Melee', 70),
('Spin', 'Melee', 75),
('Laser', 'Laser', 80),
('Gel Jump', 'Melee', 85),
('Beam', 'Laser', 90),
('Red Laser', 'Laser', 100),
('Missile', 'Projectile', 95),
('Seed', 'Projectile', 105),
('Punch', 'Melee', 110),
('Tornado', 'Summon', 120),
('Spear', 'Magic', 130),
('Magic Beam', 'Magic', 115),
('Death Ray', 'Laser', 150),
('Fireball', 'Magic', 60),
('Smash', 'Melee', 80),
('Fire Breath', 'Fire', 140),
('Flame', 'Fire', 100),
('Scythe', 'Projectile', 120),
('Pinecone', 'Projectile', 90),
('Rocket', 'Projectile', 110),
('Blizzard', 'Magic', 130),
('Cannon Shot', 'Projectile', 95),
('Strong Flame', 'Fire', 115),
('Big Scythe', 'Projectile', 135),
('Big Pinecone', 'Projectile', 105),
('Big Rocket', 'Projectile', 125),
('Storm', 'Magic', 145),
('Solar Flare', 'Fire', 100),
('Nebula Bolt', 'Magic', 100),
('Vortex Lightning', 'Magic', 100),
('Stardust Cell', 'Projectile', 100),
('Demon Scythe', 'Projectile', 65),
('Egg Bounce', 'Melee', 50),
('Head Lunge', 'Melee', 60);

INSERT INTO Minion(Minion_Name, Life_Amount, Defense, ID_ATTACK)
VALUES
('Servant of Cthulhu', 20, 0, 2),
('Creeper', 100, 10, 4),
('Bee', 30, 2, 5),
('Frozen Deer', 120, 8, 6),
('Bouncy Slime', 150, 10, 9),
('Probe', 200, 10, 11),
('Plantera Hook', 250, 12, 13),
('Ancient Light', 220, 12, 16),
('Ancient Vision', 180, 8, 17),
('Moon Leech Clot', 500, 20, 18);

INSERT INTO Boss(Boss_Name, Life_Amount, Defense, ID_MINION, ID_ATTACK, Image_URL)
VALUES
('King Slime', 3920, 10, NULL, 1, 'https://static.wikia.nocookie.net/terraria/images/9/93/King_Slime.gif/revision/latest?cb=20180716223903&path-prefix=es'),
('Eye of Cthulhu', 3640, 12, 1, 2, 'https://static.wikia.nocookie.net/terraria/images/6/68/Eye_of_Cthulhu.gif/revision/latest?cb=20200607203450&path-prefix=es'),
('Eater of Worlds', 10150, 18, NULL, 3, 'https://static.wikia.nocookie.net/terraria/images/2/2d/Eater_of_Worlds.png/revision/latest?cb=20180715195123&path-prefix=es'),
('Brain of Cthulhu', 1700, 14, 2, 4, 'https://static.wikia.nocookie.net/terraria/images/6/6a/Brain_of_Cthulhu.gif/revision/latest?cb=20200621052145&path-prefix=es'),
('Queen Bee', 4760, 8, 3, 5, 'https://static.wikia.nocookie.net/terraria/images/a/a6/Queen_Bee2.gif/revision/latest?cb=20200525035339&path-prefix=es'),
('Deerclops', 7000, 15, 4, 6, 'https://static.wikia.nocookie.net/terraria/images/8/85/Deerclops.png/revision/latest?cb=20211119045442&path-prefix=es'),
('Skeletron', 4400, 10, NULL, 7, 'https://static.wikia.nocookie.net/terraria/images/a/a3/Skeletron_Head.png/revision/latest?cb=20180321213616&path-prefix=es'),
('Wall of Flesh', 11200, 12, NULL, 8, 'https://static.wikia.nocookie.net/terraria/images/c/c0/Wall_of_Flesh.gif/revision/latest?cb=20200619031640&path-prefix=es'),
('Queen Slime', 18000, 24, 5, 9, 'https://static.wikia.nocookie.net/terraria/images/7/79/Queen_Slime.png/revision/latest?cb=20200525032537&path-prefix=es'),
('The Twins', 43000, 20, NULL, 10, 'https://static.wikia.nocookie.net/terraria/images/e/e9/Twins_Boss.gif/revision/latest?cb=20180920185012&path-prefix=es'),
('The Destroyer', 163000, 34, 6, 11, 'https://static.wikia.nocookie.net/terraria/images/4/4f/The_Destroyer.png/revision/latest?cb=20230703170141&path-prefix=es'),
('Skeletron Prime', 28000, 24, 7, 12, 'https://static.wikia.nocookie.net/terraria/images/6/60/Skeletron_Prime.png/revision/latest?cb=20170423205201&path-prefix=es'),
('Plantera', 42000, 36, 8, 13, 'https://static.wikia.nocookie.net/terraria/images/d/d2/Plantera.gif/revision/latest?cb=20200621052441&path-prefix=es'),
('Golem', 39000, 38, NULL, 14, 'https://static.wikia.nocookie.net/terraria/images/5/51/Golem_boss_2.png/revision/latest?cb=20200603044330&path-prefix=es'),
('Duke Fishron', 50000, 50, NULL, 15, 'https://static.wikia.nocookie.net/terraria_gamepedia/images/2/21/Duke_Fishron.gif/revision/latest?cb=20190125125827'),
('Empress of Light', 70000, 50, NULL, 16, 'https://static.wikia.nocookie.net/terraria/images/c/c9/Empress_of_Light.gif/revision/latest?cb=20200519130254&path-prefix=es'),
('Lunatic Cultist', 42000, 32, 9, 17, 'https://static.wikia.nocookie.net/terraria/images/a/aa/Animated_Lunatic_Cultist.gif/revision/latest?cb=20190223004959&path-prefix=es'),
('Moon Lord', 145000, 80, 10, 18, 'https://static.wikia.nocookie.net/terraria/images/7/7f/Moon_Lord.png/revision/latest?cb=20171021051421&path-prefix=es'),
('Dark Mage', 5400, 12, NULL, 19, 'https://static.wikia.nocookie.net/terraria/images/d/dc/Dark_Mage.gif/revision/latest?cb=20180705182829&path-prefix=es'),
('Ogre', 14000, 26, NULL, 20, 'https://static.wikia.nocookie.net/terraria/images/f/fc/Ogre.gif/revision/latest?cb=20180705182851&path-prefix=es'),
('Betsy', 50000, 40, NULL, 21, 'https://static.wikia.nocookie.net/terraria/images/0/0a/Betsy.gif/revision/latest?cb=20190329191835&path-prefix=es'),
('Mourning Wood', 28000, 22, NULL, 22, 'https://static.wikia.nocookie.net/terraria/images/8/8f/Arbol_del_luto.gif/revision/latest?cb=20200621044207&path-prefix=es'),
('Pumpking', 32000, 26, NULL, 23, 'https://static.wikia.nocookie.net/terraria/images/a/a6/Rey_calabaza.gif/revision/latest?cb=20190329192920&path-prefix=es'),
('Everscream', 13000, 18, NULL, 24, 'https://static.wikia.nocookie.net/terraria/images/e/e3/Everscream.gif/revision/latest?cb=20200601033531&path-prefix=es'),
('Santa-NK1', 31000, 20, NULL, 25, 'https://static.wikia.nocookie.net/terraria/images/e/ef/Santa-NK1.gif/revision/latest?cb=20190329192059&path-prefix=es'),
('Ice Queen', 34000, 30, NULL, 26, 'https://static.wikia.nocookie.net/terraria/images/c/c8/Ice_Queen.gif/revision/latest?cb=20131224162551&path-prefix=es'),
('Flying Dutchman', 20000, 30, NULL, 27, 'https://static.wikia.nocookie.net/terraria/images/1/17/Flying_Dutchman.gif/revision/latest?cb=20190329192833&path-prefix=es'),
('Mourning Wood (Wave 15+)', 35000, 24, NULL, 22, 'https://static.wikia.nocookie.net/terraria/images/8/8f/Arbol_del_luto.gif/revision/latest?cb=20200621044207&path-prefix=es'),
('Pumpking (Wave 15+)', 40000, 28, NULL, 23, 'https://static.wikia.nocookie.net/terraria/images/a/a6/Rey_calabaza.gif/revision/latest?cb=20190329192920&path-prefix=es'),
('Everscream (Wave 15+)', 16000, 20, NULL, 24, 'https://static.wikia.nocookie.net/terraria/images/e/e3/Everscream.gif/revision/latest?cb=20200601033531&path-prefix=es'),
('Santa-NK1 (Wave 15+)', 38000, 22, NULL, 25, 'https://static.wikia.nocookie.net/terraria/images/e/ef/Santa-NK1.gif/revision/latest?cb=20190329192059&path-prefix=es'),
('Ice Queen (Wave 15+)', 42000, 34, NULL, 26, 'https://static.wikia.nocookie.net/terraria/images/c/c8/Ice_Queen.gif/revision/latest?cb=20131224162551&path-prefix=es'),
-- Jefes nuevos (Pilares Celestiales y jefes de consola/3DS)
('Solar Pillar', 20000, 20, NULL, 33, 'https://static.wikia.nocookie.net/terraria/images/5/50/Solar_Pillar.png/revision/latest?cb=20150706033633&path-prefix=es'),
('Nebula Pillar', 20000, 20, NULL, 34, 'https://static.wikia.nocookie.net/terraria/images/a/a9/Nebula_Pillar.png/revision/latest?cb=20150704022525&path-prefix=es'),
('Vortex Pillar', 20000, 20, NULL, 35, 'https://static.wikia.nocookie.net/terraria/images/8/8d/Vortex_Pillar.png/revision/latest?cb=20150707223328&path-prefix=es'),
('Stardust Pillar', 20000, 20, NULL, 36, 'https://static.wikia.nocookie.net/terraria/images/9/9f/Stardust_Pillar.png/revision/latest?cb=20150707205833&path-prefix=es'),
('Ocram', 35000, 20, NULL, 37, 'https://static.wikia.nocookie.net/terraria/images/2/20/Ocram.gif/revision/latest?cb=20180715144033&path-prefix=es'),
('Lepus', 6000, 12, NULL, 38, 'https://static.wikia.nocookie.net/terraria/images/1/1d/Lepus.gif/revision/latest?cb=20180715143458&path-prefix=es'),
('Turkor the Ungrateful', 6000, 12, NULL, 39, 'https://static.wikia.nocookie.net/terraria/images/d/dd/Turkor_the_Ungrateful.gif/revision/latest?cb=20180715150838&path-prefix=es');

INSERT INTO Treasure_Bag(Treasure_Bag_Name, ID_BOSS)
VALUES
('King Slime Treasure Bag', 1),
('Eye of Cthulhu Treasure Bag', 2),
('Eater of Worlds Treasure Bag', 3),
('Brain of Cthulhu Treasure Bag', 4),
('Queen Bee Treasure Bag', 5),
('Deerclops Treasure Bag', 6),
('Skeletron Treasure Bag', 7),
('Wall of Flesh Treasure Bag', 8),
('Queen Slime Treasure Bag', 9),
('Twins Treasure Bag', 10),
('Destroyer Treasure Bag', 11),
('Skeletron Prime Treasure Bag', 12),
('Plantera Treasure Bag', 13),
('Golem Treasure Bag', 14),
('Fishron Treasure Bag', 15),
('Empress of Light Treasure Bag', 16),
('Lunatic Cultist Treasure Bag', 17),
('Moon Lord Treasure Bag', 18);

INSERT INTO Item(Item_Name, Type, Amount, ID_TREASUREBAG)
VALUES
('Slime Gun', 'Weapon', 1, 1),
('Royal Gel', 'Accessory', 1, 1),
('Shield of Cthulhu', 'Accessory', 1, 2),
('Binoculars', 'Tool', 1, 2),
('Demonite Ore', 'Material', 50, 2),
('Worm Scarf', 'Accessory', 1, 3),
('Eater''s Bone', 'Pet', 1, 3),
('Demonite Ore', 'Material', 75, 3),
('Brain of Confusion', 'Accessory', 1, 4),
('Bone Rattle', 'Pet', 1, 4),
('Crimtane Ore', 'Material', 75, 4),
('Hive Pack', 'Accessory', 1, 5),
('Nectar', 'Mount', 1, 5),
('Bee Gun', 'Weapon', 1, 5),
('Eye Bone', 'Pet', 1, 6),
('Bone Helm', 'Armor', 1, 6),
('Bone Glove', 'Accessory', 1, 7),
('Book of Skulls', 'Weapon', 1, 7),
('Skeletron Hand', 'Pet', 1, 7),
('Demon Heart', 'Consumable', 1, 8),
('Pwnhammer', 'Tool', 1, 8),
('Breaker Blade', 'Weapon', 1, 8),
('Volatile Gelatin', 'Accessory', 1, 9),
('Queen Slime Mask', 'Vanity', 1, 9),
('Crystal Assassin Hood', 'Armor', 1, 9),
('Mechanical Wheel Piece', 'Mount', 1, 10),
('Retinazer Trophy', 'Decoration', 1, 10),
('Souls of Sight', 'Material', 25, 10),
('Mechanical Wagon Piece', 'Mount', 1, 11),
('Souls of Might', 'Material', 25, 11),
('Destroyer Emblem', 'Accessory', 1, 11),
('Mechanical Battery Piece', 'Mount', 1, 12),
('Souls of Fright', 'Material', 25, 12),
('Bone Key', 'Pet', 1, 12),
('Spore Sac', 'Accessory', 1, 13),
('Seedling', 'Pet', 1, 13),
('Grenade Launcher', 'Weapon', 1, 13),
('Shiny Stone', 'Accessory', 1, 14),
('Picksaw', 'Tool', 1, 14),
('Stynger', 'Weapon', 1, 14),
('Shrimpy Truffle', 'Mount', 1, 15),
('Fishron Wings', 'Accessory', 1, 15),
('Bubble Gun', 'Weapon', 1, 15),
('Soaring Insignia', 'Accessory', 1, 16),
('Empress Wings', 'Accessory', 1, 16),
('Starlight', 'Weapon', 1, 16),
('Royal Delight', 'Pet', 1, 17),
('Ancient Manipulator', 'Crafting', 1, 17),
('Celestial Starboard', 'Accessory', 1, 18),
('Suspicious Looking Portal', 'Pet', 1, 18),
('Meowmere', 'Weapon', 1, 18),
('Star Wrath', 'Weapon', 1, 18),
('Terrarian', 'Weapon', 1, 18),
('S.D.M.G.', 'Weapon', 1, 18),
('Celebration Mk2', 'Weapon', 1, 18);

INSERT INTO Segment(Segment_Name, Life_Amount, Defense, ID_BOSS)
VALUES
('Head_EaterOfWorlds', 150, 0, 3),
('Body_EaterOfWorlds', 150, 0, 3),
('Tail_EaterOfWorlds', 150, 0, 3),
('LeftHand_Skeletron', 600, 12, 7),
('RightHand_Skeletron', 600, 12, 7),
('LeftEye_WallOfFlesh', 1500, 12, 8),
('RightEye_WallOfFlesh', 1500, 12, 8),
('PrimeCannon_SkeletronPrime', 7000, 24, 12),
('PrimeLaser_SkeletronPrime', 7000, 24, 12),
('PrimeSaw_SkeletronPrime', 7000, 24, 12),
('PrimeVice_SkeletronPrime', 7000, 24, 12),
('Head_Golem', 8000, 24, 14),
('LeftFist_Golem', 7000, 20, 14),
('RightFist_Golem', 7000, 20, 14),
('LeftHand_MoonLord', 25000, 40, 18),
('RightHand_MoonLord', 25000, 40, 18),
('Head_MoonLord', 45000, 50, 18);
