From: jonathan.derrick@intel.com (Jon Derrick)
Date: Sun, 21 Jun 2015 18:12:04 -0600
Subject: [PATCH] NVMe: Use CMB for the SQ if available
In-Reply-To: <80B89753B40C5141A3E2D53FE7A2A8A9D03A71F1@NTXBOIMBX02.micron.com>
References: <1434750357-29162-1-git-send-email-jonathan.derrick@intel.com>
 <80B89753B40C5141A3E2D53FE7A2A8A9D03A71F1@NTXBOIMBX02.micron.com>
Message-ID: <20150622001204.GA2087@localhost.localdomain>

> 
> I think a store fence is necessary between memcpy_toio() and the doorbell ring.
> This applies elsewhere in the patch as well.
> 
> For example, we've seen rare cases where Haswells do not emit the whole SQE out 
> of the write combine buffers before the doorbell write traverses PCIe.  Other 
> architectures may have a similar need.  
> 
>

I suspect you may be right. X86's memcpy_toio decays to a memcpy, but many other architectures decay to writeb/l loops, so those are probably safe. I imagine in the general case, that a write barrier before writing the doorbell is required. 
