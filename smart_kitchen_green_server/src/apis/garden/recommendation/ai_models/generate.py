import google.generativeai as genai

from core import settings



def generate_response():

    genai.configure(api_key=settings.API_KEY)

    model = genai.GenerativeModel('gemini-1.5-flash')

    prompt = "Please Show me 20 plants  For best Grow in Abbottabad Pakistan in now days (8/24/2024) ,Response Type should be json in e.g plants=[{name:plantname,category:category,bestgrow:indoor/outdoor,network_image_address:url}.....]"
    response = model.generate_content(prompt)
    print(response.text)
    return  response.text