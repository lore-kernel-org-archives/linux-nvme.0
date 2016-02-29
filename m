From: axboe@fb.com (Jens Axboe)
Date: Mon, 29 Feb 2016 12:31:55 -0700
Subject: [PATCH] nvme: expose cntlid in sysfs
In-Reply-To: <1456521859-26357-1-git-send-email-mlin@kernel.org>
References: <1456521859-26357-1-git-send-email-mlin@kernel.org>
Message-ID: <56D49CAB.1070208@fb.com>

On 02/26/2016 02:24 PM, Ming Lin wrote:
> From: Ming Lin <ming.l at ssi.samsung.com>
>
> For NVMe over Fabrics, the cntlid will be used by systemd/udev to
> create link to the device, for example,
>
> /dev/disk/by-path/<fabrics-info>-<cntlid>-<namespace> -> /dev/nvme0n1

Added for 4.6 with the acks, thanks.

-- 
Jens Axboe
