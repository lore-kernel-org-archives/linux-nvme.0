From: swise@opengridcomputing.com (Steve Wise)
Date: Thu, 16 Jun 2016 15:12:46 -0500
Subject: target crash / host hang with nvme-all.3 branch of nvme-fabrics
In-Reply-To: <576306EE.4020306@grimberg.me>
References: <00d801d1c7de$e17fc7d0$a47f5770$@opengridcomputing.com>
 <20160616145724.GA32635@infradead.org>
 <017001d1c7e7$95057270$bf105750$@opengridcomputing.com>
 <5763044A.9090206@grimberg.me>
 <01b501d1c809$92cb1a60$b8614f20$@opengridcomputing.com>
 <576306EE.4020306@grimberg.me>
Message-ID: <01b901d1c80b$72f83680$58e8a380$@opengridcomputing.com>



> >>
> >> Umm, I think this might be happening because we get to delete_ctrl when
> >> one of our queues has a NULL ctrl. This means that either:
> >> 1. we never got a chance to initialize it, or
> >> 2. we already freed it.
> >>
> >> (1) doesn't seem possible as we have a very short window (that we're
> >> better off eliminating) between when we start the keep-alive timer (in
> >> alloc_ctrl) and the time we assign the sq->ctrl (install_queue).
> >>
> >> (2) doesn't seem likely either to me at least as from what I followed,
> >> delete_ctrl should be mutual exclusive with other deletions, moreover,
> >> I didn't see an indication in the logs that any other deletions are
> >> happening.
> >>
> >> Steve, is this something that started happening recently? does the
> >> 4.6-rc3 tag suffer from the same phenomenon?
> >
> > I'll try and reproduce this on the older code, but the keep-alive timer
fired
> > for some other reason,
> 
> My assumption was that it fired because it didn't get a keep-alive from
> the host which is exactly what it's supposed to do?
>

Yes, in the original email I started this thread with, I show that on the host,
2 cpus were stuck, and I surmise that the host node was stuck NVMF-wise and thus
the target timer kicked and crashed the target. 
 
> > so I'm not sure the target side keep-alive has been
> > tested until now.
> 
> I tested it, and IIRC the original patch had Ming's tested-by tag.
> 

How did you test it?

> > But it is easy to test over iWARP, just do this while a heavy
> > fio is running:
> >
> > ifconfig ethX down; sleep 15; ifconfig ethX <ipaddr>/<mask> up
> 
> So this is related to I/O load then? Does it happen when
> you just do it without any I/O? (or small load)?

I'll try this.  

Note there are two sets of crashes discussed in this thread:  the one Yoichi saw
on his nodes where the host hung causing the target keep-alive to fire and
crash.  That is the crash with stack traces I included in the original email
starting this thread.   And then there is a repeatable crash on my setup, which
looks the same, that happens when I bring the interface down long enough to kick
the keep-alive.  Since I can reproduce the latter easily I'm continuing with
this debug.

Here is the fio command I use:

fio --bs=1k --time_based --runtime=2000 --numjobs=8 --name=TEST-1k-8g-20-8-32
--direct=1 --iodepth=32 -rw=randread --randrepeat=0 --norandommap --loops=1
--exitall --ioengine=libaio --filename=/dev/nvme1n1
