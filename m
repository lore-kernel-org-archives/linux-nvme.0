From: hch@lst.de (Christoph Hellwig)
Date: Tue, 24 Jul 2018 15:52:57 +0200
Subject: [PATCH 1/3] block: move ref_tag calculation func to the block
 layer
In-Reply-To: <1532439222-5668-1-git-send-email-maxg@mellanox.com>
References: <1532439222-5668-1-git-send-email-maxg@mellanox.com>
Message-ID: <20180724135257.GA29918@lst.de>

>  		case NVME_NS_DPS_PI_TYPE2:
>  			control |= NVME_RW_PRINFO_PRCHK_GUARD |
>  					NVME_RW_PRINFO_PRCHK_REF;
> -			cmnd->rw.reftag = cpu_to_le32(
> -					nvme_block_nr(ns, blk_rq_pos(req)));
> +			cmnd->rw.reftag = cpu_to_le32(t10_pi_ref_tag(req));

Note that this changes behavior for non-512 byte block sizes.  But
I think these changes do the right thing..
