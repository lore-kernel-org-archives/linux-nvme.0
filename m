From: axboe@kernel.dk (Jens Axboe)
Date: Tue, 07 Apr 2015 19:09:28 -0600
Subject: [PATCH] NVMe: Fix error handling of class_create("nvme")
In-Reply-To: <alpine.LNX.2.00.1504072302431.32385@localhost.lm.intel.com>
References: <1425681821-620-1-git-send-email-khoroshilov@ispras.ru>
 <alpine.LNX.2.00.1504072302431.32385@localhost.lm.intel.com>
Message-ID: <55247FC8.9030606@kernel.dk>

On 04/07/2015 05:03 PM, Keith Busch wrote:
> On Fri, 6 Mar 2015, Alexey Khoroshilov wrote:
>> class_create() returns ERR_PTR on failure,
>> so IS_ERR() should be used instead of check for NULL.
>>
>> Found by Linux Driver Verification project (linuxtesting.org).
>>
>> Signed-off-by: Alexey Khoroshilov <khoroshilov at ispras.ru>
>
> Just resending ack for 4.1.
>
> Acked-by: Keith Busch <keith.busch at intel.com>

Thanks, I missed this one. Applied to for-4.1/drivers, thanks!

-- 
Jens Axboe
