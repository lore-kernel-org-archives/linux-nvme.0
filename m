From: hch@lst.de (Christoph Hellwig)
Date: Thu, 15 Jun 2017 14:10:47 +0200
Subject: [PATCH] nvme-pci: another 64-bit division for the host memory
 buffer code
In-Reply-To: <deaabdf8-40a2-7ecd-b874-bdf7fdc0438e@grimberg.me>
References: <20170613153130.20426-1-hch@lst.de>
 <deaabdf8-40a2-7ecd-b874-bdf7fdc0438e@grimberg.me>
Message-ID: <20170615121047.GA23200@lst.de>

On Thu, Jun 15, 2017@11:55:28AM +0300, Sagi Grimberg wrote:
> This looks fine, but is there a good reason why
> shouldn't DIV_ROUND_UP take care of that instead of you
> open-coding it?

Because it uses a plain division, and Linux on most 32-bit architectures
doesn't support that, as Linus doesn't want the required libgcc helpers
in the kernel.
