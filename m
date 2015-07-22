From: sagig@dev.mellanox.co.il (Sagi Grimberg)
Date: Wed, 22 Jul 2015 14:35:01 +0300
Subject: [PATCH 3/5] block: Reduce the size of struct blk_integrity
In-Reply-To: <1437458579-18706-4-git-send-email-martin.petersen@oracle.com>
References: <20150716091957.GA18310@infradead.org>
 <1437458579-18706-1-git-send-email-martin.petersen@oracle.com>
 <1437458579-18706-4-git-send-email-martin.petersen@oracle.com>
Message-ID: <55AF7FE5.7030300@dev.mellanox.co.il>

On 7/21/2015 9:02 AM, Martin K. Petersen wrote:
> The per-device properties in the blk_integrity structure were previously
> unsigned short. However, most of the values fit inside a char. The only
> exception is the data interval size and we can work around that by
> storing it as a power of two.
>
> This cuts the size of the dynamic portion of blk_integrity in half.
>
> Signed-off-by: Martin K. Petersen <martin.petersen at oracle.com>
> Reported-by: Christoph Hellwig <hch at lst.de>

Reviewed-by: Sagi Grimberg <sagig at mellanox.com>
