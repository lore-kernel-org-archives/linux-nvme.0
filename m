From: dongli.zhang@oracle.com (Dongli Zhang)
Date: Sat, 25 May 2019 07:58:49 +0800
Subject: [5.2-rc1 regression]: nvme vs. hibernation
In-Reply-To: <nycvar.YFH.7.76.1905250023380.1962@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1905241706280.1962@cbobk.fhfr.pm>
 <20190524154429.GE15192@localhost.localdomain>
 <nycvar.YFH.7.76.1905250023380.1962@cbobk.fhfr.pm>
Message-ID: <92a15981-dfdc-0ac9-72ee-920555a3c1a4@oracle.com>

Hi Jiri,

Looks this has been discussed in the past.

http://lists.infradead.org/pipermail/linux-nvme/2019-April/023234.html

I created a fix for a case but not good enough.

http://lists.infradead.org/pipermail/linux-nvme/2019-April/023277.html

Perhaps people would have better solution.

Dongli Zhang

On 05/25/2019 06:27 AM, Jiri Kosina wrote:
> On Fri, 24 May 2019, Keith Busch wrote:
> 
>>> Something is broken in Linus' tree (4dde821e429) with respec to 
>>> hibernation on my thinkpad x270, and it seems to be nvme related.
>>>
>>> I reliably see the warning below during hibernation, and then sometimes 
>>> resume sort of works but the machine misbehaves here and there (seems like 
>>> lost IRQs), sometimes it never comes back from the hibernated state.
>>>
>>> I will not have too much have time to look into this over weekend, so I am 
>>> sending this out as-is in case anyone has immediate idea. Otherwise I'll 
>>> bisect it on monday (I don't even know at the moment what exactly was the 
>>> last version that worked reliably, I'll have to figure that out as well 
>>> later).
>>
>> I believe the warning call trace was introduced when we converted nvme to
>> lock-less completions. On device shutdown, we'll check queues for any
>> pending completions, and we temporarily disable the interrupts to make
>> sure that queues interrupt handler can't run concurrently.
> 
> Yeah, the completion changes were the primary reason why I brought this up 
> with all of you guys in CC.
> 
>> On hibernation, most CPUs are offline, and the interrupt re-enabling
>> is hitting this warning that says the IRQ is not associated with any
>> online CPUs.
>>
>> I'm sure we can find a way to fix this warning, but I'm not sure that
>> explains the rest of the symptoms you're describing though.
> 
> It seems to be more or less reliable enough for bisect. I'll try that on 
> monday and will let you know.
> 
> Thanks,
> 
