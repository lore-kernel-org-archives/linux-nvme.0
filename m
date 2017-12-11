From: Jeff.Lien@wdc.com (Jeffrey Lien)
Date: Mon, 11 Dec 2017 17:54:35 +0000
Subject: Block Integrity Rq Count Question
In-Reply-To: <20171208221946.GB26887@localhost.localdomain>
References: <MWHPR04MB1025EDA7D10216C24D00C573EA300@MWHPR04MB1025.namprd04.prod.outlook.com>
 <20171208221946.GB26887@localhost.localdomain>
Message-ID: <MWHPR04MB102571849DD1D1ACD58670DBEA370@MWHPR04MB1025.namprd04.prod.outlook.com>

Keith,
Your comment below makes sense, but I still have a question.   Where in the driver (or maybe it's block layer) is metadata pointer allocated?   I can't find where that happens in the nvme driver so does this happen in the block layer?   And how do we control whether or not it's 1 contiguous buffer or not?


Jeff Lien

-----Original Message-----
From: Keith Busch [mailto:keith.busch@intel.com] 
Sent: Friday, December 8, 2017 4:20 PM
To: Jeffrey Lien
Cc: linux-nvme at lists.infradead.org; Christoph Hellwig; David Darrington
Subject: Re: Block Integrity Rq Count Question

On Fri, Dec 08, 2017@10:04:47PM +0000, Jeffrey Lien wrote:
> I've noticed an issue when trying to create an ext3/4 filesystem on 
> nvme device with RHEL 7.3 and 7.4 and would like to understand how 
> it's supposed to work or if there's a bug in the driver code.
> 
> When doing the mkfs command on an nvme device using lbaf of 1 or 3 (ie 
> using metadata), the call to blk_rq_count_integrity_sg in 
> nvme_map_data returns 2 causing the nvme_map_data function to goto 
> out_unmap and ultimately the request fails.  In the 
> blk_rq_count_integrity_sg function, the check "if 
> (!BIOVEC_PHYS_MERGEABLE(ivprv, iv))" is true causing a 2nd segment to 
> be added.  This seems like it could happen regularly so my question is 
> why the nvme driver map data function is only ever expecting 1 
> segment?

The definition of the NVMe MPTR field says it has to be "a contiguous physical buffer". It's not physically contiguous if you've two segments.
