"""
Each file that starts with test... in this directory is scanned for subclasses of unittest.TestCase or testLib.RestTestCase
"""

import unittest
import os
import testLib

class TestAdditionalFunctional(testLib.RestTestCase):
  def assertResponse(self, respData, count = None, errCode = testLib.RestTestCase.SUCCESS):
    """
    Check that the response data dictionary matches the expected values
    """
    expected = { 'errCode' : errCode }
    if count is not None:
      expected['count']  = count
    self.assertDictEqual(expected, respData)

  def testunknownUser(self):
    respData = self.makeRequest("/users/login", method="POST", data =
    {'user' : 'za', 'password' : 'bu' })
    self.assertResponse(respData, errCode =
    testLib.RestTestCase.ERR_BAD_CREDENTIALS)

  def testAdd(self):
    respData = self.makeRequest("/users/add", method="POST", data =
    {'user' : 'za', 'password' : 'bu' })
    self.assertResponse(respData, count = 1)
   
  def testReAdd(self):
    respData = self.makeRequest("/users/add", method="POST", data =
    {'user' : 'za', 'password' : 'bu'})
    self.assertResponse(respData, count = 1)
    respData = self.makeRequest("/users/add", method="POST", data =
    {'user' : 'za', 'password' : 'bu'})
    self.assertResponse(respData, errCode =
    testLib.RestTestCase.ERR_USER_EXISTS)

  def testLongPassword(self):
    respData = self.makeRequest("/users/add", method="POST", data =
    {'user' : 'zach', 'password' : 'a'*129})
    self.assertResponse(respData, errCode =
    testLib.RestTestCase.ERR_BAD_PASSWORD)

  def testLongUsername(self):
    respData = self.makeRequest("/users/add", method="POST", data =
    {'user' : 'z'*129, 'password' : 'bu'})
    self.assertResponse(respData, errCode =
    testLib.RestTestCase.ERR_BAD_USERNAME)

  def testAddWorks(self):
    respData = self.makeRequest("/users/add", method="POST", data =
    {'user' : 'za', 'password' : 'bu'})
    self.assertResponse(respData, count = 1)
    respData = self.makeRequest("/users/login", method="POST", data =
    {'user' : 'za', 'password' : 'bu'})
    self.assertResponse(respData, count = 2)
