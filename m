From: keith.busch@intel.com (Keith Busch)
Date: Mon, 5 Feb 2018 08:02:53 -0700
Subject: coalescing in polling mode in 4.9
In-Reply-To: <20180202001028.fee27cf239e3e8a5ae6bd8a4@gmail.com>
References: <20180202001028.fee27cf239e3e8a5ae6bd8a4@gmail.com>
Message-ID: <20180205150253.GN24417@localhost.localdomain>

On Fri, Feb 02, 2018@12:10:28AM -0800, Alex Nln wrote:
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

That's a pretty low latency for this device. Are you running reads to
unmapped blocks?

I've seen the phenomenom occur where higher coalescing settings worsens
performance. That usually means the the polling thread exceeded its time:
need_resched() returns true, so the tasks schedules out and relies on
interrupts, which have been throttled. Maybe a hybrid polling would be
better for this.
