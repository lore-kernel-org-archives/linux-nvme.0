From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Thu, 27 Jun 2019 05:27:06 +0900
Subject: [PATCH v3 3/5] nvme-pci: rename module parameter write_queues to
 read_queues
In-Reply-To: <CAA70yB5arvfaUsktN-cvd0yHpRi+FwFjL4r5_jTRWM8+rBVdnA@mail.gmail.com>
References: <cover.1561385989.git.zhangweiping@didiglobal.com>
 <d61b1b9a31c3d2fae9ece26bcd5f4504b25f059f.1561385989.git.zhangweiping@didiglobal.com>
 <20190624200445.GB6526@minwooim-desktop>
 <CAA70yB5arvfaUsktN-cvd0yHpRi+FwFjL4r5_jTRWM8+rBVdnA@mail.gmail.com>
Message-ID: <20190626202706.GC4934@minwooim-desktop>

On 19-06-25 22:48:57, Weiping Zhang wrote:
> Minwoo Im <minwoo.im.dev at gmail.com> ?2019?6?25??? ??6:00???
> >
> > On 19-06-24 22:29:19, Weiping Zhang wrote:
> > > Now nvme support three type hardware queues, read, poll and default,
> > > this patch rename write_queues to read_queues to set the number of
> > > read queues more explicitly. This patch alos is prepared for nvme
> > > support WRR(weighted round robin) that we can get the number of
> > > each queue type easily.
> > >
> > > Signed-off-by: Weiping Zhang <zhangweiping at didiglobal.com>
> >
> > Hello, Weiping.
> >
> > Thanks for making this patch as a separated one.  Actually I'd like to
> > hear about if the origin purpose of this param can be changed or not.
> >
> > I can see a log from Jens when it gets added her:
> >   Commit 3b6592f70ad7("nvme: utilize two queue maps, one for reads and
> >                        one for writes")
> >   It says:
> >   """
> >   NVMe does round-robin between queues by default, which means that
> >   sharing a queue map for both reads and writes can be problematic
> >   in terms of read servicing. It's much easier to flood the queue
> >   with writes and reduce the read servicing.
> >   """
> >
> > So, I'd like to hear what other people think about this patch :)
> >
> 
> This patch does not change its original behavior, if we set read_queue
> greater than 0, the read and write request will use different tagset map,
> so they will use different hardware queue.

Yes, that's why I want to hear some comments for this change from other
people.  I'm not against this change, though.
