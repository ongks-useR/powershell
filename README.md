# PowerShell 7 + VS Code
Data cleaning with PowerShell

Demonstrate data cleaning, more specifically extract Exchange Online error code within the Details. Refer (https://learn.microsoft.com/en-us/exchange/troubleshoot/email-delivery/ndr/non-delivery-reports-in-exchange-online)
for complete list of SMTP error code and desription.

In the "Detail xxxx-x-xx.csv" file, notice there is "Detail" column that contains SMTP error code. The code comes right after LED=xxx and in the format of digit.digit.digit
Attempted to extract the error code with Power Query but data is way is more complex that imagination. It is beyond the capability of Power Query.

Therefore, regular expression is the right tool.

The result is named "ANZ_EXO_Detail.csv" and the script used is named "error_code_v2.ps1". With PowerShell regular expression, "ErrorCode" is produced based on the "Detail".
