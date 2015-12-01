From: axboe@fb.com (Jens Axboe)
Date: Tue, 1 Dec 2015 11:01:20 -0700
Subject: NVMe driver split for Linux 4.5
In-Reply-To: <1448872593-4096-1-git-send-email-hch@lst.de>
References: <1448872593-4096-1-git-send-email-hch@lst.de>
Message-ID: <565DE070.7000000@fb.com>

On 11/30/2015 01:36 AM, Christoph Hellwig wrote:
> This series contains a the split of the NVMe driver into a common core part
> and a PCIe specific fontend.
> nvme driver split to show how I want to get started.
>
> To make testing easier I've pushed out a git tree with this and all
> dependencies:
>
>      git://git.infradead.org/users/hch/block.git nvme-split.6
>
> or in gitweb:
>
>      https://urldefense.proofpoint.com/v2/url?u=http-3A__git.infradead.org_users_hch_block.git_shortlog_refs_heads_nvme-2Dsplit.6&d=CwIBAg&c=5VD0RTtNlTh3ycd41b3MUw&r=cK1a7KivzZRh1fKQMjSm2A&m=CHSSJfe8EfWpVJ_bCvWDDBlIAgwYVoXEPiF3tz_LeTY&s=x1qUJfAkEfzsYRtJchSLNoGBLTUdxeve1OOrHlVQuWM&e=
>
> Chances since the previous post from the patchbomb:
>    - use vendor ID from Identify data in the SCSI translation layer
>    - add common enable/shutdown code from the NVMe loop series

I've added this series for 4.5, it's in the for-4.5/nvme branch.

-- 
Jens Axboe
