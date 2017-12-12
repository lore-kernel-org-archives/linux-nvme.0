From: Jeff.Lien@wdc.com (Jeffrey Lien)
Date: Tue, 12 Dec 2017 14:34:11 +0000
Subject: Block Integrity Rq Count Question
In-Reply-To: <20171212083951.GA923@lst.de>
References: <MWHPR04MB1025EDA7D10216C24D00C573EA300@MWHPR04MB1025.namprd04.prod.outlook.com>
 <20171212083951.GA923@lst.de>
Message-ID: <MWHPR04MB1025501E1DBB49942A3CCB0DEA340@MWHPR04MB1025.namprd04.prod.outlook.com>

I'll see if I can reproduce on 4.14 or 4.5 and let you know - hopefully later today.  


Jeff Lien

-----Original Message-----
From: Christoph Hellwig [mailto:hch@lst.de] 
Sent: Tuesday, December 12, 2017 2:40 AM
To: Jeffrey Lien
Cc: linux-nvme at lists.infradead.org; Christoph Hellwig; David Darrington; Martin K. Petersen
Subject: Re: Block Integrity Rq Count Question

On Fri, Dec 08, 2017@10:04:47PM +0000, Jeffrey Lien wrote:
> I've noticed an issue when trying to create an ext3/4 filesystem on nvme device with RHEL 7.3 and 7.4 and would like to understand how it's supposed to work or if there's a bug in the driver code.  

Can you reproduces this on Linux 4.14 / Linux 4.15-rc, please?   The
code in bio_integrity_prep should allocate the right number of bio_vec entries based on what the device asks for, and for NVMe that's always 1 in Linux as we don't support SGLs for the metadata transfer.

> 
> When doing the mkfs command on an nvme device using lbaf of 1 or 3 (ie using metadata), the call to blk_rq_count_integrity_sg in nvme_map_data returns 2 causing the nvme_map_data function to goto out_unmap and ultimately the request fails.  In the blk_rq_count_integrity_sg function, the check "if (!BIOVEC_PHYS_MERGEABLE(ivprv, iv))" is true causing a 2nd segment to be added.  This seems like it could happen regularly so my question is why the nvme driver map data function is only ever expecting 1 segment?
> 
> Jeff Lien
> Linux Device Driver Development
> Device Host Apps and Drivers
> jeff.lien at wdc.com
> o: 507-322-2416 (ext. 23-2416)
> m: 507-273-9124
> 
> 
> 
> 
> 
---end quoted text---
