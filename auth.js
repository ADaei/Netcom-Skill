"use strict";

function connectionRequest(deviceId, url, username, password, callback) {
  return callback('easycwmp', 'easycwmp');
}

exports.connectionRequest = connectionRequest;
