February 17, 2021

Updated apex to include the entire HTML description of learning paths to a new custom field of type Text(Rich Text) on the Litmos__LearningPath__c object.


Febuary 15, 2021

This apex is designed as a single-use update for Litmos__LearningPath__c records. It pulls in LP descriptions and the Litmos Id, which is required for future operations and extended connections to Litmos via Salesforce.

Additional Note:
Add the following field to the Litmos__LearningPath__c object OR install the complete package in assets/package.xml. If you choose to name the field otherwise, update the code with the correct field API name.
API Name: Litmos_Full_Id__c
Type: Text
Length: 80
Unique: Checked (True)
Case Sensitive: Checked (True)
External Id: Checked (True)

This field is also included this package.
