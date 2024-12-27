from django.http import HttpResponseRedirect, JsonResponse
from django.shortcuts import render
from django.urls import reverse
from django.views import View
from django.views.generic import TemplateView ,RedirectView

from src.apis.accounts.models import CustomUser
from src.apis.notifier import send_push_notification_to_device
from src.apps.whisper.main import Mailing


class HomeView(TemplateView):
    template_name = "website/home.html"


def send_notification_view(request):
    if request.method == 'POST':
        # Get the selected user from the form
        user_id = request.POST.get('user_id')
        user = CustomUser.objects.get(id=user_id)

        # Send notification to the user's device if device_token exists
        if user.device_token:
            send_push_notification_to_device(
                user.device_token,
                "Test Notification",
                "This is a test notification sent to the selected user."
            )
            message = f"Notification sent to {user.email}."
        else:
            message = "Selected user does not have a device token."

        return JsonResponse({"message": message})

    # For GET requests, render the form
    users_with_device_token = CustomUser.objects.filter(device_token__isnull=False)
    return render(request, 'website/send_notification.html', {'users': users_with_device_token})


class AboutUsView(TemplateView):
    template_name = "website/aboutus.html"


class ApiDocView(TemplateView):
    template_name = "website/apidoc.html"


class ContactUsView(View):
    def get(self, request):
        return render(request, 'website/contactus.html')

    def post(self, request):
        subject = request.POST.get('subject', '')
        email = request.POST.get('email', '')
        message = request.POST.get('message', '')

        mail = Mailing()
        mail.send_email_to_admin(
            subject=subject,from_mail=email , message=message
        )

        return HttpResponseRedirect(reverse('website:contactus'))



class ApiReverse(View):
    def get(self,request):
        return reverse('api:api/')