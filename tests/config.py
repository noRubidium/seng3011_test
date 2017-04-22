import unittest
import requests
import calendar

host = 'http://api.kaiworship.xyz'
version = 'v4'
baseurl = '{host}/{version}/{statsArea}/{category}/{states}?{params}'

def formUrl(statsArea='Retail', category='Total', states='Total', startDate = None, endDate = None):
    params = ''
    if startDate != None:
        params += 'startDate={}'.format(startDate)
    params += '&'
    if endDate != None:
        params += 'endDate={}'.format(endDate)
    return baseurl.format(host=host, version=version, statsArea=statsArea, category=category, states=states, params=params)

def is_ok(response):
    return response.ok

def get_error(response):
    return response.json()['error']

CATEGORIES = [
    'Food', 'HouseholdGood',
    'ClothingFootwareAndPersonalAccessory', 'DepartmentStores',
    'CafesRestaurantsAndTakeawayFood', 'Other', 'Total'
]
NUM_CATEGORIES = len(CATEGORIES)

STATES = ['Total', 'AUS', 'NSW', 'WA',
    'SA', 'ACT', 'VIC', 'TAS', 'QLD', 'NT']
NUM_STATES = len(STATES)

COMMODITIES = [
    'Total', 'FoodAndLiveAnimals', 'BeveragesAndTobacco',
    'CrudeMaterialAndInedible', 'MineralFuelLubricantAndRelatedMaterial',
    'AnimalAndVegetableOilFatAndWaxes', 'ChemicalsAndRelatedProducts',
    'ManufacturedGoods', 'MachineryAndTransportEquipments',
    'OtherManufacturedArticles', 'Unclassified'
]
NUM_COMMODITIES = len(COMMODITIES)

def isMonthEnd(d):
    (y,m,d) = map(int, d.split('-'))
    return d == calendar.monthrange(y,m)[1]
