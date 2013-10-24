WinOCPHC
========

Windows Offline Common Password Hash Checker

Auto review Windows Password hashes and compare looking for common password, disabled and previous passwords.

Useful when review a Windows domain controller or server, extract the hashes and this will highlight issues.

It will display all users with the same password set (as hash value is the same and not salted) which shows users have common passwords.
It will highlight disabled or previously set passwords (if fgdump/gsecdump used) and flag if a user has the same password as previously set.

This is useful for pen tests as can highlight missing processes within a company, such as the Helpdesk could be creating all new users with the same password, but not forcing a password change at next login.
It also will highlight if the user has been able to set their password to one that was previously used. Plus shows they are probably not forcing regular password changes for users.

Often I find many standard domain users have the same password as many domain administrators.

Developed by Daniel Compton

https://github.com/commonexploits/winocphc

Released under AGPL see LICENSE for more information


Installing
========

    git clone https://github.com/commonexploits/winocphc.git

How To Use
========

    ./winocphc.sh


Features
========

* Auto reads file output from hashdump, fgdump, gsecdump, pwdump etc
* Finds common passwords hashes and lists all users that share passwords
* Lists disabled accounts (if fgdump/gsecdump tool used and if exist)
* Lists and checks history passwords ((if fgdump/gsecdump tool used and if exist) and alerts if user has the same password as previously set
* Masks the hash output for reporting. Not good practice to put a password of the hash in a pen test report.

Screen Shots
========

![](http://commonexploits.com/wp-content/uploads/2013/10/1.jpg)

![](http://commonexploits.com/wp-content/uploads/2013/10/2.jpg)

![](http://commonexploits.com/wp-content/uploads/2013/10/3.jpg)

![](http://commonexploits.com/wp-content/uploads/2013/10/4.jpg)



Change Log
========

* Version 1.0 - First release.

