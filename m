From: zwp10758@gmail.com (Weiping Zhang)
Date: Tue, 23 Jul 2019 22:29:48 +0800
Subject: [PATCH v3 1/5] block: add weighted round robin for blkcgroup
In-Reply-To: <20190718135916.GC696309@devbig004.ftw2.facebook.com>
References: <cover.1561385989.git.zhangweiping@didiglobal.com>
 <1333161d2c64dbe93f9dcd0814ffaf6d00216d58.1561385989.git.zhangweiping@didiglobal.com>
 <20190718135916.GC696309@devbig004.ftw2.facebook.com>
Message-ID: <CAA70yB5cjengLDTUN3U02yuBmn+dxi2KreegD+u2RohejUocsA@mail.gmail.com>

Tejun Heo <tj at kernel.org> ?2019?7?18??? ??10:00???
>
> Hello, Weiping.
>
> On Mon, Jun 24, 2019@10:28:51PM +0800, Weiping Zhang wrote:
> > +static const char *blk_wrr_name[BLK_WRR_COUNT] = {
> > +     [BLK_WRR_NONE]          = "none",
> > +     [BLK_WRR_LOW]           = "low",
> > +     [BLK_WRR_MEDIUM]        = "medium",
> > +     [BLK_WRR_HIGH]          = "high",
> > +     [BLK_WRR_URGENT]        = "urgent",
> > +};
>
Hello Tejun,

> cgroup controllers must be fully hierarchical which the proposed
> implementation isn't.  While it can be made hierarchical, there's only
> so much one can do if there are only five priority levels.
>

These priority are fully mapped to nvme specification except WRR_NONE.
The Weighted Round Robin only support some of nvme devices, not all nvme
support this feature, if you think the name of blkio.wrr is too common
for block layer
I like to rename it to blkio.nvme.wrr. This patchset implent a simple interface
to user, if user want to use this feature they should to know the Qos
of WRR provided by
nvme device is accetable for their applicatiions. The NVME WRR is a
simple and usefull
feature, I want to give user one more option when they select a proper
io isolation policy.
It's not a general io isolation method, like what blkio.throttlle or
iocost did, it just implement
a simple mapping between application and nvme hardware submission
queue,  not add
any extra io statistic at block layer. The weight of (high, medium,
low) and the burst can be
changed by nvme-set-feature command. But this patchset does not
support that, will be
added in the feature.

> Can you please take a look at the following?
>
>   http://lkml.kernel.org/r/20190710205128.1316483-1-tj at kernel.org
>
> In comparison, I'm having a bit of hard time seeing the benefits of
> this approach.  In addition to the finite level limitation, the actual
> WRR behavior would be device dependent and what each level means is
> likely to fluctuate depending on the workload and device model.
>
>From the test result(sequtial and random) it seems the high priority
can get more
bps/iops than lower priority. If device cannot guarantee the io
latency when mixture
IOs issued to the device, I think, for WRR,  the software should tune Weigth of
high,medium, low and arbitration burst may provide a more stable
latency, like what
iocost does(tune overall io issue rate).

> I wonder whether WRR is something more valuable to help internal queue
> management rather than being exposed to userspace directly.
>
> Thanks.
>
> --
> tejun
