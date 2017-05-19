From: hch@lst.de (Christoph Hellwig)
Date: Fri, 19 May 2017 16:15:22 +0200
Subject: [PATCH] nvme: Change our APST table to be no more aggressive
 than Intel RSTe
In-Reply-To: <20170519141834.GB6015@localhost.localdomain>
References: <ddc5be5d81966effaf73e3cee54330c351bc8169.1494561654.git.luto@kernel.org>
 <CALCETrUYutdtp5U7oYwf7-eNuB0MrwoC18mG5-S8iOP4ZEVDuA@mail.gmail.com>
 <20170519063505.GA15980@infradead.org>
 <20170519141834.GB6015@localhost.localdomain>
Message-ID: <20170519141522.GA1830@lst.de>

On Fri, May 19, 2017@10:18:34AM -0400, Keith Busch wrote:
> +
> +	if (ns->ctrl->quirks & NVME_QUIRK_PAGE_ALIGN)
> +		blk_queue_logical_block_size(ns->queue, ns->ctrl->page_size);
> +	else
> +		blk_queue_logical_block_size(ns->queue, bs);

Ugg.  That will invalidate the layout of any existing fs (in case the
device hasn't eaten it yet).  It would also invalidate things like
partitions tables, even if they are only used to share with windows.
