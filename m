From: ming.lei@redhat.com (Ming Lei)
Date: Sun, 8 Apr 2018 18:48:08 +0800
Subject: BUG at IP: blk_mq_get_request+0x23e/0x390 on 4.16.0-rc7
In-Reply-To: <20180408104433.GB29020@ming.t460p>
References: <10632862.17524551.1522402353418.JavaMail.zimbra@redhat.com>
 <682acdbe-7624-14d6-36e0-e2dd4c6b771f@grimberg.me>
 <256ebbe9-d932-a826-977b-5a5cb8483755@redhat.com>
 <ebdf8c7f-ae42-a08f-0d79-d2d4f17ec117@grimberg.me>
 <20180408104433.GB29020@ming.t460p>
Message-ID: <20180408104801.GC29020@ming.t460p>

On Sun, Apr 08, 2018@06:44:33PM +0800, Ming Lei wrote:
> On Sun, Apr 08, 2018@01:36:27PM +0300, Sagi Grimberg wrote:
> > 
> > > Hi Sagi
> > > 
> > > Still can reproduce this issue with the change:
> > 
> > Thanks for validating Yi,
> > 
> > Would it be possible to test the following:
> > --
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index 75336848f7a7..81ced3096433 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -444,6 +444,10 @@ struct request *blk_mq_alloc_request_hctx(struct
> > request_queue *q,
> >                 return ERR_PTR(-EXDEV);
> >         }
> >         cpu = cpumask_first_and(alloc_data.hctx->cpumask, cpu_online_mask);
> > +       if (cpu >= nr_cpu_ids) {
> > +               pr_warn("no online cpu for hctx %d\n", hctx_idx);
> > +               cpu = cpumask_first(alloc_data.hctx->cpumask);
> > +       }
> >         alloc_data.ctx = __blk_mq_get_ctx(q, cpu);
> > 
> >         rq = blk_mq_get_request(q, NULL, op, &alloc_data);
> > --
> > ...
> > 
> > 
> > > [? 153.384977] BUG: unable to handle kernel paging request at
> > > 00003a9ed053bd48
> > > [? 153.393197] IP: blk_mq_get_request+0x23e/0x390
> > 
> > Also would it be possible to provide gdb output of:
> > 
> > l *(blk_mq_get_request+0x23e)
> 
> nvmf_connect_io_queue() is used in this way by asking blk-mq to allocate
> request from one specific hw queue, but there may not be all online CPUs
> mapped to this hw queue.

And the following patchset may fail this kind of allocation and avoid
the kernel oops.

	https://marc.info/?l=linux-block&m=152318091025252&w=2

Thanks,
Ming
