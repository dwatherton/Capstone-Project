# Capstone-Project  
#### A repository containing the UALR BSCS Final Project. Team members: Daniel Atherton, Griffin Kim, Jeremy Reynolds, and Shane Champion.  

#  

##### To get started with this project in PyCharm, follow the simple, step-by-step, instructions below:

1. Open PyCharm and select "Check out from Version Control" > "Git".  

![Checkout from Git](https://imgur.com/jimrhgs.png)



2. Enter the Project Repository URL (green), a Project Directory name (yellow), and hit "Clone" (red).  

![Clone Project](https://imgur.com/KzMgvDK.png)



3. Click "Yes" to open the Project Directory in the PyCharm IDE.  

![Open as a Project](https://imgur.com/0q77GFW.png)



4. When the IDE finishes opening, open the built-in terminal.  

![Open Terminal](https://imgur.com/CZIaEXd.png)


 
5. Install Python3 - Django Projects use Python, so it's a must.  

   * You can get python3 from https://www.python.org/downloads/.  



6. Create a virtual environment for the project.  

   * Type `python3 -m venv venv` in the built-in terminal.  



7. Activate the virtual environment for the Django project.  

   * Type `source venv/bin/activate` in the built-in terminal.



8. Install the requirements for the project listed in "requirements.txt".  

   * Type `pip3 install -r requirements.txt` in the built-in terminal.  



9. Install and setup MySQL Server.  

   * Use the following links to [Install MySQL](http://www.marinamele.com/taskbuster-django-tutorial/install-and-configure-mysql-for-django#install-mysql) and [Create a MySQL Database](http://www.marinamele.com/taskbuster-django-tutorial/install-and-configure-mysql-for-django#create-database) using the following values as defined in the projects 'settings.py' file:  
   > 
   ``` python
   DATABASES = {
       'default': {
           'ENGINE': 'django.db.backends.mysql',
           'NAME': 'ew_db',
           'USER': 'ew_admin',
           'PASSWORD': 'ualrcapstone19',
           'HOST': 'localhost',
           'PORT': '3306',
       }
   }
   ```  

   * Note: If you use different values for your mysql user and database, you MUST change the code above in the settings.py file!  



10. Migrate the changes to the Django project.  
    
    * Type `python3 manage.py migrate` in the built-in terminal.  



11. Create a Django Superuser.  

    * Type `python3 manage.py createsuperuser` in the built-in terminal.  
    * Note: The Superuser that you create should not make a difference, it just grants you access to logging in as a Django Admin via the url:  `http://127.0.0.1:8000/admin/` while the Django server is running.  



#



#### You should now be able to run the project by typing `python3 manage.py runserver` in the built-in terminal, and clicking on the link that appears. At first, the site will look empty since the content that appears in the Easy Web Content Editor is loaded from the MySQL database, and the database does not currently have any pages in it. Follow the steps below to populate the Easy Web Content Editor with a pages content.  


1. Make sure the server is running and go to `http://127.0.0.1:8000/admin/`, then log in using the superuser credentials you created in Step 11. Once you are logged in, Click the "Add" button to add a new page.  

![Click Add](https://imgur.com/nTReXz2.png)



2. Populate the fields as indicated in the image below, and click the "Save" button.  

![Add Test Page](https://imgur.com/jy0OZuU.png)



3. Once the "Test Page" has been saved, click "VIEW SITE" to see what the Easy Web Content Editor looks like with pages in the database that can be edited!  

![View Site](https://imgur.com/tm87e3E.png)



4. The Easy Web Editor should look like this (assuming you entered the same content into the database fields).  

![Easy Web Editor](https://imgur.com/boPUvcO.png)



#



##### That covers everything for getting started with this project! Please expirement with the content editor buttons to get a deeper understanding of what the Easy Web Content Editor is capable of!  
