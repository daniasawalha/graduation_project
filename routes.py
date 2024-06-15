
import random
from datetime import datetime
from flask import Flask, request, jsonify
from faker import Faker
import mysql.connector
import pandas as pd
import numpy as np
import os
import smtplib, ssl
fake = Faker('ar_JO')
#Establishing a connection to the MySQL database named "graduation_prj".
#Hardcoding database credentials (user, password) directly in the code might not be secure.

db_connection = mysql.connector.connect(
        host="127.0.0.1",
        user="root",
        password="Ibrahim@77",
        database="graduation_prj"
        )


#Function to check login credentials against the database.
def check_login(username, password):
    #It executes a SQL query to find a match for the provided username and password.
    cursor = db_connection.cursor()
    query = "SELECT ID_DOCTOR FROM doctor WHERE Username = %s AND Password = %s"
    cursor.execute(query, (username, password))
    result = cursor.fetchall()
    #The result is returned as a Pandas DataFrame
    r = pd.DataFrame(result, columns=["ID_DOCTOR"])
    db_connection.commit()
    cursor.close()
    return r


#This route handles POST requests to '/loginGet' for user login.
app = Flask(__name__)
@app.route('/loginGet', methods=['POST'])
def login():
  global data,login_message,username,password
  try:
    data = request.get_json(force=True)

    # Check if data is an array and extract the first element
    if isinstance(data, list) and len(data) > 0:
        data = data[0]

    # Extracting username and password from the JSON data
    username = data.get("username")
    password = data.get("password")
    result = check_login(username, password)
    username.lower()
    
    # Check if the DataFrame is not empty
    if not result.empty:
        login_message = str(result["ID_DOCTOR"].iloc[0])
            #calls the check_login function, and returns a login message.
    else:
        login_message = "Login failed."

    return jsonify(login_message)
  except Exception as e:
        print(f"An error occurred: {str(e)}")
        print("Request data:", request.data)  # Print the raw request data
        print("JSON data:", data)  # Print the extracted JSON data
        return jsonify({"error": "Internal Server Error"}), 500
    


#Function to get the current time formatted as "YYYY-MM-DD HH:MM:SS".
def time():
    current_time = datetime.now()
    current_time_formatted = current_time.strftime("%Y-%m-%d %H:%M:%S")
    return(current_time_formatted)
def ID(result):
# Function to generate a unique ID based on some input
    ID_Patients=np.array([12386285,15020752,17070388,22623164,26200758,27200485,29056646,30024213,36948248,
                    38380904,41351968,42332677,54473461,55883294,56904668,60177972,63428957,64594982,66628385,71704080,
                    82000579,84554902])
    
   
    result_str = str(result)[:3]
    random_ID_Patients = random.choice(ID_Patients)
    random_ID_Patients_str = str(random_ID_Patients)
    list_result = [char for char in random_ID_Patients_str]
    list_doctor = [char for char in result_str]
    list_doctor_t = list_doctor[:3]
    list_result_t = list_result[:3]
    random_n = random.randint(1, 100)
    random_n_str = str(random_n)
    current_time = datetime.now()
    current_time_formatted = current_time.strftime("%Y")
    res = ''.join(list_doctor_t) +'_'+ ''.join(list_result_t)+"_"+''.join(current_time_formatted)+'_'+random_n_str
    
    
    return res

def id_doctor(result):
    
    return result


def id_img(k):
    return k

def name_img(gg, idimg):
    gg_str = ''.join(gg)  # Convert the list gg to a string
    n = idimg + '_' + gg_str
    return n
def ifpos(gg):
    gg=str(gg)
    g=[' G1',' G2',' G3']
    if gg in g:
        return "positive"
    else :
        "negative"

import base64


def encode_image_to_base64(img_path):
    
    try:
        with open(img_path, "rb") as image_file:
            encoded_image = base64.b64encode(image_file.read())
            return encoded_image.decode('utf-8')
    except FileNotFoundError:
        print("Error: File not found.")
        return None
    except Exception as e:
        print(f"Error: {e}")
        return None



#rahaf
import imghdr  # Python standard library module for determining image file type

def decode_base64_to_image(encoded_string, idd, state, idimg):
    try:
        decoded_image = base64.b64decode(encoded_string)
        dr = int(idd)
        nam = name_img(state, idimg)
        
        # Infer the image type from the decoded data
        image_type = imghdr.what(None, decoded_image)
        if not image_type:
            raise ValueError("Unable to determine image type")
        
        data_dir = f"D:\\project\\doctor\\{dr}"
        os.makedirs(data_dir, exist_ok=True)
        
        output_path = os.path.join(data_dir, f"{nam}.{image_type}")
        with open(output_path, "wb") as output_file:
            output_file.write(decoded_image)
        
        print(f"Decoded image saved at: {output_path}")
        return output_path
    except Exception as e:
        print(f"Error: {e}")
    

def level(l):
    return l
    

def insert(idd,imgb64,state):

    cursor = db_connection.cursor()
    idimg=ID(idd)
    sql = insert_query = """
    INSERT INTO biopsy (img_id, img_name,biopsy_result, state, `date/time`, directory,ID_DOCTOR)
    VALUES (%s, %s, %s, %s, %s, %s, %s);
    """
    e=ifpos(state)

    # Example data to insert
    data_to_insert = (id_img(idimg),name_img(state,idimg), e,level(state), time(),
                      decode_base64_to_image(imgb64,idd,state,idimg),id_doctor(idd))

    # Execute the INSERT query with actual values
    cursor.execute(insert_query, data_to_insert)
    db_connection.commit()
    cursor.execute("SELECT * FROM biopsy")
    myresult = cursor.fetchall()
    r= pd.DataFrame(myresult)
    print(r)

#print(insert_img())
#print(ID(),doctor(),name("g2"),ifpos("g2"))
@app.route('/insert_img', methods=['POST', 'GET'])
def insert_img():
    idd = request.headers.get('ID_DOCTOR')
    data = request.get_json()
    imgb64=data.get('image')
    state=data.get('state')

    state=str(state)
    imgb64=str(imgb64)
    doctor=insert(idd,imgb64,state)
    return jsonify("the image is insert")

def newpassword(name):
    # Using list comprehension
    
    list_result = [char for char in name]
    list_result=list_result[0]
    fake_password = fake.password(length=7)
    password=list_result+fake_password
    return password

@app.route('/password', methods=['POST'])
def generate_password():
    
    # Set up Faker and create a fake instance
    
    port = 465  # For SSL
    data = request.get_json(force=True)
    username = data.get("username")
    receiver_email = data.get("email")
    # Check if email_address is not None before using strip
    if receiver_email is not None:
       print(receiver_email)
    smtp_server = "smtp.gmail.com"
    sender_email = "dania.universityofj@gmail.com"  # Enter your address
    #receiver_email = email  # Enter receiver address
    password = "xugf fgiw pdpa utlb"
    # Generate a fake password
    new_password=newpassword(username)
    

    cursor = db_connection.cursor()
    
        #cursor  = mysql.connection.cursor()
    #cursor = mysql.connection.cursor()
    query = "UPDATE doctor SET Password= %s WHERE Username = %s AND Email_address = %s"
    cursor.execute(query, (new_password,username, receiver_email))
    db_connection.commit()
    cursor.close()
    db_connection.close()
    # Construct the email message
    subject = "new password"
    body = f"Hi there, the new password is {new_password} "
    message = f"Subject: {subject}\n\n{body}"
    
    context = ssl.create_default_context()
    with smtplib.SMTP_SSL(smtp_server, port, context=context) as server:
        server.login(sender_email, password)
        server.sendmail(sender_email, [receiver_email], message)
        
    return jsonify({"message": "Password updated and email sent successfully"})  

def list_of_imgs(doctor):
    cursor = db_connection.cursor()
    
    cursor.execute("SELECT directory, img_name FROM biopsy WHERE ID_DOCTOR = %s", (doctor,))
    myresult = cursor.fetchall()
    # Check if there are any results
    if not myresult:
        print("No images found for the specified doctor.")
        return pd.DataFrame(columns=["directory", "img_name"])  # Return an empty DataFrame
    
    # Construct a DataFrame with the fetched data
    r = pd.DataFrame(myresult, columns=["directory", "img_name"])
    
    db_connection.commit()
    cursor.close()
    return r

@app.route('/list_imgs', methods=['POST', 'GET'])
def list_imgs():
    idd = request.headers.get('ID_DOCTOR')
    
    doctor = id_doctor(idd)
    ls = list_of_imgs(doctor)
    
    res = []
    
    # Extracting directory paths and image names from DataFrame
    img_paths = ls["directory"]
    img_names = ls["img_name"]
    
    # List to store image information
    img_info_list = []
    
    for img_path, img_name in zip(img_paths, img_names):
        # Construct a dictionary containing the image name and base64-encoded image
        img_info = {
            "name": img_name,
            "base64": encode_image_to_base64(img_path)
        }
        # Append the image information dictionary to the list
        img_info_list.append(img_info)
    
    # Creating a JSON object with the 'imageInfo' key containing the list of image information
    response_data = {"imageInfo": img_info_list}
    
    # Returning the JSON response
    return jsonify(response_data)


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)