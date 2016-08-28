From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 28 Aug 2016 15:48:13 +0300
Subject: [PATCH WIP/RFC 5/6] nvme-rdma: add DELETING queue flag
In-Reply-To: <02c801d1ffa4$35581720$a0084560$@opengridcomputing.com>
References: <cover.1472219585.git.swise@opengridcomputing.com>
 <70e06b14c40d74d6a5de4fda4a5a6639e0ac4b7d.1472219586.git.swise@opengridcomputing.com>
 <02c801d1ffa4$35581720$a0084560$@opengridcomputing.com>
Message-ID: <cf143cb2-7543-556a-9e99-ab01a4cf82b3@grimberg.me>


>> From: Sagi Grimberg <sagi at grimberg.me>
>>
>> When we get a surprise disconnect from the target we queue a periodic
>> reconnect (which is the sane thing to do...).
>>
>> We only move the queues out of CONNECTED when we retry to reconnect (after
>> 10 seconds in the default case) but we stop the blk queues immediately
>> so we are not bothered with traffic from now on. If delete() is kicking
>> off in this period the queues are still in CONNECTED state.
>>
>> Part of the delete sequence is trying to issue ctrl shutdown if the
>> admin queue is CONNECTED (which it is!). This request is issued but
>> stuck in blk-mq waiting for the queues to start again. This might be
>> the one preventing us from forward progress...
>>
>> The patch separates the queue flags to CONNECTED and DELETING. Now we
>> will move out of CONNECTED as soon as error recovery kicks in (before
>> stopping the queues) and DELETING is on when we start the queue deletion.
>>
>> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
>
> Sagi,
>
> This patch is missing the change to nvme_rdma_device_unplug().  That is my
> mistake.  Since patch 6 removes that part of the unplug logic, the omission is
> benign for the series, but it should be fixed so that this patch in and of
> itself fixes the problem it is addressing regardless of whether patch 6 is
> applied.  I can fix this up if we decide patch 6 is the correct approach...

Let's fix it in unplug regardless of moving the logic so we'll have a
better bisection experience...
