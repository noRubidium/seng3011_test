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
        self.assertEqual(get_error(self.res), 10)

class TestNoDataPastDate(unittest.TestCase):
    def setUp(self):
        url = formUrl(startDate='1900-01-01', endDate='1900-01-31')
        res = requests.get(url)
        self.res = res
        self.content = self.res.json()

    def test_error_response(self):
        self.assertTrue(not is_ok(self.res))

    def test_error_message(self):
        self.assertEqual(get_error(self.res), 10)


class TestNoDataInState(unittest.TestCase):
    def setUp(self):
        url = formUrl(statsArea='MerchandiseExports', category=COMMODITIES[4], states='ACT', startDate='2016-01-01', endDate='2016-01-31')
        res = requests.get(url)
        self.res = res
        self.content = self.res.json()

    def test_error_response(self):
        self.assertTrue(not is_ok(self.res))

    def test_error_message(self):
        self.assertEqual(get_error(self.res), 10)


class TestNoDataStateWithOtherState(unittest.TestCase):
    def setUp(self):
        url = formUrl(statsArea='MerchandiseExports', category=COMMODITIES[4], states='ACT,NSW', startDate='2016-01-01', endDate='2016-01-31')
        res = requests.get(url)
        self.res = res
        self.content = self.res.json()

    def test_response(self):
        self.assertTrue(is_ok(self.res))

    def test_empty_ACT(self):
        act_data = get_data(self.res, 'MonthlyCommodityExportData')[0]['RegionalData'][0]['Data']
        self.assertTrue(act_data == None or len(act_data) == 0)
