From: keith.busch@intel.com (Keith Busch)
Date: Mon, 12 Oct 2015 17:20:25 +0000 (UTC)
Subject: nvme driver split, the easy part
In-Reply-To: <1444633456-27698-1-git-send-email-hch@lst.de>
References: <1444633456-27698-1-git-send-email-hch@lst.de>
Message-ID: <alpine.LNX.2.00.1510121505490.27742@localhost.lm.intel.com>

On Mon, 12 Oct 2015, Christoph Hellwig wrote:
> This series contains the trivial and hopefully uncontroversial part of the
> nvme driver split to show how I want to get started.
>
> This creates a new core.c with functions sitting on top of the block layer,
> splits and split a new struct nvme_ctrl out of struct nvme_dev so that the
> SCSI translation layer is decoupled from the PCI driver internals.  A new
> struct nvme_ctrl_ops is introduced to call into the low level driver, which
> for now just has a single method to read a 32-bit wide register.

Nothing here appears controversial; looks good to me.

Acked-by: Keith Busch <keith.busch at intel.com>

for the whole series.

Your second series will take a few days to process, but I can already
tell the meta-data patch [2/8] is incomplete. At the least, we need to
set cmnd.rw.meta in nvme_submit_priv(), but I'll give a more thorough
review later this week.
