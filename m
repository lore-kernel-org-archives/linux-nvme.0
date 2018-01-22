From: hch@lst.de (Christoph Hellwig)
Date: Mon, 22 Jan 2018 21:14:23 +0100
Subject: [PATCH] nvme-pci: ensure nvme_timeout complete before
 initializing procedure
In-Reply-To: <1516607585-1525-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1516607585-1525-1-git-send-email-jianchao.w.wang@oracle.com>
Message-ID: <20180122201423.GA30427@lst.de>

> Link: https://lkml.org/lkml/2018/1/19/68
> Suggested-by: Keith Busch <keith.busch at intel.com>
> Signed-off-by: Keith Busch <keith.busch at intel.com>
> Signed-off-by: Jianchao Wang <jianchao.w.wang at oracle.com>

Why does this have a signoff from Keith?
