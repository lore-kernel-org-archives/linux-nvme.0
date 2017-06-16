From: hch@lst.de (Christoph Hellwig)
Date: Fri, 16 Jun 2017 09:04:27 +0200
Subject: [PATCH 2/3] nvme-pci: Add budget to __nvme_process_cq
In-Reply-To: <1497548508-29447-3-git-send-email-sagi@grimberg.me>
References: <1497548508-29447-1-git-send-email-sagi@grimberg.me>
 <1497548508-29447-3-git-send-email-sagi@grimberg.me>
Message-ID: <20170616070427.GB7672@lst.de>

On Thu, Jun 15, 2017@08:41:47PM +0300, Sagi Grimberg wrote:
> Prepare for irq-poll logic

I don't think we should add this until we actually get the irq-poll
code back on the plate.
