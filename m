From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 17 Nov 2016 02:29:39 -0800
Subject: [PATCH 1/5] block: add async variant of blkdev_issue_zeroout
In-Reply-To: <1479279039-25818-2-git-send-email-chaitanya.kulkarni@hgst.com>
References: <1479279039-25818-1-git-send-email-chaitanya.kulkarni@hgst.com>
 <1479279039-25818-2-git-send-email-chaitanya.kulkarni@hgst.com>
Message-ID: <20161117102939.GC8295@infradead.org>

On Tue, Nov 15, 2016@10:50:35PM -0800, Chaitanya Kulkarni wrote:
> Similar to __blkdev_issue_discard this variant allows submitting
> the final bio asynchronously and chaining multiple ranges
> into a single completion.
> 
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at hgst.com>

Looks fine,

Reviewed-by: Christoph Hellwig <hch at lst.de>
