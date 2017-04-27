*** Settings ***
Library                       HttpLibrary.HTTP
Library                       OperatingSystem
Test Setup                    Create API Context
 
*** Variables ***
${API_ENDPOINT}               http://api.kaiworship.xyz
${VERSION}                    v4

*** Keywords ***
Create API Context
  Create Http Context         api.kaiworship.xyz   http

*** Test Cases ***
M.1.1 Merch All Variables No Dates

	[Tags]  happy-day 

	${stats_area} =   Set Variable	MerchandiseExports
	${categories} = 	Set Variable  Total,FoodAndLiveAnimals,BeveragesAndTobacco,CrudeMaterialAndInedible,MineralFuelLubricantAndRelatedMaterial,AnimalAndVegetableOilFatAndWaxes,ChemicalsAndRelatedProducts,ManufacturedGoods,MachineryAndTransportEquipments,OtherManufacturedArticles,Unclassified
	${states} =  			Set Variable 	Total,NSW,WA,SA,ACT,VIC,TAS,QLD,NT
	${params} =  			Set Variable  ignoreHeader=True

	${expected} = 		Set Variable  M.1.1.expected.json

  Create API Context
  GET  							/${VERSION}/${stats_area}/${categories}/${states}?${params}
  Log								${API_ENDPOINT}/${VERSION}/${stats_area}/${categories}/${states}?${params}

  Response Status Code Should Equal		200

  ${resp_body} =  	Get Response Body
  ${resp_json} =  	Parse Json  	${resp_body}
  Log  							${resp_json}
  ${exp_file} =     Get File    	expected_outputs/${expected}
  ${exp_json} =     Parse Json    ${exp_file}
  Should Be Equal  	${resp_json}  ${exp_json}

 
R.1.1 Retail All Variables No Dates

	${stats_area} =   Set Variable	Retail
	${categories} = 	Set Variable  Total,Food,HouseholdGood,ClothingFootwareAndPersonalAccessory,DepartmentStores,CafesRestaurantsAndTakeawayFood,Other
	${states} =  			Set Variable 	Total,NSW,WA,SA,ACT,VIC,TAS,QLD,NT
	${params} =  			Set Variable  ignoreHeader=True

	${expected} = 		Set Variable  R.1.1.expected.json

  Create API Context
  GET  							/${VERSION}/${stats_area}/${categories}/${states}?${params}
  Log								${API_ENDPOINT}/${VERSION}/${stats_area}/${categories}/${states}?${params}

  Response Status Code Should Equal		200

  ${resp_body} =  	Get Response Body
  ${resp_json} =  	Parse Json  	${resp_body}
  Log  							${resp_json}
  ${exp_file} =     Get File    	expected_outputs/${expected}
  ${exp_json} =     Parse Json    ${exp_file}
  Should Be Equal  	${resp_json}  ${exp_json}


M.1.2 Merch All Variables Entire Date Range

	${stats_area} =   Set Variable	MerchandiseExports
	${categories} = 	Set Variable  Total,FoodAndLiveAnimals,BeveragesAndTobacco,CrudeMaterialAndInedible,MineralFuelLubricantAndRelatedMaterial,AnimalAndVegetableOilFatAndWaxes,ChemicalsAndRelatedProducts,ManufacturedGoods,MachineryAndTransportEquipments,OtherManufacturedArticles,Unclassified
	${states} =  			Set Variable 	Total,NSW,WA,SA,ACT,VIC,TAS,QLD,NT

	${start_date} = 	Set Variable 	1995-07-01
	${end_date} = 		Set Variable 	2017-02-01
	${params} =  			Set Variable  startDate=${start_date}&endDate=${end_date}&ignoreHeader=True

	${expected} = 		Set Variable  M.1.2.expected.json

  Create API Context
  GET  							/${VERSION}/${stats_area}/${categories}/${states}?${params}
  Log								${API_ENDPOINT}/${VERSION}/${stats_area}/${categories}/${states}?${params}

  Response Status Code Should Equal		200

  ${resp_body} =  	Get Response Body
  ${resp_json} =  	Parse Json  	${resp_body}
  Log  							${resp_json}
  ${exp_file} =     Get File    	expected_outputs/${expected}
  ${exp_json} =     Parse Json    ${exp_file}
  Should Be Equal  	${resp_json}  ${exp_json}


R.1.2 Retail All Variables Entire Date Range

	${stats_area} =   Set Variable	Retail
	${categories} = 	Set Variable  Total,Food,HouseholdGood,ClothingFootwareAndPersonalAccessory,DepartmentStores,CafesRestaurantsAndTakeawayFood,Other
	${states} =  			Set Variable 	Total,NSW,WA,SA,ACT,VIC,TAS,QLD,NT

	${start_date} = 	Set Variable 	1995-07-01
	${end_date} = 		Set Variable 	2017-02-01
	${params} =  			Set Variable  startDate=${start_date}&endDate=${end_date}&ignoreHeader=True

	${expected} = 		Set Variable  R.1.2.expected.json

  Create API Context
  GET  							/${VERSION}/${stats_area}/${categories}/${states}?${params}
  Log								${API_ENDPOINT}/${VERSION}/${stats_area}/${categories}/${states}?${params}

  Response Status Code Should Equal		200

  ${resp_body} =  	Get Response Body
  ${resp_json} =  	Parse Json  	${resp_body}
  Log  							${resp_json}
  ${exp_file} =     Get File    	expected_outputs/${expected}
  ${exp_json} =     Parse Json    ${exp_file}
  Should Be Equal  	${resp_json}  ${exp_json}


M.1.3 Merch All Variables Date Range Beyond All Data

	${stats_area} =   Set Variable	MerchandiseExports
	${categories} = 	Set Variable  Total,FoodAndLiveAnimals,BeveragesAndTobacco,CrudeMaterialAndInedible,MineralFuelLubricantAndRelatedMaterial,AnimalAndVegetableOilFatAndWaxes,ChemicalsAndRelatedProducts,ManufacturedGoods,MachineryAndTransportEquipments,OtherManufacturedArticles,Unclassified
	${states} =  			Set Variable 	Total,NSW,WA,SA,ACT,VIC,TAS,QLD,NT

	${start_date} = 	Set Variable 	1990-01-01
	${end_date} = 		Set Variable 	2018-01-01
	${params} =  			Set Variable  startDate=${start_date}&endDate=${end_date}&ignoreHeader=True

	${expected} = 		Set Variable  M.1.3.expected.json

  Create API Context
  GET  							/${VERSION}/${stats_area}/${categories}/${states}?${params}
  Log								${API_ENDPOINT}/${VERSION}/${stats_area}/${categories}/${states}?${params}

  Response Status Code Should Equal		200

  ${resp_body} =  	Get Response Body
  ${resp_json} =  	Parse Json  	${resp_body}
  Log  							${resp_json}
  ${exp_file} =     Get File    	expected_outputs/${expected}
  ${exp_json} =     Parse Json    ${exp_file}
  Should Be Equal  	${resp_json}  ${exp_json}


R.1.3 Retail All Variables Date Range Beyond All Data

	${stats_area} =   Set Variable	Retail
	${categories} = 	Set Variable  Total,Food,HouseholdGood,ClothingFootwareAndPersonalAccessory,DepartmentStores,CafesRestaurantsAndTakeawayFood,Other
	${states} =  			Set Variable 	Total,NSW,WA,SA,ACT,VIC,TAS,QLD,NT

	${start_date} = 	Set Variable 	1990-01-01
	${end_date} = 		Set Variable 	2018-01-01
	${params} =  			Set Variable  startDate=${start_date}&endDate=${end_date}&ignoreHeader=True

	${expected} = 		Set Variable  R.1.3.expected.json

  Create API Context
  GET  							/${VERSION}/${stats_area}/${categories}/${states}?${params}
  Log								${API_ENDPOINT}/${VERSION}/${stats_area}/${categories}/${states}?${params}

  Response Status Code Should Equal		200

  ${resp_body} =  	Get Response Body
  ${resp_json} =  	Parse Json  	${resp_body}
  Log  							${resp_json}
  ${exp_file} =     Get File    	expected_outputs/${expected}
  ${exp_json} =     Parse Json    ${exp_file}
  Should Be Equal  	${resp_json}  ${exp_json}







M.E.1.1 Merch Error Incorrect Stats Area

	[Tags]  error 

	${stats_area} =   Set Variable	MerchandiseExport
	${categories} = 	Set Variable  Total,FoodAndLiveAnimals,BeveragesAndTobacco,CrudeMaterialAndInedible,MineralFuelLubricantAndRelatedMaterial,AnimalAndVegetableOilFatAndWaxes,ChemicalsAndRelatedProducts,ManufacturedGoods,MachineryAndTransportEquipments,OtherManufacturedArticles,Unclassified
	${states} =  			Set Variable 	Total,NSW,WA,SA,ACT,VIC,TAS,QLD,NT

	${start_date} = 	Set Variable 	1990-01-01
	${end_date} = 		Set Variable 	2018-01-01
	${params} =  			Set Variable  startDate=${start_date}&endDate=${end_date}&ignoreHeader=True

	${expected} = 		Set Variable  M.E.1.1.expected.json

  Create API Context
  Next Request May Not Succeed
  GET 							/${VERSION}/${stats_area}/${categories}/${states}?${params}
  Log								${API_ENDPOINT}/${VERSION}/${stats_area}/${categories}/${states}?${params}

  Response Status Code Should Equal		404

  ${resp_body} =  	Get Response Body
  ${resp_json} =  	Parse Json  	${resp_body}
  Log  							${resp_json}
  ${exp_file} =     Get File    	expected_outputs/${expected}
  ${exp_json} =     Parse Json    ${exp_file}
  Should Be Equal  	${resp_json}  ${exp_json}


R.E.1.1 Retail Error Incorrect Stats Area

	[Tags]  error 

	${stats_area} =   Set Variable	Retails
	${categories} = 	Set Variable  Total,Food,HouseholdGood,ClothingFootwareAndPersonalAccessory,DepartmentStores,CafesRestaurantsAndTakeawayFood,Other
	${states} =  			Set Variable 	Total,NSW,WA,SA,ACT,VIC,TAS,QLD,NT

	${start_date} = 	Set Variable 	1990-01-01
	${end_date} = 		Set Variable 	2018-01-01
	${params} =  			Set Variable  startDate=${start_date}&endDate=${end_date}&ignoreHeader=True

	${expected} = 		Set Variable  R.E.1.1.expected.json

  Create API Context
  Next Request May Not Succeed
  GET 							/${VERSION}/${stats_area}/${categories}/${states}?${params}
  Log								${API_ENDPOINT}/${VERSION}/${stats_area}/${categories}/${states}?${params}

  Response Status Code Should Equal		404

  ${resp_body} =  	Get Response Body
  ${resp_json} =  	Parse Json  	${resp_body}
  Log  							${resp_json}
  ${exp_file} =     Get File    	expected_outputs/${expected}
  ${exp_json} =     Parse Json    ${exp_file}
  Should Be Equal  	${resp_json}  ${exp_json}



M.E.1.2 Merch Error Incorrect Commodities

	[Tags]  error 

	${stats_area} =   Set Variable	MerchandiseExports
	${categories} = 	Set Variable  Total,FoodAndLiveAnimals,BeveragesAndTobacco,CrudeMaterialAndInedible,MineralFuelLubricantAndRelatedMaterial,AnimalAndVegetableOilFat,,
	${states} =  			Set Variable 	Total,NSW,WA,SA,ACT,VIC,TAS,QLD,NT

	${start_date} = 	Set Variable 	1990-01-01
	${end_date} = 		Set Variable 	2018-01-01
	${params} =  			Set Variable  startDate=${start_date}&endDate=${end_date}&ignoreHeader=True

	${expected} = 		Set Variable  M.E.1.2.expected.json

  Create API Context
  Next Request May Not Succeed
  GET 							/${VERSION}/${stats_area}/${categories}/${states}?${params}
  Log								${API_ENDPOINT}/${VERSION}/${stats_area}/${categories}/${states}?${params}

  Response Status Code Should Equal		404

  ${resp_body} =  	Get Response Body
  ${resp_json} =  	Parse Json  	${resp_body}
  Log  							${resp_json}
  ${exp_file} =     Get File    	expected_outputs/${expected}
  ${exp_json} =     Parse Json    ${exp_file}
  Should Be Equal  	${resp_json}  ${exp_json}


R.E.1.2 Retail Error Incorrect Categories

	[Tags]  error 

	${stats_area} =   Set Variable	Retail
	${categories} = 	Set Variable  Total,Food,HouseholdGood,ClothingAccessory,DepartmentStores,CafesRestaurantsAndTakeawayFood,Other
	${states} =  			Set Variable 	Total,NSW,WA,SA,ACT,VIC,TAS,QLD,NT

	${start_date} = 	Set Variable 	1990-01-01
	${end_date} = 		Set Variable 	2018-01-01
	${params} =  			Set Variable  startDate=${start_date}&endDate=${end_date}&ignoreHeader=True

	${expected} = 		Set Variable  R.E.1.2.expected.json

  Create API Context
  Next Request May Not Succeed
  GET 							/${VERSION}/${stats_area}/${categories}/${states}?${params}
  Log								${API_ENDPOINT}/${VERSION}/${stats_area}/${categories}/${states}?${params}

  Response Status Code Should Equal		404

  ${resp_body} =  	Get Response Body
  ${resp_json} =  	Parse Json  	${resp_body}
  Log  							${resp_json}
  ${exp_file} =     Get File    	expected_outputs/${expected}
  ${exp_json} =     Parse Json    ${exp_file}
  Should Be Equal  	${resp_json}  ${exp_json}



M.E.1.3 Merch Error Incorrect States

	[Tags]  error 

	${stats_area} =   Set Variable	MerchandiseExports
	${categories} = 	Set Variable  Total,FoodAndLiveAnimals,BeveragesAndTobacco,CrudeMaterialAndInedible,MineralFuelLubricantAndRelatedMaterial,AnimalAndVegetableOilFatAndWaxes,ChemicalsAndRelatedProducts,ManufacturedGoods,MachineryAndTransportEquipments,OtherManufacturedArticles,Unclassified
	${states} =  			Set Variable 	NZ,WA

	${start_date} = 	Set Variable 	1990-01-01
	${end_date} = 		Set Variable 	2018-01-01
	${params} =  			Set Variable  startDate=${start_date}&endDate=${end_date}&ignoreHeader=True

	${expected} = 		Set Variable  M.E.1.3.expected.json

  Create API Context
  Next Request May Not Succeed
  GET 							/${VERSION}/${stats_area}/${categories}/${states}?${params}
  Log								${API_ENDPOINT}/${VERSION}/${stats_area}/${categories}/${states}?${params}

  Response Status Code Should Equal		404

  ${resp_body} =  	Get Response Body
  ${resp_json} =  	Parse Json  	${resp_body}
  Log  							${resp_json}
  ${exp_file} =     Get File    	expected_outputs/${expected}
  ${exp_json} =     Parse Json    ${exp_file}
  Should Be Equal  	${resp_json}  ${exp_json}


R.E.1.3 Retail Error Incorrect States

	[Tags]  error 

	${stats_area} =   Set Variable	Retail
	${categories} = 	Set Variable  Total,Food,HouseholdGood,ClothingFootwareAndPersonalAccessory,DepartmentStores,CafesRestaurantsAndTakeawayFood,Other
	${states} =  			Set Variable 	NZ,WA

	${start_date} = 	Set Variable 	1990-01-01
	${end_date} = 		Set Variable 	2018-01-01
	${params} =  			Set Variable  startDate=${start_date}&endDate=${end_date}&ignoreHeader=True

	${expected} = 		Set Variable  R.E.1.3.expected.json

  Create API Context
  Next Request May Not Succeed
  GET 							/${VERSION}/${stats_area}/${categories}/${states}?${params}
  Log								${API_ENDPOINT}/${VERSION}/${stats_area}/${categories}/${states}?${params}

  Response Status Code Should Equal		404

  ${resp_body} =  	Get Response Body
  ${resp_json} =  	Parse Json  	${resp_body}
  Log  							${resp_json}
  ${exp_file} =     Get File    	expected_outputs/${expected}
  ${exp_json} =     Parse Json    ${exp_file}
  Should Be Equal  	${resp_json}  ${exp_json}



M.E.2.1 Merch Error EndDate before StartDate

	[Tags]  error 

	${stats_area} =   Set Variable	MerchandiseExports
	${categories} = 	Set Variable  Total,FoodAndLiveAnimals,BeveragesAndTobacco,CrudeMaterialAndInedible,MineralFuelLubricantAndRelatedMaterial,AnimalAndVegetableOilFatAndWaxes,ChemicalsAndRelatedProducts,ManufacturedGoods,MachineryAndTransportEquipments,OtherManufacturedArticles,Unclassified
	${states} =  			Set Variable 	Total,NSW,WA,SA,ACT,VIC,TAS,QLD,NT

	${start_date} = 	Set Variable 	2010-03-24
	${end_date} = 		Set Variable 	1999-12-19
	${params} =  			Set Variable  startDate=${start_date}&endDate=${end_date}&ignoreHeader=True

	${expected} = 		Set Variable  M.E.2.1.expected.json

  Create API Context
  Next Request May Not Succeed
  GET 							/${VERSION}/${stats_area}/${categories}/${states}?${params}
  Log								${API_ENDPOINT}/${VERSION}/${stats_area}/${categories}/${states}?${params}

  Response Status Code Should Equal		404

  ${resp_body} =  	Get Response Body
  ${resp_json} =  	Parse Json  	${resp_body}
  Log  							${resp_json}
  ${exp_file} =     Get File    	expected_outputs/${expected}
  ${exp_json} =     Parse Json    ${exp_file}
  Should Be Equal  	${resp_json}  ${exp_json}


R.E.2.1 Retail Error EndDate before StartDate

	[Tags]  error 

	${stats_area} =   Set Variable	Retail
	${categories} = 	Set Variable  Total,Food,HouseholdGood,ClothingFootwareAndPersonalAccessory,DepartmentStores,CafesRestaurantsAndTakeawayFood,Other
	${states} =  			Set Variable 	Total,NSW,WA,SA,ACT,VIC,TAS,QLD,NT

	${start_date} = 	Set Variable 	2010-03-24
	${end_date} = 		Set Variable 	1999-12-19
	${params} =  			Set Variable  startDate=${start_date}&endDate=${end_date}&ignoreHeader=True

	${expected} = 		Set Variable  R.E.2.1.expected.json

  Create API Context
  Next Request May Not Succeed
  GET 							/${VERSION}/${stats_area}/${categories}/${states}?${params}
  Log								${API_ENDPOINT}/${VERSION}/${stats_area}/${categories}/${states}?${params}

  Response Status Code Should Equal		404

  ${resp_body} =  	Get Response Body
  ${resp_json} =  	Parse Json  	${resp_body}
  Log  							${resp_json}
  ${exp_file} =     Get File    	expected_outputs/${expected}
  ${exp_json} =     Parse Json    ${exp_file}
  Should Be Equal  	${resp_json}  ${exp_json}

M.E.2.2 Merch Error Invalid start date not in YYYY-MM-DD format

  [Tags]  error 

  ${stats_area} =   Set Variable  MerchandiseExports
  ${categories} =   Set Variable  Total,FoodAndLiveAnimals,BeveragesAndTobacco,CrudeMaterialAndInedible,MineralFuelLubricantAndRelatedMaterial,AnimalAndVegetableOilFatAndWaxes,ChemicalsAndRelatedProducts,ManufacturedGoods,MachineryAndTransportEquipments,OtherManufacturedArticles,Unclassified
  ${states} =       Set Variable  Total,NSW,WA,SA,ACT,VIC,TAS,QLD,NT

  ${start_date} =   Set Variable  2010-3-24
  ${end_date} =     Set Variable  2011-12-19
  ${params} =       Set Variable  startDate=${start_date}&endDate=${end_date}&ignoreHeader=True

  ${expected} =     Set Variable  M.E.2.2.expected.json

  Create API Context
  Next Request May Not Succeed
  GET               /${VERSION}/${stats_area}/${categories}/${states}?${params}
  Log               ${API_ENDPOINT}/${VERSION}/${stats_area}/${categories}/${states}?${params}

  Response Status Code Should Equal   404

  ${resp_body} =    Get Response Body
  ${resp_json} =    Parse Json    ${resp_body}
  Log               ${resp_json}
  ${exp_file} =     Get File      expected_outputs/${expected}
  ${exp_json} =     Parse Json    ${exp_file}
  Should Be Equal   ${resp_json}  ${exp_json}

R.E.2.2 Retail Error Invalid start date not in YYYY-MM-DD format

  [Tags]  error 

  ${stats_area} =   Set Variable  Retail
  ${categories} =   Set Variable  Total,Food,HouseholdGood,ClothingFootwareAndPersonalAccessory,DepartmentStores,CafesRestaurantsAndTakeawayFood,Other
  ${states} =       Set Variable  Total,NSW,WA,SA,ACT,VIC,TAS,QLD,NT

  ${start_date} =   Set Variable  2010-3-24
  ${end_date} =     Set Variable  2011-12-19
  ${params} =       Set Variable  startDate=${start_date}&endDate=${end_date}&ignoreHeader=True

  ${expected} =     Set Variable  R.E.2.2.expected.json

  Create API Context
  Next Request May Not Succeed
  GET               /${VERSION}/${stats_area}/${categories}/${states}?${params}
  Log               ${API_ENDPOINT}/${VERSION}/${stats_area}/${categories}/${states}?${params}

  Response Status Code Should Equal   404

  ${resp_body} =    Get Response Body
  ${resp_json} =    Parse Json    ${resp_body}
  Log               ${resp_json}
  ${exp_file} =     Get File      expected_outputs/${expected}
  ${exp_json} =     Parse Json    ${exp_file}
  Should Be Equal   ${resp_json}  ${exp_json}

M.E.2.3 Merch Error Invalid End date not in YYYY-MM-DD format

  [Tags]  error 

  ${stats_area} =   Set Variable  MerchandiseExports
  ${categories} =   Set Variable  Total,FoodAndLiveAnimals,BeveragesAndTobacco,CrudeMaterialAndInedible,MineralFuelLubricantAndRelatedMaterial,AnimalAndVegetableOilFatAndWaxes,ChemicalsAndRelatedProducts,ManufacturedGoods,MachineryAndTransportEquipments,OtherManufacturedArticles,Unclassified
  ${states} =       Set Variable  Total,NSW,WA,SA,ACT,VIC,TAS,QLD,NT

  ${start_date} =   Set Variable  2010-03-24
  ${end_date} =     Set Variable  2011-12-1
  ${params} =       Set Variable  startDate=${start_date}&endDate=${end_date}&ignoreHeader=True

  ${expected} =     Set Variable  M.E.2.3.expected.json

  Create API Context
  Next Request May Not Succeed
  GET               /${VERSION}/${stats_area}/${categories}/${states}?${params}
  Log               ${API_ENDPOINT}/${VERSION}/${stats_area}/${categories}/${states}?${params}

  Response Status Code Should Equal   404

  ${resp_body} =    Get Response Body
  ${resp_json} =    Parse Json    ${resp_body}
  Log               ${resp_json}
  ${exp_file} =     Get File      expected_outputs/${expected}
  ${exp_json} =     Parse Json    ${exp_file}
  Should Be Equal   ${resp_json}  ${exp_json}

R.E.2.3 Retail Error Invalid End date not in YYYY-MM-DD format

  [Tags]  error 

  ${stats_area} =   Set Variable  Retail
  ${categories} =   Set Variable  Total,Food,HouseholdGood,ClothingFootwareAndPersonalAccessory,DepartmentStores,CafesRestaurantsAndTakeawayFood,Other
  ${states} =       Set Variable  Total,NSW,WA,SA,ACT,VIC,TAS,QLD,NT

  ${start_date} =   Set Variable  2010-03-24
  ${end_date} =     Set Variable  2011-12-1
  ${params} =       Set Variable  startDate=${start_date}&endDate=${end_date}&ignoreHeader=True

  ${expected} =     Set Variable  R.E.2.3.expected.json

  Create API Context
  Next Request May Not Succeed
  GET               /${VERSION}/${stats_area}/${categories}/${states}?${params}
  Log               ${API_ENDPOINT}/${VERSION}/${stats_area}/${categories}/${states}?${params}

  Response Status Code Should Equal   404

  ${resp_body} =    Get Response Body
  ${resp_json} =    Parse Json    ${resp_body}
  Log               ${resp_json}
  ${exp_file} =     Get File      expected_outputs/${expected}
  ${exp_json} =     Parse Json    ${exp_file}
  Should Be Equal   ${resp_json}  ${exp_json}

M.E.2.4 Merch Error Start date after current Date

  [Tags]  error 

  ${stats_area} =   Set Variable  MerchandiseExports
  ${categories} =   Set Variable  Total,FoodAndLiveAnimals,BeveragesAndTobacco,CrudeMaterialAndInedible,MineralFuelLubricantAndRelatedMaterial,AnimalAndVegetableOilFatAndWaxes,ChemicalsAndRelatedProducts,ManufacturedGoods,MachineryAndTransportEquipments,OtherManufacturedArticles,Unclassified
  ${states} =       Set Variable  Total,NSW,WA,SA,ACT,VIC,TAS,QLD,NT

  ${start_date} =   Set Variable  2018-03-24
  ${params} =       Set Variable  startDate=${start_date}&ignoreHeader=True

  ${expected} =     Set Variable  M.E.2.4.expected.json

  Create API Context
  Next Request May Not Succeed
  GET               /${VERSION}/${stats_area}/${categories}/${states}?${params}
  Log               ${API_ENDPOINT}/${VERSION}/${stats_area}/${categories}/${states}?${params}

  Response Status Code Should Equal   404

  ${resp_body} =    Get Response Body
  ${resp_json} =    Parse Json    ${resp_body}
  Log               ${resp_json}
  ${exp_file} =     Get File      expected_outputs/${expected}
  ${exp_json} =     Parse Json    ${exp_file}
  Should Be Equal   ${resp_json}  ${exp_json}

R.E.2.4 Retail Error Start date after current Date

  [Tags]  error 

  ${stats_area} =   Set Variable  Retail
  ${categories} =   Set Variable  Total,Food,HouseholdGood,ClothingFootwareAndPersonalAccessory,DepartmentStores,CafesRestaurantsAndTakeawayFood,Other
  ${states} =       Set Variable  Total,NSW,WA,SA,ACT,VIC,TAS,QLD,NT

  ${start_date} =   Set Variable  2018-03-24
  ${params} =       Set Variable  startDate=${start_date}&ignoreHeader=True

  ${expected} =     Set Variable  R.E.2.4.expected.json

  Create API Context
  Next Request May Not Succeed
  GET               /${VERSION}/${stats_area}/${categories}/${states}?${params}
  Log               ${API_ENDPOINT}/${VERSION}/${stats_area}/${categories}/${states}?${params}

  Response Status Code Should Equal   404

  ${resp_body} =    Get Response Body
  ${resp_json} =    Parse Json    ${resp_body}
  Log               ${resp_json}
  ${exp_file} =     Get File      expected_outputs/${expected}
  ${exp_json} =     Parse Json    ${exp_file}
  Should Be Equal   ${resp_json}  ${exp_json}

M.E.2.5 Merch Error Date Day nonexistant "2011-15-19"

  [Tags]  error 

  ${stats_area} =   Set Variable  MerchandiseExports
  ${categories} =   Set Variable  Total,FoodAndLiveAnimals,BeveragesAndTobacco,CrudeMaterialAndInedible,MineralFuelLubricantAndRelatedMaterial,AnimalAndVegetableOilFatAndWaxes,ChemicalsAndRelatedProducts,ManufacturedGoods,MachineryAndTransportEquipments,OtherManufacturedArticles,Unclassified
  ${states} =       Set Variable  Total,NSW,WA,SA,ACT,VIC,TAS,QLD,NT

  ${start_date} =   Set Variable  2010-03-24
  ${end_date} =     Set Variable  2011-15-19
  ${params} =       Set Variable  startDate=${start_date}&endDate=${end_date}&ignoreHeader=True

  ${expected} =     Set Variable  M.E.2.5.expected.json

  Create API Context
  Next Request May Not Succeed
  GET               /${VERSION}/${stats_area}/${categories}/${states}?${params}
  Log               ${API_ENDPOINT}/${VERSION}/${stats_area}/${categories}/${states}?${params}

  Response Status Code Should Equal   404

  ${resp_body} =    Get Response Body
  ${resp_json} =    Parse Json    ${resp_body}
  Log               ${resp_json}
  ${exp_file} =     Get File      expected_outputs/${expected}
  ${exp_json} =     Parse Json    ${exp_file}
  Should Be Equal   ${resp_json}  ${exp_json}


R.E.2.5 Retail Error Date nonexistant "2011-12-32"

  [Tags]  error 

  ${stats_area} =   Set Variable  Retail
  ${categories} =   Set Variable  Total,Food,HouseholdGood,ClothingFootwareAndPersonalAccessory,DepartmentStores,CafesRestaurantsAndTakeawayFood,Other
  ${states} =       Set Variable  Total,NSW,WA,SA,ACT,VIC,TAS,QLD,NT

  ${start_date} =   Set Variable  2010-03-24
  ${end_date} =     Set Variable  2011-12-32
  ${params} =       Set Variable  startDate=${start_date}&endDate=${end_date}&ignoreHeader=True

  ${expected} =     Set Variable  R.E.2.5.expected.json

  Create API Context
  Next Request May Not Succeed
  GET               /${VERSION}/${stats_area}/${categories}/${states}?${params}
  Log               ${API_ENDPOINT}/${VERSION}/${stats_area}/${categories}/${states}?${params}

  Response Status Code Should Equal   404

  ${resp_body} =    Get Response Body
  ${resp_json} =    Parse Json    ${resp_body}
  Log               ${resp_json}
  ${exp_file} =     Get File      expected_outputs/${expected}
  ${exp_json} =     Parse Json    ${exp_file}
  Should Be Equal   ${resp_json}  ${exp_json}

M.E.2.6 Merch Error 29th Feb, non leap year "2013-02-29"

  [Tags]  error 

  ${stats_area} =   Set Variable  MerchandiseExports
  ${categories} =   Set Variable  Total,FoodAndLiveAnimals,BeveragesAndTobacco,CrudeMaterialAndInedible,MineralFuelLubricantAndRelatedMaterial,AnimalAndVegetableOilFatAndWaxes,ChemicalsAndRelatedProducts,ManufacturedGoods,MachineryAndTransportEquipments,OtherManufacturedArticles,Unclassified
  ${states} =       Set Variable  Total,NSW,WA,SA,ACT,VIC,TAS,QLD,NT

  ${start_date} =   Set Variable  2011-02-28
  ${end_date} =     Set Variable  2013-02-29
  ${params} =       Set Variable  startDate=${start_date}&endDate=${end_date}&ignoreHeader=True

  ${expected} =     Set Variable  M.E.2.6.expected.json

  Create API Context
  Next Request May Not Succeed
  GET               /${VERSION}/${stats_area}/${categories}/${states}?${params}
  Log               ${API_ENDPOINT}/${VERSION}/${stats_area}/${categories}/${states}?${params}

  Response Status Code Should Equal   404

  ${resp_body} =    Get Response Body
  ${resp_json} =    Parse Json    ${resp_body}
  Log               ${resp_json}
  ${exp_file} =     Get File      expected_outputs/${expected}
  ${exp_json} =     Parse Json    ${exp_file}
  Should Be Equal   ${resp_json}  ${exp_json}


R.E.2.6 Retail Error 29th Feb, non leap year "2011-02-29"

  [Tags]  error 

  ${stats_area} =   Set Variable  Retail
  ${categories} =   Set Variable  Total,Food,HouseholdGood,ClothingFootwareAndPersonalAccessory,DepartmentStores,CafesRestaurantsAndTakeawayFood,Other
  ${states} =       Set Variable  Total,NSW,WA,SA,ACT,VIC,TAS,QLD,NT

  ${start_date} =   Set Variable  2011-02-29
  ${end_date} =     Set Variable  2011-12-19
  ${params} =       Set Variable  startDate=${start_date}&endDate=${end_date}&ignoreHeader=True

  ${expected} =     Set Variable  R.E.2.6.expected.json

  Create API Context
  Next Request May Not Succeed
  GET               /${VERSION}/${stats_area}/${categories}/${states}?${params}
  Log               ${API_ENDPOINT}/${VERSION}/${stats_area}/${categories}/${states}?${params}

  Response Status Code Should Equal   404

  ${resp_body} =    Get Response Body
  ${resp_json} =    Parse Json    ${resp_body}
  Log               ${resp_json}
  ${exp_file} =     Get File      expected_outputs/${expected}
  ${exp_json} =     Parse Json    ${exp_file}
  Should Be Equal   ${resp_json}  ${exp_json}

M.3.1 Merch Only Categories Supplied
  
  [Tags]  happy-day 


  ${stats_area} =   Set Variable  MerchandiseExports
  ${categories} =   Set Variable  Total,FoodAndLiveAnimals,BeveragesAndTobacco,CrudeMaterialAndInedible,MineralFuelLubricantAndRelatedMaterial,AnimalAndVegetableOilFatAndWaxes,ChemicalsAndRelatedProducts,ManufacturedGoods,MachineryAndTransportEquipments,OtherManufacturedArticles,Unclassified

  ${params} =       Set Variable  ignoreHeader=True

  ${expected} =     Set Variable  M.3.1.expected.json

  Create API Context
  GET               /${VERSION}/${stats_area}/${categories}?${params}
  Log               ${API_ENDPOINT}/${VERSION}/${stats_area}/${categories}?${params}

  Response Status Code Should Equal   200

  ${resp_body} =    Get Response Body
  ${resp_json} =    Parse Json    ${resp_body}
  Log               ${resp_json}
  ${exp_file} =     Get File      expected_outputs/${expected}
  ${exp_json} =     Parse Json    ${exp_file}
  Should Be Equal   ${resp_json}  ${exp_json}


R.3.1 Retail only Categories Supplied

  ${stats_area} =   Set Variable  Retail
  ${categories} =   Set Variable  Total,Food,HouseholdGood,ClothingFootwareAndPersonalAccessory,DepartmentStores,CafesRestaurantsAndTakeawayFood,Other

  ${params} =       Set Variable  ignoreHeader=True

  ${expected} =     Set Variable  R.3.1.expected.json

  Create API Context
  GET               /${VERSION}/${stats_area}/${categories}?${params}
  Log               ${API_ENDPOINT}/${VERSION}/${stats_area}/${categories}?${params}

  Response Status Code Should Equal   200

  ${resp_body} =    Get Response Body
  ${resp_json} =    Parse Json    ${resp_body}
  Log               ${resp_json}
  ${exp_file} =     Get File      expected_outputs/${expected}
  ${exp_json} =     Parse Json    ${exp_file}
  Should Be Equal   ${resp_json}  ${exp_json}


M.3.2 Merch Categories and States supplied

  ${stats_area} =   Set Variable  MerchandiseExports
  ${categories} =   Set Variable  Total,FoodAndLiveAnimals,BeveragesAndTobacco,CrudeMaterialAndInedible,MineralFuelLubricantAndRelatedMaterial,AnimalAndVegetableOilFatAndWaxes,ChemicalsAndRelatedProducts,ManufacturedGoods,MachineryAndTransportEquipments,OtherManufacturedArticles,Unclassified
  ${states} =       Set Variable  Total,NSW,WA,SA,ACT,VIC,TAS,QLD,NT

  ${params} =       Set Variable  ignoreHeader=True

  ${expected} =     Set Variable  M.3.2.expected.json

  Create API Context
  GET               /${VERSION}/${stats_area}/${categories}/${states}?${params}
  Log               ${API_ENDPOINT}/${VERSION}/${stats_area}/${categories}/${states}?${params}

  Response Status Code Should Equal   200

  ${resp_body} =    Get Response Body
  ${resp_json} =    Parse Json    ${resp_body}
  Log               ${resp_json}
  ${exp_file} =     Get File      expected_outputs/${expected}
  ${exp_json} =     Parse Json    ${exp_file}
  Should Be Equal   ${resp_json}  ${exp_json}


R.3.2 Retail Categories and States supplied

  ${stats_area} =   Set Variable  Retail
  ${categories} =   Set Variable  Total,Food,HouseholdGood,ClothingFootwareAndPersonalAccessory,DepartmentStores,CafesRestaurantsAndTakeawayFood,Other
  ${states} =       Set Variable  Total,NSW,WA,SA,ACT,VIC,TAS,QLD,NT

  ${params} =       Set Variable  ignoreHeader=True

  ${expected} =     Set Variable  R.3.2.expected.json

  Create API Context
  GET               /${VERSION}/${stats_area}/${categories}/${states}?${params}
  Log               ${API_ENDPOINT}/${VERSION}/${stats_area}/${categories}/${states}?${params}

  Response Status Code Should Equal   200

  ${resp_body} =    Get Response Body
  ${resp_json} =    Parse Json    ${resp_body}
  Log               ${resp_json}
  ${exp_file} =     Get File      expected_outputs/${expected}
  ${exp_json} =     Parse Json    ${exp_file}
  Should Be Equal   ${resp_json}  ${exp_json}


M.3.3 Merch Categories, States and Start Date supplied
  
  [Tags]  happy-day 


  ${stats_area} =   Set Variable  MerchandiseExports
  ${categories} =   Set Variable  Total,FoodAndLiveAnimals,BeveragesAndTobacco,CrudeMaterialAndInedible,MineralFuelLubricantAndRelatedMaterial,AnimalAndVegetableOilFatAndWaxes,ChemicalsAndRelatedProducts,ManufacturedGoods,MachineryAndTransportEquipments,OtherManufacturedArticles,Unclassified
  ${states} =       Set Variable  Total,NSW,WA,SA,ACT,VIC,TAS,QLD,NT

  ${start_date} =   Set Variable  2010-03-24
  ${params} =       Set Variable  startDate=${start_date}&ignoreHeader=True

  ${expected} =     Set Variable  M.3.3.expected.json

  Create API Context
  GET               /${VERSION}/${stats_area}/${categories}/${states}?${params}
  Log               ${API_ENDPOINT}/${VERSION}/${stats_area}/${categories}/${states}?${params}

  Response Status Code Should Equal   200

  ${resp_body} =    Get Response Body
  ${resp_json} =    Parse Json    ${resp_body}
  Log               ${resp_json}
  ${exp_file} =     Get File      expected_outputs/${expected}
  ${exp_json} =     Parse Json    ${exp_file}
  Should Be Equal   ${resp_json}  ${exp_json}


R.3.3 Retail Categories, States and Start Date supplied

  ${stats_area} =   Set Variable  Retail
  ${categories} =   Set Variable  Total,Food,HouseholdGood,ClothingFootwareAndPersonalAccessory,DepartmentStores,CafesRestaurantsAndTakeawayFood,Other
  ${states} =       Set Variable  Total,NSW,WA,SA,ACT,VIC,TAS,QLD,NT

  ${start_date} =   Set Variable  2010-03-24
  ${params} =       Set Variable  startDate=${start_date}&ignoreHeader=True

  ${expected} =     Set Variable  R.3.3.expected.json

  Create API Context
  GET               /${VERSION}/${stats_area}/${categories}/${states}?${params}
  Log               ${API_ENDPOINT}/${VERSION}/${stats_area}/${categories}/${states}?${params}

  Response Status Code Should Equal   200

  ${resp_body} =    Get Response Body
  ${resp_json} =    Parse Json    ${resp_body}
  Log               ${resp_json}
  ${exp_file} =     Get File      expected_outputs/${expected}
  ${exp_json} =     Parse Json    ${exp_file}
  Should Be Equal   ${resp_json}  ${exp_json}












M.3.4 Merch Categories ,States and EndDate supplied
  

  ${stats_area} =   Set Variable  MerchandiseExports
  ${categories} =   Set Variable  Total,FoodAndLiveAnimals,BeveragesAndTobacco,CrudeMaterialAndInedible,MineralFuelLubricantAndRelatedMaterial,AnimalAndVegetableOilFatAndWaxes,ChemicalsAndRelatedProducts,ManufacturedGoods,MachineryAndTransportEquipments,OtherManufacturedArticles,Unclassified
  ${states} =       Set Variable  Total,NSW,WA,SA,ACT,VIC,TAS,QLD,NT

  ${end_date} =     Set Variable  2011-12-19
  ${params} =       Set Variable  endDate=${end_date}&ignoreHeader=True

  ${expected} =     Set Variable  M.3.4.expected.json

  Create API Context
  GET               /${VERSION}/${stats_area}/${categories}/${states}?${params}
  Log               ${API_ENDPOINT}/${VERSION}/${stats_area}/${categories}/${states}?${params}

  Response Status Code Should Equal   200

  ${resp_body} =    Get Response Body
  ${resp_json} =    Parse Json    ${resp_body}
  Log               ${resp_json}
  ${exp_file} =     Get File      expected_outputs/${expected}
  ${exp_json} =     Parse Json    ${exp_file}
  Should Be Equal   ${resp_json}  ${exp_json}


R.3.4 Retail Categories States and EndDate supplied

  ${stats_area} =   Set Variable  Retail
  ${categories} =   Set Variable  Total,Food,HouseholdGood,ClothingFootwareAndPersonalAccessory,DepartmentStores,CafesRestaurantsAndTakeawayFood,Other
  ${states} =       Set Variable  Total,NSW,WA,SA,ACT,VIC,TAS,QLD,NT

  ${end_date} =     Set Variable  2011-12-19
  ${params} =       Set Variable  endDate=${end_date}&ignoreHeader=True

  ${expected} =     Set Variable  R.3.4.expected.json

  Create API Context
  GET               /${VERSION}/${stats_area}/${categories}/${states}?${params}
  Log               ${API_ENDPOINT}/${VERSION}/${stats_area}/${categories}/${states}?${params}

  Response Status Code Should Equal   200

  ${resp_body} =    Get Response Body
  ${resp_json} =    Parse Json    ${resp_body}
  Log               ${resp_json}
  ${exp_file} =     Get File      expected_outputs/${expected}
  ${exp_json} =     Parse Json    ${exp_file}
  Should Be Equal   ${resp_json}  ${exp_json}



M.3.5 Merch Categories, States, Start date and EndDate supplied

  ${stats_area} =   Set Variable  MerchandiseExports
  ${categories} =   Set Variable  Total,FoodAndLiveAnimals,BeveragesAndTobacco,CrudeMaterialAndInedible,MineralFuelLubricantAndRelatedMaterial,AnimalAndVegetableOilFatAndWaxes,ChemicalsAndRelatedProducts,ManufacturedGoods,MachineryAndTransportEquipments,OtherManufacturedArticles,Unclassified
  ${states} =       Set Variable  Total,NSW,WA,SA,ACT,VIC,TAS,QLD,NT

  ${start_date} =   Set Variable  2010-03-24
  ${end_date} =     Set Variable  2012-12-19
  ${params} =       Set Variable  startDate=${start_date}&endDate=${end_date}&ignoreHeader=True

  ${expected} =     Set Variable  M.3.5.expected.json

  Create API Context
  GET               /${VERSION}/${stats_area}/${categories}/${states}?${params}
  Log               ${API_ENDPOINT}/${VERSION}/${stats_area}/${categories}/${states}?${params}

  Response Status Code Should Equal   200

  ${resp_body} =    Get Response Body
  ${resp_json} =    Parse Json    ${resp_body}
  Log               ${resp_json}
  ${exp_file} =     Get File      expected_outputs/${expected}
  ${exp_json} =     Parse Json    ${exp_file}
  Should Be Equal   ${resp_json}  ${exp_json}


R.3.5 Retail Categories, States, Start date and EndDate supplied

  ${stats_area} =   Set Variable  Retail
  ${categories} =   Set Variable  Total,Food,HouseholdGood,ClothingFootwareAndPersonalAccessory,DepartmentStores,CafesRestaurantsAndTakeawayFood,Other
  ${states} =       Set Variable  Total,NSW,WA,SA,ACT,VIC,TAS,QLD,NT

  ${start_date} =   Set Variable  2010-03-24
  ${end_date} =     Set Variable  2012-12-19
  ${params} =       Set Variable  startDate=${start_date}&endDate=${end_date}&ignoreHeader=True

  ${expected} =     Set Variable  R.3.5.expected.json

  Create API Context
  GET               /${VERSION}/${stats_area}/${categories}/${states}?${params}
  Log               ${API_ENDPOINT}/${VERSION}/${stats_area}/${categories}/${states}?${params}

  Response Status Code Should Equal   200

  ${resp_body} =    Get Response Body
  ${resp_json} =    Parse Json    ${resp_body}
  Log               ${resp_json}
  ${exp_file} =     Get File      expected_outputs/${expected}
  ${exp_json} =     Parse Json    ${exp_file}
  Should Be Equal   ${resp_json}  ${exp_json}

M.3.6 Merch Valid Input, StartDate=1994-02-20, EndDate=1996-05-20. Data starts from 1995-07-31

  [Tags]  error 

  ${stats_area} =   Set Variable  MerchandiseExports
  ${categories} =   Set Variable  Total,FoodAndLiveAnimals,BeveragesAndTobacco,CrudeMaterialAndInedible,MineralFuelLubricantAndRelatedMaterial,AnimalAndVegetableOilFatAndWaxes,ChemicalsAndRelatedProducts,ManufacturedGoods,MachineryAndTransportEquipments,OtherManufacturedArticles,Unclassified
  ${states} =       Set Variable  Total,NSW,WA,SA,ACT,VIC,TAS,QLD,NT

  ${start_date} =   Set Variable  1994-02-20
  ${end_date} =     Set Variable  1996-05-20
  ${params} =       Set Variable  startDate=${start_date}&endDate=${end_date}&ignoreHeader=True

  ${expected} =     Set Variable  M.3.6.expected.json

   Create API Context
  GET               /${VERSION}/${stats_area}/${categories}/${states}?${params}
  Log               ${API_ENDPOINT}/${VERSION}/${stats_area}/${categories}/${states}?${params}

  Response Status Code Should Equal   200

  ${resp_body} =    Get Response Body
  ${resp_json} =    Parse Json    ${resp_body}
  Log               ${resp_json}
  ${exp_file} =     Get File      expected_outputs/${expected}
  ${exp_json} =     Parse Json    ${exp_file}
  Should Be Equal   ${resp_json}  ${exp_json}

R.3.6 Retail Valid Input, StartDate=1997-03-02 and EndDate=1996-05-20. Data starts from 1982-04-30

  ${stats_area} =   Set Variable  Retail
  ${categories} =   Set Variable  Total,Food,HouseholdGood,ClothingFootwareAndPersonalAccessory,DepartmentStores,CafesRestaurantsAndTakeawayFood,Other
  ${states} =       Set Variable  Total,NSW,WA,SA,ACT,VIC,TAS,QLD,NT

  ${start_date} =   Set Variable  1972-03-02
  ${end_date} =     Set Variable  1996-05-20
  ${params} =       Set Variable  startDate=${start_date}&endDate=${end_date}&ignoreHeader=True

  ${expected} =     Set Variable  R.3.6.expected.json

  Create API Context
  GET               /${VERSION}/${stats_area}/${categories}/${states}?${params}
  Log               ${API_ENDPOINT}/${VERSION}/${stats_area}/${categories}/${states}?${params}

  Response Status Code Should Equal   200

  ${resp_body} =    Get Response Body
  ${resp_json} =    Parse Json    ${resp_body}
  Log               ${resp_json}
  ${exp_file} =     Get File      expected_outputs/${expected}
  ${exp_json} =     Parse Json    ${exp_file}
  Should Be Equal   ${resp_json}  ${exp_json}

M.E.3.1 Merch Valid Input No Results Found for Tasmania,ACT

  [Tags]  error 

  ${stats_area} =   Set Variable  MerchandiseExports
  ${categories} =   Set Variable  Total,FoodAndLiveAnimals,BeveragesAndTobacco,CrudeMaterialAndInedible,MineralFuelLubricantAndRelatedMaterial,AnimalAndVegetableOilFatAndWaxes,ChemicalsAndRelatedProducts,ManufacturedGoods,MachineryAndTransportEquipments,OtherManufacturedArticles,Unclassified
  ${states} =       Set Variable  Total,NSW,WA,SA,ACT,VIC,TAS,QLD,NT

  ${start_date} =   Set Variable  1990-02-28
  ${end_date} =     Set Variable  1995-05-20
  ${params} =       Set Variable  startDate=${start_date}&endDate=${end_date}&ignoreHeader=True

  ${expected} =     Set Variable  M.E.3.1.expected.json

  Create API Context
  Next Request May Not Succeed
  GET               /${VERSION}/${stats_area}/${categories}/${states}?${params}
  Log               ${API_ENDPOINT}/${VERSION}/${stats_area}/${categories}/${states}?${params}

  Response Status Code Should Equal   404

  ${resp_body} =    Get Response Body
  ${resp_json} =    Parse Json    ${resp_body}
  Log               ${resp_json}
  ${exp_file} =     Get File      expected_outputs/${expected}
  ${exp_json} =     Parse Json    ${exp_file}
  Should Be Equal   ${resp_json}  ${exp_json}


R.E.3.1 Retail Valid input but no results found

  [Tags]  error 

  ${stats_area} =   Set Variable  Retail
  ${categories} =   Set Variable  Total,Food,HouseholdGood,ClothingFootwareAndPersonalAccessory,DepartmentStores,CafesRestaurantsAndTakeawayFood,Other
  ${states} =       Set Variable  Total,NSW,WA,SA,ACT,VIC,TAS,QLD,NT

  ${start_date} =   Set Variable  1972-03-02
  ${end_date} =     Set Variable  1980-05-20
  ${params} =       Set Variable  startDate=${start_date}&endDate=${end_date}&ignoreHeader=True

  ${expected} =     Set Variable  R.E.3.1.expected.json

  Create API Context
  Next Request May Not Succeed
  GET               /${VERSION}/${stats_area}/${categories}/${states}?${params}
  Log               ${API_ENDPOINT}/${VERSION}/${stats_area}/${categories}/${states}?${params}

  Response Status Code Should Equal   404

  ${resp_body} =    Get Response Body
  ${resp_json} =    Parse Json    ${resp_body}
  Log               ${resp_json}
  ${exp_file} =     Get File      expected_outputs/${expected}
  ${exp_json} =     Parse Json    ${exp_file}
  Should Be Equal   ${resp_json}  ${exp_json}
