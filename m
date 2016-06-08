From: keith.busch@intel.com (Keith Busch)
Date: Wed, 8 Jun 2016 17:13:35 -0400
Subject: NVMe/blk_mq Performance issue
In-Reply-To: <BL2PR04MB163EBA2796659DD039F7193925E0@BL2PR04MB163.namprd04.prod.outlook.com>
References: <BL2PR04MB163EBA2796659DD039F7193925E0@BL2PR04MB163.namprd04.prod.outlook.com>
Message-ID: <20160608211335.GB1696@localhost.localdomain>

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
