import firebase_admin
from firebase_admin import credentials ,messaging

from core.settings import BASE_DIR

cred = credentials.Certificate(f"{BASE_DIR}/firebase.json")
firebase_admin.initialize_app(cred)


def send_push_notification_to_device(token, title, body):
    message = messaging.Message(
        notification=messaging.Notification(
            title=title,
            body=body,
        ),
        token=token,
    )

    response = messaging.send(message)
    print('Successfully sent message:', response)
