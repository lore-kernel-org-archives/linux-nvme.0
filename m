From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 6 Oct 2016 01:48:15 +0300
Subject: [PATCH rfc 0/6] convert nvme pci to use irq-poll service
In-Reply-To: <20161005224957.GB1053@localhost.localdomain>
References: <1475660534-16681-1-git-send-email-sagi@grimberg.me>
 <20161005214730.GA1053@localhost.localdomain>
 <a66d99fb-15d3-2620-5eb6-e6bb4a0a80bc@grimberg.me>
 <20161005224957.GB1053@localhost.localdomain>
Message-ID: <d3f9dfff-47a8-dae5-e895-3164e090d1c7@grimberg.me>


>> Actually I didn't notice latency increase with QD=1 but I'm using
>> low-end devices so I might have missed it.
>> Did you use libaio or psync (for polling mode)?
>
> I used 'sync' ioengine for random read. For sequential, I used 'dd',
> and it showed the same difference.
>
> If I use pvsync2 with --hipri in fio, then I see little to no difference.
>
>> I'm a bit surprised that scheduling soft-irq (on the same core) is
>> so expensive (the networking folks are using it all over...)
>> Perhaps we need to look into napi and see if we're doing something
>> wrong there...
>
> The latency increase I observed was ~.5 microseconds. That may get lost
> in the noise for most controllers. Maybe that's within the expected
> increase using this soft-irq method?

Oh, I didn't realize the difference was that small. Perhaps that makes
better sense (although starting to look at irq-poll more closely I think
there is room for micro optimizations).

Did you happen to test long depth IO? I'm more concerned on that end...

>> I wander if we kept the cq processing in queue_rq but budget it to
>> something normally balanced? maybe poll budget to 4 completions?
>>
>> Does this have any effect with your Xpoint?
>
> No difference with that.

Yea, it was a long shot...

> I was actually never sure about having this opprotunistic polling in the
> IO submission path. For one, it can create higher latency outliers if
> a different controller's interrupt affinitized to the same CPU posted
> a completion first.

In the current scheme this opportunistic polling is mandatory as a
self-flow-control as without it nothing is preventing nvme_irq to keep
consuming completions forever (if multiple cpu cores keeps pounding the
queue with IO).

This patch set aims to tackle that too.

> Another thing we can do if we don't poll for completions in the submission
> path is split the single q_lock into submission and completion locks. Then
> we don't have to disable irq's in the submission path. I saw that demo'ed
> a while ago, and it was a small micro-improvement, but never saw the
> patch proposed on the public lists..

That'd definitely help!
