from config import *

class TestInvalidStatsArea(unittest.TestCase):
    def setUp(self):
        url = formUrl(statsArea='UNSW')
        res = requests.get(url)
        self.res = res

    def test_error_response(self):
        self.assertTrue(not is_ok(self.res))

    def test_error_message(self):
        self.assertEqual(get_error(self.res), 'You should choose the type and categories. Type is either Retail or MerchandiseExports')


class TestInvalidCategory(unittest.TestCase):
    def setUp(self):
        url = formUrl(category='UNSW')
        res = requests.get(url)
        self.res = res

    def test_error_response(self):
        self.assertTrue(not is_ok(self.res))

    def test_error_message(self):
        self.assertEqual(get_error(self.res).split('.')[0], 'The type you are requiring (UNSW) doesn\'t exist')


class TestInvalidCommodity(unittest.TestCase):
    def setUp(self):
        url = formUrl(statsArea='MerchandiseExports', category='UNSW')
        res = requests.get(url)
        self.res = res

    def test_error_response(self):
        self.assertTrue(not is_ok(self.res))

    def test_error_message(self):
        self.assertEqual(get_error(self.res).split('.')[0], 'The type you are requiring (UNSW) doesn\'t exist')


class TestInvalidStates(unittest.TestCase):
    def setUp(self):
        url = formUrl(states='UNSW')
        res = requests.get(url)
        self.res = res
        self.content = self.res.json()

    def test_error_response(self):
        self.assertTrue(not is_ok(self.res))

    def test_error_message(self):
        self.assertEqual(get_error(self.res).split('.')[0], 'The type you are requiring (UNSW) doesn\'t exist')


class TestInvalidDateFormat(unittest.TestCase):
    def test_invalid_start_format(self):
        url = formUrl(startDate='2016-1-03')
        res = requests.get(url)
        content = res.json()
        self.assertTrue(not is_ok(res))
        self.assertEqual(get_error(res), 'Start date is invalid. Dates should be YYYY-MM-DD')

    def test_invalid_end_format(self):
        url = formUrl(endDate='2016-1-03')
        res = requests.get(url)
        content = res.json()
        self.assertTrue(not is_ok(res))
        self.assertEqual(get_error(res), 'End date is invalid. Dates should be YYYY-MM-DD')


class TestNonExistingDate(unittest.TestCase):
    def test_invalid_month(self):
        date = '2016-13-20'
        url = formUrl(startDate=date)
        res = requests.get(url)
        content = res.json()
        self.assertTrue(not is_ok(res))
        self.assertEqual(get_error(res), 'Start date is invalid. There is no such date {}.'.format(date))

    def test_invalid_date(self):
        date = '2016-01-40'
        url = formUrl(startDate=date)
        res = requests.get(url)
        content = res.json()
        self.assertTrue(not is_ok(res))
        self.assertEqual(get_error(res), 'Start date is invalid. There is no such date {}.'.format(date))

    def test_over_range_date(self):
        date = '2016-06-31'
        url = formUrl(startDate=date)
        res = requests.get(url)
        content = res.json()
        self.assertTrue(not is_ok(res))
        self.assertEqual(get_error(res), 'Start date is invalid. There is no such date {}.'.format(date))

    def test_non_leap_year_leap_1(self):
        date = '2015-02-29'
        url = formUrl(startDate=date)
        res = requests.get(url)
        content = res.json()
        self.assertTrue(not is_ok(res))
        self.assertEqual(get_error(res), 'Start date is invalid. There is no such date {}.'.format(date))

    def test_non_leap_year_leap_2(self):
        date = '1900-02-29'
        url = formUrl(startDate=date)
        res = requests.get(url)
        content = res.json()
        self.assertTrue(not is_ok(res))
        self.assertEqual(get_error(res), 'Start date is invalid. There is no such date {}.'.format(date))

    def test_non_leap_year_leap_3(self):
        date = '2000-02-29'
        url = formUrl(startDate=date)
        res = requests.get(url)
        content = res.json()
        self.assertTrue(is_ok(res))


class TestInvalidDateRange(unittest.TestCase):
    def test_end_before_start(self):
        start = '2017-01-01'
        end = '2016-01-01'
        url = formUrl(startDate=start, endDate=end)
        res = requests.get(url)
        content = res.json()
        self.assertTrue(not is_ok(res))
        self.assertEqual(get_error(res), 'Start date should be before end date')
