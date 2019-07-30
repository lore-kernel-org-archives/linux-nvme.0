From: kai.heng.feng@canonical.com (Kai-Heng Feng)
Date: Wed, 31 Jul 2019 02:50:01 +0800
Subject: [Regression] Commit "nvme/pci: Use host managed power state for
 suspend" has problems
In-Reply-To: <100ba4aff1c6434a81e47774ab4acddc@AUSX13MPC105.AMER.DELL.COM>
References: <2332799.izEFUvJP67@kreacher>
 <4323ed84dd07474eab65699b4d007aaf@AUSX13MPC105.AMER.DELL.COM>
 <CAJZ5v0iDQ4=kTUgW94tKGt7oJzA_3uVU_M6HAMbNCRXwp_do8A@mail.gmail.com>
 <47415939.KV5G6iaeJG@kreacher> <20190730144134.GA12844@localhost.localdomain>
 <100ba4aff1c6434a81e47774ab4acddc@AUSX13MPC105.AMER.DELL.COM>
Message-ID: <8246360B-F7D9-42EB-94FC-82995A769E28@canonical.com>

at 01:14, <Mario.Limonciello@dell.com> <Mario.Limonciello@dell.com> wrote:

>> -----Original Message-----
>> From: Keith Busch <kbusch at kernel.org>
>> Sent: Tuesday, July 30, 2019 9:42 AM
>> To: Rafael J. Wysocki
>> Cc: Busch, Keith; Limonciello, Mario; Kai-Heng Feng; Christoph Hellwig;  
>> Sagi
>> Grimberg; linux-nvme; Linux PM; Linux Kernel Mailing List; Rajat Jain
>> Subject: Re: [Regression] Commit "nvme/pci: Use host managed power state  
>> for
>> suspend" has problems
>>
>>
>> [EXTERNAL EMAIL]
>>
>> On Tue, Jul 30, 2019@03:45:31AM -0700, Rafael J. Wysocki wrote:
>>> So I can reproduce this problem with plain 5.3-rc1 and the patch below  
>>> fixes it.
>>>
>>> Also Mario reports that the same patch needs to be applied for his 9380  
>>> to
>> reach
>>> SLP_S0 after some additional changes under testing/review now, so here it
>> goes.
>>> [The changes mentioned above are in the pm-s2idle-testing branch in the
>>>  linux-pm.git tree at kernel.org.]
>>>
>>> ---
>>> From: Rafael J. Wysocki <rafael.j.wysocki at intel.com>
>>> Subject: [PATCH] nvme-pci: Do not prevent PCI bus-level PM from being  
>>> used
>>>
>>> One of the modifications made by commit d916b1be94b6 ("nvme-pci: use
>>> host managed power state for suspend") was adding a pci_save_state()
>>> call to nvme_suspend() in order to prevent the PCI bus-level PM from
>>> being applied to the suspended NVMe devices, but that causes the NVMe
>>> drive (PC401 NVMe SK hynix 256GB) in my Dell XPS13 9380 to prevent
>>> the SoC from reaching package idle states deeper than PC3, which is
>>> way insufficient for system suspend.
>>>
>>> Fix this issue by removing the pci_save_state() call in question.
>>
>> I'm okay with the patch if we can get confirmation this doesn't break
>> any previously tested devices. I recall we add the pci_save_state() in
>> the first place specifically to prevent PCI D3 since that was reported
>> to break some devices' low power settings. Kai-Heng or Mario, any input
>> here?
>
> It's entirely possible that in fixing the shutdown/flush/send NVME power  
> state command
> that D3 will be OK now but it will take some time to double check across  
> the variety of disks that
> we tested before.

Just did a quick test, this patch regress SK Hynix BC501, the SoC stays at  
PC3 once the patch is applied.

Kai-Heng

>
> What's kernel policy in terms of adding a module parameter and removing  
> it later?  My gut
> reaction is I'd like to see that behind a module parameter and if we see  
> that all the disks
> are actually OK we can potentially rip it out in a future release.  Also  
> gives us a knob for easier
> wider testing outside of the 4 of us.
>
>>> Fixes: d916b1be94b6 ("nvme-pci: use host managed power state for  
>>> suspend")
>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki at intel.com>
>>> ---
>>>  drivers/nvme/host/pci.c |    8 +-------
>>>  1 file changed, 1 insertion(+), 7 deletions(-)
>>>
>>> Index: linux-pm/drivers/nvme/host/pci.c
>> ==============================================================
>> =====
>>> --- linux-pm.orig/drivers/nvme/host/pci.c
>>> +++ linux-pm/drivers/nvme/host/pci.c
>>> @@ -2897,14 +2897,8 @@ static int nvme_suspend(struct device *d
>>>  		nvme_dev_disable(ndev, true);
>>>  		ctrl->npss = 0;
>>>  		ret = 0;
>>> -		goto unfreeze;
>>>  	}
>>> -	/*
>>> -	 * A saved state prevents pci pm from generically controlling the
>>> -	 * device's power. If we're using protocol specific settings, we don't
>>> -	 * want pci interfering.
>>> -	 */
>>> -	pci_save_state(pdev);
>>> +
>>>  unfreeze:
>>>  	nvme_unfreeze(ctrl);
>>>  	return ret;
