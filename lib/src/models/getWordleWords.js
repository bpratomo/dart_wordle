'use strict';

const fs = require('fs');

let rawdata = fs.readFileSync('dictionary.json');
let dictionary = JSON.parse(rawdata);
let filtered = Object.keys(dictionary).filter(word => word.length == 5)
let finalData = JSON.stringify(filtered)
fs.writeFileSync('WordleWords.json',finalData)
console.log(filtered) 