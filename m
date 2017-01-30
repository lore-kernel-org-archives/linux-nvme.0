From: scott.bauer@intel.com (Scott Bauer)
Date: Mon, 30 Jan 2017 10:08:10 -0700
Subject: [PATCH v4 2/6] block: Add Sed-opal library
In-Reply-To: <20170108140507.GA32432@infradead.org>
References: <1483039615-22407-1-git-send-email-scott.bauer@intel.com>
 <1483039615-22407-3-git-send-email-scott.bauer@intel.com>
 <20170108140507.GA32432@infradead.org>
Message-ID: <20170130170810.GA20723@sbauer-Z170X-UD5>

On Sun, Jan 08, 2017@06:05:07AM -0800, Christoph Hellwig wrote:
> On Thu, Dec 29, 2016@12:26:51PM -0700, Scott Bauer wrote:
> 
> > +	cmd->cmd = cmd->cmd_buf;
> > +	cmd->resp = cmd->resp_buf;
> > +
> > +	dma_align = (queue_dma_alignment(q) | q->dma_pad_mask) + 1;
> > +	cmd->cmd = (u8 *)round_up((uintptr_t)cmd->cmd, dma_align);
> > +	cmd->resp = (u8 *)round_up((uintptr_t)cmd->resp, dma_align);
> 
> The block layer will automatically bounce buffer non-aligned payloads.
> If the cost of copying is too high we could switch back to dynamic
> allocations using kmalloc here, which will be properly aligned.
> 
> Also ->cmd and ->resp probably should be void pointers, so that no
> casting is required for the various command and response structures.

We'll keep it unaligned and let the block layer deal with it. I had
previously toyed with the void pointers, but we reference directly into
cmd->cmd[] during command setup. So while we'll avoid a cast here we'll
end up adding more code/casts to other functions, so I'm going to leave
it as is in the series coming out in an hour or so.
