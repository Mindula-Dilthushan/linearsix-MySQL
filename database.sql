# DROP DATABASE tempdb;

# CREATE DATABASE tempdb;

# USE tempdb;

# CREATE TABLE `user` (
#     `id` int,
#     `firstName` varchar(255),
#     `lastName` varchar(255),
#     `email` varchar(255),
#     `cultureID` int,
#     `deleted` bit,
#     `country` varchar(255),
#     `isRevokeAccess` bit,
#     `created` datetime
# );
# INSERT INTO `user` (`id`, `firstName`, `lastName`, `email`, `cultureID`, `deleted`, `country`, `isRevokeAccess`, `created`)
# VALUES
#     (1, 'Victor', 'Shevchenko', 'vs@gmail.com', 1033, 1, 'US', 0, '2011-04-05'),
#     (2, 'Oleksandr', 'Petrenko', 'op@gmail.com', 1034, 0, 'UA', 0, '2014-05-01'),
#     (3, 'Victor', 'Tarasenko', 'vt@gmail.com', 1033, 1, 'US', 1, '2015-07-03'),
#     (4, 'Sergiy', 'Ivanenko', 'sergiy@gmail.com', 1046, 0, 'UA', 1, '2010-02-02'),
#     (5, 'Vitalii', 'Danilchenko', 'shumko@gmail.com', 1031, 0, 'UA', 1, '2014-05-01'),
#     (6, 'Joe', 'Dou', 'joe@gmail.com', 1032, 0, 'US', 1, '2009-01-01'),
#     (7, 'Marko', 'Polo', 'marko@gmail.com', 1033, 1, 'UA', 1, '2015-07-03');
#
# CREATE TABLE `group` (
#     `id` int,
#     `name` varchar(255),
#     `created` datetime
# );
# INSERT INTO `group` (`id`, `name`, `created`)
# VALUES
#     (10, 'Support', '2010-02-02'),
#     (12, 'Dev team', '2010-02-03'),
#     (13, 'Apps team', '2011-05-06'),
#     (14, 'TEST - dev team', '2013-05-06'),
#     (15, 'Guest', '2014-02-02'),
#     (16, 'TEST-QA-team', '2014-02-02'),
#     (17, 'TEST-team', '2011-01-07');
#
# CREATE TABLE `groupMembership` (
#     `id` int,
#     `userID` int,
#     `groupID` int,
#     `created` datetime
# );
# INSERT INTO `groupMembership` (`id`, `userID`, `groupID`, `created`)
# VALUES
#     (110, 2, 10, '2010-02-02'),
#     (112, 3, 15, '2010-02-03'),
#     (114, 1, 10, '2014-02-02'),
#     (115, 1, 17, '2011-05-02'),
#     (117, 4, 12, '2014-07-13'),
#     (120, 5, 15, '2014-06-15')


SELECT `name` FROM `group` WHERE `name` LIKE 'TEST-%' AND `id` NOT IN ( SELECT `groupID` FROM `groupMembership`);

SELECT `firstName`, `lastName` FROM `user` WHERE `firstName` = 'Victor' AND `id` NOT IN (
    SELECT `userID` FROM `groupMembership` WHERE `groupID` IN (
        SELECT `id` FROM `group` WHERE `name` LIKE 'TEST-%'
    )
);

SELECT u.firstName, u.lastName, g.name AS groupName
FROM `user` u JOIN `groupMembership` gm ON u.id = gm.userID JOIN `group` g ON gm.groupID = g.id
WHERE u.created < g.created;

