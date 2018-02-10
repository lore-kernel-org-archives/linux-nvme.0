From: alex.nlnnfn@gmail.com (Alex Nln)
Date: Sat, 10 Feb 2018 13:08:17 -0800
Subject: coalescing in polling mode in 4.9
In-Reply-To: <41246a55-9ecc-72e1-c51e-f04195ca35ed@samsung.com>
References: <20180202001028.fee27cf239e3e8a5ae6bd8a4@gmail.com>
 <CGME20180205145924epcas3p2f8156043ec00b51c135ac62c1fa177d7@epcas3p2.samsung.com>
 <20180205150253.GN24417@localhost.localdomain>
 <7d378937-1859-0007-12b3-ca1722d2a5c3@samsung.com>
 <20180205213945.303b3a69a7048d94cecac599@gmail.com>
 <41246a55-9ecc-72e1-c51e-f04195ca35ed@samsung.com>
Message-ID: <20180210130817.df352d4336ae0e80ae1755cb@gmail.com>

Hi Nitesh,

Yes, the benefits are clear, in terms of IOPS and latency. See below.

coalescing   iops clat intr/s
    0x0000 108710 8.65 108711
    0xff01 113081 8.28  56541
    0xff03 114955 8.14  28738
    0xff07 116318 8.04  14539
    0xff0f 116470 8.02   7279
    0xff1f 116908 8.00   3653
    0xff3f 116833 8.00   1825
    0xff7f 116718 8.00    911
    0xffff 116962 8.00    456

It is quite strange model of IO processing: polling with interrupts. 
Shouldn't these two be mutual exclusive? Why not to disable
interrupts at all on a queue while polling?

Thanks,
Alex

device Intel DC P3600, kernel 4.9.76 + Nitesh patch that fixes polling, fio 2.21:

[global]
iodepth=1
direct=1
ioengine=pvsync2
hipri
group_reporting
time_based
norandommap=1

[job1]
rw=read
filename=/dev/nvme0n1
name=raw=sequential-read
numjobs=1
runtime=60



On Sat, 10 Feb 2018 04:07:08 +0530
Nitesh Shetty <nj.shetty@samsung.com> wrote:

> Hi Alex,
> 
> Did you observe any benefit in polling-performance i.e. with 
> interrupt-coalescing vs without interrupt-coalescing. I'd appreciate if 
> you could share the performance/latency data.
> 
> Thanks,
> Nitesh
> 
> On Tuesday 06 February 2018 11:09 AM, Alex Nln wrote:
> > Hi Nitesh,
> > 
> > On Mon, 05 Feb 2018 21:12:12 +0530
> > Nitesh <nj.shetty@samsung.com> wrote:
> > 
> >> Hi Alex,
> >> I got into similar problem not long ago. With coalescing enabled, some
> >> I/Os took very long. Every time need_reshed() returns true,
> >> io_schedule() makes task go to sleep as its state is previous set as
> >> non-interruptible.I handled this by setting task state as running, and
> >> release the cpu. Diff is attached below, you may give it a try.
> >>
> > 
> > I tested this patch on kernel 4.9 and it solves the problem.
> > Thanks a lot
> > 
> > 
> >>
> >> diff --git a/fs/block_dev.c b/fs/block_dev.c
> >> index 4a181fc..d2eeedf 100644
> >> --- a/fs/block_dev.c
> >> +++ b/fs/block_dev.c
> >> @@ -236,9 +236,13 @@ __blkdev_direct_IO_simple(struct kiocb *iocb,
> >> struct iov_iter *iter,
> >>                   set_current_state(TASK_UNINTERRUPTIBLE);
> >>                   if (!READ_ONCE(bio.bi_private))
> >>                           break;
> >> -               if (!(iocb->ki_flags & IOCB_HIPRI) ||
> >> -                   !blk_poll(bdev_get_queue(bdev), qc))
> >> +               if (!(iocb->ki_flags & IOCB_HIPRI))
> >>                           io_schedule();
> >> +               else if (!blk_poll(bdev_get_queue(bdev), qc)) {
> >> +                       if(need_resched())
> >> +                               set_current_state(TASK_RUNNING);
> >> +                       io_schedule();
> >> +               }
> >>           }
> >>           __set_current_state(TASK_RUNNING);
> >>
> >>
> > 
> > _______________________________________________
> > Linux-nvme mailing list
> > Linux-nvme at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-nvme
> > 
> > 
> > 
