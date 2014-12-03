From: sbradshaw@micron.com (Sam Bradshaw (sbradshaw))
Date: Wed, 3 Dec 2014 18:42:03 +0000
Subject: Testing NVME Split BIO 
In-Reply-To: <BL2PR04MB1635C3D325742BB32A47B6D927B0@BL2PR04MB163.namprd04.prod.outlook.com>
References: <BL2PR04MB1635C3D325742BB32A47B6D927B0@BL2PR04MB163.namprd04.prod.outlook.com>
Message-ID: <80B89753B40C5141A3E2D53FE7A2A8A9945EDA0E@NTXBOIMBX02.micron.com>



> -----Original Message-----
> From: Linux-nvme [mailto:linux-nvme-bounces at lists.infradead.org] On
> Behalf Of Jeffrey Lien
> Sent: Wednesday, December 03, 2014 10:19 AM
> To: linux-nvme at lists.infradead.org
> Subject: Testing NVME Split BIO
> 
> We are trying to create a testcase to verify the nvme split bio
> function.   Does anyone have any ideas or suggestions for a simple way
> to force a split bio request?

We built a device mapper shim layer that does this.  Using a 4k transfer, single bvec, the mapper would: 
1) bio_alloc a bio with 2 bvecs
2) point the first bvec at the original bvec but truncate the size to 2k
3) alloc a 4k page, kmap it, memcpy the upper 2k from the original bvec page into a non-zero offset into the allocated page
4) point the second bvec in the allocated bio at the bvec with non-zero offset
5) hand it off to the driver

Make sure your allocated bio callback does any cleanup then calls the original callback with a pointer to the original bio.

A device mapper shim approach may not be the "easiest" but has other benefits for traffic shaping beyond this use case.

-Sam
