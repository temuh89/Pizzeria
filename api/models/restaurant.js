import { Schema, model } from 'mongoose';

const restaurantSchema = new Schema({
  name: {
    type: String,
    required: true,
    unique: true,
  },
  address: {
    type: String,
    required: false,
  },
  style: {
    type: String,
    required: false,
  },
  vegetarian: {
    type: Boolean,
    required: false,
    default: false,
  },
  openingHours: {
    type: Date,
    required: false,
  },
  closingHours: {
    type: Date,
    required: false,
  },
  delivers: {
    type: Boolean,
    required: false,
    default: false,
  },
  }, {
    timestamps: true,
});

export default model('Restaurant', restaurantSchema);
