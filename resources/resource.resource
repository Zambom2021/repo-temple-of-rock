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
Library         ../resources/DateGenerator.py
Library         ../resources/case_utils.py

Resource        ../resources/keywords.robot
Resource        ../resources/asserts_web.robot
Resource        ../resources/assertions.robot
Resource        ../resources/page_Objects.robot


