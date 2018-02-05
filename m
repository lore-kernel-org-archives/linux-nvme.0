From: alex.nlnnfn@gmail.com (Alex Nln)
Date: Sun, 4 Feb 2018 16:15:06 -0800
Subject: coalescing in polling mode in 4.9
In-Reply-To: <20180202001028.fee27cf239e3e8a5ae6bd8a4@gmail.com>
References: <20180202001028.fee27cf239e3e8a5ae6bd8a4@gmail.com>
Message-ID: <20180204161506.4e74225c809295c037fae83a@gmail.com>


Appreciate if someone could help me to understand why do we need interrupts 
in polling mode, and performance drops when interrupts coalescing enabled.

Thanks

On Fri, 2 Feb 2018 00:10:28 -0800
Alex Nln <alex.nlnnfn@gmail.com> wrote:

> Hello,
> 
> Enabling interrupt coalescing in nvme device, kernel 4.9 
> significantly reduces performance when using polling mode.
> When I enable coalescing, IOPS drops from 100K to 35K and 
> latency jumps from 7 usec to 25 usec.
> 
> Shouldn't we expect performance boost in polling mode when
> interrupt coalescing enabled? 
> 
> 
> Device is Intel DC P3600
> Coalescing enabled:  nvme set-feature /dev/nvme0 -f 8 -v 0x00ffff
> fio-2.16 file:
> [global]
> iodepth=1
> direct=1
> ioengine=pvsync2
> hipri
> group_reporting
> time_based
> blocksize=4k
> norandommap=1
> 
> [job1]
> rw=read
> filename=/dev/nvme0n1
> name=raw=sequential-read
> numjobs=1
> runtime=60
> 
> 
> 
> Thanks
