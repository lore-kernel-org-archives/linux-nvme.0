From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 9 Jul 2019 14:26:04 -0700
Subject: [PATCH rfc] nvme-tcp: support simple polling
In-Reply-To: <20190709202201.GB8405@lst.de>
References: <20190703210804.23137-1-sagi@grimberg.me>
 <20190709202201.GB8405@lst.de>
Message-ID: <70b60d78-1a77-ddb0-3414-e0c26d657e4f@grimberg.me>


>> Simple polling support via socket busy_poll interface.
>> Although we do not shutdown interrupts but simply hammer
>> the socket poll, we can sometimes find completions faster
>> than the normal interrupt driven RX path.
>>
>> We add per queue nr_cqe counter that resets every time
>> RX path is invoked such that .poll callback can return it
>> to stay consistent with the semantics.
>>
>> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
>> ---
>> There is quite a bit more to do in this direction such as
>> asking the net device to allocate polling rings and steer our
>> polling queues to them, but that would require some infrastructure
>> work in the networking stack.
>>
>> With this alone, even while still absorbing the net device interrupts
>> I'm seeing around 10%-20% latency improvement while sacrificing lots
>> of cpu cycles for it.
> 
> Looks good enough to me, especially now that we need to explicitly opt
> into polling queues.

Cool, so unless we have any objections, lets let it sit in 5.3?
