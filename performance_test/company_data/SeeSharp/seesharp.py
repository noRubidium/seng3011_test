from locust import HttpLocust, TaskSet, task
import json
import random
VERSION='v1'
AVAILABLE_COMPANIES = [
    'ABP.AX', 'AAPL',
    '^AORD', '^NDX',
    '^AXJO', '^GDAXI',
    'IRE.AX', 'NWS.AX',
    'WOW.AX', '000001.SS',
    'FFBC'
]
NUM_CMP = len(AVAILABLE_COMPANIES)

AVAILABLE_VAR = [
    'AV_Return',
    'CV_Return'
]
NUM_VAR = len(AVAILABLE_VAR)

AVAILABLE_DATE_RANGE = [
    'Last_Week',
    'Last_Fortnight',
    'Last_28Days'
]
NUM_DR = len(AVAILABLE_DATE_RANGE)


class UserBehavior(TaskSet):

    @task(6)
    def random_query(self):
        url = '/InstrumentID/{inst}/DateOfInterest/2016-12-10/List_of_Var/{lv}/{date_range}'
        date_range = 'Upper_window/{u}/Lower_window/{l}'.format(u=random.randint(3,30), l=random.randint(3,30)) if \
            random.random > 0.5 else 'Window/{w}'.format(w=random.choice(AVAILABLE_DATE_RANGE))
        name='/InstrumentID/[]/DateOfInterest/[]/List_of_Var/[]/[DateRange]'
        inst = ','.join(random.sample(AVAILABLE_COMPANIES, random.randint(1, NUM_CMP)))
        lv = ','.join(random.sample(AVAILABLE_VAR, random.randint(1, NUM_VAR)))
        url = url.format(inst=inst, date_range=date_range, lv=lv)
        self.client.get(url, name=name)

    @task(5)
    def negative_window(self):
        """
        Test for invalid dates
        :return:
        """
        url = '/InstrumentID/ABP.AX/DateOfInterest/2012-12-10/List_of_Var/AV_Return/Upper_window/-1/Lower_window/1'.format(version=VERSION)
        with self.client.get(url, catch_response=True) as response:
            if response.status_code == 200 and 'Errors' in json.loads(response.content):
                response.success()
            else:
                response.failure(str(response.status_code)+ ': Expected Error')

    @task(4)
    def invalid_list_of_var(self):
        """
        Test for invalid dates
        :return: 
        """
        url = '/InstrumentID/ABP.AX/DateOfInterest/2012-12-10/List_of_Var/AV_Returns/Upper_window/1/Lower_window/1'.format(version=VERSION)
        with self.client.get(url, catch_response=True) as response:
            if response.status_code == 200 and 'Errors' in json.loads(response.content):
                response.success()
            else:
                response.failure('Expected Error')

    @task(3)
    def invalid_dates(self):
        """
        Test for invalid dates
        :return: 
        """
        url = '/InstrumentID/ABP.AX/DateOfInterest/2012-12-42/List_of_Var/AV_Return/Upper_window/1/Lower_window/1'.format(version=VERSION)
        with self.client.get(url, catch_response=True) as response:
            if response.status_code == 200 and 'Errors' in json.loads(response.content):
                response.success()
            else:
                response.failure('Expected Error')

    @task(2)
    def invalid_instrument(self):
        """
        Test for invalid dates
        :return: 
        """
        url = '/InstrumentID/UNSW/DateOfInterest/2012-12-01/List_of_Var/AV_Return/Upper_window/1/Lower_window/1'.format(
            version=VERSION)
        with self.client.get(url, catch_response=True) as response:
            if response.status_code == 200 and 'Errors' in json.loads(response.content):
                response.success()
            else:
                response.failure('Expected Error')

    @task(1)
    def check_simple_output(self):
        """
        Test actual output of one query
        :return: 
        """
        url = '/InstrumentID/ABP.AX/DateOfInterest/2012-12-10/List_of_Var/AV_Return/Upper_window/1/Lower_window/1'.format(version=VERSION)
        with self.client.get(url, catch_response=True) as response:
            result = json.loads(response.content)['CompanyReturns']
            try:
                if not len(result) == 1:
                    response.failure('Wrong number of outputs')
                elif not result[0]['InstrumentID'] == 'ABP.AX':
                    response.failure('Wrong category')
                elif not len(result[0]['Data']) == 3:
                    response.failure('Wrong number of days')
                elif not result[0]['Data'][0]['RelativeDate'] == -1:
                    response.failure('Wrong relative date')
                elif not result[0]['Data'][0]['Date'] == '2012-12-09':
                    response.failure('Wrong starting date')
                elif not result[0]['Data'][0]['Return'] == 0:
                    response.failure('Wrong return value')
                elif not result[0]['Data'][2]['Date'] == '2012-12-11':
                    response.failure('Wrong ending date')
                elif not result[0]['Data'][2]['AV_Return'] == 0.004986192409836404:
                    response.failure('Wrong avg return data')
            except KeyError as e:
                response.failure('Missing index inside the response!' + str(e))


# locust --host=http://174.138.67.207 -f seesharp.py 2>output

class WebsiteUser(HttpLocust):
    task_set = UserBehavior
    min_wait = 1000
    max_wait = 3000
