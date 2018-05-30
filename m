From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 31 May 2018 02:25:54 +0300
Subject: [PATCHv3 1/9] nvme: Sync request queues on reset
In-Reply-To: <20180525183050.GU11037@localhost.localdomain>
References: <20180524203500.14081-1-keith.busch@intel.com>
 <20180524203500.14081-2-keith.busch@intel.com>
 <20180525124209.GD23463@lst.de>
 <20180525142233.GN11037@localhost.localdomain>
 <20180525143253.GA26539@lst.de>
 <96a98ecf-9b35-1f4f-da20-3729d7a2de68@broadcom.com>
 <20180525162439.GT11037@localhost.localdomain>
 <7f88c98a-652f-4a82-0f0b-feb36fe46bb0@broadcom.com>
 <20180525183050.GU11037@localhost.localdomain>
Message-ID: <a43e1dda-d2a7-4e82-527b-76314eb714fc@grimberg.me>


>>> At least in the current blk-mq timeout handling, returning RESET_TIMER
>>> presents other challenges for the reset handler: the timer may have
>>> reclaimed the request that reset_work is trying to complete.
>>
>> why would that be true if BLK_EH_RESET_TIMER was returned ?
> 
> That return rearms the timer for triggering timeout handling, and
> when that timeout handling triggers, your reset work won't be able to
> complete the request. You're basically relying on the timer being high
> enough that your reset work beats the timer to the completion. That may
> be sufficient in practice most of the time.

Why? the timeout handler would reset the timer yet again.
