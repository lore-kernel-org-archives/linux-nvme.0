From: swise@opengridcomputing.com (Steve Wise)
Date: Thu, 9 Jun 2016 09:22:30 -0500
Subject: nvme-fabrics: crash at nvme connect-all
In-Reply-To: <006501d1c258$835dacc0$8a190640$@opengridcomputing.com>
References: <53708289.31891804.1465463883806.JavaMail.zimbra@kalray.eu>
 <575936F0.9000600@lightbits.io>
 <574056153.32082017.1465466832847.JavaMail.zimbra@kalray.eu>
 <57594E81.9060302@lightbits.io>
 <1218382158.32228335.1465474321289.JavaMail.zimbra@kalray.eu>
 <5759614D.5080703@lightbits.io>
 <004901d1c252$b5978d10$20c6a730$@opengridcomputing.com>
 <005701d1c253$f9590550$ec0b0ff0$@opengridcomputing.com>
 <575973A4.9080001@lightbits.io>
 <006501d1c258$835dacc0$8a190640$@opengridcomputing.com>
Message-ID: <006a01d1c25a$5b23c0d0$116b4270$@opengridcomputing.com>

> >
> > >>> Steve, did you see this before? I'm wandering if we need some sort
> > >>> of logic handling with resource limitation in iWARP (global mrs pool...)
> > >>
> > >> Haven't seen this.  Does 'cat /sys/kernel/debug/iw_cxgb4/blah/stats' show
> > >> anything interesting?  Where/why is it crashing?
> > >>
> > >
> > > So this is the failure:
> > >
> > > [  703.239462] rdma_rw_init_mrs: failed to allocated 128 MRs
> > > [  703.239498] failed to init MR pool ret= -12
> > > [  703.239541] nvmet_rdma: failed to create_qp ret= -12
> > > [  703.239582] nvmet_rdma: nvmet_rdma_alloc_queue: creating RDMA queue
> > failed
> > > (-12).
> > >
> > > Not sure why it would fail.  I would think my setup would be allocating
more
> > > given I have 16 cores on the host and target.  The debugfs "stats" file I
> > > mentioned above should show us something if we're running out of adapter
> > > resources for MR or PBL records.
> >
> > Note that Marta ran both the host and the target on the same machine.
> > So, 8 (cores) x 128 (queue entries) x 2 (host and target) gives 2048
> > MRs...
> >
> > What is the T5 limitation?
> 
> It varies based on a config file that gets loaded when cxgb4 loads.  Note the
> error has nothing to do with the low fastreg sg depth limit of T5.  If we were
> hitting that then we would be seeing EINVAL and not ENOMEM.  Looking at
> c4iw_alloc_mr(), the ENOMEM paths are either failures from kzalloc() or
> dma_alloc_coherent(), or failures to allocate adapter resources for MR and PBL
> records.  Each MR takes a 32B record in adapter mem, and the PBL takes
whatever
> based on the max sg depth (roughly sg_depth * 8 + some rounding up).  The
> debugfs "stats" file will show us what is being exhausted and how much adapter
> mem is available for these resources.
> 
> Also, the amount of available adapter mem depends on the type of T5 adapter.
> The T5 adapter info should be in the dmesg log when cxgb4 is loaded.
> 
> Steve

Here is an example of the iw_cxgb4 debugfs "stats" output.  This is for a
T580-CR with the "default" configuration, which means there is no config file
named t5-config.txt in /lib/firmware/cxgb4/.

[root at stevo1 linux-2.6]# cat /sys/kernel/debug/iw_cxgb4/0000\:82\:00.4/stats
   Object:      Total    Current        Max       Fail
     PDID:      65536          0          0          0
      QID:      24576          0          0          0
   TPTMEM:   36604800          0          0          0
   PBLMEM:   91512064          0          0          0
   RQTMEM:  128116864          0          0          0
  OCQPMEM:          0          0          0          0
  DB FULL:          0
 DB EMPTY:          0
  DB DROP:          0
 DB State: NORMAL Transitions 0 FC Interruptions 0
TCAM_FULL:          0
ACT_OFLD_CONN_FAILS:          0
PAS_OFLD_CONN_FAILS:          0
NEG_ADV_RCVD:          0
AVAILABLE IRD:     589824

Note it shows the total, currently allocated, max ever allocated, and failures
for each rdma resource, most of which are tied to HW resources.  So if we see
failures, then we know the adapter resources were exhausted.

TPTMEM is the available adapter memory for MR records.  Each record is 32B.  So
a total of 1143900 MRs (TPTMEM / 32) can be created.  The PBLMEM resource is for
holding the dma addresses for all pages in a MR, so each MR uses some number
depending on the sg depth passed in when allocating a FRMR.  So if we allocate
128 deep page lists, we should be able to allocate 89367 PBLs (PBLMEM / 8 /
128).

Seems like we shouldn't be exhausting the adapter resources with 2048 MRs... 

Steve
