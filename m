From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 5 Jun 2019 16:35:12 -0700
Subject: [PATCH 08/13] IB/iser: set virt_boundary_mask in the scsi host
In-Reply-To: <20190605202235.GC3273@ziepe.ca>
References: <20190605190836.32354-1-hch@lst.de>
 <20190605190836.32354-9-hch@lst.de> <20190605202235.GC3273@ziepe.ca>
Message-ID: <b3e46295-4257-86ad-6994-f83b736c8f40@grimberg.me>


>> This ensures all proper DMA layer handling is taken care of by the
>> SCSI midlayer.
> 
> Maybe not entirely related to this series, but it looks like the SCSI
> layer is changing the device global dma_set_max_seg_size() - at least
> in RDMA the dma device is being shared between many users, so we
> really don't want SCSI to make this value smaller.
> 
> Can we do something about this?

srp seems to do the right thing:
target_host->max_segment_size = ib_dma_max_seg_size(ibdev);

But iser does not, which means that scsi limits it to:
BLK_MAX_SEGMENT_SIZE (64k)

I can send a fix to iser.

> Wondering about other values too, and the interaction with the new
> combining stuff in umem.c

The only other values AFAICT is the dma_boundary that rdma llds don't
set...
