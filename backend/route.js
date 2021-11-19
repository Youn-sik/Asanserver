const express = require('express');
const router = express.Router();
const User = require('./models/schema/user.js');
router.get('/', (req, res) => {
  res.send('/')
});
router.get('/about', (req, res) => {
  res.send('/about')
});
router.get('/:name', (req, res) => {
  User.find({ name: req.params.name }, (err, user) => {
    res.send(JSON.stringify(user))
  });
});
module.exports = router;