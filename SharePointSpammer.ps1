<#
    This PowerShell script will read from a text file to get a list of recipients to email.
    It will also read from an html file to craft the body of the email message.
#>

function sharepointSpam($attachment)
{
     try{
        
        Add-PSSnapin Microsoft.SharePoint.PowerShell -erroraction SilentlyContinue   
        
        #SMTP Server
        $smtpServer = "xxxxxxxxxx"

        #Email content
        $from = "SharePointMigration@xxxxxxxxxxx.ic.gov"
        
        $subject = "Testing SharePoint Spam Script"
        
        #use to load message body from an html file.  Had to use an HTML file in order to get the line breaks to work
        [String]$body = Get-Content "C:\testEmail.html"
        
        #IMPORTANT: The text file with the recipients must start with a semicolon on each line or it will not work.  Also do not use any parentheses ""
        #The text file should look like this  
        
        # ;user1@domain.com
        # ;user2@domain.com
        # ;user3@domain.com
                
        $emailAddressFile = Get-Content "C:\SharePointEmailSpam.txt"
        foreach($address in $emailAddressFile)
        {
            
            if($address -ne $null)
            {
                $recipient = ($address.Split(";"))[0]
                $to = ($address.Split(";"))[1]
            }
           else
            { 
                Write-Host "The text file is empty. Add some email addresses. Every line should start with a semicolon and each address should be on a new line."
            }
            
            Send-MailMessage -From $from -To $to -Subject $subject -Body $body -priority High -BodyAsHtml -Attachments $attachment -SmtpServer $smtpServer
             
            Write-Host -ForegroundColor "yellow" "email sent to: " $to
             
        }#ends foreach
  }#ends try
  
  catch [Exception]
        {
            Write-Host $_.Exception.message
        }
}#ends function

    #Attachment location
    $attachment = "C:\SharePoint 2010 Migration Site Owners Info.docx"

    #Sends email and passes in attachment
    sharepointSpam $attachment