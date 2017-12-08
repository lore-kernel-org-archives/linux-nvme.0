From: Jeff.Lien@wdc.com (Jeffrey Lien)
Date: Fri, 8 Dec 2017 22:04:47 +0000
Subject: Block Integrity Rq Count Question
Message-ID: <MWHPR04MB1025EDA7D10216C24D00C573EA300@MWHPR04MB1025.namprd04.prod.outlook.com>

I've noticed an issue when trying to create an ext3/4 filesystem on nvme device with RHEL 7.3 and 7.4 and would like to understand how it's supposed to work or if there's a bug in the driver code.  

When doing the mkfs command on an nvme device using lbaf of 1 or 3 (ie using metadata), the call to blk_rq_count_integrity_sg in nvme_map_data returns 2 causing the nvme_map_data function to goto out_unmap and ultimately the request fails.  In the blk_rq_count_integrity_sg function, the check "if (!BIOVEC_PHYS_MERGEABLE(ivprv, iv))" is true causing a 2nd segment to be added.  This seems like it could happen regularly so my question is why the nvme driver map data function is only ever expecting 1 segment?

Jeff Lien
Linux Device Driver Development
Device Host Apps and Drivers
jeff.lien at wdc.com
o: 507-322-2416 (ext. 23-2416)
m: 507-273-9124
