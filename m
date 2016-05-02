From: shhuiw@foxmail.com (=?ISO-8859-1?B?V2FuZyBTaGVuZy1IdWk=?=)
Date: Mon, 2 May 2016 08:18:36 +0800
Subject: [PATCH] NVMe: nvme_core_exit() should do cleanup in the
 reverseorder as nvme_core_init does
In-Reply-To: <20160501180541.GA8879@infradead.org>
References: <1461831571-5248-1-git-send-email-shhuiw@foxmail.com>
 <20160501180541.GA8879@infradead.org>
Message-ID: <tencent_409FA0137CFC2A055C88B96B@qq.com>

Christoph,

The order of the statements doesn't impact current implementation. 
No dependance between the data structures referred in each step.
It's kind of code cleanup.

Regards,
Wang Sheng-Hui

------------------ Original ------------------
From:  "Christoph Hellwig";<hch@infradead.org>;
Date:  Mon, May 2, 2016 02:05 AM
To:  "Wang Sheng-Hui"<shhuiw at foxmail.com>; 
Cc:  "keith.busch"<keith.busch at intel.com>; "axboe"<axboe at fb.com>; "linux-nvme"<linux-nvme at lists.infradead.org>; 
Subject:  Re: [PATCH] NVMe: nvme_core_exit() should do cleanup in the reverseorder as nvme_core_init does



On Thu, Apr 28, 2016@04:19:31PM +0800, Wang Sheng-Hui wrote:
> nvme_core_init does:
>     1) register_blkdev
>     2) __register_chrdev
>     3) class_create
> 
> nvme_core_exit should do cleanup in the reverse order.

Not sure why this would matter, but it looks correct to me:

Reviewed-by: Christoph Hellwig <hch at lst.de>

_______________________________________________
Linux-nvme mailing list
Linux-nvme at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
