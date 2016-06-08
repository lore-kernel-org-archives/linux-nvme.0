From: Jeff.Lien@hgst.com (Jeff Lien)
Date: Wed, 8 Jun 2016 20:22:44 +0000
Subject: NVMe/blk_mq Performance issue
Message-ID: <BL2PR04MB163EBA2796659DD039F7193925E0@BL2PR04MB163.namprd04.prod.outlook.com>

We have a performance test scenario designed to verify the OS, driver's and device's ability to handle requests as fast as the system can send them.  It uses fio to send sequential write requests with block size of 512 bytes and queue depth of 32.  This scenario will run the system cpu up to 100%; trying to flood the driver/device with write requests.   When going from Redhat 7.1 to 7.2 we noticed a degradation of about 14% in IOPs; 479862 IOPs with 7.1 and 411385 with 7.2.   With the system and device constant, only the kernel code changed with the blk_mq layer/nvme driver combo being the most likely cause degradation.  

Has anyone else noticed any performance issues with the nvme driver using the blk_mq layer?   If so, are there any patches, recommendations or tuning options available to help optimize this particular scenario?   




     
 
 ----------------------------------------------------------
 Jeff Lien
 Linux Device Driver Development
 Device Host Apps and Drivers
 Western Digital Corporation
 e. ?jeff.lien at hgst.com
 o.? +1-507-322-2416
 m. +1-507-273-9124
 
 
 1456350886356_PastedImage
 
 
 
 
 
 
 
    
-------------- next part --------------
A non-text attachment was scrubbed...
Name: OutlookEmoji-1456350886356_PastedImage.png
Type: image/png
Size: 9193 bytes
Desc: OutlookEmoji-1456350886356_PastedImage.png
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20160608/871bb3f8/attachment-0001.png>
