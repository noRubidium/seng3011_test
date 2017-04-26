## How to Run the Correctness Testing

#  Requirements:
* Python2.7 needs to be installed on the system
* Bash environment should be enabled

# Test Files Within the correctness-testing directory:
* Correctness-tests.robot (our test suite / script which contains all our test)
* Expected_outputs (a folder with all expected output .json files)
* Sample_reports (a folder containing a sample report and log produced by the framework)
* run_test.sh

To install the testing framework, simply run `./run_test.sh`
This will install (through pip) the robot framework and necessary libraries, then run our test script by `robot correctness-tests.robot`

Test results will be printed to the terminal, with an associated report and log being produced within the root directory. IF there are any issues with the run_test.sh script, then run the scrip with admin privileges.
