From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 30 May 2017 14:58:06 +0300
Subject: [PATCH V2 1/1] nvme: fix multiple ctrl removal scheduling
In-Reply-To: <20170526100613.GE24894@localhost.localdomain>
References: <20170524142623.GA27721@dhcp-216.srv.tuxera.com>
 <20170526100613.GE24894@localhost.localdomain>
Message-ID: <29f66b96-0629-177a-be54-dbd638bf0f49@grimberg.me>


>> Allowing multiple resets can result in multiple controller removal as
>> well if different conditions inside nvme_reset_work fail and which
>> might deadlock on device_release_driver.
>>
>> This patch makes sure that work queue item (reset_work) is added only
>> if controller state != NVME_CTRL_RESETTING and that is achieved by
>> moving state change outside nvme_reset_work into nvme_reset and
>> removing old work_busy call.  State change is always synchronizated
>> using controller spinlock.
>
> So, the reason the state is changed when the work is running rather than
> queueing is for the window when the state may be set to NVME_CTRL_DELETING,
> and we don't want the reset work to proceed in that case.
>
> What do you think about adding a new state, like NVME_CTRL_SCHED_RESET,
> then leaving the NVME_CTRL_RESETTING state change as-is?

OK, just got to this one.

Instead of adding yet another state, how about making controller delete
cancel the reset_work (cancel_work_sync)?
