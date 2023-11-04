const express = require('express');
const app = express();
const port = 4000;
const cors = require('cors');
const bodyParser = require('body-parser');


app.use(cors());
app.use(bodyParser.json());


const testData = [
    {title: 'TestTitle1', body: 'TestBody1'},
    {title: 'TestTitle2', body: 'TestBody2'},
    {title: 'TestTitle3', body: 'TestBody3'},
    {title: 'TestTitle4', body: 'TestBody4'},
    {title: 'TestTitle5', body: 'TestBody5'}
]



app.get('/api/getitems', (req, res) => {
    res.header('getHeader','getValue')
    res.json(testData);
  });

app.post('/api/Postitems',(req,res) => {
  const data = req.body;
  testData.push (data);
res.status(200).send('데이터가 정상적으로 저장되었습니다.');



});


  app.listen(port, () => {
    console.log(`서버가 포트 ${port}에서 실행중입니다.`);
  });
  