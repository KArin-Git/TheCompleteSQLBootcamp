-- Q1: retrieve all the information from the cd.facilities table
SELECT * FROM cd.facilities;

-- Q2: print out a list of all of the facilities and their cost to members.
-- and retrieve a list of only facility names and costs?
SELECT name, membercost FROM cd.facilities;

-- Q3: How can you produce a list of facilities that charge a fee to members?
-- Expected Results should have just 5 rows:
SELECT * FROM cd.facilities
WHERE membercost > 0
ORDER BY membercost;

-- Q4: How can you produce a list off acilities that charge a fee to members,
-- and that fee is less than 1/50th of the monthly maintenance cost?
-- Return the facid, facility name, member cost, and monthly maintenance of the facilities in question.
-- Expected Result is just two rows:
SELECT name, membercost, monthlymaintenance FROM cd.facilities
WHERE membercost < monthlymaintenance / 50
	AND membercost != 0;
	
-- Q5: How can you produce a list of all facilities with the word 'Tennis' in their name?
-- Expected Result is 3 rows
SELECT * FROM cd.facilities
WHERE name ILIKE '%tennis%';

-- Q6: How can you retrieve the details off acilities with ID 1 and 5?
-- Try to do it without using the OR operator.
-- Expected Result is 2 rows
SELECT * FROM cd.facilities
WHERE facid IN(1, 5);

-- Q7: How can you produce a list of members who joined after the start of September 2012?
-- Return the memid, surname, firstname, and joindate of the members in question.
-- Expected Result is 10 rows (not all are shown below)
SELECT memid, surname, firstname, joindate FROM cd.members
WHERE joindate > '2012-09-01'
ORDER BY memid;

-- Q8: How can you produce an ordered list of the first 10 surnames in the members table?
-- The list must not contain duplicates.
-- Expected Result should be 10 rows if you include GUEST as a last name
SELECT DISTINCT surname FROM cd.members
ORDER BY surname
LIMIT 10;

-- Q9: You'd like to get the sign update of your last member.
-- How can you retrieve this information?
-- Expected Result
-- 2012-09-26 18:08:45
SELECT joindate FROM cd.members
ORDER BY joindate DESC
LIMIT 1;

-- Q10: Produce a count of the number of facilities that have a cost to guests of 10 or more.
-- Expected Result 6
SELECT facid, name, guestcost FROM cd.facilities
WHERE guestcost >= 10
ORDER BY guestcost;

-- Q11: Produce a list of the total number of slots booked per facility in the month of September 2012.
-- Produce an output table consisting of facility id and slots, sorted by the number of slots.
-- Expected Result is 9 rows
-- ** NOT PASS ** --
SELECT DISTINCT facid, SUM(slots) AS "Total Slots" FROM cd.bookings
GROUP BY facid, starttime
	HAVING DATE(starttime) BETWEEN '2012-09-01' AND '2012-09-30'
ORDER BY SUM(slots);

-- Q12: Produce a list of facilities with more than 1000 slots booked.
-- Produce an output table consisting of facility id and total slots
-- sorted by facility id.
-- Expected Result is 5 rows
SELECT facid, SUM(slots) AS "total_slots" FROM cd.bookings
GROUP BY facid
	HAVING SUM(slots) > 1000
ORDER BY facid

-- Q13: How can you produce a list of the start times for bookings for tennis courts,
-- for the date '2012-09-21'?
-- Return a list of start time and facility name pairings,
-- ordered by the time.
-- Expected Result is 12 rows
SELECT * FROM cd.bookings
INNER JOIN cd.facilities
	ON cd.bookings.facid = cd.facilities.facid
WHERE DATE(starttime) = '2012-09-21'
	AND name ILIKE 'Tennis court%'
ORDER BY starttime;