From: maxg@mellanox.com (Max Gurtovoy)
Date: Sun, 28 May 2017 12:53:00 +0300
Subject: [PATCH v2 2/2] IB/mlx5: set UMR wqe fence according to HCA cap
In-Reply-To: <20170528090705.GM13083@lst.de>
References: <1495957991-19223-1-git-send-email-maxg@mellanox.com>
 <1495957991-19223-2-git-send-email-maxg@mellanox.com>
 <20170528090705.GM13083@lst.de>
Message-ID: <19a1d347-91da-7e5f-8877-86772204a80a@mellanox.com>



On 5/28/2017 12:07 PM, Christoph Hellwig wrote:
> On Sun, May 28, 2017@10:53:11AM +0300, Max Gurtovoy wrote:
>> Cache the needed umr_fence and set the wqe ctrl segmennt
>> accordingly.
>
> Looks good,
>
> Reviewed-by: Christoph Hellwig <hch at lst.de>

Thanks.

>
> But that whole fence logic looks awkward to me.  Does the following
> patch to reorder it make sense to you?
>


Yes it make sense to me.
Sagi/Leon, any comments ?
