Link to the exercises - *[Learn Python On AWS Workshop](https://learn-to-code.workshop.aws/)*

**Content**
* [x] [1. Setup](#1.-Setup) 
* [x] [2. Getting started](#2.-Getting-started)
  * [x] [2.1. Cloud9](#2.1.-Create-a-new-environment-in-AWS-Cloud9)
  * [x] [2.2. Python Version](#2.2.-Python-version)
  * [x] 2.3. Virtual Environment
* [x] [3. Variables](#3.-Variables)
* [x] [4. Data types](#4.-Data-types)
  * [x] [4.1. Strings](#4.1.-Strings)
  * [x] [4.2. Numbers](#4.2.-Numbers)
  * [x] [4.3. Dictionaries](#4.3.-Dictionaries)
  * [x] [4.4. Lists](#4.4.-Lists)
  * [x] [4.5. Determining Type](#4.5.-Determining-Type)
* [x] [5. Python Packages](#5.-Python-Packages)
* [x] [6. Functions](#6.-Functions)
* [ ] [7. Arguments and Parameters]()
* [ ] [8. Inputs]()
* [ ] [9. Loops]()
* [ ] [10. If Statements]()
* [ ] [11. Logging]()
* [ ] [12. Errors and Exceptions]()
* [ ] [13. Persisting Data]()
* [ ] [14. Building in AWS]()
* [ ] [16. Clean Up]()
* [ ] [17. Congratulations]()

# 1. Setup

Used: AWS Cloud9

# 2. Getting started

## 2.1. Create a new environment in AWS Cloud9
1. Log in to your AWS account
2. Find *Cloud9* among all services<br>
![Step2](img/Screenshot_1.png)
3. Create a new AWS Cloud9 environment<br>
![Step3](img/Screenshot_2.png)
4. Give it a name and description<br>
![Step4](img/Screenshot_3.png)
5. Configure settings (keep the default setting, so you won't be charged)<br>
![Step5](img/Screenshot_4.png)
6. Review and create environment<br>
![Step6](img/Screenshot_5.png)

**Tip**. If there is an error like this *Unable to access your environment The environment creation failed with the error: The development environment...* try to change your location.

## 2.2. Python version
![Step 1.2](img/Screenshot_6.png)

## 2.3. Virtual Environment
To create a virtual environment we will use the command:
```python
python -m venv my_venv
```
To activate the environment use the following command (Linux):
```python
source my_venv/bin/activate
```
# 3. Variables
# 4. Data types
## 4.1. Strings
### Using Variables in Strings
#### .format()
```python
first_name = "John"
surname = "Doe"
print("My first name is {}. My family name is {}".format(first_name, surname))
```
#### f strings
```python
firstname = "Jane"
surname = "Doe"
print(f"My first name is {firstname}. My family name is {surname}")
```
## 4.2. Numbers
* `str()` returns a string object
* `int()` returns an integer object
* `float()` returns a floating point object
* `bool()` a boolean value of True or False

## 4.3. Dictionaries
### Create
Assigning `{}` to a variable, for example:

`account_details = {}`

or use the `dict()` constructor:

`account_details = dict()`
```python
>>> user = {"first_name":"Ada"}
>>> print(user)

{'first_name': 'Ada'}
```
### Read
```python
>>> user = {"first_name":"Ada"}
>>> print(user["first_name"])
Ada
```
`dict.get(key, default=None)`
### Update
Dictionaries are mutable, which means they can be changed after you create them.
#### Add a key-value
To add an additional `key-value` to a dictionary, provide the dictionary name, the new key in `[]` and a value after an `=` sign.
```python
>>>user["family_name"] = "Byron"
>>>print(user)
{'first_name': 'Ada', 'family_name': 'Byron'}
```
#### Modify a value
To modify a value in a similar way to adding it. You provide the new value after the `=` sign.
```python
user["family_name"] = "Lovelace"
print(user)
{'first_name': 'Ada', 'family_name': 'Lovelace'}
```
### Delete a Key-Value Pair
To remove a key-value pair you use the `del` statement with the name of the dictionary and the key you want to delete.
```python
>>> del user["family_name"]
>>> print(user)
{'first_name': 'Ada'}
```

## 4.4. Lists
A list is an ordered sequence of values separated by spaces. For example:
`[0,1,2,3,4]`or `["apples","oranges","bananas"]`  

Lists are mutable, which means they can be changed after you create them. 

### Create
Assigning `[]` to a variable, for example:

`fruit = []`

or use the list() constructor:

`fruit = list()`
### Read
#### Element
```python
>>>fruit = ["apples","oranges","bananas"]
>>>print(fruit[1])
oranges
```
#### Lenght
```python
>>>len(fruit)
3
```
### Reverse
```python
>>>print(fruit[-1])
bananas
>>>print(fruit[-2])
oranges
```
### Update
You can use `append()` to add an element to the end of the list.
```python
>>> fruit.append("kiwi")
>>> print(fruit)
['apples', 'oranges', 'bananas', 'kiwi']
```
If you want add an element at a specific point in the list you can use the index value with the `insert()` method.
```python
>>> fruit.insert(2, "passion fruit")
>>> print(fruit)
['apples', 'oranges', 'passion fruit', 'bananas', 'kiwi']
```
### Organizing a list
#### Sorting
`sorted(list)`
```python
>>>print(sorted(fruit))
['apples', 'bananas', 'kiwi', 'oranges', 'passion fruit']
>>>print(fruit)
['apples', 'oranges', 'passion fruit', 'bananas', 'kiwi']
```
`list.sort()`
```python
>>> fruit.sort()
>>> print(fruit)
['apples', 'bananas', 'kiwi', 'oranges', 'passion fruit']```
```
`list.reverse()`
```python
>>>fruit.reverse()
>>> print(fruit)
['passion fruit', 'oranges', 'kiwi', 'bananas', 'apples']
```
### Delete
`del list[index]`
```python
>>> del fruit[1]
>>> print(fruit)
['passion fruit', 'kiwi', 'bananas', 'apples']
```

`list.pop()` or `list.pop(index)`
```python
>>>favorite_fruit = fruit.pop()
>>>print(favorite_fruit)
apples
```
```python
>>> fresh_fruit = fruit.pop(1)
>>> print(fresh_fruit)
kiwi
```
`list.remove(value)`
```python
>>> fruit.remove('bananas')
>>> print(fruit)
['passion fruit']
```

## 4.5. Determining Type
`type()`
```python
>>>my_variable = "A string"
>>>print(type(my_variable))
<class 'str'>
```

# 5. Python Packages
## 5.1. Install pip
In the AWS Cloud9 IDE, confirm whether` pip` is already installed for the active version of Python by running the `python -m pip --version` command:
```
ec2-user:~/environment $ python -m pip --version
pip 20.2.2 from /usr/lib/python3.7/site-packages/pip (python 3.7)
```
If pip is installed, skip to the next section.

To install pip, run the following commands. Because sudo is in a different environment from your user, you must specify the version of Python to use if it differs from the current aliased version.
```
curl -O https://bootstrap.pypa.io/get-pip.py # Get the install script.
sudo python36 get-pip.py                     # Install pip for Python 3.6.
python -m pip --version                      # Verify pip is installed.
rm get-pip.py                                # Delete the install script.
```
## 5.2. Install the AWS SDK for Python (Boto3)
After you install pip, install the AWS SDK for Python (Boto3) by running the `pip install`   command.
```
python -m pip install boto3  # Install boto3 for Python
python -m pip show boto3     # Verify boto3 is installed for the current version of Python.
```

[Boto3 documentation](https://boto3.amazonaws.com/v1/documentation/api/latest/index.html).

Use `pip freeze` to  see what packages you have installed.

## 5.3. Creating a requirements.txt file
`pip freeze > requirements.txt`

To install a *requirements.txt* file in the new virtual environment you type `pip install -r requirements.txt` in the new virtual environment to install all the same packages and dependencies from that file.

# 6. Functions
In this section we will start with a simple function and then write a function which uses the Amazon Translate Service.

*Done in Cloud9*
# 7. Arguments and Parameters
# 8. Inputs
# 9. Loops
# 10. If Statements
# 11. Logging
# 12. Errors and Exceptions
# 13. Persisting Data
# 14. Building in AWS
# 15. Clean Up
# 16. Congratulations
