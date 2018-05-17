From: axboe@kernel.dk (Jens Axboe)
Date: Thu, 17 May 2018 09:22:32 -0600
Subject: [PATCHSET 0/3] Split queue lock into submission/completion locks
In-Reply-To: <1526569337-3489-1-git-send-email-axboe@kernel.dk>
References: <1526569337-3489-1-git-send-email-axboe@kernel.dk>
Message-ID: <cf519183-dd29-212f-5963-77f1f68157f6@kernel.dk>

On 5/17/18 9:02 AM, Jens Axboe wrote:
> This series is on top of the previous work from yesterday, including
> Christophs patch. It splits nvmeq->q_lock into two locks:
> 
> 1) ->sq_lock, that protects the submission side of things
> 2) ->cq_lock, that protects the completion side
> 
> This also means that we can drop the IRQ safe nature of the submission
> side locking.

Series also here:

http://git.kernel.dk/cgit/linux-block/log/?h=nvme-4.18

NOT on top of Christophs change, as it seems to regress performance for me.

Quick test on polling on an xpoint device with 4 threads shows a nice
improvement for me:

Current master:
   read: IOPS=519k, BW=253MiB/s (266MB/s)(2532MiB/10001msec)
    clat (usec): min=5, max=630, avg= 7.38, stdev= 3.16
     lat (usec): min=5, max=630, avg= 7.41, stdev= 3.16
    clat percentiles (nsec):
     |  1.00th=[ 6560],  5.00th=[ 6688], 10.00th=[ 6688], 20.00th=[ 6752],
     | 30.00th=[ 6816], 40.00th=[ 6880], 50.00th=[ 6944], 60.00th=[ 7072],
     | 70.00th=[ 7136], 80.00th=[ 7328], 90.00th=[ 7712], 95.00th=[ 8256],
     | 99.00th=[18048], 99.50th=[19072], 99.90th=[36096], 99.95th=[36608],
     | 99.99th=[41216]

and with this series:
   read: IOPS=507k, BW=248MiB/s (260MB/s)(2476MiB/10001msec)
    clat (usec): min=6, max=640, avg= 7.56, stdev= 3.19
     lat (usec): min=6, max=640, avg= 7.59, stdev= 3.19
    clat percentiles (nsec):
     |  1.00th=[ 6688],  5.00th=[ 6816], 10.00th=[ 6880], 20.00th=[ 6944],
     | 30.00th=[ 7008], 40.00th=[ 7072], 50.00th=[ 7136], 60.00th=[ 7200],
     | 70.00th=[ 7328], 80.00th=[ 7520], 90.00th=[ 7904], 95.00th=[ 8384],
     | 99.00th=[18048], 99.50th=[18816], 99.90th=[36096], 99.95th=[36608],
     | 99.99th=[42752]

For polling, looking at CPU utilization usually means seeing if we decrease
system time and shift that to app time instead. For master, it's
5.49/94.52% usr/sys, and with the patchset it's 5.71/94.27%.

-- 
Jens Axboe
