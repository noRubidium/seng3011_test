# How to Run the Performance Testing

##  Requirements:
* Python2.7 needs to be installed on the system
* Bash environment should be enabled

## How to run the tests:
1. Make sure you have python2.7 installed on your machine, and
if you run `python --version` in the terminal, it gives you
`Python 2.7.X`
2. Make sure you are under Linux environment, and have the support to run bash script.
3. Make sure the Internet connection is good.
5. Within a pero
5. Run the following to install locustio
```bash
  pip install locustio
```
or 
```bash
  easy_install locustio
```
5. Run the following command
```bash
  bash run_test.sh
```
6. open `http://127.0.0.1:8089` in a web browser. You are able to configure the number of users and the rate of increase of users.

To test other teams API's cd into their directory and run the `runtest.sh` script.
