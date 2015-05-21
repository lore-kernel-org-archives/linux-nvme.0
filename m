From: parav.pandit@avagotech.com (Parav Pandit)
Date: Fri, 22 May 2015 00:44:53 +0530
Subject: [PATCH] NVMe: Avoid interrupt disable during queue init.
In-Reply-To: <555E2656.5030503@kernel.dk>
References: <1432253553-17045-1-git-send-email-parav.pandit@avagotech.com>
 <555E2656.5030503@kernel.dk>
Message-ID: <CAGgvQNQ=FqKyzg6T2xvLh65mkvxrs_P+BW=JvFo_d1c0xGtFAA@mail.gmail.com>

On Fri, May 22, 2015@12:09 AM, Jens Axboe <axboe@kernel.dk> wrote:
> On 05/21/2015 06:12 PM, Parav Pandit wrote:
>>
>> Avoid diabling interrupt and holding q_lock for the queue
>> which is just getting initialized.
>>
>> With this change, online_queues is also incremented without
>> lock during queue setup stage.
>> if Power management nvme_suspend() kicks in during queue setup time,
>> per nvmeq based q_lock spinlock cannot protect device wide
>> online_queues variable anyway.
>
>
> Seems fairly pointless, it's not like it's a hot path...
>
I didn't follow your comments.
Do you mean we should still hold the lock, even if its not needed?

I meant to say in above patch/comment that holding q_lock is not
necessary in this path. So I removed it.

> --
> Jens Axboe
>
