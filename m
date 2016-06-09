From: swise@opengridcomputing.com (Steve Wise)
Date: Thu, 9 Jun 2016 09:09:18 -0500
Subject: nvme-fabrics: crash at nvme connect-all
In-Reply-To: <575973A4.9080001@lightbits.io>
References: <53708289.31891804.1465463883806.JavaMail.zimbra@kalray.eu>
 <575936F0.9000600@lightbits.io>
 <574056153.32082017.1465466832847.JavaMail.zimbra@kalray.eu>
 <57594E81.9060302@lightbits.io>
 <1218382158.32228335.1465474321289.JavaMail.zimbra@kalray.eu>
 <5759614D.5080703@lightbits.io>
 <004901d1c252$b5978d10$20c6a730$@opengridcomputing.com>
 <005701d1c253$f9590550$ec0b0ff0$@opengridcomputing.com>
 <575973A4.9080001@lightbits.io>
Message-ID: <006501d1c258$835dacc0$8a190640$@opengridcomputing.com>

> 
> >>> Steve, did you see this before? I'm wandering if we need some sort
> >>> of logic handling with resource limitation in iWARP (global mrs pool...)
> >>
> >> Haven't seen this.  Does 'cat /sys/kernel/debug/iw_cxgb4/blah/stats' show
> >> anything interesting?  Where/why is it crashing?
> >>
> >
> > So this is the failure:
> >
> > [  703.239462] rdma_rw_init_mrs: failed to allocated 128 MRs
> > [  703.239498] failed to init MR pool ret= -12
> > [  703.239541] nvmet_rdma: failed to create_qp ret= -12
> > [  703.239582] nvmet_rdma: nvmet_rdma_alloc_queue: creating RDMA queue
> failed
> > (-12).
> >
> > Not sure why it would fail.  I would think my setup would be allocating more
> > given I have 16 cores on the host and target.  The debugfs "stats" file I
> > mentioned above should show us something if we're running out of adapter
> > resources for MR or PBL records.
> 
> Note that Marta ran both the host and the target on the same machine.
> So, 8 (cores) x 128 (queue entries) x 2 (host and target) gives 2048
> MRs...
> 
> What is the T5 limitation?

It varies based on a config file that gets loaded when cxgb4 loads.  Note the
error has nothing to do with the low fastreg sg depth limit of T5.  If we were
hitting that then we would be seeing EINVAL and not ENOMEM.  Looking at
c4iw_alloc_mr(), the ENOMEM paths are either failures from kzalloc() or
dma_alloc_coherent(), or failures to allocate adapter resources for MR and PBL
records.  Each MR takes a 32B record in adapter mem, and the PBL takes whatever
based on the max sg depth (roughly sg_depth * 8 + some rounding up).  The
debugfs "stats" file will show us what is being exhausted and how much adapter
mem is available for these resources.

Also, the amount of available adapter mem depends on the type of T5 adapter.
The T5 adapter info should be in the dmesg log when cxgb4 is loaded.

Steve
