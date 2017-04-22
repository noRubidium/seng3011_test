from config import *
import time

class TestNoDataFutureDate(unittest.TestCase):
    def setUp(self):
        now = time.strftime("%Y-%m-%d")
        url = formUrl(startDate=now)
        res = requests.get(url)
        self.res = res
        self.content = self.res.json()

    def test_error_response(self):
        self.assertTrue(not is_ok(self.res))

    def test_error_message(self):
        self.assertEqual(get_error(self.res), 'Results not found. ABS does not have the data for the requested dates.')

class TestNoDataPastDate(unittest.TestCase):
    def setUp(self):
        url = formUrl(startDate='1900-01-01', endDate='1900-01-31')
        res = requests.get(url)
        self.res = res
        self.content = self.res.json()

    def test_error_response(self):
        self.assertTrue(not is_ok(self.res))

    def test_error_message(self):
        self.assertEqual(get_error(self.res), 'Results not found. ABS does not have the data for the requested dates.')


class TestNoDataInState(unittest.TestCase):
    def setUp(self):
        url = formUrl(statsArea='MerchandiseExports', category=COMMODITIES[4], states='ACT', startDate='2016-01-01', endDate='2016-01-31')
        res = requests.get(url)
        self.res = res
        self.content = self.res.json()

    def test_error_response(self):
        self.assertTrue(not is_ok(self.res))

    def test_error_message(self):
        self.assertEqual(get_error(self.res), 'Results not found. ABS does not have the data for the requested dates.')


class TestNoDataStateWithOtherState(unittest.TestCase):
    def setUp(self):
        url = formUrl(statsArea='MerchandiseExports', category=COMMODITIES[4], states='ACT,NSW', startDate='2016-01-01', endDate='2016-01-31')
        res = requests.get(url)
        self.res = res
        self.content = self.res.json()

    def test_response(self):
        self.assertTrue(is_ok(self.res))

    def test_empty_ACT(self):
        act_data = self.content['MonthlyCommodityExportData'][0]['regional_data'][0]['data']
        self.assertEqual(len(act_data), 0)
