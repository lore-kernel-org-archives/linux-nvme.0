From: axboe@kernel.dk (Jens Axboe)
Date: Mon, 24 Nov 2014 08:03:58 -0700
Subject: [PATCH 0/6] blk: introduce generic io stat accounting help
 function
In-Reply-To: <1416798327-12817-1-git-send-email-guz.fnst@cn.fujitsu.com>
References: <1416798327-12817-1-git-send-email-guz.fnst@cn.fujitsu.com>
Message-ID: <547348DE.60704@kernel.dk>

On 11/23/2014 08:05 PM, Gu Zheng wrote:
> Many block drivers accounting io stat based on bio (e.g. NVMe...),
> the blk_account_io_start/end() which is based on request
> does not make sense to them, so here we introduce the similar help
> function named generic_start/end_io_acct base on raw sectors, and it can
> simplify some driver's open io accounting code.
>
> Gu Zheng (6):
>    blk: introduce generic io stat accounting help function
>    NVMe: use generic io stat accounting functions to simplify
>      nvme_start/end_io_acct
>    md/bcache: use generic io stats accounting functions to simplify io
>      stat accounting
>    drbd: use generic io stats accounting functions to simplify io stat
>      accounting
>    md: use generic io stats accounting functions to simplify io stat
>      accounting
>    block/rsxx: use generic io stats accounting functions to simplify io
>      stat accounting

Thanks, this looks good. I'll apply it, except 2/6, since nvme no longer 
uses them.

-- 
Jens Axboe
