From: sagig@dev.mellanox.co.il (Sagi Grimberg)
Date: Wed, 22 Jul 2015 14:33:52 +0300
Subject: [PATCH 2/5] block: Consolidate static integrity profile properties
In-Reply-To: <1437458579-18706-3-git-send-email-martin.petersen@oracle.com>
References: <20150716091957.GA18310@infradead.org>
 <1437458579-18706-1-git-send-email-martin.petersen@oracle.com>
 <1437458579-18706-3-git-send-email-martin.petersen@oracle.com>
Message-ID: <55AF7FA0.3080705@dev.mellanox.co.il>

On 7/21/2015 9:02 AM, Martin K. Petersen wrote:
> We previously made a complete copy of a device's data integrity profile
> even though several of the fields inside the blk_integrity struct are
> pointers to fixed template entries in t10-pi.c.
>
> Split the static and per-device portions so that we can reference the
> template directly.
>
> Signed-off-by: Martin K. Petersen <martin.petersen at oracle.com>
> Reported-by: Christoph Hellwig <hch at lst.de>

Reviewed-by: Sagi Grimberg <sagig at mellanox.com>
