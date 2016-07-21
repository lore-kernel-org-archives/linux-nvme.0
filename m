From: xjtuwjp@gmail.com (Jack Wang)
Date: Thu, 21 Jul 2016 16:22:16 +0200
Subject: Bandwidth issues and blktrace debug
In-Reply-To: <CA+-kpaQ1L0H_dcvqkyrd8d-zOjExE5tXXf88mPA+WpeorsSrDg@mail.gmail.com>
References: <CA+-kpaTvU+5vbqk536ajVSxwKSfa+c_4Ks5wv4iaee7UfcOnqA@mail.gmail.com>
 <CAD+HZHWTf-78rMR9bRZdF_36gMah-RD87NBT-01NqcFLHKNnWQ@mail.gmail.com>
 <CA+-kpaQ1L0H_dcvqkyrd8d-zOjExE5tXXf88mPA+WpeorsSrDg@mail.gmail.com>
Message-ID: <CAD+HZHUXtCU0pYJnhPfUsoG3Lx=yGCDmdV5+rxb+LDC4vqSRQQ@mail.gmail.com>

2016-07-21 13:39 GMT+02:00 Gil Shomron <gil.shomron at gmail.com>:
>
> Hi Jack, how did you understand that the IO in the good trace is 128K
> and on the bad one is 1M?
Or maybe you didn't catch queue spiting part for good trace.

>
> As far as I understand there are 8*256K requests at the end of each
It's 256 sectors, so 128K

> trace, so it is 1M.... or I'm missing something?
>
> About the max_hw_sectors_kb and max_sectors_kb - both are 128.

Read the user guide:
http://www.cse.unsw.edu.au/~aaronc/iosched/doc/blktrace.html

See comments inline.

I cc-ed the list back.



>
> On Thu, Jul 21, 2016@2:18 PM, Jack Wang <xjtuwjp@gmail.com> wrote:
> >
> >
> > 2016-07-21 12:36 GMT+02:00 Gil Shomron <gil.shomron at gmail.com>:
> >>
> >> Hi all,
> >>
> >> I have Intel's P3700 SSD mounted on a Lenovo x3650 M5 server with two
> >> Intel Xeon E5-2630 v3 CPUs. The server is running Ubuntu 14.04 with
> >> 4.6.4 Kernel.
> >>
> >> I've been using fio to benchmark the SSD using a synchronous
> >> sequential reads with 1MB block size. Bandwidth result is ~1.6GB/sec.
> >> This is relatively small to the maximum 2.8GB/sec it should be. I did
> >> witnessed a P3700 reaches this bandwidth with a similar benchmark on a
> >> high-end PC.
> >>
> >> This is the fio command I'm using
> >> sudo fio --time_based --name=benchmark --size=1G --runtime=15
> >> --blocksize=1M --ioengine=sync --randrepeat=0 --iodepth=1 --direct=1
> >> --sync=1 --verify_fatal=0 --numjobs=1 --rw=read --group_reporting
> >>
> >> Trying to debug this I've installed blktrace, and ran it on my server
> >> and on the high-end PC for comparison. see below.
> >>
> >> Notice that on the server there are a bunch of splits (X) while the PC
> >> doesn't have them, and on the server there is a mismatch between the
> >> queued and dispatched requests (on the end). What is it?
> >>
> >> Server trace (bad):
> >> 259,0    0    94207     1.353041898  1597  A   R 410329088 + 2048 <-
> >> (259,1) 410327040
request remaped, start from sector 410329088, length is 2048 sectors,
so total 1M.
> >> 259,1    0    94208     1.353042039  1597  Q   R 410329088 + 2048 [fio]
> >> 259,1    0    94209     1.353042709  1597  X   R 410329088 / 410329344
due to your hardware limit, request splited (410329344 - 410329088) 128K,
> >> [fio]
> >> 259,1    0    94210     1.353042800  1597  Q   R 410329344 + 1792 [fio]

request from 410329344 got requeued.

Snip

Cheers,
Jack

> >>
> >> Thanks,
> >>    Gil.
> >
> >
> >  Hi Gil,
> >
> > Looks you're not using same fio configration file on both server, the good
> > one received IO with block size 128K,
> > bad one with 1M.
> >
> > Also have you checked:
> >  /sys/block/nvmxx/queue/max_hw_sectors_kb
> > /sys/block/nvmxx/queue/max_sectors_kb
> >
> > block layer split IO based on thoes limit.
> >
> > You can increase the second one if possible.
> >
> > Regards,
> > Jack
