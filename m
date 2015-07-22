From: sagig@dev.mellanox.co.il (Sagi Grimberg)
Date: Wed, 22 Jul 2015 14:32:13 +0300
Subject: [PATCH 1/5] block: Move integrity kobject to struct gendisk
In-Reply-To: <1437458579-18706-2-git-send-email-martin.petersen@oracle.com>
References: <20150716091957.GA18310@infradead.org>
 <1437458579-18706-1-git-send-email-martin.petersen@oracle.com>
 <1437458579-18706-2-git-send-email-martin.petersen@oracle.com>
Message-ID: <55AF7F3D.5000206@dev.mellanox.co.il>

On 7/21/2015 9:02 AM, Martin K. Petersen wrote:
> The integrity kobject purely exists to support the integrity
> subdirectory in sysfs and doesn't really have anything to do with the
> blk_integrity data structure. Move the kobject to struct gendisk where
> it belongs.
>
> Signed-off-by: Martin K. Petersen <martin.petersen at oracle.com>
> Reported-by: Christoph Hellwig <hch at lst.de>

Reviewed-by: Sagi Grimberg <sagig at mellanox.com>
