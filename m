From: Jeff.Lien@hgst.com (Jeff Lien)
Date: Fri, 13 May 2016 20:52:15 +0000
Subject: Hang Condition in nvme_ns_remove
Message-ID: <BL2PR04MB163363775AA16EECA5666CE92740@BL2PR04MB163.namprd04.prod.outlook.com>

I encountered another hang condition in the nvme_ns_remove function.  It's caused when nvme_ns_remove is called by nvme_scan_namespaces/__nvme_scan_namespaces.  In nvme_scan_namespaces, the namespaces_mutex is locked; nvme_ns_remove will also try to get that mutex right before the call to list_del_init.  When that handles it hangs there.   

It could be fixed by removing the mutex_lock call in nvme_ns_remove and then changing the code so that all other callers of ns_remove get the lock instead.  Since I'm not real familiar with this part of the code, I don't know if this is the best fix or not.   Asking for your input on that.   

  
 ----------------------------------------------------------
 Jeff Lien
 Linux Device Driver Development
 Device Host Apps and Drivers
 Western Digital Corporation
 e. ?jeff.lien at hgst.com
 o.? +1-507-322-2416
 m. +1-507-273-9124
 
 
 
 
 
 
 
 
    
