import tensorflow as tf
filename = 'soil_classifier'

model = tf.keras.models.load_model(f'{filename}.h5')
converter = tf.lite.TFLiteConverter.from_keras_model(model)
tflite_model = converter.convert()
open(f"{filename}.tflite", "wb").write(tflite_model)