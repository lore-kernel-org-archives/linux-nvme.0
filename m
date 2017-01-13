From: axboe@kernel.dk (Jens Axboe)
Date: Fri, 13 Jan 2017 15:17:20 -0700
Subject: fix data transfer size caculation for special payload requests
In-Reply-To: <1484306953-3194-1-git-send-email-hch@lst.de>
References: <1484306953-3194-1-git-send-email-hch@lst.de>
Message-ID: <20170113221720.GA16425@kernel.dk>

On Fri, Jan 13 2017, Christoph Hellwig wrote:
> Hi all,
> 
> the first two fixes fix a regression in 4.10-rc1 where the data transfer
> size for discard commands wasn't set properly, leading to hangs with
> Hyper-V VMs.  The use the new data transfer size helper added in patch 1
> more widely.

Added for this series, thanks.

-- 
Jens Axboe
