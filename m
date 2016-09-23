From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri, 23 Sep 2016 14:10:17 -0700
Subject: NVMf (NVME over fabrics) Performance
In-Reply-To: <96b893e9c10252baddbbf761294e4794@mail.gmail.com>
References: <c53316925d9da9f13925a29674533f2e@mail.gmail.com>
 <044931a9-2c5a-c33f-3d44-6009fc96297e@grimberg.me>
 <96b893e9c10252baddbbf761294e4794@mail.gmail.com>
Message-ID: <8946d566-ae6a-2255-5001-a45248b96786@grimberg.me>


> Hi Saig,

Hey Kiru,

> Thanks for the suggestion, here is what I have (re)tried
>
> 1. Both target and initiator is not blocked by CPU (CPU is atleast 70% idle,
> and load is distributed across 16 CPU's)

The distribution makes sense as we're multi-queue.

> 2. Yes, irqbalancer is running.

I'd advise to turn it off when testing performance. I've never
really seen irqbalancer actually help something...

> 3. register_always is true already, I have upgraded to 4.8.rc7.

OK, this is a bit tricky, but having it on will usually hurt your
4k read performance. Its the correct thing to do but you should
be able to get better performance.

Some background:
nvme-rdma (like iser, srp and others) can optimize 4k reads (or reads
that fit in a single page) by skipping memory registration and send
a global rkey, which is good for performance but exposes host memory
to the target (which can abuse it if buggy/malicious).

Since you mentioned you are using ConnectX3 devices, it makes sense
that it really slow things down because ConnectX3 devices has severe
fencing strategy for memory registrations. There are some devices
that has better performance with small registrations on...

So, I suggest using register_always=N when testing small 4k reads.

Do you see the same with 4k writes btw?
