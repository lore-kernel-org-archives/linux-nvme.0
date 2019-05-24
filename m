From: john.p.donnelly@oracle.com (John Donnelly)
Date: Fri, 24 May 2019 09:16:01 -0500
Subject: Use of WARN in nvme subssytem. 
Message-ID: <82D7EABA-733D-4CBF-BCD6-E8EA51C2B220@oracle.com>

Hi,

There is approximately 72 occurrences of WARN*  in the driver/nvme modules in 5.2.rc.  If the system is configured with the option ?panic_on_warn? the system will reboot.  Are all of  these warnings necessary ? I am sure many could  be converted to log entries with more informative content for administrators. 


Thanks,

John.
