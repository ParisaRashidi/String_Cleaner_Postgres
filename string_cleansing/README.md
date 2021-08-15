# String_Cleaner_Postgres
This function removes all extra characters from strings ( including spaces), and makes string clear to compare them.
* How to use?
just run function in PostgresSQL and give your String as input:
SELECT clear_string("میدأنٰ امام       خُمین");
the result would be: میدان امام خمینی
