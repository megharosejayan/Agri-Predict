from flask import Flask, render_template, request, jsonify
import pandas as pd 
import numpy as np 
import pickle 
import streamlit as st 
from PIL import Image 
import json


app = Flask(__name__)
def analysis(state,city,crop,season,area):
        result = {}
        crops={'Arhar/Tur': 0, 'Bajra': 1, 'Barley': 2, 'Castor seed': 3, 'Cotton(lint)': 4, 'Dry chillies': 5, 'Gram': 6, 'Groundnut': 7, 'Horse-gram': 8, 'Jowar': 9, 'Khesari': 10, 'Linseed': 11, 'Maize': 12, 'Masoor': 13, 'Mesta': 14, 'Moong(Green Gram)': 15, 'Niger seed': 16, 'Onion': 17, 'Other  Rabi pulses': 18, 'Other Kharif pulses': 19, 'Peas & beans (Pulses)': 20, 'Ragi': 21, 'Rapeseed &Mustard': 22, 'Rice': 23, 'Safflower': 24, 'Sesamum': 25, 'Small millets': 26, 'Soyabean': 27, 'Sunflower': 28, 'Urad': 29, 'Wheat': 30}
        seasons={'Autumn': 0, 'Kharif': 1, 'Rabi': 2, 'Summer': 3, 'Winter': 4}  
        cities={'AGAR MALWA': 0, 'AHMADABAD': 1, 'AHMEDNAGAR': 2, 'AKOLA': 3, 'ALAPPUZHA': 4, 'ALIRAJPUR': 5, 'AMBALA': 6, 'AMRAVATI': 7, 'AMRELI': 8, 'ANAND': 9, 'ANANTAPUR': 10, 'ANANTNAG': 11, 'ANJAW': 12, 'ANUPPUR': 13, 'ARARIA': 14, 'ARWAL': 15, 'ASHOKNAGAR': 16, 'AURANGABAD': 17, 'BADGAM': 18, 'BAGALKOT': 19, 'BAKSA': 20, 'BALAGHAT': 21, 'BALOD': 22, 'BALODA BAZAR': 23, 'BALRAMPUR': 24, 'BANAS KANTHA': 25, 'BANDIPORA': 26, 'BANGALORE RURAL': 27, 'BANKA': 28, 'BARAMULLA': 29, 'BARPETA': 30, 'BARWANI': 31, 'BASTAR': 32, 'BEED': 33, 'BEGUSARAI': 34, 'BELGAUM': 35, 'BELLARY': 36, 'BEMETARA': 37, 'BENGALURU URBAN': 38, 'BETUL': 39, 'BHAGALPUR': 40, 'BHANDARA': 41, 'BHARUCH': 42, 'BHAVNAGAR': 43, 'BHIND': 44, 'BHIWANI': 45, 'BHOJPUR': 46, 'BHOPAL': 47, 'BIDAR': 48, 'BIJAPUR': 49, 'BILASPUR': 50, 'BOKARO': 51, 'BONGAIGAON': 52, 'BULDHANA': 53, 'BURHANPUR': 54, 'BUXAR': 55, 'CACHAR': 56, 'CHAMARAJANAGAR': 57, 'CHAMBA': 58, 'CHANDIGARH': 59, 'CHANDRAPUR': 60, 'CHANGLANG': 61, 'CHATRA': 62, 'CHHATARPUR': 63, 'CHHINDWARA': 64, 'CHIKBALLAPUR': 65, 'CHIKMAGALUR': 66, 'CHIRANG': 67, 'CHITRADURGA': 68, 'CHITTOOR': 69, 'DADRA AND NAGAR HAVELI': 70, 'DAKSHIN KANNAD': 71, 'DAMOH': 72, 'DANG': 73, 'DANTEWADA': 74, 'DARBHANGA': 75, 'DARRANG': 76, 'DATIA': 77, 'DAVANGERE': 78, 'DEOGHAR': 79, 'DEWAS': 80, 'DHAMTARI': 81, 'DHANBAD': 82, 'DHAR': 83, 'DHARWAD': 84, 'DHEMAJI': 85, 'DHUBRI': 86, 'DHULE': 87, 'DIBANG VALLEY': 88, 'DIBRUGARH': 89, 'DIMA HASAO': 90, 'DINDORI': 91, 'DODA': 92, 'DOHAD': 93, 'DUMKA': 94, 'DURG': 95, 'EAST GODAVARI': 96, 'EAST KAMENG': 97, 'EAST SIANG': 98, 'EAST SINGHBUM': 99, 'ERNAKULAM': 100, 'FARIDABAD': 101, 'FATEHABAD': 102, 'GADAG': 103, 'GADCHIROLI': 104, 'GANDERBAL': 105, 'GANDHINAGAR': 106, 'GARHWA': 107, 'GARIYABAND': 108, 'GAYA': 109, 'GIRIDIH': 110, 'GOALPARA': 111, 'GODDA': 112, 'GOLAGHAT': 113, 'GONDIA': 114, 'GOPALGANJ': 115, 'GULBARGA': 116, 'GUMLA': 117, 'GUNA': 118, 'GUNTUR': 119, 'GURGAON': 120, 'GWALIOR': 121, 'HAILAKANDI': 122, 'HAMIRPUR': 123, 'HARDA': 124, 'HASSAN': 125, 'HAVERI': 126, 'HAZARIBAGH': 127, 'HINGOLI': 128, 'HISAR': 129, 'HOSHANGABAD': 130, 'IDUKKI': 131, 'INDORE': 132, 'JABALPUR': 133, 'JALGAON': 134, 'JALNA': 135, 'JAMMU': 136, 'JAMNAGAR': 137, 'JAMTARA': 138, 'JAMUI': 139, 'JANJGIR-CHAMPA': 140, 'JASHPUR': 141, 'JEHANABAD': 142, 'JHABUA': 143, 'JHAJJAR': 144, 'JIND': 145, 'JORHAT': 146, 'JUNAGADH': 147, 'KABIRDHAM': 148, 'KACHCHH': 149, 'KADAPA': 150, 'KAIMUR (BHABUA)': 151, 'KAITHAL': 152, 'KAMRUP': 153, 'KAMRUP METRO': 154, 'KANGRA': 155, 'KANKER': 156, 'KANNUR': 157, 'KARBI ANGLONG': 158, 'KARGIL': 159, 'KARIMGANJ': 160, 'KARNAL': 161, 'KASARAGOD': 162, 'KATHUA': 163, 'KATIHAR': 164, 'KATNI': 165, 'KHAGARIA': 166, 'KHANDWA': 167, 'KHARGONE': 168, 'KHEDA': 169, 'KHUNTI': 170, 'KINNAUR': 171, 'KISHANGANJ': 172, 'KISHTWAR': 173, 'KODAGU': 174, 'KODERMA': 175, 'KOKRAJHAR': 176, 'KOLAR': 177, 'KOLHAPUR': 178, 'KOLLAM': 179, 'KONDAGAON': 180, 'KOPPAL': 181, 'KORBA': 182, 'KOREA': 183, 'KOTTAYAM': 184, 'KOZHIKODE': 185, 'KRISHNA': 186, 'KULGAM': 187, 'KULLU': 188, 'KUPWARA': 189, 'KURNOOL': 190, 'KURUKSHETRA': 191, 'KURUNG KUMEY': 192, 'LAHUL AND SPITI': 193, 'LAKHIMPUR': 194, 'LAKHISARAI': 195, 'LATEHAR': 196, 'LATUR': 197, 'LEH LADAKH': 198, 'LOHARDAGA': 199, 'LOHIT': 200, 'LONGDING': 201, 'LOWER DIBANG VALLEY': 202, 'LOWER SUBANSIRI': 203, 'MADHEPURA': 204, 'MADHUBANI': 205, 'MAHASAMUND': 206, 'MAHENDRAGARH': 207, 'MAHESANA': 208, 'MALAPPURAM': 209, 'MANDI': 210, 'MANDLA': 211, 'MANDSAUR': 212, 'MANDYA': 213, 'MARIGAON': 214, 'MEWAT': 215, 'MORENA': 216, 'MUMBAI': 217, 'MUNGELI': 218, 'MUNGER': 219, 'MUZAFFARPUR': 220, 'MYSORE': 221, 'NAGAON': 222, 'NAGPUR': 223, 'NALANDA': 224, 'NALBARI': 225, 'NANDED': 226, 'NANDURBAR': 227, 'NARAYANPUR': 228, 'NARMADA': 229, 'NARSINGHPUR': 230, 'NASHIK': 231, 'NAVSARI': 232, 'NAWADA': 233, 'NEEMUCH': 234, 'NICOBARS': 235, 'NORTH AND MIDDLE ANDAMAN': 236, 'NORTH GOA': 237, 'OSMANABAD': 238, 'PAKUR': 239, 'PALAKKAD': 240, 'PALAMU': 241, 'PALGHAR': 242, 'PALWAL': 243, 'PANCH MAHALS': 244, 'PANCHKULA': 245, 'PANIPAT': 246, 'PANNA': 247, 'PAPUM PARE': 248, 'PARBHANI': 249, 'PASHCHIM CHAMPARAN': 250, 'PATAN': 251, 'PATHANAMTHITTA': 252, 'PATNA': 253, 'POONCH': 254, 'PORBANDAR': 255, 'PRAKASAM': 256, 'PULWAMA': 257, 'PUNE': 258, 'PURBI CHAMPARAN': 259, 'PURNIA': 260, 'RAICHUR': 261, 'RAIGAD': 262, 'RAIGARH': 263, 'RAIPUR': 264, 'RAISEN': 265, 'RAJAURI': 266, 'RAJGARH': 267, 'RAJKOT': 268, 'RAJNANDGAON': 269, 'RAMANAGARA': 270, 'RAMBAN': 271, 'RAMGARH': 272, 'RANCHI': 273, 'RATLAM': 274, 'RATNAGIRI': 275, 'REASI': 276, 'REWA': 277, 'REWARI': 278, 'ROHTAK': 279, 'ROHTAS': 280, 'SABAR KANTHA': 281, 'SAGAR': 282, 'SAHARSA': 283, 'SAHEBGANJ': 284, 'SAMASTIPUR': 285, 'SAMBA': 286, 'SANGLI': 287, 'SARAIKELA KHARSAWAN': 288, 'SARAN': 289, 'SATARA': 290, 'SATNA': 291, 'SEHORE': 292, 'SEONI': 293, 'SHAHDOL': 294, 'SHAJAPUR': 295, 'SHEIKHPURA': 296, 'SHEOHAR': 297, 'SHEOPUR': 298, 'SHIMLA': 299, 'SHIMOGA': 300, 'SHIVPURI': 301, 'SHOPIAN': 302, 'SIDHI': 303, 'SIMDEGA': 304, 'SINDHUDURG': 305, 'SINGRAULI': 306, 'SIRMAUR': 307, 'SIRSA': 308, 'SITAMARHI': 309, 'SIVASAGAR': 310, 'SIWAN': 311, 'SOLAN': 312, 'SOLAPUR': 313, 'SONIPAT': 314, 'SONITPUR': 315, 'SOUTH ANDAMANS': 316, 'SOUTH GOA': 317, 'SPSR NELLORE': 318, 'SRIKAKULAM': 319, 'SRINAGAR': 320, 'SUKMA': 321, 'SUPAUL': 322, 'SURAJPUR': 323, 'SURAT': 324, 'SURENDRANAGAR': 325, 'SURGUJA': 326, 'TAPI': 327, 'TAWANG': 328, 'THANE': 329, 'THIRUVANANTHAPURAM': 330, 'THRISSUR': 331, 'TIKAMGARH': 332, 'TINSUKIA': 333, 'TIRAP': 334, 'TUMKUR': 335, 'UDALGURI': 336, 'UDHAMPUR': 337, 'UDUPI': 338, 'UJJAIN': 339, 'UMARIA': 340, 'UNA': 341, 'UPPER SIANG': 342, 'UPPER SUBANSIRI': 343, 'UTTAR KANNAD': 344, 'VADODARA': 345, 'VAISHALI': 346, 'VALSAD': 347, 'VIDISHA': 348, 'VISAKHAPATANAM': 349, 'VIZIANAGARAM': 350, 'WARDHA': 351, 'WAYANAD': 352, 'WEST GODAVARI': 353, 'WEST KAMENG': 354, 'WEST SIANG': 355, 'WEST SINGHBHUM': 356, 'YADGIR': 357, 'YAMUNANAGAR': 358}
        city=city.upper()
        print(cities[city])
        states={'Andaman and Nicobar Islands': 0, 'Andhra Pradesh': 1, 'Arunachal Pradesh': 2, 'Assam': 3, 'Bihar': 4, 'Chandigarh': 5, 'Chhattisgarh': 6, 'Dadra and Nagar Haveli': 7, 'Goa': 8, 'Gujarat': 9, 'Haryana': 10, 'Himachal Pradesh': 11, 'Jammu and Kashmir ': 12, 'Jharkhand': 13, 'Karnataka': 14, 'Kerala': 15, 'Madhya Pradesh': 16, 'Maharashtra': 17} 

    #try:
        pickle_in = open('agri_rf_model_5.pkl', 'rb') 
        regressor = pickle.load(pickle_in) 
        prediction = regressor.predict([[states[state],cities[city],2021,seasons[season],crops[crop],area]]) 
        print("Prediction=")
        print(prediction)
        result["data"] = round(prediction.tolist()[0],3)
        result["status"] = "success"
    #except:
    #    result["data"] = None
    #    result["status"] = "failed"
        return result


@app.route('/API/postData', methods=['POST'])
def get_prediction():
        response = {}
    #try:
        body = request.get_json()
        
        state = body['state']
        city = body['city']
        crop = body['crop']
        season = body['season']
        area = body['area']
        print("state=",state)
        print("city=",city)
        print("crop=",crop)
        print("season=",season)
        print("area=",area)
	
        response = analysis(state,city,crop,season,area)
    #except:
    #    response["data"] = None
    #    response["status"] = "failed"
        
        return jsonify(response)

if __name__ == '__main__':
    app.run()
    
