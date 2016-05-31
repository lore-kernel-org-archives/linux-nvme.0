From: gpiccoli@linux.vnet.ibm.com (Guilherme G. Piccoli)
Date: Tue, 31 May 2016 19:24:48 -0300
Subject: [PATCH v3] NVMe: Add controller state for scheduling resets
In-Reply-To: <20160531222640.GH24107@localhost.localdomain>
References: <1464729927-14574-1-git-send-email-keith.busch@intel.com>
 <201605312210.u4VM8qNZ046737@mx0a-001b2d01.pphosted.com>
 <20160531222640.GH24107@localhost.localdomain>
Message-ID: <201605312224.u4VMO0Ex024289@mx0a-001b2d01.pphosted.com>

On 05/31/2016 07:26 PM, Keith Busch wrote:
> On Tue, May 31, 2016@07:10:45PM -0300, Guilherme G. Piccoli wrote:
>> On 05/31/2016 06:25 PM, Keith Busch wrote:
>>> All resets now must be submitted through the new state. This makes it
>>> easier to coordinate controller tasks and simplifies the reset logic.
>>
>> Keith, I'm working on a patch right now that explores the capacity of
>> differentiate between resets. What I'm doing is re-working a quirk already
>> sent to the list, in which we need to wait some seconds before read the
>> NVME_REG_CSTS register in a specific adapter after fw-activate event.
>>
>> The improved quirk was counting on ctrl->state to differentiate between
>> resets; whenever reset_controller was issued from userspace, this state was
>> set as NVME_CTRL_LIVE and in any other case, the state was
>> NVME_CTRL_RESETTING.
>>
>> Now, I tested the quirk after adding this patch and, as expected, the state
>> is always NVME_CTRL_RESETTING. So, is there any other way to differentiate
>> between resets?
>
> Do you need such distinguishing? What if you 'modprobe -r nvme &&
> modprobe nvme'? Does that sequence somehow not require the delayed MMIO
> that a nvme controller reset requires?
>
> Why not just do delay all the time for your device? In the worst case
> scenario, it just adds an unnecessary, but harmless, short delay during
> initialization.
>

Hmmm...need is strong word heheh

But imagine a scenario I have multiple nvme devices and want to upgrade 
the firmware for only one. In this case, the procedure is to 
reset_controller only the specific device after the fw activation.
modprobe the driver in this case it too much.

Now, the quirk needs 2 sec delay, not so big, but not so small value 
either. Would be _desirable_ to have such distinguishing, although we 
can live without it I guess.

But since you just sent the patch unifying the resets, I thought worth 
asking you if it's possible to include some kind of differentiation, or 
if such feature already exists (and I wasn't able to find heheh)

Thanks,


Guilherme
