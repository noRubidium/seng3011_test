# How to Run the Correctness Testing
## The offcial website for the framework
[ROBOT](http://robotframework.org/)

## Test Files Within the correctness-testing directory:
* Correctness-tests.robot (our test suite / script which contains all our test)
* Expected_outputs (a folder with all expected output .json files)
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
4. Run the following command
```bash
  bash run_test.sh
```
5. This will install (through pip) the robot framework and necessary libraries, then run our test script by `robot correctness-tests.robot`

Test results will be printed to the terminal, with an associated report and log being produced within the root directory. 
## Miscelaneous
If there are any issues with the run_test.sh script, then run the scrip with admin privileges.
