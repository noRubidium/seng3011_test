# How to Run the Correctness Testing
## The offcial website for the framework
[ROBOT](http://robotframework.org/)

## Test Files Within the correctness-testing directory:
There are two folders: 
* Eleven51 - test files that test our API.
* TeamRocket - test files that tests other team's API (TeamRocket).

Within each of the above folders are the following files:
* Correctness-tests.robot (our test suite / script which contains all our test)
* Expected_outputs (a folder with all expected output .json files)
* Sample_Logs (a folder containing sample test output logs and reports)
* run_test.sh

##  Requirements:
* Python2.7 needs to be installed on the system
* Bash environment should be enabled

## How to run the tests:
1. Make sure you have python2.7 installed on your machine, and
if you run `python --version` in the terminal, it gives you
`Python 2.7.X`
2. Make sure you are under Linux environment, and have the support to run bash script.
3. Make sure the Internet connection is good.
4. Change directories into Eleven51 to test our API. (cd into TeamRocket to run our tests on TeamRocket's API)
```bash
  cd Eleven51
```
5. Run the following command
```bash
  bash run_test.sh
```
6. This will install (through pip) the robot framework and necessary libraries, then run our test script by `robot correctness-tests.robot`

Test results will be printed to the terminal, with an associated report and log being produced within the root directory. 
## Miscellaneous
If there are any issues with the run_test.sh script, then run the scrip with admin privileges.
