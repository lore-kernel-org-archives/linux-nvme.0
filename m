From: axboe@kernel.dk (Jens Axboe)
Date: Fri, 23 Sep 2016 15:01:33 -0600
Subject: [PATCH] nvmet: Use direct IO for writes
In-Reply-To: <90968fae-476a-2f7a-cb93-f83e99a9d878@grimberg.me>
References: <1474481450-5036-1-git-send-email-sagi@grimberg.me>
 <20160922135707.GA14645@lst.de>
 <369f64ac-7059-ca5a-24aa-6775985e049e@kernel.dk>
 <90968fae-476a-2f7a-cb93-f83e99a9d878@grimberg.me>
Message-ID: <63105f3f-3042-5b98-86e4-d8a1cc51494d@kernel.dk>

On 09/23/2016 03:00 PM, Sagi Grimberg wrote:
>
>>> This looks reasonable.  But I still wonder why we bother to inject delay
>>> for any fast blk-mq device (background: Sagi told me he is observing
>>> issues without this on a NVMe PCIe card backend)
>>
>> Batching/merging. It's not like we're doing a calculated explicit delay,
>> it's just async running the queue.
>
> So are we OK with bypassing that in nvmet?

I'm OK with the patch as posted.

-- 
Jens Axboe
