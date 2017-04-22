# How to run the tests:
1. Make sure you have python2.7 installed on your machine, and
if you run `python --version` in the terminal, it gives you
`Python 2.7.X`
2. Make sure you are under Linux environment, and have the support to run bash script.
3. Make sure the Internet connection is good.
4. Run the following command
```bash
  bash run_test.sh
```
5. After the command finishes, an html file `test_report.html` is generated. You can view the result in browser by opening the file in a browser.

# How to configure the tests
- Delete tests:
  - Edit 'tests/\_\_init\_\_.py' comment out the test suite you don't want to run.
- Add tests:
  - Create file `tests/test_{test_name}.py`
    - `test_{test_name}` needs to follow the normal python module file naming convention
  - Include the file in `tests/__init__.py` by add a line: `from test_{test_name} import *`
  - Inside file `tests/test_{test_name}.py`, you can create multiple classes that extends 'unittest.TestCase' and create methods for each of the tests. By simply following the format of other files.
- Configure all tests:
  - Most of the configurations are in `config.py`
  - `version` variable is for using different versions.
  - `host` and `baseurl` can be changed to fit different API end points.

# Miscellaneous
- V3 API is failing tests for 'ACT' with missing data for certain category, since we have updated the error in V4 to
  - Give error if no data is returned even with valid query
  - When querying multiple states, if no data is recorded in a certain state, we should still have that list of the state returned in the result (for the ease of testing).
