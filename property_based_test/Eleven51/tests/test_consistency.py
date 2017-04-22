from config import *
import random



class TestAPIConsistency(unittest.TestCase):
    def test_same_query_retail(self):
        states = random.sample(STATES, random.randint(0, NUM_STATES))
        category = random.sample(CATEGORIES, random.randint(1, NUM_CATEGORIES))
        url = formUrl(states=','.join(states), category=','.join(category))
        res1 = requests.get(url)
        res2 = requests.get(url)
        self.assertTrue(res1.ok)
        self.assertTrue(res2.ok)
        r1 = res1.json()['MonthlyRetailData']
        r2 = res2.json()['MonthlyRetailData']
        self.assertEqual(r1, r2)

    def test_same_query_merch(self):
        states = random.sample(STATES, random.randint(0, NUM_STATES))
        category = random.sample(COMMODITIES, random.randint(1, NUM_COMMODITIES))
        url = formUrl(statsArea='MerchandiseExports', states=','.join(states), category=','.join(category))
        res1 = requests.get(url)
        res2 = requests.get(url)
        self.assertTrue(res1.ok)
        self.assertTrue(res2.ok)
        r1 = res1.json()['MonthlyCommodityExportData']
        r2 = res2.json()['MonthlyCommodityExportData']
        self.assertEqual(r1, r2)

    def test_same_start_month(self):
        start1 = '2016-01-01'
        start2 = '2016-01-31'
        url1 = formUrl(startDate=start1)
        url2 = formUrl(startDate=start2)
        res1 = requests.get(url1)
        res2 = requests.get(url2)
        self.assertTrue(res1.ok)
        self.assertTrue(res2.ok)
        r1 = res1.json()['MonthlyRetailData']
        r2 = res2.json()['MonthlyRetailData']
        self.assertEqual(r1, r2)

    def test_same_end_month(self):
        end1 = '2016-01-01'
        end2 = '2016-01-31'
        url1 = formUrl(endDate=end1)
        url2 = formUrl(endDate=end2)
        r1 = requests.get(url1).json()['MonthlyRetailData']
        r2 = requests.get(url2).json()['MonthlyRetailData']
        self.assertEqual(r1, r2)

    def test_state_aus_total_retail(self):
        state1 = 'AUS'
        state2 = 'Total'
        url1 = formUrl(states=state1)
        url2 = formUrl(states=state2)
        r1 = requests.get(url1).json()['MonthlyRetailData']
        r2 = requests.get(url2).json()['MonthlyRetailData']
        self.assertEqual(r1, r2)

    def test_state_aus_total_merch(self):
        state1 = 'AUS'
        state2 = 'Total'
        url1 = formUrl(statsArea='MerchandiseExports', states=state1)
        url2 = formUrl(statsArea='MerchandiseExports', states=state2)
        r1 = requests.get(url1).json()['MonthlyCommodityExportData']
        r2 = requests.get(url2).json()['MonthlyCommodityExportData']
        self.assertEqual(r1, r2)

if __name__ == '__main__':
    unittest.main()
