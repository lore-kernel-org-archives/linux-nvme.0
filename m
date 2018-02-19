From: mb@lightnvm.io (=?UTF-8?Q?Matias_Bj=c3=b8rling?=)
Date: Mon, 19 Feb 2018 08:31:31 +0100
Subject: [PATCH v2 5/6] lightnvm: remove nvm_dev_ops->max_phys_sect
In-Reply-To: <918E7340-05D7-4E2F-BC43-2B81D435C3C6@cnexlabs.com>
References: <20180215131200.3354-1-mb@lightnvm.io>
 <20180215131200.3354-6-mb@lightnvm.io>
 <918E7340-05D7-4E2F-BC43-2B81D435C3C6@cnexlabs.com>
Message-ID: <899e5ed5-4bf7-666a-d756-d86420cf9c9e@lightnvm.io>

On 02/16/2018 07:48 AM, Javier Gonzalez wrote:
> 
>> On 15 Feb 2018,@05.11, Matias Bj?rling <mb@lightnvm.io> wrote:
>>
>> The value of max_phys_sect is always static. Instead of
>> defining it in the nvm_dev_ops structure, declare it as a global
>> value.
>>
>> Signed-off-by: Matias Bj?rling <mb at lightnvm.io>
>> ---
>> drivers/lightnvm/core.c          | 28 +++++++---------------------
>> drivers/lightnvm/pblk-init.c     |  9 ++++-----
>> drivers/lightnvm/pblk-recovery.c |  8 ++------
>> drivers/nvme/host/lightnvm.c     |  5 +----
>> include/linux/lightnvm.h         |  5 ++---
>> 5 files changed, 16 insertions(+), 39 deletions(-)
>>
> 
> The patch looks good, but I have a question. If a target implements the
> scalar interface, then it will not be limited to 64 lbas/ppas and it
> will not make sense to split the bio base don this value. In fact, it
> looks like in time, we will move to a scalar interface in the 2.0 path
> to align with the zoned interface, so this value will be dependent on
> whether the target is using the scalar or vector interface.
> 

Both read/write and vector interface will coexist. I am only removing 
what is hardwired into the specification.

The read/write interface has always been able issue more than 64 LBAs, 
it is instead limited by what the hardware reports its max transfer size 
to be.
