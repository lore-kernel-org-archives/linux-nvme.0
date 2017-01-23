From: Darren.Trapp@cavium.com (Trapp, Darren)
Date: Mon, 23 Jan 2017 22:53:04 +0000
Subject: crash in sg_alloc_table_chained
Message-ID: <8C8F83F9-BDBB-4B59-BA4E-BAA34CB2E20D@cavium.com>

Gents,

I am using 4.10rc4 kernel with the FC-NVME transport to format a partition on a remote nvme device.  I?ve created a partition on the device, but when I try and create a FS via:

Mkfs ?t ext3 /dev/nvme0n1p1

I get a crash in sg_alloc_table_chained at the BUG_ON(!nents).  It is called from nvme_fc_map_data:
	        ret = sg_alloc_table_chained(&freq->sg_table, rq->nr_phys_segments,
                        freq->sg_table.sgl);

 In this case, rq->nr_phys_segments is 0.  For reference blk_rq_payload_bytes returned 0x10.

Any ideas what is going on?  


Darren
