From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 17 Nov 2016 02:28:54 -0800
Subject: [PATCH 5/5] nvmet: add support for the Write Zeroes command
In-Reply-To: <1479279039-25818-6-git-send-email-chaitanya.kulkarni@hgst.com>
References: <1479279039-25818-1-git-send-email-chaitanya.kulkarni@hgst.com>
 <1479279039-25818-6-git-send-email-chaitanya.kulkarni@hgst.com>
Message-ID: <20161117102854.GB8295@infradead.org>

> +	if (__blkdev_issue_zeroout(req->ns->bdev, sector, nr_sector,
> +				GFP_KERNEL, &bio, false))

FYI, the NVMe working group has recently clarified that Write Zeroes
can deallocate the underlying LBAs, so we can pass true instead of false
here.
