const fs = require('fs');
const path = require('path');

const logFile = path.join(__dirname, '../../storage/logs/app.log');

class Logger {

  static info(message, metaData = {}, data = {}) {
    this.write("INFO", message, metaData, data);
  }

  static error(message, metaData = {}, data = {}) {
    this.write("ERROR", message, metaData, data);
  }

  static write(level, message, metaData = {}, data = {}) {
    const log = {
      timestamp: this.formatTimestamp(),
      message,
      level,
      trace_id: this.generateTraceId(),
      service: "users-api",
      meta_data: metaData,
      data: data,
    };

    fs.appendFileSync(logFile, JSON.stringify(log) + "\n");
  }

  static generateTraceId() {
    return (
      this.randomHex(16) + ',' + this.randomHex(16)
    );
  }

  static randomHex(length) {
    return [...Array(length)]
      .map(() => Math.floor(Math.random() * 16).toString(16))
      .join('');
  }

  static formatTimestamp() {
    const now = new Date();

    const tzOffset = -now.getTimezoneOffset();
    const sign = tzOffset >= 0 ? '+' : '-';
    const hours = String(Math.floor(Math.abs(tzOffset) / 60)).padStart(2, '0');
    const minutes = String(Math.abs(tzOffset) % 60).padStart(2, '0');

    return now.toISOString().replace(/[-:]/g, '').split('.')[0] + sign + hours + ':' + minutes;
  }
}

module.exports = Logger;