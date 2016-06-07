From: Jeff.Lien@hgst.com (Jeff Lien)
Date: Tue, 7 Jun 2016 17:45:47 +0000
Subject: Fw: Question on Patch - NVMe: Shutdown controller only for power-off
In-Reply-To: <BL2PR04MB163B82FED551339CEDC2116925D0@BL2PR04MB163.namprd04.prod.outlook.com>
References: <BL2PR04MB163B82FED551339CEDC2116925D0@BL2PR04MB163.namprd04.prod.outlook.com>
Message-ID: <BL2PR04MB1632C89FD6CF0D88A006313925D0@BL2PR04MB163.namprd04.prod.outlook.com>

Forwarding the plain text version to the distribution/

 ----------------------------------------------------------
 Jeff Lien
 Linux Device Driver Development
 Device Host Apps and Drivers
 Western Digital Corporation
 e. ?jeff.lien at hgst.com
 o.? +1-507-322-2416
 m. +1-507-273-9124
 
 
 
 
 
 
 
    



From: Jeff Lien
Sent: Tuesday, June 07, 2016 12:29 PM
To: Busch, Keith; axboe at fb.com; linux-nvme at lists.infradead.org
Cc: David Darrington; Guilherme G. Piccoli; Murali N Iyer
Subject: Question on Patch - NVMe: Shutdown controller only for power-off
? 

Keith, Jens,
I have a question on the subject matter patch that was pushed on 1/12/2016. ? In the nvme_reset_work function in pci.c, the following comment doesn't seem to match what the code is doing.




?
1893???????? /*
1894????????? * If we're called to reset a live controller first shut it down before
1895????????? * moving on.
1896????????? */
1897???????? if (dev->bar)
1898???????????????? nvme_dev_disable(dev, false);


Calling nvme_dev_disable with a shutdown parm of false does not shutdown the device. ? Am I reading the comment or code wrong here? ? We're going thru this code path on a sysfs reset_controller to reset the device and activate a new level of fw and expected a shutdown to happen like it did in the 3.10.0-327 kernel. ??I'm thinking  the shutdown parm should be true in this call. ?




----------------------------------------------------------
Jeff Lien
Linux Device Driver Development
Device Host Apps and Drivers
Western Digital Corporation
e. ?jeff.lien at hgst.com
o.? +1-507-322-2416
m. +1-507-273-9124


1456350886356_PastedImage







       
