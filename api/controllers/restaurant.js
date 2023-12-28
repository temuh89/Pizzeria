import Restaurant from '../models/restaurant.js'
import { getCurrentTime } from '../utils/time.js'

export const createRestaurant = async (req, res) => {
  try {
    const { name, style, address, openhours, closehours, vegetarian } = req.body
    if (!name || !style || !address || !openhours || !closehours || !vegetarian) {
      return res.status(400).json({ message: 'missing required fields' })
    }
    const restaurant = new Restaurant({
      ...req.body,
    })
    await restaurant.save()
    res.status(201).json(restaurant)
  } catch (err) {
    res.status(400).json({ message: err.message })
  }
}

export const getRestaurants = async (req, res) => {
  try {
    const restaurants = await Restaurant.find()
    res.status(200).json(restaurants)
  } catch (err) {
    res.status(404).json({ message: err.message })
  }
}

export const getRestaurantById = async (req, res) => {
  try {
    const restaurant = await Restaurant.findById(req.params.id)
    res.status(200).json(restaurant)
  } catch (err) {
    res.status(404).json({ message: err.message })
  }
}

export const updateRestaurantById = async (req, res) => {
  try {
    const restaurant = await Restaurant.findByIdAndUpdate(
      req.params.id,
      req.body,
      { new: true }
    )
    res.status(200).json(restaurant)
  } catch (err) {
    res.status(404).json({ message: err.message })
  }
}

export const deleteRestaurantById = async (req, res) => {
  try {
    const restaurant = await Restaurant.findByIdAndDelete(req.params.id)
    res.status(200).json(restaurant)
  } catch (err) {
    res.status(404).json({ message: err.message })
  }
}

export const restaurantRecommendation = async (req, res) => {
  try {
    // recommend restauarant by name, style, address, openhours, closehours, vegetarian
    const { name, style, address, openhours, closehours, vegetarian } = req.body
    const query = {
      $or: [
        { name },
        { style },
        { address },
        { vegetarian },
      ],
    };
    if (openhours && closehours) {
      const currentTime = getCurrentTime();
      query.openhours = { $lte: currentTime };
      query.closehours = { $gte: currentTime };
    }
    const restaurant = await Restaurant.find(query);
    res.status(200).json({
      message: {
        restaurant: {
          name: restaurant.name,
          style: restaurant.style,
          address: restaurant.address,
          openhours: restaurant.openhours,
          closehours: restaurant.closehours,
          vegetarian: restaurant.vegetarian,
        }
      }
    })
  }
  catch (err) {
    res.status(404).json({ message: err.message })
  }
}