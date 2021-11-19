const mongoose = require('mongoose');
const stbSchema = new mongoose.Schema({
  main_serial_number: String,
  sub_serial_number: String,
  network_status: String,
  update_time: String,
});
module.exports = mongoose.model('Stb', stbSchema);