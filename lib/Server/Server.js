const express = require('express');
const app = express();
const port = 4000;
const cors = require('cors');
const bodyParser = require('body-parser');

const mysql = require('mysql2');
const connection = mysql.createConnection({
  host: 'localhost',
  user: 'Hwan',
  password: '0727',
  database: 'JIGU'
});

app.use(cors());
app.use(bodyParser.json());

connection.connect((err) => {
  if (err) {
    console.error('Database connection error: ' + err.stack);
    return;
  }
  console.log('Connected to MySQL database.');
});

// const testData = [
//   { title: 'TestTitle1', body: 'TestBody1' },
//   { title: 'TestTitle2', body: 'TestBody2' },
//   { title: 'TestTitle3', body: 'TestBody3' },
//   { title: 'TestTitle4', body: 'TestBody4' },
//   { title: 'TestTitle5', body: 'TestBody5' }
// ]




const select = 'SELECT * FROM notice_board;';




app.get('/api/getitems', (req, res) => {
  connection.query(select, (err, results) => {
    if (err) {
      console.error('Error' + err.stack);
      res.status(500).json({ error: 'Error fetching data' });
      return;
    }

    // 데이터를 확인하기 위해 콘솔에 출력
    console.log(results);

    res.header('getHeader', 'getValue');
    res.json(results);
  });
});



app.post('/api/Postitems', (req, res) => {

  
  console.log('함수 실행됨')
  const data = req.body;
  //testData.push(data);
console.log(data)

  connection.query(
    'insert into notice_board (TITLE,CONTENT) values (?,?)',
    [data.TITLE, data.CONTENT],
    (err, result) => {
      if (err) {
        console.log('error' + err.stack);
        res.status(500).json({ error: 'error' })
        return
      }
      console.log('Data saved to MySQL database.');
      res.status(200).send('데이터가 정상적으로 저장되었습니다.');
    }
  )
});


app.listen(port, () => {
  console.log(`서버가 포트 ${port}에서 실행중입니다.`);
});
