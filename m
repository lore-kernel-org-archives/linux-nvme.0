From: stephen.bates@microsemi.com (Stephen Bates)
Date: Mon, 9 May 2016 14:53:30 +0000
Subject: [PATCH 0/2] Block: Give option to force io polling
In-Reply-To: <20160508090257.GG15458@infradead.org>
References: <1459455554-2794-1-git-send-email-jonathan.derrick@intel.com>
 <D87A37E7A4AA544D853031D9A919C70B168FDA58@avsrvexchmbx2.microsemi.net>
 <20160508090257.GG15458@infradead.org>
Message-ID: <D87A37E7A4AA544D853031D9A919C70B16901010@avsrvexchmbx2.microsemi.net>

> On Thu, May 05, 2016@07:44:29PM +0000, Stephen Bates wrote:
> > I am very interested in seeing this added. There are use cases involving
> super-low latency (non-NAND based) NVMe devices and they want the
> fastest possible IO response times for ALL IO to that device. They also have
> no desire to wait for the new system calls and glibc updates needed to tie
> their applications into polling or to rewrite their applications to avail of those
> new calls. I have done some testing on Jon's "big hammer" and it seems to
> work well for this use case and applied cleanly against v4.6-rc6.
> 
> Let's get the driver for those devices merged first, and if you can provide
> numbers that it's worth it we can add a tweak to always enable polling from
> the driver for those devices.

Christoph, this is a DRAM based NVMe device, the code for polling in NVMe was merged in 4.5 right? We are using the inbox NVMe driver. Here is some performance data:

QD=1, single thread, random 4KB reads

Polling Off: 12us Avg / 40us 99.99% ;
Polling On: 9.5us Avg / 25us 99.99%

Both the average and 99.99% reduction are of interest.

Cheers

Stephen
