From: stephen.bates@microsemi.com (Stephen Bates)
Date: Thu, 12 May 2016 17:27:59 +0000
Subject: [PATCH 0/2] Block: Give option to force io polling
In-Reply-To: <20160512070805.GE20802@infradead.org>
References: <1459455554-2794-1-git-send-email-jonathan.derrick@intel.com>
 <D87A37E7A4AA544D853031D9A919C70B168FDA58@avsrvexchmbx2.microsemi.net>
 <20160508090257.GG15458@infradead.org>
 <D87A37E7A4AA544D853031D9A919C70B16901010@avsrvexchmbx2.microsemi.net>
 <20160512070805.GE20802@infradead.org>
Message-ID: <D87A37E7A4AA544D853031D9A919C70B16905A94@avsrvexchmbx2.microsemi.net>

> 
> 
> On Mon, May 09, 2016@02:53:30PM +0000, Stephen Bates wrote:
> > Christoph, this is a DRAM based NVMe device, the code for polling in
> NVMe was merged in 4.5 right? We are using the inbox NVMe driver. Here is
> some performance data:
> >
> > QD=1, single thread, random 4KB reads
> >
> > Polling Off: 12us Avg / 40us 99.99% ;
> > Polling On: 9.5us Avg / 25us 99.99%
> >
> > Both the average and 99.99% reduction are of interest.
> 
> How does CPU usage look for common workloads with polling force enabled?

Christoph, CPU load added. 

Polling Off: 12us Avg / 40us 99.99% ; CPU 0.39 H/W Threads
Polling On: 9.5us Avg / 25us 99.99% ; CPU 0.98 H/W Threads

> If it's really an overall win we should just add a quirk to the NVMe driver to
> always force polling for this device based on the PCI ID.

While I like the "big hammer" approach I think we have to have some control over when it is swung ;-). Always turning on polling for a specific device seems a bit too Mj?lnir [1] of a solution. The bonus of polling is only when QD and/or thread-count is low and not everyone will use the device that way.  I also suspect other low latency NVMe devices are coming and having a quirk for each and every one of them does not make sense. We could use a module param or sysfs entry in the NVMe driver itself if we want to avoid having this control in the block layer?

Stephen

[1] Mj?lnir = Thor's Hammer ;-).
