#!/usr/bin/env python
import sys
from twython import Twython
CONSUMER_KEY = '++++++++++++++++++++'
CONSUMER_SECRET = '+++++++++++++++++++++++++++'
ACCESS_KEY = '+++++++++++++++++++++++++++++++++++'
ACCESS_SECRET = '+++++++++++++++++++++++++++++++'

api = Twython(CONSUMER_KEY,CONSUMER_SECRET,ACCESS_KEY,ACCESS_SECRET)
                                                                                                                   
api.update_status(status=sys.argv[1]) 
