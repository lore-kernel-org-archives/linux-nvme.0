From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Wed, 13 Jul 2016 22:33:30 +0300
Subject: [patch] nvme-rdma: fix an error code
In-Reply-To: <57866AE4.9040407@fb.com>
References: <20160713100320.GC29468@mwanda>
 <57866AE4.9040407@fb.com>
Message-ID: <20160713193330.GW32247@mwanda>

On Wed, Jul 13, 2016@09:23:00AM -0700, Jens Axboe wrote:
> On 07/13/2016 03:03 AM, Dan Carpenter wrote:
> >We accidentally return success when an error code was intended.
> >
> >Fixes: 711023071960 ('nvme-rdma: add a NVMe over Fabrics RDMA host driver')
> >Signed-off-by: Dan Carpenter <dan.carpenter at oracle.com>
> 
> This is already fixed, what branch are you looking at?
> 

Thanks.

Linux-next, but I wait a day before sending them out so I can review
them the next day.  So yesterday's linux-next, I guess.

regards,
dan carpenter
