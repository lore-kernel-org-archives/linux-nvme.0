From: Darren.Trapp@cavium.com (Trapp, Darren)
Date: Mon, 23 Jan 2017 23:10:11 +0000
Subject: crash in sg_alloc_table_chained
In-Reply-To: <20170123230838.GB10771@localhost.localdomain>
References: <8C8F83F9-BDBB-4B59-BA4E-BAA34CB2E20D@cavium.com>
 <20170123230838.GB10771@localhost.localdomain>
Message-ID: <FE63694B-6112-480D-8ABF-5146C7AD85B6@cavium.com>

So that works other than hitting a WARN_ON_ONCE in nvme_fc_start_fcp_op  at: 
        WARN_ON_ONCE(sqe->common.command_id != cpu_to_le16(op->rqno));


I am able to mount and unmount the FS now.  

Darren 

On 1/23/17, 3:08 PM, "Keith Busch" <keith.busch@intel.com> wrote:

    On Mon, Jan 23, 2017@10:53:04PM +0000, Trapp, Darren wrote:
    > Gents,
    > 
    > I am using 4.10rc4 kernel with the FC-NVME transport to format a partition on a remote nvme device.  I?ve created a partition on the device, but when I try and create a FS via:
    > 
    > Mkfs ?t ext3 /dev/nvme0n1p1
    > 
    > I get a crash in sg_alloc_table_chained at the BUG_ON(!nents).  It is called from nvme_fc_map_data:
    > 	        ret = sg_alloc_table_chained(&freq->sg_table, rq->nr_phys_segments,
    >                         freq->sg_table.sgl);
    > 
    >  In this case, rq->nr_phys_segments is 0.  For reference blk_rq_payload_bytes returned 0x10.
    > 
    > Any ideas what is going on?  
    
    Just to confirm a suspicion, is it successful if you run:
    
      # mkfs.ext3 /dev/nvme0n1p1 -E nodiscard
    
    ?
    
