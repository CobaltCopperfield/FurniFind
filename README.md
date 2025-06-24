# FurniFind

A Flutter mobile application that recommends the most suitable furniture type based on wood specifications using machine learning.

## Overview

FurniFind is an intelligent furniture recommendation system that analyzes wood properties and suggests the best furniture type to create. The app uses a machine learning model trained on wood characteristics to provide accurate recommendations for furniture makers and woodworking enthusiasts.

## Features

- **Wood Type Selection**: Choose from 65+ supported wood types including Oak, Teak, Mahogany, Pine, and more
- **Dimensional Input**: Specify wood dimensions (thickness, width, height)
- **Quality Assessment**: Input wood quality characteristics (strength, durability, appearance, etc.)
- **AI Recommendations**: Get instant furniture suggestions based on your wood specifications
- **Simple Interface**: Clean, user-friendly design for easy input and quick results

## Supported Furniture Types

The app can recommend 9 different furniture types:
- Bookcase
- Dresser
- Coat Rack
- Picture Frame
- Cabinet
- Rocking Chair
- Coffee Table
- Garden Bench
- Dining Table

## Supported Wood Types

Over 65 wood types are supported, including:
- **Hardwoods**: Oak, Maple, Cherry, Walnut, Mahogany, Teak
- **Softwoods**: Pine, Fir, Cedar, Spruce, Hemlock
- **Exotic Woods**: Zebrawood, Purpleheart, Ebony, Bloodwood
- **Regional Varieties**: African Mahogany, Brazilian Cherry, Burmese Blackwood

## Wood Quality Characteristics

The system recognizes 25 different wood quality attributes:
- Strength properties: Strong, Tough, Hard, Durable
- Appearance: Beautiful, Attractive, Elegant, Figured
- Texture: Smooth, Fine, Coarse, Striped
- Special properties: Water-resistant, Aromatic, Flexible

## Technical Architecture

### Mobile App (Flutter)
- **Framework**: Flutter
- **Language**: Dart
- **HTTP Client**: http package for API communication
- **UI Components**: Material Design widgets

### Backend Server (Flask)
- **Framework**: Flask (Python)
- **Machine Learning**: scikit-learn Decision Tree Classifier
- **Model Accuracy**: 99.99%
- **Data Processing**: Text normalization and preprocessing
- **API Endpoint**: POST `/getFurniture`

### Machine Learning Model
- **Algorithm**: Decision Tree Classifier
- **Training Data**: 149,409 wood-furniture combinations
- **Features**: Wood type, thickness, width, height, quality
- **Preprocessing**: Label encoding for categorical variables

## Installation & Setup

### Prerequisites
- Flutter SDK
- Python 3.7+
- Android Studio / VS Code

### Mobile App Setup
1. Clone the repository
2. Navigate to the Flutter project directory
3. Install dependencies:
  ```bash
  flutter pub get
  ```
4. Update the server IP address in the code (line 61):
  ```dart
  final url = Uri.parse('http://YOUR_SERVER_IP:5000/getFurniture');
  ```   
5. Run the app:
   ```flutter
   flutter run
   ```

### Backend Server Setup
1. Install Python dependencies:
   ```bash
   pip install flask joblib scikit-learn pandas numpy
   ```
2. Ensure the model files are in the correct directories:
   - model/furnitureRecommendationModel.joblib
   - model/label_encoder/label_encoder.joblib
3. Start the Flask server:
   ```bash
   python app.py
   ```
4. Server will run on http://0.0.0.0:5000

## Usage

1. **Launch the app** on your mobile device
2. **Enter wood specifications**:
   - Wood type (e.g., "Oak", "Pine")
   - Thickness (0.25 - 4 inches)
   - Width (2 - 12 inches)
   - Height (4 - 16 inches)
   - Quality characteristics (e.g., "Strong", "Durable")
3. **Tap "Analyze"** to get your recommendation
4. **View the result** displaying the most suitable furniture type

## API Reference

### POST /getFurniture

Request body:

```bash
{
  "woodType": "Oak",
  "thickness": 2.5,
  "width": 8.0,
  "height": 12.0,
  "quality": "Strong"
}
```

Response:

```bash
{
  "data": "Dining Table"
}
```

## Model Performance

- **Accuracy**: 99.99%
- **Training Dataset**: 149,409 records
- **Validation Method**: Train-test split (80/20)
- **Model Type**: Decision Tree Classifier

## Development Notes

### Input Validation
- Wood types and qualities are case-insensitive
- Special characters and spaces are automatically removed
- Numeric inputs are validated for appropriate ranges

### Error Handling
- Invalid wood types/qualities return "Data not recognized!"
- Network errors display "Failed to fetch data from server"
- Input validation prevents invalid submissions

## Future Enhancements

- Add wood cost estimation
- Include project difficulty ratings
- Implement user favorites and history
- Add wood availability checker
- Include step-by-step furniture guides

For issues, questions, or suggestions, please create an issue in the project repository.

---

**FurniFind** - Making woodworking smarter, one recommendation at a time! 🪵🔨
