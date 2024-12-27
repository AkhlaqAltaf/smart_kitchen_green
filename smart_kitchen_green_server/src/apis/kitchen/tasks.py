# your_app/tasks.py
from celery import shared_task
from django.utils import timezone
from .models import Product, Appliance
from django.core.mail import send_mail  # Or your notification function

from ..notifier import send_push_notification_to_device

from celery import shared_task
from django.utils import timezone
from datetime import timedelta, datetime
from .models import Product

from celery import shared_task
from django.utils import timezone
from datetime import timedelta


from datetime import timedelta
from django.utils import timezone
from celery import shared_task
from src.apis.kitchen.models import Appliance

@shared_task
def check_appliance_runtime():
    print("CHECKING APPLIANCES...")

    # Get current time
    now = timezone.now()

    # Loop through all appliances
    appliances = Appliance.objects.all()

    for appliance in appliances:
        # Get the appliance creation time
        created_at = appliance.created_at
        # Parse the take_time field (assumed to be in minutes)
        if appliance.take_time:
            try:
                take_time_minutes = int(appliance.take_time)  # Convert take_time directly to integer (minutes)
                take_time = timedelta(minutes=take_time_minutes)  # Convert minutes to timedelta

            except ValueError as e:
                print(f"Error parsing take_time for appliance {appliance.name}: {e}. Skipping.")
                continue

            # Calculate the elapsed time since appliance was created
            elapsed_time = now - created_at

            # Check if the appliance has been running longer than the specified take_time
            if elapsed_time > take_time:
                # Check if the appliance has already been notified 3 times
                if appliance.notification_count < 3:
                    # Notify the user
                    user_device_token = appliance.user.device_token  # Get the user's device token
                    send_push_notification_to_device(
                        user_device_token,
                        "Appliance Overuse",
                        f"Your {appliance.product.name} has been running longer than expected. Please check it."
                    )
                    # Increment the notification count
                    appliance.notification_count += 1
                    appliance.save()

                # If notified 3 times, delete the appliance
                if appliance.notification_count >= 3:
                    appliance.delete()
                    print(f"Appliance {appliance.name} deleted after 3 notifications.")

    print("Finished checking appliances.")


@shared_task
def check_expiry_dates():
    print("CHECKING EXPIRY DATES...")

    now = timezone.now()
    today = now.date()  # Get today's date

    # Notify about products that expire today
    products_expiring_today = Product.objects.filter(type='CAN_USE')

    for product in products_expiring_today:
        # Parse the expiry_date string to a date object
        expiry_date = datetime.strptime(product.expiry_date, '%Y-%m-%d').date()

        # Check if the expiry date is today
        if expiry_date == today:
            user_device_token = product.user.device_token  # Get the user's device token


            send_push_notification_to_device(
                    user_device_token,
                    "Expiry Reminder",
                    f"Your product {product.name} expires today. Please use it or remove it."
                )

                # Increment the notification count
            product.notification_count += 1
            product.save()

    # Notify about products that have already expired (before today)
    products_expired = Product.objects.filter(type='CAN_USE')

    for product in products_expired:
        # Parse the expiry_date string to a date object
        expiry_date = datetime.strptime(product.expiry_date, '%Y-%m-%d').date()

        # Check if the expiry date is in the past
        if expiry_date < today:
            user_device_token = product.user.device_token  # Get the user's device token

             # Allow up to 3 notifications before stopping
            send_push_notification_to_device(
                    user_device_token,
                    "Expired",
                    f"Your product {product.name} has expired. Please use it or remove it."
                )

                # Increment the notification count
            product.notification_count += 1
            product.save()

    print("Finished checking expiry dates.")
