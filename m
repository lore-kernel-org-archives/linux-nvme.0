From: hch@lst.de (Christoph Hellwig)
Date: Tue, 24 Jul 2018 09:56:47 +0200
Subject: [PATCHv2 2/2] scsi: set timed out out mq requests to complete
In-Reply-To: <20180723143751.10843-2-keith.busch@intel.com>
References: <20180723143751.10843-1-keith.busch@intel.com>
 <20180723143751.10843-2-keith.busch@intel.com>
Message-ID: <20180724075646.GC7859@lst.de>

On Mon, Jul 23, 2018@08:37:51AM -0600, Keith Busch wrote:
> The scsi block layer requires requests claimed by the error handling be
> completed by the error handler. A previous commit allowed completions
> to proceed for blk-mq, breaking that assumption.
> 
> This patch prevents completions that may race with the timeout handler
> by marking the state to complete, restoring the previous behavior.
> 
> Fixes: 12f5b931 ("blk-mq: Remove generation seqeunce")
> Signed-off-by: Keith Busch <keith.busch at intel.com>

Looks good enough (reluctantly) for this merge window:

Reviewed-by: Christoph Hellwig <hch at lst.de>
