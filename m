From: axboe@kernel.dk (Jens Axboe)
Date: Thu, 20 Apr 2017 12:30:48 -0600
Subject: [PATCH-v1 00/22] lpfc updates for 11.2.0.12
In-Reply-To: <20170420044641.10657-1-jsmart2021@gmail.com>
References: <20170420044641.10657-1-jsmart2021@gmail.com>
Message-ID: <20170420183047.GD22378@kernel.dk>

On Wed, Apr 19 2017, jsmart2021@gmail.com wrote:
> From: James Smart <jsmart2021 at gmail.com>
> 
> This patch set provides a number of bug fixes, code cleanups, and error
> handling, mostly in the nvme area of lpfc.
> 
> There is one new feature in the series to add Fabric Assigned WWN support.
> 
> The patches were cut against the linux-block tree, for-4.12/block branch,
> and are intended to be pulled in through that tree rather than the scsi trees.
> 
> The patches are dependent on the FC nvme/nvmet patches from the following 2
> series:
> http://lists.infradead.org/pipermail/linux-nvme/2017-April/009250.html
> http://lists.infradead.org/pipermail/linux-nvme/2017-April/009256.html

James, if you can address the (minor) review comments from Johannes and
repost with the reviewed/tested-by collected, we can get this applied. I
almost applied it as-is, but we may as well just get the last little
bits fixed up.

Thanks!

-- 
Jens Axboe
