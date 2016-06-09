From: sagi@lightbits.io (Sagi Grimberg)
Date: Thu, 9 Jun 2016 16:48:20 +0300
Subject: nvme-fabrics: crash at nvme connect-all
In-Reply-To: <005701d1c253$f9590550$ec0b0ff0$@opengridcomputing.com>
References: <53708289.31891804.1465463883806.JavaMail.zimbra@kalray.eu>
 <575936F0.9000600@lightbits.io>
 <574056153.32082017.1465466832847.JavaMail.zimbra@kalray.eu>
 <57594E81.9060302@lightbits.io>
 <1218382158.32228335.1465474321289.JavaMail.zimbra@kalray.eu>
 <5759614D.5080703@lightbits.io>
 <004901d1c252$b5978d10$20c6a730$@opengridcomputing.com>
 <005701d1c253$f9590550$ec0b0ff0$@opengridcomputing.com>
Message-ID: <575973A4.9080001@lightbits.io>


>>> Steve, did you see this before? I'm wandering if we need some sort
>>> of logic handling with resource limitation in iWARP (global mrs pool...)
>>
>> Haven't seen this.  Does 'cat /sys/kernel/debug/iw_cxgb4/blah/stats' show
>> anything interesting?  Where/why is it crashing?
>>
>
> So this is the failure:
>
> [  703.239462] rdma_rw_init_mrs: failed to allocated 128 MRs
> [  703.239498] failed to init MR pool ret= -12
> [  703.239541] nvmet_rdma: failed to create_qp ret= -12
> [  703.239582] nvmet_rdma: nvmet_rdma_alloc_queue: creating RDMA queue failed
> (-12).
>
> Not sure why it would fail.  I would think my setup would be allocating more
> given I have 16 cores on the host and target.  The debugfs "stats" file I
> mentioned above should show us something if we're running out of adapter
> resources for MR or PBL records.

Note that Marta ran both the host and the target on the same machine.
So, 8 (cores) x 128 (queue entries) x 2 (host and target) gives 2048
MRs...

What is the T5 limitation?
