From: willy@linux.intel.com (Matthew Wilcox)
Date: Mon, 4 Mar 2013 07:46:52 -0500
Subject: [PATCH 1/2] Add support for 32 bit DMA for 32 bit machines
In-Reply-To: <E821E2F372F08945977BD15EAE588D61097C5FF6@SACMBXIP02.sdcorp.global.sandisk.com>
References: <E821E2F372F08945977BD15EAE588D61097C57E9@SACMBXIP02.sdcorp.global.sandisk.com>
 <20130301151219.GF4530@linux.intel.com>
 <E821E2F372F08945977BD15EAE588D61097C5FF6@SACMBXIP02.sdcorp.global.sandisk.com>
Message-ID: <20130304124652.GG4530@linux.intel.com>

On Fri, Mar 01, 2013@10:05:25PM +0000, Chayan Biswas wrote:
> > What problem are you solving here?  If the system is 32-bit, setting the
> > DMA mask to 64-bit should be harmless.  The DMA mask tells the system
> > what the device is capable of -- this doesn't change if the system
> > happens to be 32-bit.
> 
> [CB] The current code does not check for the return value from dma_set_mask() which can fail. Checking for the return value and falling back to 32 bit DMA is consistent with most of the device drivers currently in the kernel using this function and setting 64 bit DMA. Am I missing something here?

I agree that dma_set_mask() can fail, but the only failure mode I
know of is when the architecture code can't handle masks that _small_.
Since we're setting it to the maximum value, I wasn't aware of a way it
could fail.

> Maybe checking for the sizeof(dma_addr_t)  is superfluous and we can remove.
> 
> Without this patch we have hit system hang on a 32 bit OS earlier. Adding this patch resolved the issue.

Was it 32-bit x86, or some other architecture?
