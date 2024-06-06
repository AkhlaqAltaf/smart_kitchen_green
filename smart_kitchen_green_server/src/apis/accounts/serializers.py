from rest_framework import serializers
from django.contrib.auth import get_user_model
from src.apps.whisper.main import Mailing

User = get_user_model()


class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ('id', 'email', 'password','verification_code')
        read_only_fields = ('verification_code',)
        extra_kwargs = {'password': {'write_only': True}}

    def create(self, validated_data):
        user = User.objects.create_user(
            email=validated_data['email'],
            password=validated_data['password']
        )
        code = user.verification_code
        mail = Mailing()
        mail.send_verification_code(to_email=[user.email],template="verification_email.html",code=code)

        return user







