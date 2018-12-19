From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Tue, 18 Dec 2018 22:34:02 -0500
Subject: [PATCH] nvme-core: add support for Write-Zeroes command
In-Reply-To: <20181218034203.22256-1-chaitanya.kulkarni@wdc.com> (Chaitanya
 Kulkarni's message of "Mon, 17 Dec 2018 22:42:03 -0500")
References: <20181218034203.22256-1-chaitanya.kulkarni@wdc.com>
Message-ID: <yq1r2eei40l.fsf@oracle.com>


Chaitanya,

> Allow write zeroes operations (REQ_OP_WRITE_ZEROES) on the block
> device, if the device supports an optional command bit set for write
> zeroes. Add support to setup write zeroes command. Set maximum
> possible write zeroes sectors in one write zeroes command according to
> nvme write zeroes command definition.
>
> This patch was posted as a part of block-write-zeroes support
> implementation (https://patchwork.kernel.org/patch/9454859/), but did
> not make into mainline kernel as it got reverted due to failure on the
> Linus's machine.
>
> In this patch in order to be more cautious, we use NVMe controller's
> maximum hardware sector size which is calculated based on the
> controller's MDTS (Maximum Data Transfer Size) field to calculate the
> maximum sectors for the write zeroes request.

Looks good to me.

Reviewed-by: Martin K. Petersen <martin.petersen at oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
