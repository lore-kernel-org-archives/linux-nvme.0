From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Wed, 23 May 2018 07:12:00 +0000
Subject: [PATCH V7] nvmet: add simple file backed ns support
In-Reply-To: <20180523061003.GA13940@lst.de>
References: <20180523043439.12846-1-chaitanya.kulkarni@wdc.com>,
 <20180523061003.GA13940@lst.de>
Message-ID: <BN6PR04MB1203759A015A9D1FED5AAC4B866B0@BN6PR04MB1203.namprd04.prod.outlook.com>

[CK] It really looked weird?when I aligned it to the start, I guess I need to get used to it. BTW, I have got the caching patch ready, I'll send shortly.


From: Christoph Hellwig <hch@lst.de>
Sent: Tuesday, May 22, 2018 11:10:03 PM
To: Chaitanya Kulkarni
Cc: linux-nvme at lists.infradead.org; hch at lst.de; keith.busch at intel.com; sagi at grimberg.me; Damien Le Moal
Subject: Re: [PATCH V7] nvmet: add simple file backed ns support
? 
 
> +???????????? if (unlikely(is_sync) &&
> +???????????????????? (nr_bvec - 1 == 0 || bv_cnt == NVMET_MAX_MPOOL_BVEC)) {

Nitpick (can be fixed when applying):? Either align to the condition
or by two tabs, not by one tab as the code inside the block.? E.g. in this
case I'd do:

??????????????? if (unlikely(is_sync) &&
??????????????????? (nr_bvec - 1 == 0 || bv_cnt == NVMET_MAX_MPOOL_BVEC)) {


Otherwise looks good,

Reviewed-by: Christoph Hellwig <hch at lst.de>
    
