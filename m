From: Chayan.Biswas@sandisk.com (Chayan Biswas)
Date: Tue, 5 Mar 2013 21:57:18 +0000
Subject: [PATCH 1/2] Add support for 32 bit DMA for 32 bit machines
In-Reply-To: <20130304124652.GG4530@linux.intel.com>
References: <E821E2F372F08945977BD15EAE588D61097C57E9@SACMBXIP02.sdcorp.global.sandisk.com>
 <20130301151219.GF4530@linux.intel.com>
 <E821E2F372F08945977BD15EAE588D61097C5FF6@SACMBXIP02.sdcorp.global.sandisk.com>
 <20130304124652.GG4530@linux.intel.com>
Message-ID: <E821E2F372F08945977BD15EAE588D61097D2F11@SACMBXIP02.sdcorp.global.sandisk.com>

> > [CB] The current code does not check for the return value from
> dma_set_mask() which can fail. Checking for the return value and falling back
> to 32 bit DMA is consistent with most of the device drivers currently in the
> kernel using this function and setting 64 bit DMA. Am I missing something
> here?
>
> I agree that dma_set_mask() can fail, but the only failure mode I
> know of is when the architecture code can't handle masks that _small_.
> Since we're setting it to the maximum value, I wasn't aware of a way it
> could fail.
>
> > Maybe checking for the sizeof(dma_addr_t)  is superfluous and we can
> remove.
> >
> > Without this patch we have hit system hang on a 32 bit OS earlier. Adding
> this patch resolved the issue.
>
> Was it 32-bit x86, or some other architecture?

[CB] Yes, we saw the issue on an x86 machine with 32 bit Linux. The same machine we are now using with 64 bit Linux and is working as it is (without the patch).


________________________________

PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
