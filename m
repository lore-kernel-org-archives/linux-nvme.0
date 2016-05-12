From: hch@infradead.org (hch@infradead.org)
Date: Thu, 12 May 2016 00:08:05 -0700
Subject: [PATCH 0/2] Block: Give option to force io polling
In-Reply-To: <D87A37E7A4AA544D853031D9A919C70B16901010@avsrvexchmbx2.microsemi.net>
References: <1459455554-2794-1-git-send-email-jonathan.derrick@intel.com>
 <D87A37E7A4AA544D853031D9A919C70B168FDA58@avsrvexchmbx2.microsemi.net>
 <20160508090257.GG15458@infradead.org>
 <D87A37E7A4AA544D853031D9A919C70B16901010@avsrvexchmbx2.microsemi.net>
Message-ID: <20160512070805.GE20802@infradead.org>

On Mon, May 09, 2016@02:53:30PM +0000, Stephen Bates wrote:
> Christoph, this is a DRAM based NVMe device, the code for polling in NVMe was merged in 4.5 right? We are using the inbox NVMe driver. Here is some performance data:
> 
> QD=1, single thread, random 4KB reads
> 
> Polling Off: 12us Avg / 40us 99.99% ;
> Polling On: 9.5us Avg / 25us 99.99%
> 
> Both the average and 99.99% reduction are of interest.

How does CPU usage look for common workloads with polling force
enabled?  If it's really an overall win we should just add a quirk
to the NVMe driver to always force polling for this device based on the
PCI ID.
