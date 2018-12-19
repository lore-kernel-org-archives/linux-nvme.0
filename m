From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Wed, 19 Dec 2018 07:12:49 +0000
Subject: [PATCH] nvme-core: add support for Write-Zeroes command
In-Reply-To: <20181218165211.GB16673@infradead.org>
References: <20181218034203.22256-1-chaitanya.kulkarni@wdc.com>
 <20181218165211.GB16673@infradead.org>
Message-ID: <798ABE0A-D035-4323-A133-A316536F2FD0@wdc.com>

Will send out a new patch as soon as next merge window opens.

?On 12/18/18, 8:52 AM, "Christoph Hellwig" <hch@infradead.org> wrote:

    On Mon, Dec 17, 2018@10:42:03PM -0500, Chaitanya Kulkarni wrote:
    > Allow write zeroes operations (REQ_OP_WRITE_ZEROES) on the block
    > device, if the device supports an optional command bit set for write
    > zeroes. Add support to setup write zeroes command. Set maximum possible
    > write zeroes sectors in one write zeroes command according to
    > nvme write zeroes command definition.
    > 
    > This patch was posted as a part of block-write-zeroes support
    > implementation (https://patchwork.kernel.org/patch/9454859/),
    > but did not make into mainline kernel as it got reverted due to
    > failure on the Linus's machine.
    > 
    > In this patch in order to be more cautious, we use NVMe controller's
    > maximum hardware sector size which is calculated based on the
    > controller's MDTS (Maximum Data Transfer Size) field to calculate
    > the maximum sectors for the write zeroes request.
    
    This looks good to me, but due to the history I don't think we want
    to apply this in the last week of the merge window, so I'll defer this
    for the next merge window.
    
