From: axboe@kernel.dk (Jens Axboe)
Date: Fri, 05 Jun 2015 10:34:02 -0600
Subject: [PATCH] NVMe: Memory barrier before queue_count is incremented
In-Reply-To: <alpine.LNX.2.00.1505282232260.15930@localhost.lm.intel.com>
References: <1432751183-20199-1-git-send-email-jonathan.derrick@intel.com>
 <alpine.LNX.2.00.1505282232260.15930@localhost.lm.intel.com>
Message-ID: <5571CF7A.2050100@kernel.dk>

On 05/28/2015 04:32 PM, Keith Busch wrote:
> On Wed, 27 May 2015, Jon Derrick wrote:
>> Protects against reordering and/or preempting which would allow the
>> kthread to access the queue descriptor before it is set up
>
> Looks good to me.
>
> Acked-by: Keith Busch <keith.busch at intel.com>

Ditto, merged.


-- 
Jens Axboe
