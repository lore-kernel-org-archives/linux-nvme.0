From: nj.shetty@samsung.com (Nitesh)
Date: Mon, 05 Feb 2018 21:12:12 +0530
Subject: coalescing in polling mode in 4.9
In-Reply-To: <20180205150253.GN24417@localhost.localdomain>
References: <20180202001028.fee27cf239e3e8a5ae6bd8a4@gmail.com>
 <CGME20180205145924epcas3p2f8156043ec00b51c135ac62c1fa177d7@epcas3p2.samsung.com>
 <20180205150253.GN24417@localhost.localdomain>
Message-ID: <7d378937-1859-0007-12b3-ca1722d2a5c3@samsung.com>

Hi Alex,
I got into similar problem not long ago. With coalescing enabled, some 
I/Os took very long. Every time need_reshed() returns true, 
io_schedule() makes task go to sleep as its state is previous set as 
non-interruptible.I handled this by setting task state as running, and 
release the cpu. Diff is attached below, you may give it a try.

Hi Keith,
Should below not be the default way to handle classic-polling case i.e. 
do not rely on interrupts at all? For sleep during polling-path (which 
reduces cpu utilization) we anyway have hybrid polling path. If this 
approach seems acceptable, I can further refactor the code and submit a 
patch. I look forward to your suggestions.


diff --git a/fs/block_dev.c b/fs/block_dev.c
index 4a181fc..d2eeedf 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -236,9 +236,13 @@ __blkdev_direct_IO_simple(struct kiocb *iocb, 
struct iov_iter *iter,
                 set_current_state(TASK_UNINTERRUPTIBLE);
                 if (!READ_ONCE(bio.bi_private))
                         break;
-               if (!(iocb->ki_flags & IOCB_HIPRI) ||
-                   !blk_poll(bdev_get_queue(bdev), qc))
+               if (!(iocb->ki_flags & IOCB_HIPRI))
                         io_schedule();
+               else if (!blk_poll(bdev_get_queue(bdev), qc)) {
+                       if(need_resched())
+                               set_current_state(TASK_RUNNING);
+                       io_schedule();
+               }
         }
         __set_current_state(TASK_RUNNING);


On Monday 05 February 2018 08:32 PM, Keith Busch wrote:
> On Fri, Feb 02, 2018@12:10:28AM -0800, Alex Nln wrote:
>> Enabling interrupt coalescing in nvme device, kernel 4.9
>> significantly reduces performance when using polling mode.
>> When I enable coalescing, IOPS drops from 100K to 35K and
>> latency jumps from 7 usec to 25 usec.
>>
>> Shouldn't we expect performance boost in polling mode when
>> interrupt coalescing enabled?
>>
>>
>> Device is Intel DC P3600
> 
> That's a pretty low latency for this device. Are you running reads to
> unmapped blocks?
> 
> I've seen the phenomenom occur where higher coalescing settings worsens
> performance. That usually means the the polling thread exceeded its time:
> need_resched() returns true, so the tasks schedules out and relies on
> interrupts, which have been throttled. Maybe a hybrid polling would be
> better for this.
> 
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
> 
> 
> 
