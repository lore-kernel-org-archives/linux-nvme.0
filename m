From: hch@lst.de (Christoph Hellwig)
Date: Thu, 6 Jul 2017 01:02:23 +0200
Subject: [PATCH v3] nvme: split nvme_uninit_ctrl into stop and uninit
In-Reply-To: <20170705224150.GB24884@localhost.localdomain>
References: <1499286857-7657-1-git-send-email-sagi@grimberg.me>
 <20170705222502.GA24884@localhost.localdomain>
 <20170705224150.GB24884@localhost.localdomain>
Message-ID: <20170705230223.GA12008@lst.de>

On Wed, Jul 05, 2017@06:41:51PM -0400, Keith Busch wrote:
> Ah, it doesn't merge with your earlier patch, "nvme: move queue_count to
> the nvme_ctrl". That 8-patch series the conflict came from looks good too,
> so let's rebase this one on top of that.

Maybe we should have this one in earlier to ease backporting?  Then
again we could just backport the above patch aswell, as it's a trivial
code move.
