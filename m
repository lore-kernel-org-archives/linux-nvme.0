From: hch@lst.de (Christoph Hellwig)
Date: Wed, 23 May 2018 08:10:03 +0200
Subject: [PATCH V7] nvmet: add simple file backed ns support
In-Reply-To: <20180523043439.12846-1-chaitanya.kulkarni@wdc.com>
References: <20180523043439.12846-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20180523061003.GA13940@lst.de>

> +		if (unlikely(is_sync) &&
> +			(nr_bvec - 1 == 0 || bv_cnt == NVMET_MAX_MPOOL_BVEC)) {

Nitpick (can be fixed when applying):  Either align to the condition
or by two tabs, not by one tab as the code inside the block.  E.g. in this
case I'd do:

		if (unlikely(is_sync) &&
		    (nr_bvec - 1 == 0 || bv_cnt == NVMET_MAX_MPOOL_BVEC)) {


Otherwise looks good,

Reviewed-by: Christoph Hellwig <hch at lst.de>
