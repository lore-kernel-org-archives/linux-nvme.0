From: keith.busch@intel.com (Keith Busch)
Date: Tue, 24 Mar 2015 22:43:27 +0000 (UTC)
Subject: [PATCH 1/1] nvme: Fix PRP list calculation for non-4k system
 page size
In-Reply-To: <201503242226.t2OMQpWq011660@d03av02.boulder.ibm.com>
References: <201503242226.t2OMQpWq011660@d03av02.boulder.ibm.com>
Message-ID: <alpine.LNX.2.00.1503242233530.32385@localhost.lm.intel.com>

On Tue, 24 Mar 2015, Brian King wrote:
> PRP list calculation is supposed to be based on device's page size.
> Systems with page size larger than device's page size cause corruption
> to the name space as well as system memory with out this fix.
> Systems like x86 might not experience this issue because it uses
> PAGE_SIZE of 4K where as powerpc uses PAGE_SIZE of 64k while NVMe device's
> page size varies depending upon the vendor.

Darn, I thought we had this working. I must have just gotten lucky when
testing on an 8k page. Thanks for the fix.

> -	int offset = offset_in_page(dma_addr);
> +	u32 page_size = dev->page_size;
> +	int offset = dma_addr % page_size;

Trying to micro-optimize the io path to have fewer divisions. This should
work out the same if changed to:

 	int offset = dma_addr & (page_size - 1);

The page_size is always a power of two, but I don't think the compiler
knows that.
