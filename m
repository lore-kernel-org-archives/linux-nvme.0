From: s.wendy.cheng@gmail.com (Wendy Cheng)
Date: Thu, 14 Jul 2016 10:45:55 -0700
Subject: NVMe over RDMA latency
In-Reply-To: <CABgxfbFST4Y=d9KyDetptwNv6Hf0iJfzWm3y2aavLD3PExDCQw@mail.gmail.com>
References: <1467921342.24395.12.camel@ssi> <57860EBA.5010103@grimberg.me>
 <1468434332.1869.8.camel@ssi>
 <CABgxfbFST4Y=d9KyDetptwNv6Hf0iJfzWm3y2aavLD3PExDCQw@mail.gmail.com>
Message-ID: <CABgxfbH-bMynfmMdnX0CQsSD7Yi1dPhiJMshuHhESJdu+_JzUQ@mail.gmail.com>

On Thu, Jul 14, 2016@9:43 AM, Wendy Cheng <s.wendy.cheng@gmail.com> wrote:
> On Wed, Jul 13, 2016@11:25 AM, Ming Lin <mlin@kernel.org> wrote:
>
>>> 1. I imagine you are not polling in the host but rather interrupt
>>>     driven correct? thats a latency source.
>>
>> It's polling.
>>
>> root at host:~# cat /sys/block/nvme0n1/queue/io_poll
>> 1
>>
>>>
>>> 2. the target code is polling if the block device supports it. can you
>>>     confirm that is indeed the case?
>>
>> Yes.
>>
>>>
>>> 3. mlx4 has a strong fencing policy for memory registration, which we
>>>     always do. thats a latency source. can you try with
>>>     register_always=0?
>>
>> root at host:~# cat /sys/module/nvme_rdma/parameters/register_always
>> N
>>
>>
>>>
>>> 4. IRQ affinity assignments. if the sqe is submitted on cpu core X and
>>>     the completion comes to cpu core Y, we will consume some latency
>>>     with the context-switch of waiking up fio on cpu core X. Is this
>>>     a possible case?
>>
>> Only 1 CPU online on both host and target machine.
>>
>
> Since the above tunables can be easily toggled on/off, could you break
> down their contributions to the overall latency with each individual
> tunable ? e.g. only do io_poll on / off to see how much it improves
> the latency.
>
> From your data, it seems to indicate the local performance on the
> target got worse. Is this perception correct ?
>
> Before the tunable: the target avg=22.35 usec
> After the tunable: the target avg=23.59 usec
>
> I'm particularly interested in the local target device latency with
> io_poll on vs. off. Did you keep your p99.99 latency and p90.00
> latency numbers from this experiment that can be share ?
>

BTW using one single CPU on the target (storage server) does not make
sense. My guess is that the source of slow down on the target was
because of this - as it is particularly relevant on polling mode


Thanks,
Wendy
