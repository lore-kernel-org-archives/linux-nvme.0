From: hch@lst.de (Christoph Hellwig)
Date: Wed, 30 Aug 2017 10:15:33 +0200
Subject: [PATCHv2 2/4] nvme/pci: Use req_op to determine DIF remapping
In-Reply-To: <1504043164-5398-3-git-send-email-keith.busch@intel.com>
References: <1504043164-5398-1-git-send-email-keith.busch@intel.com>
 <1504043164-5398-3-git-send-email-keith.busch@intel.com>
Message-ID: <20170830081533.GB17819@lst.de>

On Tue, Aug 29, 2017@05:46:02PM -0400, Keith Busch wrote:
> Only read and write commands need DIF remapping. Everything else uses
> a passthrough integrity payload.
> 
> Signed-off-by: Keith Busch <keith.busch at intel.com>

Cc to stable because this means metadata passthrough for NVME_SUBMIT_IO
has been broken for a long time?

Also this reminds that that I really want to move the
remapping to the block core.
