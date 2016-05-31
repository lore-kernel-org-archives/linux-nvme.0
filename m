From: keith.busch@intel.com (Keith Busch)
Date: Tue, 31 May 2016 18:26:41 -0400
Subject: [PATCH v3] NVMe: Add controller state for scheduling resets
In-Reply-To: <201605312210.u4VM8qNZ046737@mx0a-001b2d01.pphosted.com>
References: <1464729927-14574-1-git-send-email-keith.busch@intel.com>
 <201605312210.u4VM8qNZ046737@mx0a-001b2d01.pphosted.com>
Message-ID: <20160531222640.GH24107@localhost.localdomain>

On Tue, May 31, 2016@07:10:45PM -0300, Guilherme G. Piccoli wrote:
> On 05/31/2016 06:25 PM, Keith Busch wrote:
> >All resets now must be submitted through the new state. This makes it
> >easier to coordinate controller tasks and simplifies the reset logic.
> 
> Keith, I'm working on a patch right now that explores the capacity of
> differentiate between resets. What I'm doing is re-working a quirk already
> sent to the list, in which we need to wait some seconds before read the
> NVME_REG_CSTS register in a specific adapter after fw-activate event.
> 
> The improved quirk was counting on ctrl->state to differentiate between
> resets; whenever reset_controller was issued from userspace, this state was
> set as NVME_CTRL_LIVE and in any other case, the state was
> NVME_CTRL_RESETTING.
> 
> Now, I tested the quirk after adding this patch and, as expected, the state
> is always NVME_CTRL_RESETTING. So, is there any other way to differentiate
> between resets?

Do you need such distinguishing? What if you 'modprobe -r nvme &&
modprobe nvme'? Does that sequence somehow not require the delayed MMIO
that a nvme controller reset requires?

Why not just do delay all the time for your device? In the worst case
scenario, it just adds an unnecessary, but harmless, short delay during
initialization.
