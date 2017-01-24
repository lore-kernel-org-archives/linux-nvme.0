From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 23 Jan 2017 23:46:22 -0800
Subject: [PATCH v4 2/6] block: Add Sed-opal library
In-Reply-To: <20170119182839.GB9228@sbauer-Z170X-UD5>
References: <1483039615-22407-1-git-send-email-scott.bauer@intel.com>
 <1483039615-22407-3-git-send-email-scott.bauer@intel.com>
 <20170119182839.GB9228@sbauer-Z170X-UD5>
Message-ID: <20170124074622.GA27932@infradead.org>

On Thu, Jan 19, 2017@11:28:40AM -0700, Scott Bauer wrote:
> Just let alloc_opal_dev kzalloc normally and do no alignment. It would then
> be up to the drivers to move the data from the buffer to a bounce buffer,
> that is aligned, in the send/recv functions before sending down to the controller.
> 
> Both are easy to implement but we wanted to see if anyone had other ideas or liked
> one over the other.

Option two works, and there won't be any bounce buffering as kmalloc
allocations are always naturally and dma boundary aligned.

Option three is to simply drop the alignment and let the block
layer bounce buffer if needed.

Either two or three are fine with me.
