-- Challenge Bonus queries.
-- 1. (2.5 pts)
-- Retrieve all the number of backer_counts in descending order for each `cf_id` for the "live" campaigns.

SELECT backers_count, cf_id, outcome

FROM campaign

WHERE (outcome = 'live')

GROUP BY cf_id

ORDER BY backers_count DESC;


-- 2. (2.5 pts)
-- Using the "backers" table confirm the results in the first query.

SELECT COUNT(cf_id), cf_id

FROM backers

GROUP BY cf_id

ORDER BY COUNT DESC;


-- 3. (5 pts)
-- Create a table that has the first and last name, and email address of each contact.
-- and the amount left to reach the goal for all "live" projects in descending order.

CREATE TABLE email_contacts_remaining_goal

AS

SELECT ct.contact_id,
	ct.first_name, 
	ct.last_name, 
	ct.email,
	cp.outcome,
	cp.goal - cp.pledged AS remaining_goal_amount

FROM contacts AS ct

INNER JOIN campaign as cp

ON (ct.contact_id = cp.contact_id)

WHERE (cp.outcome = 'live')

ORDER BY remaining_goal_amount DESC;

SELECT * FROM email_contacts_remaining_goal;

ALTER TABLE email_contacts_remaining_goal

DROP COLUMN contact_id,
DROP COLUMN outcome;



-- Check the table

SELECT * FROM email_contacts_remaining_goal;

-- 4. (5 pts)
-- Create a table, "email_backers_remaining_goal_amount" that contains the email address of each backer in descending order, 
-- and has the first and last name of each backer, the cf_id, company name, description, 
-- end date of the campaign, and the remaining amount of the campaign goal as "Left of Goal". 

CREATE TABLE email_backers_remaining_goal_amount

AS

SELECT bk.email,
	bk.first_name,
	bk.last_name,
	bk.cf_id,
	cp.company_name,
	cp.description,
	cp.end_date,
	cp.goal - cp.pledged AS left_of_goal
	
FROM backers as bk

INNER JOIN campaign as cp

ON (bk.cf_id = cp.cf_id)

ORDER BY email DESC;


-- Check the table

SELECT * FROM email_backers_remaining_goal_amount;
