import 'package:flutter/material.dart';

const timeOfDayEmoji = [
  '🔆',
  '☀️',
  '🌤️',
  '🌙',
  '🌚',
];

const dashboardMessage = [
  'howdy there 👋',
  'good day 😁',
  'hi there 😉',
];

String emojiTimeOfDay() {
  if (TimeOfDay.now().hour > 0 && TimeOfDay.now().hour <= 5) {
    return timeOfDayEmoji[0];
  } else if (TimeOfDay.now().hour > 5 && TimeOfDay.now().hour < 12) {
    return timeOfDayEmoji[1];
  } else if (TimeOfDay.now().hour >= 12 && TimeOfDay.now().hour < 17) {
    return timeOfDayEmoji[2];
  } else if (TimeOfDay.now().hour >= 17 && TimeOfDay.now().hour < 20) {
    return timeOfDayEmoji[3];
  } else {
    return timeOfDayEmoji[4];
  }
}

const categoryEmojiMap = {
  'Beef': '🥩',
  'Chicken': '🐔',
  'Dessert': '🍰',
  'Lamb': '🐑',
  'Pasta': '♨',
  'Pork': '🐖',
  'Seafood': '🦐',
  'Side Dish': '🥙',
  'Starter': '🍚',
  'Vegan': '🥦',
  'Vegetarian': '🥕',
  'Breakfast': '🍞',
  'Goat': '🐐',
  'Others': '🤷‍♀️',
};
