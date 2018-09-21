From: hch@lst.de (hch@lst.de)
Date: Fri, 21 Sep 2018 10:19:14 +0200
Subject: [PATCH] nvme-fabrics -in case of REQ_NVME_MPATH we should
 return BLK_STS_RESOURCE
In-Reply-To: <CY4PR17MB1368B68A2FC010C1A8CED289E6120@CY4PR17MB1368.namprd17.prod.outlook.com>
References: <CY4PR17MB1368DE7C1E52DF30E17060BBE61D0@CY4PR17MB1368.namprd17.prod.outlook.com>
 <20180918162526.GA5038@lst.de>
 <2866a0d5-9864-a2fd-572b-6e6f2c581de5@broadcom.com>
 <20180918190834.GA26013@localhost.localdomain>
 <19b26262-686c-c778-7e01-488917537636@broadcom.com>
 <20180920063924.GG12913@lst.de>
 <CY4PR17MB1368B68A2FC010C1A8CED289E6120@CY4PR17MB1368.namprd17.prod.outlook.com>
Message-ID: <20180921081914.GA16212@lst.de>

On Fri, Sep 21, 2018@08:15:14AM +0000, Susobhan Dey wrote:
> I am trying to figure out is there any impact if we return BLK_STS_RESOURCE as ultimately it will land to multipather make request and eventually gets completed through multipather completion handler.

If we return BLK_STS_RESOURCE the block layer will keep retrying it
on the same device until we hit the max retries count.  So yes, eventually
it will go up to the multipath layer, but it will do so much delayed.
