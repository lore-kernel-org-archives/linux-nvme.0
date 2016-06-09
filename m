From: Jeff.Lien@hgst.com (Jeff Lien)
Date: Thu, 9 Jun 2016 12:59:05 +0000
Subject: NVMe/blk_mq Performance issue
In-Reply-To: <20160608211335.GB1696@localhost.localdomain>
References: <BL2PR04MB163EBA2796659DD039F7193925E0@BL2PR04MB163.namprd04.prod.outlook.com>,
 <20160608211335.GB1696@localhost.localdomain>
Message-ID: <BL2PR04MB1632401DA662CC7A9FFDE8C925F0@BL2PR04MB163.namprd04.prod.outlook.com>

Keith,
We reran this scenario with the Redhat 7.3 test kernel (3.10.0-405.el7.bz1331884.1.x86_64 from Dave Milburn) that contained the affinity fixes.  Here are the results:  

IOPS
3.10.0-405.el7.bz1331884.1.x86_64 ( RHEL7.3 ) = 411385 ( -14% slower than CentOS7.1 )
3.10.0-229.el7.x86_64 = 479862


----------------------------------------------------------
Jeff Lien
Linux Device Driver Development
Device Host Apps and Drivers
Western Digital Corporation
e.  jeff.lien at hgst.com
o.  +1-507-322-2416
m. +1-507-273-9124





________________________________________
From: Keith Busch <keith.busch@intel.com>
Sent: Wednesday, June 08, 2016 4:13 PM
To: Jeff Lien
Cc: linux-nvme; Christoph Hellwig; David Darrington; axboe at fb.com
Subject: Re: NVMe/blk_mq Performance issue

On Wed, Jun 08, 2016@08:22:44PM +0000, Jeff Lien wrote:
> We have a performance test scenario designed to verify the OS, driver's and device's ability to handle requests as fast as the system can send them.  It uses fio to send sequential write requests with block size of 512 bytes and queue depth of 32.  This scenario will run the system cpu up to 100%; trying to flood the driver/device with write requests.   When going from Redhat 7.1 to 7.2 we noticed a degradation of about 14% in IOPs; 479862 IOPs with 7.1 and 411385 with 7.2.   With the system and device constant, only the kernel code changed with the blk_mq layer/nvme driver combo being the most likely cause degradation.
>
> Has anyone else noticed any performance issues with the nvme driver using the blk_mq layer?   If so, are there any patches, recommendations or tuning options available to help optimize this particular scenario?

Hi Jeff,

This probably isn't a blk-mq issue. We mentioned the affinity hint in
7.2 is incorrect on rhel bz1331884 (you opened that that one, though
not for that issue). Would you be able to confirm if the update fixes
the performance issue that you're seeing?

Thanks,
Keith
