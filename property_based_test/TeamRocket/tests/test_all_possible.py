from config import *
import time

class TestCorrectnessMassiveRetailQuery(unittest.TestCase):
    def setUp(self):
        now = time.strftime("%Y-%m-%d")
        url = formUrl(states=','.join(STATES), category=','.join(CATEGORIES), startDate='1900-01-01', endDate=now)
        res = requests.get(url)
        self.res = res
        self.content = self.res.json()

    def test_ok(self):
        self.assertTrue(is_ok(self.res))

    # def test_header_exist(self):
    #     self.assertTrue('Header' in self.content)

    def test_return_data_exists(self):
        self.assertTrue('MonthlyRetailData' in self.content['data'])

    def test_content_num_category(self):
        self.assertEqual(len(get_data(self.res, 'MonthlyRetailData')), NUM_CATEGORIES)

    # def test_content_num_states(self):
    #     for item in get_data(self.res, 'MonthlyRetailData'):
    #         self.assertEqual(len(item['RegionalData']), NUM_STATES, 'incorrect number of states in {} category'.format(item['Categry']))

    def test_every_turnover(self):
        """test if every data has turnover"""
        for item in get_data(self.res, 'MonthlyRetailData'):
            for r_d in item['RegionalData']:
                for d in r_d['Data']:
                    self.assertTrue('Turnover' in d)

    def test_every_date_end(self):
        """test if every date is the end of the month"""
        for item in get_data(self.res, 'MonthlyRetailData'):
            for r_d in item['RegionalData']:
                for d in r_d['Data']:
                    self.assertTrue(isMonthEnd(d['Date']))




class TestCorrectnessMassiveMerchQuery(unittest.TestCase):
    def setUp(self):
        now = time.strftime("%Y-%m-%d")
        url = formUrl(states=','.join(STATES), category=','.join(COMMODITIES), startDate='1900-01-01', endDate=now, statsArea='MerchandiseExports')
        import sys
        sys.stderr.write(url)
        res = requests.get(url)
        self.res = res
        self.content = self.res.json()

    def test_ok(self):
        self.assertTrue(is_ok(self.res))

    # def test_header_exist(self):
    #     self.assertTrue('Header' in self.content)

    def test_return_data_exists(self):
        self.assertTrue('MonthlyCommodityExportData' in self.content['data'])

    def test_content_num_category(self):
        self.assertEqual(len(get_data(self.res, 'MonthlyCommodityExportData')), NUM_COMMODITIES)

    # def test_content_num_states(self):
    #     for item in get_data(self.res, 'MonthlyCommodityExportData'):
    #         self.assertEqual(len(item['RegionalData']), NUM_STATES, 'incorrect number of states in {} category'.format(item['Commodity']))

    def test_every_turnover(self):
        """test if every data has value"""
        for item in get_data(self.res, 'MonthlyCommodityExportData'):
            for r_d in item['RegionalData']:
                for d in r_d['Data']:
                    self.assertTrue('Value' in d)

    def test_every_date_end(self):
        """test if every date is the end of the month"""
        for item in get_data(self.res, 'MonthlyCommodityExportData'):
            for r_d in item['RegionalData']:
                for d in r_d['Data']:
                    self.assertTrue(isMonthEnd(d['Date']))
