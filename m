From: hch@lst.de (Christoph Hellwig)
Date: Tue, 30 Apr 2019 16:32:22 +0200
Subject: [PATCH 14/15] nvme-pci: optimize mapping single segment
 requests using SGLs
In-Reply-To: <20190430141722.GA19100@apples.localdomain>
References: <20190321231037.25104-1-hch@lst.de>
 <20190321231037.25104-15-hch@lst.de>
 <20190430141722.GA19100@apples.localdomain>
Message-ID: <20190430143222.GA24666@lst.de>

On Tue, Apr 30, 2019@04:17:22PM +0200, Klaus Birkelund wrote:
> nvme_setup_sgl_simple does not set the PSDT field, so bypassing
> nvme_pci_setup_sgls causing controllers to assume PRP.
> 
> Adding `cmnd->flags = NVME_CMD_SGL_METABUF` in nvme_setup_sgl_simple
> fixes the issue.

Indeed.  Can you send the patch?
