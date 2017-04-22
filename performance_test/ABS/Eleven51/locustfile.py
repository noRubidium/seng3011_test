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
    'CafesRestaurantsAndTakeawayFood': '46',
    'Other': '45'
}

AVAILABLE_CATEGORIES = CATEGORIES.keys()
NUM_CATEGORIES = len(AVAILABLE_CATEGORIES)

STATES = {
    'Total': '-',
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
    'CrudeMaterialAndInedible': '2',
    'MineralFuelLubricantAndRelatedMaterial': '3',
    'AnimalAndVegetableOilFatAndWaxes': '4',
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
        url = '/{version}/Retail/Food/USA'.format(version=VERSION)
        with self.client.get(url, catch_response=True) as response:
            if response.status_code == 404:
                response.success()
            else:
                response.failure('Expected not found')

    @task(8)
    def invalid_category(self):
        url = '/{version}/Retail/Foodie'.format(version=VERSION)
        with self.client.get(url, catch_response=True) as response:
            if response.status_code == 404:
                response.success()
            else:
                response.failure('Expected not found')

    @task(7)
    def random_query_merch(self):
        commodities = random.sample(AVAILABLE_COMMODITIES, random.randint(1, NUM_COMMODITIES))
        states = random.sample(AVAILABLE_STATES, random.randint(0, NUM_STATES))
        url = '/{version}/MerchandiseExports/{com}/{states}'.format(version=VERSION, com=','.join(commodities), states=','.join(states))
        name = '/{version}/MerchandiseExports/[commodities]/[states]'.format(version=VERSION)
        with self.client.get(url, name=name, catch_response=True) as response:
            # ACT doesn't have merch data
            if len(states) == 1 and states[0] == 'ACT' and response.status_code == 404:
                response.success()

    @task(6)
    def random_query_retail(self):
        cat = random.sample(AVAILABLE_CATEGORIES, random.randint(1, NUM_CATEGORIES))
        states = random.sample(AVAILABLE_STATES, random.randint(0, NUM_STATES))
        url = '/{version}/Retail/{cat}/{states}'.format(version=VERSION, cat=','.join(cat),
                                                                   states=','.join(states))
        self.client.get(url, name='/{version}/Retail/[categories]/[states]'.format(version=VERSION))

    @task(5)
    def empty_dates(self):
        """
        Test for invalid dates
        :return: 
        """
        url = '/{version}/Retail/Food'.format(version=VERSION)
        self.client.get(url)

    @task(4)
    def invalid_date_range(self):
        """
        Test for invalid dates
        :return: 
        """
        url = '/{version}/Retail/Food?startDate=2017-01-01&endDate=2016-01-01'.format(version=VERSION)
        with self.client.get(url, catch_response=True) as response:
            if response.status_code == 404:
                response.success()
            else:
                response.failure('Expected not found')

    @task(3)
    def invalid_dates(self):
        """
        Test for invalid dates
        :return: 
        """
        url = '/{version}/Retail/Food?startDate=2016-02-31'.format(version=VERSION)
        with self.client.get(url, catch_response=True) as response:
            if response.status_code == 404:
                response.success()
            else:
                response.failure('Expected not found')

    @task(2)
    def partial_dates(self):
        """
        test part of the date
        :return: 
        """
        url = '/{version}/Retail/Food?startDate=2016-01-01'.format(version=VERSION)
        self.client.get(url)

    @task(1)
    def check_simple_output(self):
        """
        Test actual output of one query
        :return: 
        """
        url = '/{version}/Retail/Food?startDate=2016-01-01&endDate=2016-03-01'.format(version=VERSION)
        with self.client.get(url, catch_response=True) as response:
            result = json.loads(response.content)
            try:
                if not len(result['MonthlyRetailData']) == 1:
                    response.failure('Wrong number of categories')
                elif not result['MonthlyRetailData'][0]['category'] == 'Food':
                    response.failure('Wrong category')
                elif not len(result['MonthlyRetailData'][0]['regional_data']) == 1:
                    response.failure('Wrong number of states')
                elif not result['MonthlyRetailData'][0]['regional_data'][0]['state'] == 'AUS':
                    response.failure('Wrong state: ' + result['MonthlyRetailData'][0]['regional_data'][0]['state'])
                elif not len(result['MonthlyRetailData'][0]['regional_data'][0]['data']) == 3:
                    response.failure('Wrong number of returns')
                elif not result['MonthlyRetailData'][0]['regional_data'][0]['data'][0]['date'] == '2016-01-31':
                    response.failure('Wrong starting date of returns')
                elif not result['MonthlyRetailData'][0]['regional_data'][0]['data'][2]['date'] == '2016-03-31':
                    response.failure('Wrong ending date of returns')
                elif not result['MonthlyRetailData'][0]['regional_data'][0]['data'][2]['turnover'] == 10354.0:
                    response.failure('Wrong returns data')
            except KeyError as e:
                response.failure('Missing index inside the response!' + str(e))


class WebsiteUser(HttpLocust):
    task_set = UserBehavior
    min_wait = 1000
    max_wait = 3000
