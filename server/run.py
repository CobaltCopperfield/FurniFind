from flask import Flask, request, jsonify
import joblib
import re

app = Flask(__name__)

# load the model from a file
model = joblib.load("model/furnitureRecommendationModel.joblib")

# Load the LabelEncoder
le_loaded = joblib.load('model/label_encoder/label_encoder.joblib')

# Function to convert text to lowercase and remove spaces, hyphens, special characters, and numbers
def text_processor(text):
    return re.sub(r'[^a-z]', '', text.lower().replace(' ', '').replace('-', ''))

# Route to handle furniture request
@app.route('/getFurniture', methods=['POST'])
def furniture_recommendation():
    data = request.get_json()

    if data:
        wood_type = data.get('woodType', '')
        thickness = data.get('thickness', 0.0)
        width = data.get('width', 0.0)
        height = data.get('height', 0.0)
        quality = data.get('quality', '')

        wood_types_list = ['acacia', 'africanmahogany', 'afzelia', 'aridda',
            'ash', 'batadomba', 'bathhik', 'beech', 'birch', 'blackwood',
            'bloodwood', 'boxwood', 'braziliancherry', 'bulu', 'burmeseblackwood',
            'butternut', 'casurina', 'cedar', 'cherry', 'cottonwood', 'cumaru',
            'cypress', 'davu', 'ebony', 'elm', 'eppingforest', 'fir', 'gokatu',
            'goncaloalves', 'hemlock', 'hickory', 'imbuia', 'ipe', 'ironwood',
            'jarrah', 'jatoba', 'kataboda', 'kauri', 'kempas', 'koa', 'laburnum',
            'larch', 'lignumvitae', 'mahogany', 'maple', 'merbau', 'mesquite',
            'mora', 'muninga', 'oak', 'padauk', 'pine', 'pinus', 'purpleheart',
            'redwood', 'sabbukku', 'spruce', 'sycamore', 'teak', 'texasebony',
            'thelambu', 'tulipwood', 'walnut', 'wamara', 'zebrawood', 'ziricote']

        wood_quality_list = ['aromatic', 'attractive', 'beautiful', 'black',
            'coarse', 'dark', 'durable', 'elegant', 'exotic', 'figured',
            'fine', 'flexible', 'hard', 'heavy', 'interlocked', 'ironlike',
            'resinous', 'resistant', 'smooth', 'stable', 'straight', 'striped',
            'strong', 'tough', 'waterresistant']

        # Process wood_type, quality strings
        wood_type_processed = text_processor(wood_type)
        quality_processed = text_processor(quality)

        try:
            # Get the index of the wood type from the wood_types_list
            wood_type_val = wood_types_list.index(wood_type_processed)

            # Get the index of the wood quality from the wood_quality_list
            quality_val = wood_quality_list.index(quality_processed)

        except ValueError:
            return jsonify({'data': 'Data not recognized!'})
        
        # Get the recommended furniture
        recommendation = model.predict([[wood_type_val, thickness, width, height, quality_val]])
        
        # Convert the recommendation to a string
        recommendation = le_loaded.inverse_transform(recommendation)[0]

        # Return a sample response
        response = {
            'data': recommendation
        }

        print(recommendation)
        return jsonify(response)

if __name__ == '__main__':
    app.run(host='0.0.0.0', debug=True)