From: shan.hai@oracle.com (Shan Hai)
Date: Mon, 24 Dec 2018 09:10:41 +0800
Subject: [PATCH 1/2] nvme-pci: add module param for io queue number
In-Reply-To: <677bfb90-c328-c707-a042-156f17cb426f@acm.org>
References: <1545372253-28025-1-git-send-email-shan.hai@oracle.com>
 <677bfb90-c328-c707-a042-156f17cb426f@acm.org>
Message-ID: <19ee67dd-c805-f174-94af-bca3aa498677@oracle.com>

Hi Bart,

On 2018/12/21 ??11:02, Bart Van Assche wrote:
> On 12/20/18 10:04 PM, Shan Hai wrote:
>> The num_possible_cpus() number of io queues by default would cause
>> irq vector shortage problem on a large system when hotplugging cpus,
>> add a module parameter to set number of io queues according to the
>> system configuration to fix the issue.
>
> Is it possible to achieve this without introducing a new configuration 
> knob? I think it will be much more convenient for users of large 
> systems that they don't have to discover a knob like this one first in 
> order to make the NVMe driver work on their systems.
>

The problem occurs when offlining CPUs aggressively on a system with 
large number of cores,

for instance offlining 368? out of 384 total cores, the failure of 
hotplug is caused by device irq migration

on cpu hotplugging, the situation becomes worse when there are multiple 
NVME devices are available

on the system.


I didn't find a simpler way to achieve this except the solution provided 
in this patchset.


Thanks

Shan Hai

> Thanks,
>
> Bart.
