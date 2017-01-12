From: sagi@grimberg.me (sagi grimberg)
Date: Thu, 12 Jan 2017 10:52:25 +0200
Subject: [LSF/MM TOPIC][LSF/MM ATTEND] NAPI polling for block drivers
In-Reply-To: <1484151982.2619.6.camel@sandisk.com>
References: <20170111134312.GH6286@linux-x5ow.site>
 <1484150893.2619.1.camel@sandisk.com>
 <20170111161238.GA18881@infradead.org>
 <2aff05af-5e83-7d3d-f879-2cce02b6d88c@suse.de>
 <1484151982.2619.6.camel@sandisk.com>
Message-ID: <CAB5WxwdZVdBUOGEsS045h3PQVtXBMfgH3a5vh_UmTBso9FPLcw@mail.gmail.com>

>>>> A typical Ethernet network adapter delays the generation of an
>>>> interrupt
>>>> after it has received a packet. A typical block device or HBA does not
>>>> delay
>>>> the generation of an interrupt that reports an I/O completion.
>>>
>>> NVMe allows for configurable interrupt coalescing, as do a few modern
>>> SCSI HBAs.
>>
>> Essentially every modern SCSI HBA does interrupt coalescing; otherwise
>> the queuing interface won't work efficiently.
>
> Hello Hannes,
>
> The first e-mail in this e-mail thread referred to measurements against a
> block device for which interrupt coalescing was not enabled. I think that
> the measurements have to be repeated against a block device for which
> interrupt coalescing is enabled.

Hey Bart,

I see how interrupt coalescing can help, but even without it, I think it
should be better.

Moreover, I don't think that strict moderation is something that can
work. The only way interrupt moderation can be effective, is if it's
adaptive and adjusts itself to the workload. Note that this feature
is on by default in most of the modern Ethernet devices (adaptive-rx).

IMHO, irq-poll vs. interrupt polling should be compared without relying
on the underlying device capabilities.
