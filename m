From: axboe@fb.com (Jens Axboe)
Date: Fri, 19 Jun 2015 13:16:51 -0600
Subject: [PATCH] NVMe: Fix IO for extended metadata formats
In-Reply-To: <1434733650-16440-1-git-send-email-keith.busch@intel.com>
References: <1434733650-16440-1-git-send-email-keith.busch@intel.com>
Message-ID: <55846AA3.7060701@fb.com>

On 06/19/2015 11:07 AM, Keith Busch wrote:
> This fixes io submit ioctl handling when using extended metadata
> formats. When these formats are used, the user provides a single virtually
> contiguous buffer containing both the block and metadata interleaved,
> so the metadata size needs to be added to the total length and not mapped
> as a separate transfer.
>
> The command is also driver generated, so this patch does not enforce
> blk-integrity extensions provide the metadata buffer.

Applied for 4.2.

-- 
Jens Axboe
