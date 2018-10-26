From: hch@lst.de (Christoph Hellwig)
Date: Fri, 26 Oct 2018 09:53:19 +0200
Subject: [PATCH] nvme: make sure ns head inherits underlying device limits
In-Reply-To: <70bcef36-48da-cae7-4e23-ac9b01814a74@grimberg.me>
References: <20181019222450.25397-1-sagi@grimberg.me>
 <20181022085752.GD18755@lst.de>
 <70bcef36-48da-cae7-4e23-ac9b01814a74@grimberg.me>
Message-ID: <20181026075319.GC5092@lst.de>

On Mon, Oct 22, 2018@05:22:15PM -0700, Sagi Grimberg wrote:
> Without this patch at least max_segments and max_hw_sectors of the head 
> device node are degenerated to defaults that have nothing to do with the
> underlying device limits.
>
> This can result in unnecessary bio splitting for the head device
> node...

But we never split bios for the multipath queue!
