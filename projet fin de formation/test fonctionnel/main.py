from appium import webdriver
from appium.webdriver.common.mobileby import MobileBy
from appium.webdriver.common.touch_action import TouchAction

# Configuration des capabilities pour Appium
desired_capabilities = {
    'platformName': 'Android',
    'platformVersion': 'version_Android',  # Exemple : '11.0'
    'deviceName': 'nom_de_ton_appareil',
    'appPackage': 'com.shein.android',
    'appActivity': 'com.shein.android.activity.MainActivity',
    'automationName': 'UiAutomator2'
}

# Initialiser le driver
driver = webdriver.Remote('http://localhost:4723/wd/hub', desired_capabilities)

try:
    # Accéder à la page de création de compte
    driver.find_element(MobileBy.ACCESSIBILITY_ID, 'Créer un compte').click()

    # Saisir un email
    email_field = driver.find_element(MobileBy.ID, 'com.shein.android:id/email_field')
    email_field.send_keys('ougniimane@gmail.com')

    # Saisir un mot de passe
    password_field = driver.find_element(MobileBy.ID, 'com.shein.android:id/password_field')
    password_field.send_keys('123456789')

    # Cliquer sur le bouton de création de compte
    create_account_button = driver.find_element(MobileBy.ID, 'com.shein.android:id/create_account_button')
    create_account_button.click()

    # Vérifier la confirmation
    confirmation_message = driver.find_element(MobileBy.ID, 'com.shein.android:id/confirmation_message')
    assert 'Compte créé avec succès' in confirmation_message.text

finally:
    # Fermer le driver
    driver.quit()
