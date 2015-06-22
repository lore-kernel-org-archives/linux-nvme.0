From: hch@lst.de (Christoph Hellwig)
Date: Mon, 22 Jun 2015 07:34:18 +0200
Subject: [PATCH] NVMe: Fix IO for extended metadata formats
In-Reply-To: <1434733650-16440-1-git-send-email-keith.busch@intel.com>
References: <1434733650-16440-1-git-send-email-keith.busch@intel.com>
Message-ID: <20150622053417.GA29813@lst.de>

On Fri, Jun 19, 2015@11:07:30AM -0600, Keith Busch wrote:
> This fixes io submit ioctl handling when using extended metadata
> formats. When these formats are used, the user provides a single virtually
> contiguous buffer containing both the block and metadata interleaved,
> so the metadata size needs to be added to the total length and not mapped
> as a separate transfer.
> 
> The command is also driver generated, so this patch does not enforce
> blk-integrity extensions provide the metadata buffer.

Does this actually work properly?  I'd assume the block layer might
not be too happy if we have weird arbitrary sizes for this additional
metadata.
