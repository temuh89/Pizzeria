import './loadEnv.js'
import express, { json } from 'express'
import cors from 'cors'
import { connect as _connect, set } from 'mongoose'
import bodyParser from 'body-parser'
import { restaurantRecommendation } from './controllers/restaurant.js'

const app = express()
app.use(cors())
app.use(json())
app.use(bodyParser.urlencoded({ extended: true }))
app.use(express.urlencoded({ extended: true }))
app.use(express.json())

app.use('/restaurant', restaurantRecommendation)

set('strictQuery', true)
const url = `mongodb+srv://${process.env.USER_NAME}:${process.env.PASSWORD}${process.env.MONGODB_URI}`
const connect = _connect(url, {
  useNewUrlParser: true,
  autoIndex: false,
})
connect
  .then(() => {
    console.log('connected to db succesfully')
  })
  .catch((err) => {
    console.log(err.message)
  })

const PORT = process.env.PORT || 8000
app.get('/', (req, res) => res.send('welcome to Pizerria API'))
app.listen(PORT, () => {
  console.log(`server is running at http://localhost:${PORT}`)
})