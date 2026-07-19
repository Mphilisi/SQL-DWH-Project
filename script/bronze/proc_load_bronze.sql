

CREATE OR ALTER PROCEDURE bronze.load_bronze 
AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME;
	BEGIN TRY
		PRINT '======================================================================================';
		PRINT 'Loading the bronze layer';
		PRINT '======================================================================================';

		PRINT '--------------------------------------------------------------------------------------';
		PRINT 'Loading CRM Tables';
		PRINT '--------------------------------------------------------------------------------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating table: bronze.crm_cust_info';
		--The ff script will make the table empty before loading data into it
		TRUNCATE TABLE bronze.crm_cust_info;

		PRINT '>> Inserting data into the table: bronze.crm_cust_info';
		BULK INSERT bronze.crm_cust_info
		FROM 'C:\Users\mngat\Desktop\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);

		PRINT '>> Truncating table: bronze.crm_prd_info';
		--The ff script will make the 'bronze,crm_prd_info' empty before loading data to it
		TRUNCATE TABLE bronze.crm_prd_info;

		PRINT '>> Inserting data into table: bronze.crm_prd_info';
		BULK INSERT bronze.crm_prd_info
		FROM 'C:\Users\mngat\Desktop\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
	
		print '>> Truncating table bronze.crm_sales_details';
		--The ff script will make the table empty before loading data into it
		TRUNCATE TABLE bronze.crm_sales_details;

		PRINT '>> Loading data into ttable: bronze.crm_sales_details';
		BULK INSERT bronze.crm_sales_details
		FROM 'C:\Users\mngat\Desktop\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
	
		PRINT '--------------------------------------------------------------------------------------';
		PRINT 'Loading ERP Tables';
		PRINT '--------------------------------------------------------------------------------------';

		PRINT '>> Truncating table: bronze.erp_cust_AZ12';
		--The ff script 2will make the table empty before loading data into it
		TRUNCATE TABLE bronze.erp_cust_AZ12;

		PRINT '>> Loading data into ttable: bronze.erp_cust_AZ12';
		BULK INSERT bronze.erp_cust_AZ12
		FROM 'C:\Users\mngat\Desktop\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
	
		PRINT '>> Truncating table: bronze.erp_loc_A101';
		--The ff script will make the table empty before loading data into it
		TRUNCATE TABLE bronze.erp_loc_A101;
	
		PRINT '>> Loading data into ttable: bronze.erp_loc_A101';
		BULK INSERT bronze.erp_loc_A101
		FROM 'C:\Users\mngat\Desktop\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
	
		PRINT '>> Truncating table: bronze.erp_px_cat_G1V2';
		--The ff script will make the table empty before loading data into it
		TRUNCATE TABLE bronze.erp_px_cat_G1V2;

		PRINT '>> Loading data into ttable: bronze.erp_px_cat_G1V2';
		BULK INSERT bronze.erp_px_cat_G1V2
		FROM 'C:\Users\mngat\Desktop\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
	END TRY
	BEGIN CATCH
		PRINT '=======================================================================================================';
		PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER';
		PRINT 'Error Message' + ERROR_MESSAGE();
		PRINT 'Error Number' + CAST(ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error State' + CAST(ERROR_STATE() AS NVARCHAR);
		PRINT '=======================================================================================================';
	END CATCH
END;
