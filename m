From: james.smart@broadcom.com (James Smart)
Date: Sat, 30 Sep 2017 12:04:47 -0700
Subject: [PATCH 1/2] nvmet: fix ctlr ref counting
In-Reply-To: <85e7a64e-fcf4-6a1d-02ea-55232b3c4199@grimberg.me>
References: <20170928153553.13993-1-jsmart2021@gmail.com>
 <20170928153553.13993-2-jsmart2021@gmail.com>
 <85e7a64e-fcf4-6a1d-02ea-55232b3c4199@grimberg.me>
Message-ID: <9b966d7e-0fcb-c681-9272-2bc9b34257fa@broadcom.com>

On 9/30/2017 11:00 AM, Sagi Grimberg wrote:
>
>> Current code:
>> initializes the reference at allocation
>> increments reference when ctlr finds are done
>> has decrements to back out of ctlr finds
>> decrements in admin queue connect cmd failures to
>> ?? cause ctlr free
>> in nvmet_sq_destroy() decrements to cause ctlr free
>>
>> Issue is: nvmet_sq_destroy is called for every queue (admin and
>> io), thus the controller is freed upon the first queue termination.
>> It's an early "free". There could be other ctlr struct changes made
>> while subsequent queues are being torn down.
>
> This is not true, each sq takes a reference on the controller, so
> the controller is actually freed only on the _last_ sq destroy.

Looked at it again. And yeah - you are right. The get is by the find 
routine.
I've got to go look at this again.

-- james
