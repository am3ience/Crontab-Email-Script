#!/bin/bash
#
#  PROGRAM: Email.sh - Email Crontab program
#
#  DATE: October 6, 2016
#
#
#
#  DESIGNERS/PROGRAMMERS: Paul Cabanez
#                         Justin Chau
#
#  NOTES: This Program prompts the user for date and time and destination email
#         it also asks for an attachent or not. Created an email script and Crontab entry.

echo -e "What month do you want to send the email on?\n(1-12) Jan = 1, Dec = 12 or enter * for every month: "
read month

echo -e "What day of the month do you want to send it on?\n(1-31) or * for every day: "
read dayofmonth

echo -e "What day of the week do you want to send it on?\n(0-6) Sunday = 0, Saturday = 6 or * for every day: "
read dayofweek

echo -e "What hour of that day did you want it to send on?\n(0-23) or * for every hour: "
read hour

echo -e "What minute of that hour do you want to send it on?\n(0-59) or * for every minute: "
read minute

echo -e "_____________________\n"   # Line break to break betwee date/time prompts, to email prompts


echo "Enter the email you want to send to: "
read destEmail

echo "Enter subject line: "
read subj

echo "Enter what you want to say in the body of the email: "
read body

echo "Do you want to attach a file? y/n: "  # ask the user if they want to attach something
read attach

if ( [[ $attach == 'y' ]] || [[ $attach == 'Y' ]] );
then
  echo -e "Enter the full file path of the file you want to send:\nex.) /user/Home/test.txt"
  read file
  echo "mail -s '$subj' -a $file $destEmail <<< '$body'" > /root/Documents/Email2.sh   # creats an Email2 script that mails the email with the user's preferences
  chmod 777 "/root/Documents/Email2.sh"                                            # add permissions for execution
else
  echo "mail -s '$subj' $destEmail <<< '$body'" > /root/Documents/Email2.sh            # creates the script without an attachment
  chmod 777 "/root/Documents/Email2.sh"                                            # add permissions for execution
fi

echo "$minute $hour $dayofmonth $month $dayofweek root /root/Documents/Email2.sh"  >> /etc/crontab  # appends the crontab script with the user's settings for email sending

echo "Email Prepared!"
