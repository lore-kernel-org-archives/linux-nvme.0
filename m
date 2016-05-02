From: axboe@fb.com (Jens Axboe)
Date: Mon, 2 May 2016 09:11:02 -0600
Subject: [PATCH] NVMe: nvme_core_exit() should do cleanup in the reverse
 order as nvme_core_init does
In-Reply-To: <1461831571-5248-1-git-send-email-shhuiw@foxmail.com>
References: <1461831571-5248-1-git-send-email-shhuiw@foxmail.com>
Message-ID: <57276E06.3050002@fb.com>

On 04/28/2016 02:19 AM, Wang Sheng-Hui wrote:
> nvme_core_init does:
>      1) register_blkdev
>      2) __register_chrdev
>      3) class_create
>
> nvme_core_exit should do cleanup in the reverse order.

Added for 4.7.


-- 
Jens Axboe
