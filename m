From: willy@linux.intel.com (Matthew Wilcox)
Date: Sat, 10 May 2014 22:52:54 -0400
Subject: [PATCH] Remove redundant writes to uncached sqe memory
In-Reply-To: <536D3E3F.9050902@micron.com>
References: <536D3E3F.9050902@micron.com>
Message-ID: <20140511025254.GC6121@linux.intel.com>

On Fri, May 09, 2014@01:44:47PM -0700, Sam Bradshaw wrote:
> The memset to clear the SQE in nvme_submit_iod() is made partially 
> redundant by subsequent writes.  This patch explicitly clears each 
> SQE structure member in ascending order, eliminating the need for 
> the memset.  With this change, our perf runs show ~1.5% less time
> spent in the IO submission path and minor reduced q lock contention.

I'm shocked!  I thought that zeroing the cacheline first would be better
performing than storing into parts of the cacheline.  But I can't argue
with your numbers.  I think your patch is missing a store to the metadata
element though; care to rerun your test with that added?
