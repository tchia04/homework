#!flask/bin/python
#import boto.ec2
from dateutil.parser import *
import subprocess
import datetime
from datetime import datetime

from flask import Flask, jsonify, request
app = Flask(__name__)

@app.route('/', methods=['GET'])
def get_tasks():
    public_ip    = subprocess.check_output(['curl', '-s', 'http://169.254.169.254/latest/meta-data/public-ipv4'])
    private_ip   = subprocess.check_output(['curl', '-s', 'http://169.254.169.254/latest/meta-data/local-ipv4'])
    current_time_utc = str(datetime.now())


    if request.environ.get('HTTP_X_FORWARDED_FOR') is None:
        print "no http_x_forwared_for"
        return jsonify({'client ip': request.environ['REMOTE_ADDR'],
			'ec2 public_ip': public_ip,
			'ec2 private_ip': private_ip,
			'current_time_in_utc': current_time_utc,
		 }), 200
    else:
        print "has http_x_forwared_for"
        return jsonify({'client_ip': request.environ['HTTP_X_FORWARDED_FOR'],
			'ec2_public_ip': public_ip,
			'ec2_private_ip': private_ip,
			'current_time_in_utc': current_time_utc,
            }), 200

@app.route('/loaderio-14cd55e65597953829f714fdd2ba66b1/', methods=['GET'])
def get_loader_io():
        return "loaderio-14cd55e65597953829f714fdd2ba66b1", 200

if __name__ == '__main__':
#    app.run(debug=True,host='0.0.0.0', port=8000)
    app.run(debug=True,host='0.0.0.0', port=80)
