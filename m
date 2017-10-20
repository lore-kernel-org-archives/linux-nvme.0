From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 20 Oct 2017 03:12:01 -0700
Subject: [PATCH V7] nvme-pci: add SGL support
In-Reply-To: <20171019154821.GD2768@localhost.localdomain>
References: <1508203460-13852-1-git-send-email-ckulkarnilinux@gmail.com>
 <20171019102847.GA6828@infradead.org>
 <20171019154821.GD2768@localhost.localdomain>
Message-ID: <20171020101201.GA26703@infradead.org>

On Thu, Oct 19, 2017@09:48:22AM -0600, Keith Busch wrote:
> Yeah, I don't have any major concerns. I was hung up on the
> tagset.cmd_size being smaller when SGL's are used, but it took me a
> minute to determine that's okay as we were overallocating it before.

How is it smaller?  The code ensures we use the larger of the two
calculations:

	dev->tagset.cmd_size = nvme_pci_cmd_size(dev, false);
	if ((dev->ctrl.sgls & ((1 << 0) | (1 << 1))) && sgl_threshold) {
		dev->tagset.cmd_size = max(dev->tagset.cmd_size,
				nvme_pci_cmd_size(dev, true));
	}
