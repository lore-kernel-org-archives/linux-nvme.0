From: alex.nlnnfn@gmail.com (Alex Nln)
Date: Mon, 5 Feb 2018 19:55:26 -0800
Subject: coalescing in polling mode in 4.9
In-Reply-To: <20180205150253.GN24417@localhost.localdomain>
References: <20180202001028.fee27cf239e3e8a5ae6bd8a4@gmail.com>
 <20180205150253.GN24417@localhost.localdomain>
Message-ID: <20180205195526.ecef69fbc4a9550f221134be@gmail.com>

On Mon, 5 Feb 2018 08:02:53 -0700
Keith Busch <keith.busch@intel.com> wrote:

> On Fri, Feb 02, 2018@12:10:28AM -0800, Alex Nln wrote:
> > Enabling interrupt coalescing in nvme device, kernel 4.9 
> > significantly reduces performance when using polling mode.
> > When I enable coalescing, IOPS drops from 100K to 35K and 
> > latency jumps from 7 usec to 25 usec.
> > 
> > Shouldn't we expect performance boost in polling mode when
> > interrupt coalescing enabled? 
> > 
> > 
> > Device is Intel DC P3600
> 
> That's a pretty low latency for this device. Are you running reads to
> unmapped blocks?

These are synchronous sequential reads, random reads' latency is higher.

> 
> I've seen the phenomenom occur where higher coalescing settings worsens
> performance. That usually means the the polling thread exceeded its time:
> need_resched() returns true, so the tasks schedules out and relies on
> interrupts, which have been throttled. Maybe a hybrid polling would be
> better for this.
> 

It looks like the eventual call to need_resched() is a result of low performance.
When I set coalescing to 0x00FFFF there are about 160 nvme interrupts/sec, 
but ~35K IOPS, so clearly only a fractions of CQ entries are processed in 
interrupt context, most of the CQ entries still processed by polling.
Somehow device delays posting completion entries when coalescing is enabled.
Is it possible?

Thanks for help
