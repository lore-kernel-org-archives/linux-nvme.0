From: swise@opengridcomputing.com (Steve Wise)
Date: Thu, 9 Jun 2016 16:06:49 -0500
Subject: nvme-fabrics: crash at nvme connect-all
In-Reply-To: <CAF1ivSb2fvjEzCxWXnrxv_i74SRm2qxWZ-RiKpEaGOx-Dk3f1A@mail.gmail.com>
References: <53708289.31891804.1465463883806.JavaMail.zimbra@kalray.eu>
 <20160609132459.GA5105@infradead.org>
 <1290178000.33062227.1465486654766.JavaMail.zimbra@kalray.eu>
 <04d301d1c28d$183af7b0$48b0e710$@opengridcomputing.com>
 <CAF1ivSb2fvjEzCxWXnrxv_i74SRm2qxWZ-RiKpEaGOx-Dk3f1A@mail.gmail.com>
Message-ID: <04e301d1c292$d6c34430$8449cc90$@opengridcomputing.com>

> >
> > I can force a crash with this patch:
> >
> > diff --git a/drivers/infiniband/hw/cxgb4/mem.c
> b/drivers/infiniband/hw/cxgb4/mem.c
> > index 55d0651..bbc1422 100644
> > --- a/drivers/infiniband/hw/cxgb4/mem.c
> > +++ b/drivers/infiniband/hw/cxgb4/mem.c
> > @@ -619,6 +619,10 @@ struct ib_mr *c4iw_alloc_mr(struct ib_pd *pd,
> >         u32 stag = 0;
> >         int ret = 0;
> >         int length = roundup(max_num_sg * sizeof(u64), 32);
> > +       static int foo;
> > +
> > +       if (foo++ > 200)
> > +               return ERR_PTR(-ENOMEM);
> >
> >         php = to_c4iw_pd(pd);
> >         rhp = php->rhp;
> >
> >
> > Crash:
> >
> > rdma_rw_init_mrs: failed to allocated 128 MRs
> > failed to init MR pool ret= -12
> > nvmet_rdma: failed to create_qp ret= -12
> > nvmet_rdma: nvmet_rdma_alloc_queue: creating RDMA queue failed (-12).
> > nvme nvme1: Connect rejected, no private data.
> > nvme nvme1: rdma_resolve_addr wait failed (-104).
> > nvme nvme1: failed to initialize i/o queue: -104
> > nvmet_rdma: freeing queue 17
> > general protection fault: 0000 [#1] SMP
> 
> > RIP: 0010:[<ffffffff810d04c3>]  [<ffffffff810d04c3>]
> get_next_timer_interrupt+0x183/0x210
> > RSP: 0018:ffff88107f243e68  EFLAGS: 00010002
> > RAX: 00000000fffe39b8 RBX: 0000000000000001 RCX: 00000000fffe39b8
> > RDX: 6b6b6b6b6b6b6b6b RSI: 0000000000000039 RDI: 0000000000000036
> > RBP: ffff88107f243eb8 R08: ffff88107f24f488 R09: 0000000000fffe36
> > R10: ffff88107f243e70 R11: ffff88107f243e88 R12: 0000002a89f289c0
> > R13: 00000000fffe35d0 R14: ffff88107f24ec40 R15: 0000000000000040
> > FS:  0000000000000000(0000) GS:ffff88107f240000(0000)
> knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: ffffffffff600400 CR3: 000000103af92000 CR4: 00000000000406e0
> > Stack:
> >  ffff88107f24f488 ffff88107f24f688 ffff88107f24f888 ffff88107f24fa88
> >  ffff88107ec39698 ffff88107f250180 00000000fffe35d0 ffff88107f24c700
> >  0000002a89f30293 0000002a89f289c0 ffff88107f243f38 ffffffff810e2ac4
> > Call Trace:
> >  <IRQ>
> >  [<ffffffff810e2ac4>] tick_nohz_stop_sched_tick+0x1b4/0x2c0
> >  [<ffffffff810986a5>] ? sched_clock_cpu+0xc5/0xd0
> >  [<ffffffff810e2c73>] __tick_nohz_idle_enter+0xa3/0x140
> >  [<ffffffff810e2d38>] tick_nohz_irq_exit+0x28/0x40
> >  [<ffffffff8106c0a5>] irq_exit+0x95/0xb0
> >  [<ffffffff81642c76>] smp_apic_timer_interrupt+0x46/0x60
> >  [<ffffffff8164134f>] apic_timer_interrupt+0x7f/0x90
> >  <EOI>
> >  [<ffffffff810a7d2a>] ? cpu_idle_loop+0xda/0x250
> >  [<ffffffff810a7e13>] ? cpu_idle_loop+0x1c3/0x250
> >  [<ffffffff810a7ec1>] cpu_startup_entry+0x21/0x30
> >  [<ffffffff81044ce8>] start_secondary+0x78/0x80
> 
> The stack looks weird. Nothing nvme code related.
> I guess it is a random crash.
> 
> Could you do it again and will you see a different call stack?

Yes, I get the same crash after reproducing it twice.  At least the RIP is exactly the same:

get_next_timer_interrupt+0x183/0x210

The rest of the stack looked a little different but still had tick_nohz stuff in it.

Does this look correct ("freeing queue 17" twice)?

nvmet: creating controller 1 for NQN nqn.2014-08.org.nvmexpress:NVMf:uuid:6e01fbc9-49fb-4998-9522-df85a95f9ff7.
nvme nvme1: new ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery", addr 10.0.1.14:4420
nvmet_rdma: freeing queue 17
nvmet: creating controller 1 for NQN nqn.2014-08.org.nvmexpress:NVMf:uuid:6e01fbc9-49fb-4998-9522-df85a95f9ff7.
nvme nvme1: creating 16 I/O queues.
rdma_rw_init_mrs: failed to allocated 128 MRs
failed to init MR pool ret= -12
nvmet_rdma: failed to create_qp ret= -12
nvmet_rdma: nvmet_rdma_alloc_queue: creating RDMA queue failed (-12).
nvme nvme1: Connect rejected, no private data.
nvme nvme1: rdma_resolve_addr wait failed (-104).
nvme nvme1: failed to initialize i/o queue: -104
nvmet_rdma: freeing queue 17
general protection fault: 0000 [#1] SMP
