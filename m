From: hch@lst.de (Christoph Hellwig)
Date: Tue, 12 Dec 2017 09:39:51 +0100
Subject: Block Integrity Rq Count Question
In-Reply-To: <MWHPR04MB1025EDA7D10216C24D00C573EA300@MWHPR04MB1025.namprd04.prod.outlook.com>
References: <MWHPR04MB1025EDA7D10216C24D00C573EA300@MWHPR04MB1025.namprd04.prod.outlook.com>
Message-ID: <20171212083951.GA923@lst.de>

On Fri, Dec 08, 2017@10:04:47PM +0000, Jeffrey Lien wrote:
> I've noticed an issue when trying to create an ext3/4 filesystem on nvme device with RHEL 7.3 and 7.4 and would like to understand how it's supposed to work or if there's a bug in the driver code.  

Can you reproduces this on Linux 4.14 / Linux 4.15-rc, please?   The
code in bio_integrity_prep should allocate the right number of
bio_vec entries based on what the device asks for, and for NVMe that's
always 1 in Linux as we don't support SGLs for the metadata transfer.

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
