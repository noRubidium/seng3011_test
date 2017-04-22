# http://45.76.114.158/api/?StatisticsArea=Retail&State=NSW&Category=DepartmentStores&startDate=2013-12-01&endDate=2014-01-01

from locust import HttpLocust, TaskSet, task
import json
import random


VERSION = 'v4'
try:
    f = open('scale_test.config', 'r')
    l = f.readline()
    VERSION = l.split('=')[1]
except (IOError, IndexError):
    pass


CATEGORIES = {
    'Total': '20',
    'Food': '41',
    'HouseholdGood': '42',
    'ClothingFootwareAndPersonalAccessory': '43',
    'DepartmentStores': '44',
    'CafesResturantsAndTakeawayFood': '46',
    'Other': '45'
}

AVAILABLE_CATEGORIES = CATEGORIES.keys()
NUM_CATEGORIES = len(AVAILABLE_CATEGORIES)

STATES = {
    'AUS': '0',
    'NSW': '1',
    'WA': '5',
    'SA': '4',
    'ACT': '8',
    'VIC': '2',
    'TAS': '6',
    'QLD': '3',
    'NT': '7'
}

AVAILABLE_STATES = STATES.keys()
NUM_STATES = len(AVAILABLE_STATES)

COMMODITIES = {
    'Total': '-1',
    'FoodAndLiveAnimals': '0',
    'BeveragesAndTobacco': '1',
    'CrudMaterialAndInedible': '2',
    'MineralFuelLubricentAndRelatedMaterial': '3',
    # 'AnimalAndVegitableOilFatAndWaxes': '4',
    'ChemicalsAndRelatedProducts': '5',
    'ManufacturedGoods': '6',
    'MachineryAndTransportEquipments': '7',
    'OtherManufacturedArticles': '8',
    'Unclassified': '9'
}

AVAILABLE_COMMODITIES = COMMODITIES.keys()
NUM_COMMODITIES = len(AVAILABLE_COMMODITIES)


class UserBehavior(TaskSet):

    @task(9)
    def invalid_state(self):
        url = '/api?StatisticsArea=Retail&Category=Food&State=USA&startDate=2016-01-01&endDate=2016-03-01'
        with self.client.get(url, catch_response=True) as response:
            if response.status_code == 500:
                response.success()
            else:
                response.failure('Expected not found')

    @task(8)
    def invalid_category(self):
        url = '/api?StatisticsArea=Retail&Category=Foodie&State=NSW&startDate=2016-01-01&endDate=2016-03-01'
        with self.client.get(url, catch_response=True) as response:
            if response.status_code == 500:
                response.success()
            else:
                response.failure('Expected not found')

    @task(7)
    def random_query_merch(self):
        commodities = random.sample(AVAILABLE_COMMODITIES, random.randint(1, NUM_COMMODITIES))
        states = random.sample(AVAILABLE_STATES, random.randint(1, NUM_STATES))
        url = '/api?StatisticsArea=MerchandiseExports&Category={com}&State={states}&startDate=2016-03-01&endDate=2017-03-01'\
            .format(com=','.join(commodities), states=','.join(states))
        name = '/{version}/MerchandiseExports/[commodities]/[states]'.format(version=VERSION)
        with self.client.get(url, name=name, catch_response=True) as response:
            # ACT doesn't have merch data
            if response.status_code == 500 and json.loads(response.content)['data']['code'] == 10:
                response.success()

    @task(6)
    def random_query_retail(self):
        cat = random.sample(AVAILABLE_CATEGORIES, random.randint(1, NUM_CATEGORIES))
        states = random.sample(AVAILABLE_STATES, random.randint(1, NUM_STATES))
        url = '/api?StatisticsArea=Retail&Category={cat}&State={states}&startDate=2016-03-01&endDate=2017-03-01'.format(
            version=VERSION, cat=','.join(cat), states=','.join(states))
        name = '/{version}/Retail/[categories]/[states]'.format(version=VERSION)
        with self.client.get(url, name=name, catch_response=True) as response:
            # ACT doesn't have merch data
            if response.status_code == 500 and json.loads(response.content)['data']['code'] == 10:
                response.success()

    @task(5)
    def empty_dates(self):
        pass
        # """
        # Test for invalid dates
        # :return:
        # """
        # url = '/api?StatisticArea=Retail&Category=Food'.format(version=VERSION)
        # self.client.get(url)

    @task(4)
    def invalid_date_range(self):
        """
        Test for invalid dates
        :return: 
        """
        url = '/api?StatisticsArea=Retail&Category=Food&State=NSW&startDate=2017-01-01&endDate=2016-01-01'
        with self.client.get(url, catch_response=True) as response:
            if response.status_code == 500:
                response.success()
            else:
                response.failure('Expected not found')

    @task(3)
    def invalid_dates(self):
        """
        Test for invalid dates
        :return: 
        """
        url = '/api?StatisticsArea=Retail&Category=Food&State=NSW&startDate=2016-02-31&endDate=2016-01-01'
        with self.client.get(url, catch_response=True) as response:
            if response.status_code == 500:
                response.success()
            else:
                response.failure('Expected not found')

    # @task(2)
    # def partial_dates(self):
    #     """
    #     test part of the date
    #     :return:
    #     """
    #     url = '/{version}/Retail/Food?startDate=2016-01-01'.format(version=VERSION)
    #     self.client.get(url)

    @task(1)
    def check_simple_output(self):
        """
        Test actual output of one query
        :return: 
        """
        url = '/api?StatisticsArea=Retail&Category=Food&State=AUS&startDate=2016-01-01&endDate=2016-03-01'
        with self.client.get(url, catch_response=True) as response:
            result = json.loads(response.content)['data']
            try:
                if not len(result['MonthlyRetailData']) == 1:
                    response.failure('Wrong number of categories')
                elif not result['MonthlyRetailData'][0]['RetailIndustry'] == 'Food':
                    response.failure('Wrong category')
                elif not len(result['MonthlyRetailData'][0]['RegionalData']) == 1:
                    response.failure('Wrong number of states')
                elif not result['MonthlyRetailData'][0]['RegionalData'][0]['State'] == 'AUS':
                    response.failure('Wrong state: ' + result['MonthlyRetailData'][0]['RegionalData'][0]['State'])
                elif not len(result['MonthlyRetailData'][0]['RegionalData'][0]['Data']) == 3:
                    response.failure('Wrong number of returns')
                elif not result['MonthlyRetailData'][0]['RegionalData'][0]['Data'][0]['Date'] == '2016-01-31':
                    response.failure('Wrong starting date of returns')
                elif not result['MonthlyRetailData'][0]['RegionalData'][0]['Data'][2]['Date'] == '2016-03-31':
                    response.failure('Wrong ending date of returns')
                elif not result['MonthlyRetailData'][0]['RegionalData'][0]['Data'][2]['Turnover'] == 10354.0:
                    response.failure('Wrong returns data')
            except KeyError as e:
                response.failure('Missing index inside the response!' + str(e))


class WebsiteUser(HttpLocust):
    task_set = UserBehavior
    min_wait = 1000
    max_wait = 3000
