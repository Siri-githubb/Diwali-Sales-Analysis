/*
Diwali Sales Report: Data Cleaning in SQL

# Objectives: The objective of this process was to clean and prepare the raw Diwali sales dataset
			for analysis by addressing missing values, duplicates, and other inconsistencies.

# Steps Taken
- Drop irrelevant columns
- Standardized values
- Handled missing values
- Removed duplicate records


*/
Select * 
From project..Diwali_Sales_Data;


-- Drop column named status and unnamed

Alter Table project..Diwali_Sales_Data
Drop column Status;

Alter Table project..Diwali_Sales_Data
Drop column unnamed1;



--Replace value 0 as 'No' and 1 as 'Yes'


SET Marital_Status = CASE
    WHEN Marital_Status = 0 THEN 'No'
    WHEN Marital_Status = 1 THEN 'Yes'
END;

UPDATE project..Diwali_Sales_Data

        
-- Replace value of Gender column to Female and Male.
Select Gender,
	Case 
		When Gender = 'F' Then 'Female'
		When Gender = 'M' Then 'Male'
		End
From project..Diwali_Sales_Data

update project..Diwali_Sales_Data
Set Gender = Case 
		When Gender = 'F' Then 'Female'
		When Gender = 'M' Then 'Male'
		End;



-- Drop Row where Amount is Null

Select *
From project..Diwali_Sales_Data
Where Amount is NULL;



Delete from project..Diwali_Sales_Data
Where Amount is Null;



-- Check if there is any duplicate value

With duplicate_value as(
Select *,
ROW_NUMBER() over(Partition By User_ID, Cust_name, Product_ID, Gender, Age, Product_Category, Occupation, Orders, Amount, Marital_Status
				order by User_ID) Row_num
From project..Diwali_Sales_Data
) Select * 
From duplicate_value
Where Row_num > 1;



With delete_duplicate_value As(
Select *,
ROW_NUMBER() over(Partition By 
						User_ID, Cust_name, Product_ID, Gender, Age, Product_Category, Occupation, Orders, Amount, Marital_Status
						order by User_ID) Row_num
From project..Diwali_Sales_Data
)
Delete 
From delete_duplicate_value
Where Row_num > 1;



-- Age and Age Group

Alter Table project..Diwali_Sales_Data
Add Age_Group varchar(10)


update project..Diwali_Sales_Data
Set Age_Group = Case 
		When Age < 18 Then 'Below 18'
		When Age >=18 AND Age <=35 then '18-35'
		When Age > 35 And Age <=50 Then '36-50'
		When Age >50 And Age <= 60 Then '50-60'
		When Age > 60 Then '60+'
		End;


Select Age, Age_Group
From project..Diwali_Sales_Data
Where Age = 18 
Or Age = 36;
