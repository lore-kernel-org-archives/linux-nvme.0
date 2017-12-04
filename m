From: hch@lst.de (Christoph Hellwig)
Date: Mon, 4 Dec 2017 21:26:23 +0100
Subject: [PATCH] nvme-pci: remove an unnecessary initialization in HMB code
In-Reply-To: <1512419034-5857-1-git-send-email-minwoo.im.dev@gmail.com>
References: <1512419034-5857-1-git-send-email-minwoo.im.dev@gmail.com>
Message-ID: <20171204202623.GA17614@lst.de>

On Tue, Dec 05, 2017@05:23:54AM +0900, Minwoo Im wrote:
> The local variable __size__ will be set a bit later in a for-loop.
> Remove the explicit initialization at the beginning of this function.

Thanks,

applied to nvme-4.16.
