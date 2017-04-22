import unittest
import requests
import calendar

host = 'http://45.76.114.158/api/'
version = 'v2.01'
baseurl = '{host}?StatisticsArea={statsArea}&State={states}&Category={category}&{params}'

def formUrl(statsArea='Retail', category='Total', states='AUS', startDate = None, endDate = None):
    params = ''
    if startDate != None:
        params += 'startDate={}'.format(startDate)
    else:
        params += 'startDate={}'.format('1900-01-01')
    params += '&'
    if endDate != None:
        params += 'endDate={}'.format(endDate)
    else:
        params += 'endDate={}'.format('2100-01-01')
    import sys
    sys.stderr.write(baseurl.format(host=host, version=version, statsArea=statsArea, category=category, states=states, params=params))
    return baseurl.format(host=host, version=version, statsArea=statsArea, category=category, states=states, params=params)

def is_ok(response):
    return response.ok and response.json()['header']['status'] == 'success'

def get_error(response):
    return response.json()['data']['code']

def get_data(response, name):
    return response.json()['data'][name]

CATEGORIES = [
    'Total',
    'Food',
    'HouseholdGood',
    'ClothingFootwareAndPersonalAccessory',
    'DepartmentStores',
    'CafesResturantsAndTakeawayFood',
    'Other'
]
NUM_CATEGORIES = len(CATEGORIES)

STATES = ['AUS', 'NSW', 'WA',
    'SA', 'ACT', 'VIC', 'TAS', 'QLD', 'NT']
NUM_STATES = len(STATES)

COMMODITIES = [
    'Total', 'FoodAndLiveAnimals',
    'BeveragesAndTobacco',
    'CrudMaterialAndInedible',
    'MineralFuelLubricentAndRelatedMaterial',
    'AnimalAndVegitableOilFatAndWaxes',
    'ChemicalsAndRelatedProducts',
    'ManufacturedGoods',
    'MachineryAndTransportEquipments',
    'OtherManufacturedArticles',
    'Unclassified'
]
NUM_COMMODITIES = len(COMMODITIES)

def isMonthEnd(d):
    (y,m,d) = map(int, d.split('-'))
    return d == calendar.monthrange(y,m)[1]
