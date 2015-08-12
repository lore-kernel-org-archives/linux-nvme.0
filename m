From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Tue, 11 Aug 2015 20:29:55 -0400
Subject: [PATCH 1/6] block: cleanup blkdev_ioctl
In-Reply-To: <1438672271-11309-2-git-send-email-hch@lst.de> (Christoph
 Hellwig's message of "Tue, 4 Aug 2015 09:11:06 +0200")
References: <1438672271-11309-1-git-send-email-hch@lst.de>
 <1438672271-11309-2-git-send-email-hch@lst.de>
Message-ID: <yq1y4hhe4cc.fsf@sermon.lab.mkp.net>

>>>>> "Christoph" == Christoph Hellwig <hch at lst.de> writes:

Christoph> Split out helpers for all non-trivial ioctls to make this
Christoph> function simpler, and also start passing around a pointer
Christoph> version of the argument, as that's what most ioctl handlers
Christoph> actually need.

Looks good.

Reviewed-by: Martin K. Petersen <martin.petersen at oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
