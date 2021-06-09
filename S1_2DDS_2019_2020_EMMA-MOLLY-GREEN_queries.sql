-- Emma Green --

-- Stops queries from truncating the data when they return. 
SET TRUNCATE OFF;


prompt
prompt Running Query1:
prompt     Username,lastName,JoinDate,CountryName
prompt     Of users after 13 Jan 17
prompt
-- (QUERY: 1) --
SELECT BR_User."Username" AS "User", BR_User."LastName" AS "Name", BR_User."JoinDate", BR_Country."CountryName" AS "Country"
--Join
FROM BR_User, BR_Country
WHERE BR_User."CountryId" = BR_Country."CountryId"
-- Constraints
AND
"JoinDate" >= '13-JAN-17'
Order by "JoinDate" ASC;


prompt
prompt Running Query2:
prompt     NumOfUsers
prompt     Of each app/category
prompt
-- (QUERY: 2) --
SELECT BR_App."AppName", COUNT(*) AS "NumUsers", BR_AppCategory."CategoryName" AS "CatName"
--Join
FROM BR_AppUser, BR_App, BR_AppCategory
WHERE BR_App."AppId" = BR_AppUser."AppId"
AND BR_AppCategory."AppCategoryId" = BR_App."AppCategoryId"
--Count aggregate
GROUP BY BR_App."AppName", BR_AppCategory."CategoryName"
--Constraints
ORDER BY COUNT(*) DESC;


prompt
prompt Running Query3:
prompt     AppsApprovedForRelease, DaySinceUpdate
prompt
-- (QUERY: 3) --
SELECT "AppName", TRUNC((CURRENT_DATE - "LastUpdated"), 1) AS "DaysSinceLastUpdate"
FROM BR_App
WHERE "ApprovedForRelease" = 'Y';


prompt
prompt Running Query4:
prompt     Users
prompt     Who downloaded social apps and older than 13
prompt
-- (QUERY: 4) --
SELECT BR_User."Username"
--Join
FROM BR_User, BR_App, BR_AppUser
WHERE BR_App."AppId" = BR_AppUser."AppId"
AND BR_AppUser."UserId" = BR_User."UserId"
--Constraints
AND BR_App."AppCategoryId" = 40
AND (CURRENT_DATE - "DateOfBirth") > 13
ORDER BY BR_User."DateOfBirth" ASC;