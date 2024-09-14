import json

import joblib
import pandas as pd

from src.apis.garden.recommendation.ai_models.generate import generate_response
from src.apis.garden.recommendation.data_process.process import get_processed_data
from pathlib import Path
from concurrent.futures import ThreadPoolExecutor

BASE_DIR = Path(__file__).resolve().parent.parent.parent.parent


class Prediction:
    def __init__(self, data):
        self.file1_model1 = BASE_DIR / 'garden/recommendation/ai_models/model1/k_clustering4.pkl'
        self.file2_model1 = BASE_DIR / 'garden/recommendation/ai_models/model1/processed_data4.pkl'
        self.scaler_model1 = BASE_DIR / 'garden/recommendation/ai_models/model1/scaler4.pkl'

        self.processed_model_model1 = None
        self.processed_data = None
        self.predictions_model1 = None

        # Load data and models
        self.load_data_and_models(data)

    def load_data_and_models(self, data):
        self.processed_data = get_processed_data(data=data)
        self.processed_model_model1 = pd.read_pickle(self.file2_model1)

    def get_predictions(self, data, scaler, loaded_model):
        data_ = pd.DataFrame(data, index=[0])
        X_new_scaled = scaler.transform(data_)
        predictions = loaded_model.predict(X_new_scaled)
        return predictions

    def get_predictions_parallel(self, data, executor):
        # Load model1
        scaler_model1 = joblib.load(self.scaler_model1)
        loaded_model_model1 = joblib.load(self.file1_model1)

        # Run both models in parallel
        future_model1 = executor.submit(self.get_predictions, data, scaler_model1, loaded_model_model1)
        predictions_model1 = future_model1.result()

        return predictions_model1

    def filter_predictions(self):


        executor = ThreadPoolExecutor()
        self.predictions_model1 = self.get_predictions_parallel(self.processed_data, executor)
        executor.shutdown()

        return self.combine_predictions()

    def combine_predictions(self):
        try:
            data = generate_response()
            data = json.loads(data)

            predictions_model1 = [
                {
                    "name": plant["name"],
                    "category": plant["category"],
                    "bestgrow": plant["bestgrow"],
                    "network_image_address": plant["network_image_address"]
                }

                for plant in data["plants"]
            ]

        except Exception as e:
            print(e)
            predictions_model1 = self.process_predictions(self.predictions_model1, self.processed_model_model1)
        return predictions_model1

    def process_predictions(self, predictions, processed_model):
        cluster_to_seedId_names = processed_model.groupby('Cluster')['Seed_Name'].apply(list).to_dict()
        cluster_to_areas = processed_model.groupby('Cluster')['Best_Growing_Areas'].apply(list).to_dict()
        cluster_to_soils = processed_model.groupby('Cluster')['Soil_Types'].apply(list).to_dict()
        cluster_to_seed_id = processed_model.groupby('Cluster')['Seed_ID'].apply(list).to_dict()

        predicted_cluster = predictions[0]
        predicted_names = cluster_to_seedId_names.get(predicted_cluster, [])
        predicted_areas = cluster_to_areas.get(predicted_cluster, [])
        predicted_seedId = cluster_to_seed_id.get(predicted_cluster, [])
        predicted_soil = cluster_to_soils.get(predicted_cluster, [])

        data = [
            {
                'seedId': seedId,
                'seedName': seedName,
                'bestGrowingAreas': areas,
                'soilType': soil
            }
            for seedId, seedName, areas, soil in zip(predicted_seedId, predicted_names, predicted_areas, predicted_soil)
        ]

        return data
