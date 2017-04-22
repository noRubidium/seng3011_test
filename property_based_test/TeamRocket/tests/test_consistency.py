from config import *
import random



class TestAPIConsistency(unittest.TestCase):
    def test_same_query_retail(self):
        states = random.sample(STATES, random.randint(0, NUM_STATES))
        category = random.sample(CATEGORIES, random.randint(1, NUM_CATEGORIES))
        url = formUrl(states=','.join(states), category=','.join(category))
        res1 = requests.get(url)
        res2 = requests.get(url)
        self.assertTrue(is_ok(res1))
        self.assertTrue(is_ok(res2))
        r1 = get_data(res1, 'MonthlyRetailData')
        r2 = get_data(res2, 'MonthlyRetailData')
        self.assertEqual(r1, r2)

    def test_same_query_merch(self):
        states = random.sample(STATES, random.randint(0, NUM_STATES))
        category = random.sample(COMMODITIES, random.randint(1, NUM_COMMODITIES))
        url = formUrl(statsArea='MerchandiseExports', states=','.join(filter(lambda x : x != 'AUS', states)), category=','.join(category))
        res1 = requests.get(url)
        res2 = requests.get(url)

        self.assertTrue(is_ok(res1))
        self.assertTrue(is_ok(res2))
        r1 = get_data(res1, 'MonthlyCommodityExportData')
        r2 = get_data(res2, 'MonthlyCommodityExportData')
        self.assertEqual(r1, r2)

    def test_same_start_month(self):
        start1 = '2016-01-01'
        start2 = '2016-01-31'
        url1 = formUrl(startDate=start1)
        url2 = formUrl(startDate=start2)
        res1 = requests.get(url1)
        res2 = requests.get(url2)
        self.assertTrue(is_ok(res1))
        self.assertTrue(is_ok(res2))
        r1 = get_data(res1, 'MonthlyRetailData')
        r2 = get_data(res2, 'MonthlyRetailData')
        self.assertEqual(r1, r2)

    def test_same_end_month(self):
        end1 = '2016-01-01'
        end2 = '2016-01-31'
        url1 = formUrl(endDate=end1)
        url2 = formUrl(endDate=end2)
        res1 = requests.get(url1)
        res2 = requests.get(url2)
        r1 = get_data(res1, 'MonthlyRetailData')
        r2 = get_data(res2, 'MonthlyRetailData')
        self.assertEqual(r1, r2, url1)


if __name__ == '__main__':
    unittest.main()
