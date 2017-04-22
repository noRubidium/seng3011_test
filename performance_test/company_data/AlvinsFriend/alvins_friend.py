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
    'CM_Return'
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
        url = '/v2/id={inst}&dateOfInterest=2016-12-10&listOfVars={lv}&{date_range}'
        date_range = 'upperWindow={u}&lowerWindow={l}'.format(u=random.randint(3,30), l=random.randint(3,30))
        name='/InstrumentID/[]/DateOfInterest/[]/List_of_Var/[]/[DateRange]'
        inst = ';'.join(random.sample(AVAILABLE_COMPANIES, random.randint(1, NUM_CMP)))
        lv = ';'.join(random.sample(AVAILABLE_VAR, random.randint(1, NUM_VAR)))
        url = url.format(inst=inst, date_range=date_range, lv=lv)
        with self.client.get(url, name=name, catch_response=True) as response:
            if response.status_code == 200 and 'SUCCESS' == response.json()['Log']['Response']['Code']:
                response.success()
            elif response.status_code == 200:
                response.failure(url + ': Expected NORMAL STATE: ' + response.json()['Log']['Response']['Nature'])

    @task(5)
    def negative_window(self):
        """
        Test for invalid dates
        :return:
        """
        url = '/v2/id=ABP.AX&dateOfInterest=2012-12-10&listOfVars=AV_Return;CM_Return&upperWindow=-1&lowerWindow=3'.format(version=VERSION)
        with self.client.get(url, catch_response=True) as response:
            if response.status_code != 200:
                return

            if 'Error' == response.json()['Log']['Response']['Code']:
                response.success()
            else:
                response.failure('Expected Error')

    @task(4)
    def invalid_list_of_var(self):
        """
        Test for invalid dates
        :return: 
        """
        url = '/v2/id=ABP.AX&dateOfInterest=2012-12-10&listOfVars=AV_Returns&upperWindow=5&lowerWindow=3'.format(version=VERSION)
        with self.client.get(url, catch_response=True) as response:
            if response.status_code != 200:
                return

            if 'Error' == response.json()['Log']['Response']['Code']:
                response.success()
            else:
                response.failure('Expected Error')

    @task(3)
    def invalid_dates(self):
        """
        Test for invalid dates
        :return: 
        """
        url = '/v2/id=ABP.AX&dateOfInterest=2012-12-40&listOfVars=AV_Returns&upperWindow=5&lowerWindow=3'.format(version=VERSION)
        with self.client.get(url, catch_response=True) as response:
            if response.status_code != 200:
                return

            if 'Error' == response.json()['Log']['Response']['Code']:
                response.success()
            else:
                response.failure('Expected Error')

    @task(2)
    def invalid_instrument(self):
        """
        Test for invalid dates
        :return: 
        """
        url = '/v2/id=UNSW&dateOfInterest=2012-12-10&listOfVars=AV_Returns&upperWindow=5&lowerWindow=3'.format(
            version=VERSION)
        with self.client.get(url, catch_response=True) as response:
            if response.status_code != 200:
                return

            if 'Error' == response.json()['Log']['Response']['Code']:
                response.success()
            else:
                response.failure('Expected Error')

    @task(1)
    def check_simple_output(self):
        """
        Test actual output of one query
        :return: 
        """
        url = '/v2/id=ABP.AX&dateOfInterest=2012-12-10&listOfVars=AV_Return&upperWindow=1&lowerWindow=1'.format(version=VERSION)
        with self.client.get(url, catch_response=True) as response:
            try:
                result = response.json()['CompanyReturns']
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
            except:
                pass

# locust --host=http://174.138.67.207 -f seesharp.py 2>output

class WebsiteUser(HttpLocust):
    task_set = UserBehavior
    min_wait = 1000
    max_wait = 3000
