From: axboe@fb.com (Jens Axboe)
Date: Wed, 13 Jul 2016 09:23:00 -0700
Subject: [patch] nvme-rdma: fix an error code
In-Reply-To: <20160713100320.GC29468@mwanda>
References: <20160713100320.GC29468@mwanda>
Message-ID: <57866AE4.9040407@fb.com>

On 07/13/2016 03:03 AM, Dan Carpenter wrote:
> We accidentally return success when an error code was intended.
>
> Fixes: 711023071960 ('nvme-rdma: add a NVMe over Fabrics RDMA host driver')
> Signed-off-by: Dan Carpenter <dan.carpenter at oracle.com>

This is already fixed, what branch are you looking at?

commit 458a9632ad7428e16e1feafb61aca33a11ac2f46
Author: Wei Yongjun <yongjun_wei at trendmicro.com.cn>
Date:   Tue Jul 12 11:06:17 2016 +0000

     nvme-rdma: fix the return value of nvme_rdma_reinit_request()

-- 
Jens Axboe
