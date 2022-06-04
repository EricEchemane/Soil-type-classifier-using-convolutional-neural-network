import tensorflow as tf
import numpy as np
from tensorflow import keras

image = tf.keras.preprocessing.image

CLASSES = ['clay', 'gravel', 'humus', 'peat', 'sand']

def classify(image_fp):
    img = image.load_img(image_fp, target_size = (256, 256))
    img = image.img_to_array(img)

    image_array = img / 255. # scale the image
    img_batch = np.expand_dims(image_array, axis = 0)

    class_ = CLASSES # possible output values
    model = keras.models.load_model('soil_classifier.h5')
    predicted_value = model.predict(img_batch)

    out  = {
      "clay": f"{predicted_value[0][0]:.5f}",
      "gravel": f"{predicted_value[0][1]:.5f}",
      "humus": f"{predicted_value[0][2]:.5f}",
      "peat": f"{predicted_value[0][3]:.5f}",
      "sand": f"{predicted_value[0][4]:.5f}",
      "Result": f"{(predicted_value[0][predicted_value.argmax()] * 100):.2f}% {class_[predicted_value.argmax()]}"
    }
    return out