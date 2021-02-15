Febuary 15, 2021

This apex is designed as a single-use update for Litmos__LearningPath__c records. It pulls in LP descriptions and the Litmos Id, which is required for future operations and extended connections to Litmos via Salesforce.

Additional Note:
Add the following field to the Litmos__LearningPath__c object. If you choose to name the field otherwise, update the code with the correct field API name.
API Name: Litmos_Full_Id__c
Type: Text
Length: 80
Unique: Checked (True)
Case Sensitive: Checked (True)
External Id: Checked (True)
