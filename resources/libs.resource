*** Settings ***

Library         SeleniumLibrary
Library         DateTime
Library         JSONLibrary
Library         String
Library         OperatingSystem
Library         RequestsLibrary
Library         FakerLibrary
Library         Collections
Library         httpx
Library         JsonConverter.py
Library         chromeOptions.py

Library         ${EXECDIR}/resources/DateGenerator.py
Library         ${EXECDIR}/resources/caseUtils.py
Library         ${EXECDIR}/resources/NameGenerator.py
Library         ${EXECDIR}/resources/modelPayload.py
Library         ${EXECDIR}/resources/GenresModel.py