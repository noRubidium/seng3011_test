*** Settings ***
Library                       HttpLibrary.HTTP
Library                       OperatingSystem
Library                       Collections
Test Setup                    Create API Context
 
*** Variables ***
${API_ENDPOINT}               http://45.76.114.158

*** Keywords ***
Create API Context
  Create Http Context         45.76.114.158   http

*** Test Cases ***

TR.M.1.2 Merch All Variables Entire Date Range

	${stats_area} =   Set Variable	MerchandiseExports
	${categories} = 	Set Variable  Total,FoodAndLiveAnimals,BeveragesAndTobacco,CrudMaterialAndInedible,MineralFuelLubricentAndRelatedMaterial,AnimalAndVegitableOilFatAndWaxes,ChemicalsAndRelatedProducts,ManufacturedGoods,MachineryAndTransportEquipments,OtherManufacturedArticles,Unclassified
	${states} =  			Set Variable 	AUS,NSW,WA,SA,ACT,VIC,TAS,QLD,NT

	${start_date} = 	Set Variable 	1995-07-01
	${end_date} = 		Set Variable 	2017-02-01

	${expected} = 		Set Variable  TR.M.1.2.expected.json

  Create API Context
  GET               /api?StatisticsArea=${stats_area}&State=${states}&Category=${categories}&startDate=${start_date}&endDate=${end_date}&pretty=true
  Follow Response
  Log               ${API_ENDPOINT}/api?StatisticsArea=${stats_area}&State=${states}&Category=${categories}&startDate=${start_date}&endDate=${end_date}

  Response Status Code Should Equal   200

  ${resp_body} =      Get Response Body
  ${resp_json} =      Parse Json      ${resp_body}
  Log                 ${resp_json}
  Remove from dictionary   ${resp_json}     header
  Log                 ${resp_json}
  ${exp_file} =       Get File        expected_outputs/${expected}
  ${exp_json} =       Parse Json      ${exp_file}
  Log                 ${exp_json}
  Should Be Equal     ${resp_json}    ${exp_json}


TR.M.1.2 Retail All Variables Entire Date Range

	${stats_area} =   Set Variable	Retail
	${categories} = 	Set Variable  Total,Food,HouseholdGood,ClothingFootwareAndPersonalAccessory,DepartmentStores,CafesResturantsAndTakeawayFood,Other
	${states} =  			Set Variable 	AUS,NSW,WA,SA,ACT,VIC,TAS,QLD,NT

	${start_date} = 	Set Variable 	1995-07-01
	${end_date} = 		Set Variable 	2017-02-01

	${expected} = 		Set Variable  TR.R.1.2.expected.json

  Create API Context
  GET               /api?StatisticsArea=${stats_area}&State=${states}&Category=${categories}&startDate=${start_date}&endDate=${end_date}&pretty=true
  Follow Response
  Log               ${API_ENDPOINT}/api?StatisticsArea=${stats_area}&State=${states}&Category=${categories}&startDate=${start_date}&endDate=${end_date}

  Response Status Code Should Equal   200

  ${resp_body} =      Get Response Body
  ${resp_json} =      Parse Json      ${resp_body}
  Log                 ${resp_json}
  Remove from dictionary   ${resp_json}     header
  Log                 ${resp_json}
  ${exp_file} =       Get File        expected_outputs/${expected}
  ${exp_json} =       Parse Json      ${exp_file}
  Log                 ${exp_json}
  Should Be Equal     ${resp_json}    ${exp_json}




TR.M.E.1.1 Merch Error Incorrect Stats Area

	[Tags]  error 

	${stats_area} =   Set Variable	MerchandiseExport
  ${categories} =   Set Variable  Total,FoodAndLiveAnimals,BeveragesAndTobacco,CrudMaterialAndInedible,MineralFuelLubricentAndRelatedMaterial,AnimalAndVegitableOilFatAndWaxes,ChemicalsAndRelatedProducts,ManufacturedGoods,MachineryAndTransportEquipments,OtherManufacturedArticles,Unclassified
	${states} =  			Set Variable 	AUS,NSW,WA,SA,ACT,VIC,TAS,QLD,NT

	${start_date} = 	Set Variable 	1999-01-01
	${end_date} = 		Set Variable 	2017-01-01

	${expected} = 		Set Variable  TR.M.E.1.1.expected.json

  Create API Context
  GET               /api?StatisticsArea=${stats_area}&State=${states}&Category=${categories}&startDate=${start_date}&endDate=${end_date}&pretty=true
  Follow Response
  Log               ${API_ENDPOINT}/api?StatisticsArea=${stats_area}&State=${states}&Category=${categories}&startDate=${start_date}&endDate=${end_date}

  Response Status Code Should Equal   500

  ${resp_body} =      Get Response Body
  ${resp_json} =      Parse Json      ${resp_body}
  Log                 ${resp_json}
  Remove from dictionary   ${resp_json}     header
  Log                 ${resp_json}
  ${exp_file} =       Get File        expected_outputs/${expected}
  ${exp_json} =       Parse Json      ${exp_file}
  Log                 ${exp_json}
  Should Be Equal     ${resp_json}    ${exp_json}


TR.R.E.1.1 Retail Error Incorrect Stats Area

	[Tags]  error 

	${stats_area} =   Set Variable	Retails
  ${categories} =   Set Variable  Total,Food,HouseholdGood,ClothingFootwareAndPersonalAccessory,DepartmentStores,CafesResturantsAndTakeawayFood,Other
	${states} =  			Set Variable 	AUS,NSW,WA,SA,ACT,VIC,TAS,QLD,NT

	${start_date} = 	Set Variable 	1999-01-01
	${end_date} = 		Set Variable 	2017-01-01

	${expected} = 		Set Variable  TR.R.E.1.1.expected.json

  Create API Context
  GET               /api?StatisticsArea=${stats_area}&State=${states}&Category=${categories}&startDate=${start_date}&endDate=${end_date}&pretty=true
  Follow Response
  Log               ${API_ENDPOINT}/api?StatisticsArea=${stats_area}&State=${states}&Category=${categories}&startDate=${start_date}&endDate=${end_date}

  Response Status Code Should Equal   500

  ${resp_body} =      Get Response Body
  ${resp_json} =      Parse Json      ${resp_body}
  Log                 ${resp_json}
  Remove from dictionary   ${resp_json}     header
  Log                 ${resp_json}
  ${exp_file} =       Get File        expected_outputs/${expected}
  ${exp_json} =       Parse Json      ${exp_file}
  Log                 ${exp_json}
  Should Be Equal     ${resp_json}    ${exp_json}



TR.M.E.1.2 Merch Error Incorrect Commodities

	[Tags]  error 

	${stats_area} =   Set Variable	MerchandiseExports
	${categories} = 	Set Variable  Total,FoodAndLiveAnimals,BeveragesAndTobacco,CrudeMaterialAndInedible,MineralFuelLubricantAndRelatedMaterial,AnimalAndVegetableOilFat,,
	${states} =  			Set Variable 	AUS,NSW,WA,SA,ACT,VIC,TAS,QLD,NT

	${start_date} = 	Set Variable 	1999-01-01
	${end_date} = 		Set Variable 	2017-01-01

	${expected} = 		Set Variable  TR.M.E.1.2.expected.json

  Create API Context
  GET               /api?StatisticsArea=${stats_area}&State=${states}&Category=${categories}&startDate=${start_date}&endDate=${end_date}&pretty=true
  Follow Response
  Log               ${API_ENDPOINT}/api?StatisticsArea=${stats_area}&State=${states}&Category=${categories}&startDate=${start_date}&endDate=${end_date}

  Response Status Code Should Equal   500

  ${resp_body} =      Get Response Body
  ${resp_json} =      Parse Json      ${resp_body}
  Log                 ${resp_json}
  Remove from dictionary   ${resp_json}     header
  Log                 ${resp_json}
  ${exp_file} =       Get File        expected_outputs/${expected}
  ${exp_json} =       Parse Json      ${exp_file}
  Log                 ${exp_json}
  Should Be Equal     ${resp_json}    ${exp_json}


TR.R.E.1.2 Retail Error Incorrect Categories

	[Tags]  error 

	${stats_area} =   Set Variable	Retail
	${categories} = 	Set Variable  Total,Food,HouseholdGood,ClothingAccessory,DepartmentStores,CafesRestaurantsAndTakeawayFood,Other
	${states} =  			Set Variable 	AUS,NSW,WA,SA,ACT,VIC,TAS,QLD,NT

	${start_date} = 	Set Variable 	1999-01-01
	${end_date} = 		Set Variable 	2017-01-01

	${expected} = 		Set Variable  TR.R.E.1.2.expected.json

  Create API Context
  GET               /api?StatisticsArea=${stats_area}&State=${states}&Category=${categories}&startDate=${start_date}&endDate=${end_date}&pretty=true
  Follow Response
  Log               ${API_ENDPOINT}/api?StatisticsArea=${stats_area}&State=${states}&Category=${categories}&startDate=${start_date}&endDate=${end_date}

  Response Status Code Should Equal   500

  ${resp_body} =      Get Response Body
  ${resp_json} =      Parse Json      ${resp_body}
  Log                 ${resp_json}
  Remove from dictionary   ${resp_json}     header
  Log                 ${resp_json}
  ${exp_file} =       Get File        expected_outputs/${expected}
  ${exp_json} =       Parse Json      ${exp_file}
  Log                 ${exp_json}
  Should Be Equal     ${resp_json}    ${exp_json}



TR.M.E.1.3 Merch Error Incorrect States

	[Tags]  error 

	${stats_area} =   Set Variable	MerchandiseExports
  ${categories} =   Set Variable  Total,FoodAndLiveAnimals,BeveragesAndTobacco,CrudMaterialAndInedible,MineralFuelLubricentAndRelatedMaterial,AnimalAndVegitableOilFatAndWaxes,ChemicalsAndRelatedProducts,ManufacturedGoods,MachineryAndTransportEquipments,OtherManufacturedArticles,Unclassified
	${states} =  			Set Variable 	NZ,WA

	${start_date} = 	Set Variable 	1999-01-01
	${end_date} = 		Set Variable 	2017-01-01
	${params} =  			Set Variable  startDate=${start_date}&endDate=${end_date}&ignoreHeader=True

	${expected} = 		Set Variable  TR.M.E.1.3.expected.json

  Create API Context
  GET               /api?StatisticsArea=${stats_area}&State=${states}&Category=${categories}&startDate=${start_date}&endDate=${end_date}&pretty=true
  Follow Response
  Log               ${API_ENDPOINT}/api?StatisticsArea=${stats_area}&State=${states}&Category=${categories}&startDate=${start_date}&endDate=${end_date}

  Response Status Code Should Equal   500

  ${resp_body} =      Get Response Body
  ${resp_json} =      Parse Json      ${resp_body}
  Log                 ${resp_json}
  Remove from dictionary   ${resp_json}     header
  Log                 ${resp_json}
  ${exp_file} =       Get File        expected_outputs/${expected}
  ${exp_json} =       Parse Json      ${exp_file}
  Log                 ${exp_json}
  Should Be Equal     ${resp_json}    ${exp_json}


TR.R.E.1.3 Retail Error Incorrect States

	[Tags]  error 

	${stats_area} =   Set Variable	Retail
  ${categories} =   Set Variable  Total,Food,HouseholdGood,ClothingFootwareAndPersonalAccessory,DepartmentStores,CafesResturantsAndTakeawayFood,Other
	${states} =  			Set Variable 	NZ,WA

	${start_date} = 	Set Variable 	1999-01-01
	${end_date} = 		Set Variable 	2017-01-01
	${params} =  			Set Variable  startDate=${start_date}&endDate=${end_date}&ignoreHeader=True

	${expected} = 		Set Variable  TR.R.E.1.3.expected.json

  Create API Context
  GET               /api?StatisticsArea=${stats_area}&State=${states}&Category=${categories}&startDate=${start_date}&endDate=${end_date}&pretty=true
  Follow Response
  Log               ${API_ENDPOINT}/api?StatisticsArea=${stats_area}&State=${states}&Category=${categories}&startDate=${start_date}&endDate=${end_date}

  Response Status Code Should Equal   500

  ${resp_body} =      Get Response Body
  ${resp_json} =      Parse Json      ${resp_body}
  Log                 ${resp_json}
  Remove from dictionary   ${resp_json}     header
  Log                 ${resp_json}
  ${exp_file} =       Get File        expected_outputs/${expected}
  ${exp_json} =       Parse Json      ${exp_file}
  Log                 ${exp_json}
  Should Be Equal     ${resp_json}    ${exp_json}









TR.M.E.2.1 Merch Error EndDate before StartDate

	[Tags]  error 

	${stats_area} =   Set Variable	MerchandiseExports
  ${categories} =   Set Variable  Total,FoodAndLiveAnimals,BeveragesAndTobacco,CrudMaterialAndInedible,MineralFuelLubricentAndRelatedMaterial,AnimalAndVegitableOilFatAndWaxes,ChemicalsAndRelatedProducts,ManufacturedGoods,MachineryAndTransportEquipments,OtherManufacturedArticles,Unclassified
	${states} =  			Set Variable 	AUS,NSW,WA,SA,ACT,VIC,TAS,QLD,NT

	${start_date} = 	Set Variable 	2010-03-24
	${end_date} = 		Set Variable 	1999-12-19

	${expected} = 		Set Variable  TR.M.E.2.1.expected.json

  Create API Context
  GET               /api?StatisticsArea=${stats_area}&State=${states}&Category=${categories}&startDate=${start_date}&endDate=${end_date}&pretty=true
  Follow Response
  Log               ${API_ENDPOINT}/api?StatisticsArea=${stats_area}&State=${states}&Category=${categories}&startDate=${start_date}&endDate=${end_date}

  Response Status Code Should Equal   500

  ${resp_body} =      Get Response Body
  ${resp_json} =      Parse Json      ${resp_body}
  Log                 ${resp_json}
  Remove from dictionary   ${resp_json}     header
  Log                 ${resp_json}
  ${exp_file} =       Get File        expected_outputs/${expected}
  ${exp_json} =       Parse Json      ${exp_file}
  Log                 ${exp_json}
  Should Be Equal     ${resp_json}    ${exp_json}


TR.R.E.2.1 Retail Error EndDate before StartDate

	[Tags]  error 

	${stats_area} =   Set Variable	Retail
  ${categories} =   Set Variable  Total,Food,HouseholdGood,ClothingFootwareAndPersonalAccessory,DepartmentStores,CafesResturantsAndTakeawayFood,Other
	${states} =  			Set Variable 	AUS,NSW,WA,SA,ACT,VIC,TAS,QLD,NT

	${start_date} = 	Set Variable 	2010-03-24
	${end_date} = 		Set Variable 	1999-12-19
	${params} =  			Set Variable  startDate=${start_date}&endDate=${end_date}&ignoreHeader=True

	${expected} = 		Set Variable  TR.R.E.2.1.expected.json

  Create API Context
  GET               /api?StatisticsArea=${stats_area}&State=${states}&Category=${categories}&startDate=${start_date}&endDate=${end_date}&pretty=true
  Follow Response
  Log               ${API_ENDPOINT}/api?StatisticsArea=${stats_area}&State=${states}&Category=${categories}&startDate=${start_date}&endDate=${end_date}

  Response Status Code Should Equal   500

  ${resp_body} =      Get Response Body
  ${resp_json} =      Parse Json      ${resp_body}
  Log                 ${resp_json}
  Remove from dictionary   ${resp_json}     header
  Log                 ${resp_json}
  ${exp_file} =       Get File        expected_outputs/${expected}
  ${exp_json} =       Parse Json      ${exp_file}
  Log                 ${exp_json}
  Should Be Equal     ${resp_json}    ${exp_json}


TR.M.E.2.2 Merch Error Invalid start date not in YYYY-MM-DD format

  [Tags]  error 

  ${stats_area} =   Set Variable  MerchandiseExports
  ${categories} =   Set Variable  Total,FoodAndLiveAnimals,BeveragesAndTobacco,CrudMaterialAndInedible,MineralFuelLubricentAndRelatedMaterial,AnimalAndVegitableOilFatAndWaxes,ChemicalsAndRelatedProducts,ManufacturedGoods,MachineryAndTransportEquipments,OtherManufacturedArticles,Unclassified
  ${states} =       Set Variable  AUS,NSW,WA,SA,ACT,VIC,TAS,QLD,NT

  ${start_date} =   Set Variable  2010-324
  ${end_date} =     Set Variable  2011-12-19

  ${expected} =     Set Variable  TR.M.E.2.2.expected.json

  Create API Context
  GET               /api?StatisticsArea=${stats_area}&State=${states}&Category=${categories}&startDate=${start_date}&endDate=${end_date}&pretty=true
  Follow Response
  Log               ${API_ENDPOINT}/api?StatisticsArea=${stats_area}&State=${states}&Category=${categories}&startDate=${start_date}&endDate=${end_date}

  Response Status Code Should Equal   500

  ${resp_body} =      Get Response Body
  ${resp_json} =      Parse Json      ${resp_body}
  Log                 ${resp_json}
  Remove from dictionary   ${resp_json}     header
  Log                 ${resp_json}
  ${exp_file} =       Get File        expected_outputs/${expected}
  ${exp_json} =       Parse Json      ${exp_file}
  Log                 ${exp_json}
  Should Be Equal     ${resp_json}    ${exp_json}

TR.R.E.2.2 Retail Error Invalid start date not in YYYY-MM-DD format

  [Tags]  error 

  ${stats_area} =   Set Variable  Retail
  ${categories} =   Set Variable  Total,Food,HouseholdGood,ClothingFootwareAndPersonalAccessory,DepartmentStores,CafesResturantsAndTakeawayFood,Other
  ${states} =       Set Variable  AUS,NSW,WA,SA,ACT,VIC,TAS,QLD,NT

  ${start_date} =   Set Variable  2010-324
  ${end_date} =     Set Variable  2011-12-19

  ${expected} =     Set Variable  TR.R.E.2.2.expected.json

  Create API Context
  GET               /api?StatisticsArea=${stats_area}&State=${states}&Category=${categories}&startDate=${start_date}&endDate=${end_date}&pretty=true
  Follow Response
  Log               ${API_ENDPOINT}/api?StatisticsArea=${stats_area}&State=${states}&Category=${categories}&startDate=${start_date}&endDate=${end_date}

  Response Status Code Should Equal   500

  ${resp_body} =      Get Response Body
  ${resp_json} =      Parse Json      ${resp_body}
  Log                 ${resp_json}
  Remove from dictionary   ${resp_json}     header
  Log                 ${resp_json}
  ${exp_file} =       Get File        expected_outputs/${expected}
  ${exp_json} =       Parse Json      ${exp_file}
  Log                 ${exp_json}
  Should Be Equal     ${resp_json}    ${exp_json}
  Should Be Equal   ${resp_json}  ${exp_json}




TR.M.E.2.3 Merch Error Invalid End date not in YYYY-MM-DD format

  [Tags]  error 

  ${stats_area} =   Set Variable  MerchandiseExports
  ${categories} =   Set Variable  Total,FoodAndLiveAnimals,BeveragesAndTobacco,CrudMaterialAndInedible,MineralFuelLubricentAndRelatedMaterial,AnimalAndVegitableOilFatAndWaxes,ChemicalsAndRelatedProducts,ManufacturedGoods,MachineryAndTransportEquipments,OtherManufacturedArticles,Unclassified
  ${states} =       Set Variable  AUS,NSW,WA,SA,ACT,VIC,TAS,QLD,NT

  ${start_date} =   Set Variable  2010-03-24
  ${end_date} =     Set Variable  201-12-10

  ${expected} =     Set Variable  TR.M.E.2.3.expected.json

  Create API Context
  GET               /api?StatisticsArea=${stats_area}&State=${states}&Category=${categories}&startDate=${start_date}&endDate=${end_date}&pretty=true
  Follow Response
  Log               ${API_ENDPOINT}/api?StatisticsArea=${stats_area}&State=${states}&Category=${categories}&startDate=${start_date}&endDate=${end_date}

  Response Status Code Should Equal   500

  ${resp_body} =      Get Response Body
  ${resp_json} =      Parse Json      ${resp_body}
  Log                 ${resp_json}
  Remove from dictionary   ${resp_json}     header
  Log                 ${resp_json}
  ${exp_file} =       Get File        expected_outputs/${expected}
  ${exp_json} =       Parse Json      ${exp_file}
  Log                 ${exp_json}
  Should Be Equal     ${resp_json}    ${exp_json}


TR.R.E.2.3 Retail Error Invalid End date not in YYYY-MM-DD format

  [Tags]  error 

  ${stats_area} =   Set Variable  Retail
  ${categories} =   Set Variable  Total,Food,HouseholdGood,ClothingFootwareAndPersonalAccessory,DepartmentStores,CafesResturantsAndTakeawayFood,Other
  ${states} =       Set Variable  AUS,NSW,WA,SA,ACT,VIC,TAS,QLD,NT

  ${start_date} =   Set Variable  2010-03-24
  ${end_date} =     Set Variable  201-12-10
  ${params} =       Set Variable  startDate=${start_date}&endDate=${end_date}&ignoreHeader=True

  ${expected} =     Set Variable  TR.R.E.2.3.expected.json

  Create API Context
  GET               /api?StatisticsArea=${stats_area}&State=${states}&Category=${categories}&startDate=${start_date}&endDate=${end_date}&pretty=true
  Follow Response
  Log               ${API_ENDPOINT}/api?StatisticsArea=${stats_area}&State=${states}&Category=${categories}&startDate=${start_date}&endDate=${end_date}

  Response Status Code Should Equal   500

  ${resp_body} =      Get Response Body
  ${resp_json} =      Parse Json      ${resp_body}
  Log                 ${resp_json}
  Remove from dictionary   ${resp_json}     header
  Log                 ${resp_json}
  ${exp_file} =       Get File        expected_outputs/${expected}
  ${exp_json} =       Parse Json      ${exp_file}
  Log                 ${exp_json}
  Should Be Equal     ${resp_json}    ${exp_json}


TR.M.E.2.4 Merch Error Start date after current Date

  [Tags]  error 

  ${stats_area} =   Set Variable  MerchandiseExports
  ${categories} =   Set Variable  Total,FoodAndLiveAnimals,BeveragesAndTobacco,CrudMaterialAndInedible,MineralFuelLubricentAndRelatedMaterial,AnimalAndVegitableOilFatAndWaxes,ChemicalsAndRelatedProducts,ManufacturedGoods,MachineryAndTransportEquipments,OtherManufacturedArticles,Unclassified
  ${states} =       Set Variable  AUS,NSW,WA,SA,ACT,VIC,TAS,QLD,NT

  ${start_date} =   Set Variable  2018-03-24
  ${end_date} =     Set Variable  2018-09-24

  ${expected} =     Set Variable  TR.M.E.2.4.expected.json

  Create API Context
  GET               /api?StatisticsArea=${stats_area}&State=${states}&Category=${categories}&startDate=${start_date}&endDate=${end_date}&pretty=true
  Follow Response
  Log               ${API_ENDPOINT}/api?StatisticsArea=${stats_area}&State=${states}&Category=${categories}&startDate=${start_date}&endDate=${end_date}

  Response Status Code Should Equal   500

  ${resp_body} =      Get Response Body
  ${resp_json} =      Parse Json      ${resp_body}
  Log                 ${resp_json}
  Remove from dictionary   ${resp_json}     header
  Log                 ${resp_json}
  ${exp_file} =       Get File        expected_outputs/${expected}
  ${exp_json} =       Parse Json      ${exp_file}
  Log                 ${exp_json}
  Should Be Equal     ${resp_json}    ${exp_json}

TR.R.E.2.4 Retail Error Start date after current Date

  [Tags]  error 

  ${stats_area} =   Set Variable  Retail
  ${categories} =   Set Variable  Total,Food,HouseholdGood,ClothingFootwareAndPersonalAccessory,DepartmentStores,CafesResturantsAndTakeawayFood,Other
  ${states} =       Set Variable  AUS,NSW,WA,SA,ACT,VIC,TAS,QLD,NT

  ${start_date} =   Set Variable  2018-03-24
  ${end_date} =     Set Variable  2018-09-24

  ${expected} =     Set Variable  TR.R.E.2.4.expected.json

  Create API Context
  GET               /api?StatisticsArea=${stats_area}&State=${states}&Category=${categories}&startDate=${start_date}&endDate=${end_date}&pretty=true
  Follow Response
  Log               ${API_ENDPOINT}/api?StatisticsArea=${stats_area}&State=${states}&Category=${categories}&startDate=${start_date}&endDate=${end_date}

  Response Status Code Should Equal   500

  ${resp_body} =      Get Response Body
  ${resp_json} =      Parse Json      ${resp_body}
  Log                 ${resp_json}
  Remove from dictionary   ${resp_json}     header
  Log                 ${resp_json}
  ${exp_file} =       Get File        expected_outputs/${expected}
  ${exp_json} =       Parse Json      ${exp_file}
  Log                 ${exp_json}
  Should Be Equal     ${resp_json}    ${exp_json}

TR.M.E.2.5 Merch Error Date Day nonexistant "2011-15-19"

  [Tags]  error 

  ${stats_area} =   Set Variable  MerchandiseExports
  ${categories} =   Set Variable  Total,FoodAndLiveAnimals,BeveragesAndTobacco,CrudMaterialAndInedible,MineralFuelLubricentAndRelatedMaterial,AnimalAndVegitableOilFatAndWaxes,ChemicalsAndRelatedProducts,ManufacturedGoods,MachineryAndTransportEquipments,OtherManufacturedArticles,Unclassified
  ${states} =       Set Variable  AUS,NSW,WA,SA,ACT,VIC,TAS,QLD,NT

  ${start_date} =   Set Variable  2010-03-24
  ${end_date} =     Set Variable  2011-15-19

  ${expected} =     Set Variable  TR.M.E.2.5.expected.json

  Create API Context
  GET               /api?StatisticsArea=${stats_area}&State=${states}&Category=${categories}&startDate=${start_date}&endDate=${end_date}&pretty=true
  Follow Response
  Log               ${API_ENDPOINT}/api?StatisticsArea=${stats_area}&State=${states}&Category=${categories}&startDate=${start_date}&endDate=${end_date}

  Response Status Code Should Equal   500

  ${resp_body} =      Get Response Body
  ${resp_json} =      Parse Json      ${resp_body}
  Log                 ${resp_json}
  Remove from dictionary   ${resp_json}     header
  Log                 ${resp_json}
  ${exp_file} =       Get File        expected_outputs/${expected}
  ${exp_json} =       Parse Json      ${exp_file}
  Log                 ${exp_json}
  Should Be Equal     ${resp_json}    ${exp_json}


TR.R.E.2.5 Retail Error Date nonexistant "2011-12-32"

  [Tags]  error 

  ${stats_area} =   Set Variable  Retail
  ${categories} =   Set Variable  Total,Food,HouseholdGood,ClothingFootwareAndPersonalAccessory,DepartmentStores,CafesResturantsAndTakeawayFood,Other
  ${states} =       Set Variable  AUS,NSW,WA,SA,ACT,VIC,TAS,QLD,NT

  ${start_date} =   Set Variable  2010-03-24
  ${end_date} =     Set Variable  2011-12-32

  ${expected} =     Set Variable  TR.R.E.2.5.expected.json

  Create API Context
  GET               /api?StatisticsArea=${stats_area}&State=${states}&Category=${categories}&startDate=${start_date}&endDate=${end_date}&pretty=true
  Follow Response
  Log               ${API_ENDPOINT}/api?StatisticsArea=${stats_area}&State=${states}&Category=${categories}&startDate=${start_date}&endDate=${end_date}

  Response Status Code Should Equal   500

  ${resp_body} =      Get Response Body
  ${resp_json} =      Parse Json      ${resp_body}
  Log                 ${resp_json}
  Remove from dictionary   ${resp_json}     header
  Log                 ${resp_json}
  ${exp_file} =       Get File        expected_outputs/${expected}
  ${exp_json} =       Parse Json      ${exp_file}
  Log                 ${exp_json}
  Should Be Equal     ${resp_json}    ${exp_json}

TR.M.E.2.6 Merch Error 29th Feb, non leap year "2013-02-29"

  [Tags]  error 

  ${stats_area} =   Set Variable  MerchandiseExports
  ${categories} =   Set Variable  Total,FoodAndLiveAnimals,BeveragesAndTobacco,CrudMaterialAndInedible,MineralFuelLubricentAndRelatedMaterial,AnimalAndVegitableOilFatAndWaxes,ChemicalsAndRelatedProducts,ManufacturedGoods,MachineryAndTransportEquipments,OtherManufacturedArticles,Unclassified
  ${states} =       Set Variable  AUS,NSW,WA,SA,ACT,VIC,TAS,QLD,NT

  ${start_date} =   Set Variable  2011-02-28
  ${end_date} =     Set Variable  2013-02-29

  ${expected} =     Set Variable  TR.M.E.2.6.expected.json

  Create API Context
  GET               /api?StatisticsArea=${stats_area}&State=${states}&Category=${categories}&startDate=${start_date}&endDate=${end_date}&pretty=true
  Follow Response
  Log               ${API_ENDPOINT}/api?StatisticsArea=${stats_area}&State=${states}&Category=${categories}&startDate=${start_date}&endDate=${end_date}

  Response Status Code Should Equal   500

  ${resp_body} =      Get Response Body
  ${resp_json} =      Parse Json      ${resp_body}
  Log                 ${resp_json}
  Remove from dictionary   ${resp_json}     header
  Log                 ${resp_json}
  ${exp_file} =       Get File        expected_outputs/${expected}
  ${exp_json} =       Parse Json      ${exp_file}
  Log                 ${exp_json}
  Should Be Equal     ${resp_json}    ${exp_json}


TR.R.E.2.6 Retail Error 29th Feb, non leap year "2011-02-29"

  [Tags]  error 

  ${stats_area} =   Set Variable  Retail
  ${categories} =   Set Variable  Total,Food,HouseholdGood,ClothingFootwareAndPersonalAccessory,DepartmentStores,CafesResturantsAndTakeawayFood,Other
  ${states} =       Set Variable  AUS,NSW,WA,SA,ACT,VIC,TAS,QLD,NT

  ${start_date} =   Set Variable  2011-02-29
  ${end_date} =     Set Variable  2011-12-19

  ${expected} =     Set Variable  TR.R.E.2.6.expected.json

  Create API Context
  GET               /api?StatisticsArea=${stats_area}&State=${states}&Category=${categories}&startDate=${start_date}&endDate=${end_date}&pretty=true
  Follow Response
  Log               ${API_ENDPOINT}/api?StatisticsArea=${stats_area}&State=${states}&Category=${categories}&startDate=${start_date}&endDate=${end_date}

  Response Status Code Should Equal   500

  ${resp_body} =      Get Response Body
  ${resp_json} =      Parse Json      ${resp_body}
  Log                 ${resp_json}
  Remove from dictionary   ${resp_json}     header
  Log                 ${resp_json}
  ${exp_file} =       Get File        expected_outputs/${expected}
  ${exp_json} =       Parse Json      ${exp_file}
  Log                 ${exp_json}
  Should Be Equal     ${resp_json}    ${exp_json}






TR.M.3.5 Merch Categories, States, Start date and EndDate supplied

  ${stats_area} =   Set Variable  MerchandiseExports
  ${categories} =   Set Variable  Total,FoodAndLiveAnimals,BeveragesAndTobacco,CrudMaterialAndInedible,MineralFuelLubricentAndRelatedMaterial,AnimalAndVegitableOilFatAndWaxes,ChemicalsAndRelatedProducts,ManufacturedGoods,MachineryAndTransportEquipments,OtherManufacturedArticles,Unclassified
  ${states} =       Set Variable  AUS,NSW,WA,SA,ACT,VIC,TAS,QLD,NT

  ${start_date} =   Set Variable  2010-03-24
  ${end_date} =     Set Variable  2012-12-19

  ${expected} =     Set Variable  TR.M.3.5.expected.json

  Create API Context
  GET               /api?StatisticsArea=${stats_area}&State=${states}&Category=${categories}&startDate=${start_date}&endDate=${end_date}&pretty=true
  Follow Response
  Log               ${API_ENDPOINT}/api?StatisticsArea=${stats_area}&State=${states}&Category=${categories}&startDate=${start_date}&endDate=${end_date}

  Response Status Code Should Equal   200

  ${resp_body} =      Get Response Body
  ${resp_json} =      Parse Json      ${resp_body}
  Log                 ${resp_json}
  Remove from dictionary   ${resp_json}     header
  Log                 ${resp_json}
  ${exp_file} =       Get File        expected_outputs/${expected}
  ${exp_json} =       Parse Json      ${exp_file}
  Log                 ${exp_json}
  Should Be Equal     ${resp_json}    ${exp_json}


TR.R.3.5 Retail Categories, States, Start date and EndDate supplied

  ${stats_area} =   Set Variable  Retail
  ${categories} =   Set Variable  Total,Food,HouseholdGood,ClothingFootwareAndPersonalAccessory,DepartmentStores,CafesResturantsAndTakeawayFood,Other
  ${states} =       Set Variable  AUS,NSW,WA,SA,ACT,VIC,TAS,QLD,NT

  ${start_date} =   Set Variable  2010-03-24
  ${end_date} =     Set Variable  2012-12-19

  ${expected} =     Set Variable  TR.R.3.5.expected.json

  Create API Context
  GET               /api?StatisticsArea=${stats_area}&State=${states}&Category=${categories}&startDate=${start_date}&endDate=${end_date}&pretty=true
  Follow Response
  Log               ${API_ENDPOINT}/api?StatisticsArea=${stats_area}&State=${states}&Category=${categories}&startDate=${start_date}&endDate=${end_date}

  Response Status Code Should Equal   200

  ${resp_body} =      Get Response Body
  ${resp_json} =      Parse Json      ${resp_body}
  Log                 ${resp_json}
  Remove from dictionary   ${resp_json}     header
  Log                 ${resp_json}
  ${exp_file} =       Get File        expected_outputs/${expected}
  ${exp_json} =       Parse Json      ${exp_file}
  Log                 ${exp_json}
  Should Be Equal     ${resp_json}    ${exp_json}

TR.M.3.6 Merch Valid Input, StartDate=1994-02-20, EndDate=1996-05-20. Data starts from 1995-07-31

  [Tags]  error 

  ${stats_area} =   Set Variable  MerchandiseExports
  ${categories} =   Set Variable  Total,FoodAndLiveAnimals,BeveragesAndTobacco,CrudMaterialAndInedible,MineralFuelLubricentAndRelatedMaterial,AnimalAndVegitableOilFatAndWaxes,ChemicalsAndRelatedProducts,ManufacturedGoods,MachineryAndTransportEquipments,OtherManufacturedArticles,Unclassified
  ${states} =       Set Variable  AUS,NSW,WA,SA,ACT,VIC,TAS,QLD,NT

  ${start_date} =   Set Variable  1994-02-20
  ${end_date} =     Set Variable  1996-05-20
  ${params} =       Set Variable  startDate=${start_date}&endDate=${end_date}&ignoreHeader=True

  ${expected} =     Set Variable  TR.M.3.6.expected.json

  Create API Context
  GET               /api?StatisticsArea=${stats_area}&State=${states}&Category=${categories}&startDate=${start_date}&endDate=${end_date}&pretty=true
  Follow Response
  Log               ${API_ENDPOINT}/api?StatisticsArea=${stats_area}&State=${states}&Category=${categories}&startDate=${start_date}&endDate=${end_date}

  Response Status Code Should Equal   200

  ${resp_body} =      Get Response Body
  ${resp_json} =      Parse Json      ${resp_body}
  Log                 ${resp_json}
  Remove from dictionary   ${resp_json}     header
  Log                 ${resp_json}
  ${exp_file} =       Get File        expected_outputs/${expected}
  ${exp_json} =       Parse Json      ${exp_file}
  Log                 ${exp_json}
  Should Be Equal     ${resp_json}    ${exp_json}

TR.R.3.6 Retail Valid Input, StartDate=1997-03-02 and EndDate=1996-05-20. Data starts from 1982-04-30

  ${stats_area} =   Set Variable  Retail
  ${categories} =   Set Variable  Total,Food,HouseholdGood,ClothingFootwareAndPersonalAccessory,DepartmentStores,CafesResturantsAndTakeawayFood,Other
  ${states} =       Set Variable  AUS,NSW,WA,SA,ACT,VIC,TAS,QLD,NT

  ${start_date} =   Set Variable  1972-03-02
  ${end_date} =     Set Variable  1996-05-20
  ${params} =       Set Variable  startDate=${start_date}&endDate=${end_date}&ignoreHeader=True

  ${expected} =     Set Variable  TR.R.3.6.expected.json

  Create API Context
  GET               /api?StatisticsArea=${stats_area}&State=${states}&Category=${categories}&startDate=${start_date}&endDate=${end_date}&pretty=true
  Follow Response
  Log               ${API_ENDPOINT}/api?StatisticsArea=${stats_area}&State=${states}&Category=${categories}&startDate=${start_date}&endDate=${end_date}

  Response Status Code Should Equal   200

  ${resp_body} =      Get Response Body
  ${resp_json} =      Parse Json      ${resp_body}
  Log                 ${resp_json}
  Remove from dictionary   ${resp_json}     header
  Log                 ${resp_json}
  ${exp_file} =       Get File        expected_outputs/${expected}
  ${exp_json} =       Parse Json      ${exp_file}
  Log                 ${exp_json}
  Should Be Equal     ${resp_json}    ${exp_json}

TR.M.E.3.1 Merch Valid Input But No Results Found (for Tasmania,ACT)

  [Tags]  error 

  ${stats_area} =   Set Variable  MerchandiseExports
  ${categories} =   Set Variable  Total,FoodAndLiveAnimals,BeveragesAndTobacco,CrudMaterialAndInedible,MineralFuelLubricentAndRelatedMaterial,AnimalAndVegitableOilFatAndWaxes,ChemicalsAndRelatedProducts,ManufacturedGoods,MachineryAndTransportEquipments,OtherManufacturedArticles,Unclassified
  ${states} =       Set Variable  AUS,NSW,WA,SA,ACT,VIC,TAS,QLD,NT

  ${start_date} =   Set Variable  1990-02-28
  ${end_date} =     Set Variable  1995-05-20
  ${params} =       Set Variable  startDate=${start_date}&endDate=${end_date}&ignoreHeader=True

  ${expected} =     Set Variable  TR.M.E.3.1.expected.json

  Create API Context
  GET               /api?StatisticsArea=${stats_area}&State=${states}&Category=${categories}&startDate=${start_date}&endDate=${end_date}&pretty=true
  Follow Response
  Log               ${API_ENDPOINT}/api?StatisticsArea=${stats_area}&State=${states}&Category=${categories}&startDate=${start_date}&endDate=${end_date}

  Response Status Code Should Equal   500

  ${resp_body} =      Get Response Body
  ${resp_json} =      Parse Json      ${resp_body}
  Log                 ${resp_json}
  Remove from dictionary   ${resp_json}     header
  Log                 ${resp_json}
  ${exp_file} =       Get File        expected_outputs/${expected}
  ${exp_json} =       Parse Json      ${exp_file}
  Log                 ${exp_json}
  Should Be Equal     ${resp_json}    ${exp_json}
