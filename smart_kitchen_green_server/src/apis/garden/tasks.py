from celery import shared_task
from django.utils import timezone
from datetime import timedelta
from .models import Plant, RecommendedPlants
from django.contrib.auth.models import User

from ..kitchen.models import Appliance
from ..notifier import send_push_notification_to_device

from django.utils import timezone
from datetime import timedelta
@shared_task
def check_plants_watering():
    print("CHECKING PLANTS FOR WATERING TASK...")

    # Get the current time
    now = timezone.now()

    # Get all plants that have a last_watering date
    plants = Plant.objects.filter(last_watering__isnull=False)

    # Iterate through all the plants to check if they need watering
    for plant in plants:
        # Get the associated recommended plant
        recommended_plant = plant.recommended_plant

        # If the recommended plant has a watering time specified
        if recommended_plant.water_time:
            try:
                # Convert the watering time to an integer (assumes it's stored as a string)
                watering_time_hours = int(recommended_plant.water_time)

                # Calculate the next watering time by adding the watering time to the last_watering timestamp
                next_watering_time = plant.last_watering + timedelta(hours=watering_time_hours)

                # Check if the plant needs watering (if the next watering time is less than or equal to the current time)
                if next_watering_time <= now:
                    # Send notification to the user about watering
                    user_device_token = plant.user.device_token  # Assuming there's a device token stored in the User model
                    send_push_notification_to_device(
                        user_device_token,
                        "Watering Reminder",
                        f"Your plant {recommended_plant.name} needs watering!"
                    )

            except ValueError:
                print(f"Invalid watering time for {recommended_plant.name}.")

    print("Finished checking plants for watering.")

