import { Router } from 'express'
import { restaurantRecommendation } from '../controllers/restaurant.js'
const restaurant = Router()

restaurant.post('/recommendation', restaurantRecommendation)

export default restaurant

