CREATE TABLE "backers" (
    "backer_id" varchar(10)   NOT NULL,
    "cf_id" int   NOT NULL,
    "first_name" varchar(50)   NOT NULL,
    "last_name" varchar(50)   NOT NULL,
    "email" varchar(100)   NOT NULL,
    CONSTRAINT "pk_backers" PRIMARY KEY (
        "backer_id"
     )
);

ALTER TABLE "backers" ADD CONSTRAINT "fk_backers_cf_id" FOREIGN KEY("cf_id")
REFERENCES "campaign" ("cf_id");

SELECT backers_count, cf_id, outcome

FROM campaign

WHERE (outcome = 'live')

GROUP BY cf_id

ORDER BY backers_count DESC;

SELECT COUNT(cf_id), cf_id

FROM backers

GROUP BY cf_id

ORDER BY COUNT DESC;
=================================================
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

SELECT * FROM email_contacts_remaining_goal;
================================================
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

SELECT * FROM email_backers_remaining_goal_amount;




