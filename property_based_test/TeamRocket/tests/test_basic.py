from config import *


class TestCorrectnessOneQuery(unittest.TestCase):
    def setUp(self):
        url = formUrl(startDate='2016-01-01', endDate='2016-01-31')
        res = requests.get(url)
        self.res = res
        self.content = self.res.json()


    def test_ok(self):
        self.assertTrue(is_ok(self.res))

    # def test_header_exist(self):
    #     self.assertTrue('Header' in self.content)
    #
    # def test_end_date(self):
    #     self.assertEqual(self.content['Header'].get('end_date', None), '2016-01-31')
    #
    # def test_start_date(self):
    #     self.assertEqual(self.content['Header'].get('start_date', None), '2016-01-01')

    # def test_return_data_exists(self):
    #     self.assertTrue('MonthlyRetailData' in self.content)

    def test_content(self):
        self.assertEqual(get_data(self.res, 'MonthlyRetailData'), [{u"RetailIndustry": u"Total", u"RegionalData": [{u"State": u"AUS", u"Data": [{u"Date": u"2016-01-31", u"Turnover": 24753.1}]}]}])


class TestCorrectnessMassiveRetailQuery(unittest.TestCase):
    def setUp(self):
        url = formUrl(states=','.join(STATES), category=','.join(CATEGORIES), startDate='2016-01-01', endDate='2016-01-31')
        res = requests.get(url)
        self.res = res
        self.content = self.res.json()

    def test_ok(self):
        self.assertTrue(is_ok(self.res))

    def test_header_exist(self):
        self.assertTrue('Header' in self.content)

    def test_end_date(self):
        self.assertEqual(self.content['Header'].get('end_date', None), '2016-01-31')

    def test_start_date(self):
        self.assertEqual(self.content['Header'].get('start_date', None), '2016-01-01')

    def test_return_data_exists(self):
        self.assertTrue('MonthlyRetailData' in self.content)

    def test_content_num_category(self):
        self.assertEqual(len(get_data(self.res, 'MonthlyRetailData')), NUM_CATEGORIES)

    def test_content_num_states(self):
        for item in get_data(self.res, 'MonthlyRetailData'):
            self.assertEqual(len(item['regional_data']), NUM_STATES, 'incorrect number of states in {} category'.format(item['category']))

    def test_every_turnover(self):
        """test if every data has turnover"""
        for item in get_data(self.res, 'MonthlyRetailData'):
            for r_d in item['regional_data']:
                for d in r_d['data']:
                    self.assertTrue('turnover' in d)

    def test_every_date_end(self):
        """test if every date is the end of the month"""
        for item in get_data(self.res, 'MonthlyRetailData'):
            for r_d in item['regional_data']:
                for d in r_d['data']:
                    self.assertTrue(isMonthEnd(d['date']))




class TestCorrectnessMassiveMerchQuery(unittest.TestCase):
    def setUp(self):
        url = formUrl(states=','.join(STATES), category=','.join(COMMODITIES), startDate='2016-01-01', endDate='2016-01-31', statsArea='MerchandiseExports')
        res = requests.get(url)
        self.res = res
        self.content = self.res.json()

    def test_ok(self):
        self.assertTrue(is_ok(self.res))

    def test_header_exist(self):
        self.assertTrue('Header' in self.content)

    def test_end_date(self):
        self.assertEqual(self.content['Header'].get('end_date', None), '2016-01-31')

    def test_start_date(self):
        self.assertEqual(self.content['Header'].get('start_date', None), '2016-01-01')

    def test_return_data_exists(self):
        self.assertTrue('MonthlyCommodityExportData' in self.content)

    def test_content_num_category(self):
        self.assertEqual(len(get_data(self.res, 'MonthlyCommodityExportData')), NUM_COMMODITIES)

    def test_content_num_states(self):
        for item in get_data(self.res, 'MonthlyCommodityExportData'):
            self.assertEqual(len(item['regional_data']), NUM_STATES, 'incorrect number of states in {} category'.format(item['commodity']))

    def test_every_turnover(self):
        """test if every data has value"""
        for item in get_data(self.res, 'MonthlyCommodityExportData'):
            for r_d in item['regional_data']:
                for d in r_d['data']:
                    self.assertTrue('value' in d)

    def test_every_date_end(self):
        """test if every date is the end of the month"""
        for item in get_data(self.res, 'MonthlyCommodityExportData'):
            for r_d in item['regional_data']:
                for d in r_d['data']:
                    self.assertTrue(isMonthEnd(d['date']))
