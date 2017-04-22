from config import *
import time

class TestOptionalDates(unittest.TestCase):
    """
    Test API
    """
    def test_no_date(self):
        """
        Test no date
        """
        url = formUrl()
        r = requests.get(url).json()
        now = time.strftime("%Y-%m-%d")
        (y, m, _) = map(int, now.split('-'))
        last_year = y - 1
        last_month = m + 1
        if last_month > 12:
            last_month = 1
            last_year += 1
        end_date = now + '-' + str(calendar.monthrange(y,m)[1])
        start_date = '{:04d}-{:02d}-{:02d}'.format(last_year,last_month, calendar.monthrange(last_year,last_month)[1])
        data = r['MonthlyRetailData'][0]['regional_data'][0]['data']
        self.assertEqual(data[0]['date'], start_date)
        self.assertEqual(r['Header']['end_date'], now)

    def test_starting_date_missing(self):
        now = '2016-12-31'
        url = formUrl(endDate=now)
        r = requests.get(url).json()
        (y, m, _) = map(int, now.split('-'))
        start_date = '2016-01-31'
        end_date = '2016-12-31'
        data = r['MonthlyRetailData'][0]['regional_data'][0]['data']
        self.assertEqual(data[0]['date'], start_date)
        self.assertEqual(data[-1]['date'], end_date)

    def test_ending_date_missing(self):
        now = '2016-01-31'
        url = formUrl(startDate=now)
        r = requests.get(url).json()
        (y, m, _) = map(int, now.split('-'))
        start_date = '2016-01-31'
        end_date = '2016-12-31'
        data = r['MonthlyRetailData'][0]['regional_data'][0]['data']
        self.assertEqual(data[0]['date'], start_date)
        self.assertEqual(data[-1]['date'], end_date)

class TestOptionalStates(unittest.TestCase):
    def setUp(self):
        url = formUrl(states='', startDate='2016-01-01', endDate='2016-01-31')
        res = requests.get(url)
        self.res = res
        self.content = self.res.json()

    def test_ok(self):
        self.assertTrue(is_ok(self.res))

    def test_header_exist(self):
        self.assertTrue('Header' in self.content)

    def test_return_data_exists(self):
        self.assertTrue('MonthlyRetailData' in self.content)

    def test_content_num_states(self):
        for item in self.content['MonthlyRetailData']:
            self.assertEqual(len(item['regional_data']), 1, 'incorrect number of states in {} category'.format(item['category']))

    def test_state_AUS(self):
        """test if every data has turnover"""
        for item in self.content['MonthlyRetailData']:
            for r_d in item['regional_data']:
                self.assertEqual(r_d['state'], 'AUS')


class TestAllOptional(unittest.TestCase):
    def setUp(self):
        url = formUrl(states='')
        res = requests.get(url)
        self.res = res
        self.content = self.res.json()
        self.now = time.strftime("%Y-%m-%d")

    def test_ok(self):
        self.assertTrue(is_ok(self.res))

    def test_header_exist(self):
        self.assertTrue('Header' in self.content)

    def test_return_data_exists(self):
        self.assertTrue('MonthlyRetailData' in self.content)

    def test_content_num_states(self):
        for item in self.content['MonthlyRetailData']:
            self.assertEqual(len(item['regional_data']), 1, 'incorrect number of states in {} category'.format(item['category']))

    def test_state_AUS(self):
        """test if every data has turnover"""
        for item in self.content['MonthlyRetailData']:
            for r_d in item['regional_data']:
                self.assertEqual(r_d['state'], 'AUS')

    def check_date(self):
        (y, m, _) = map(int, self.now.split('-'))
        last_year = y - 1
        last_month = m + 1
        if last_month > 12:
            last_month = 1
            last_year += 1
        end_date = self.now + '-' + str(calendar.monthrange(y,m)[1])
        start_date = '{:04d}-{:02d}-{:02d}'.format(last_year,last_month, calendar.monthrange(last_year,last_month)[1])
        data = r['MonthlyRetailData'][0]['regional_data'][0]['data']
        self.assertEqual(data[0]['date'], start_date)
        self.assertEqual(r['Header']['end_date'], self.now)

if __name__ == '__main__':
    unittest.main()
