From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Thu, 09 Nov 2017 15:34:39 -0500
Subject: [PATCH 7/7] nvme: create 'slaves' and 'holders' entries for
 hidden controllers
In-Reply-To: <20171109174450.17142-8-hch@lst.de> (Christoph Hellwig's message
 of "Thu, 9 Nov 2017 18:44:50 +0100")
References: <20171109174450.17142-1-hch@lst.de>
 <20171109174450.17142-8-hch@lst.de>
Message-ID: <yq1r2t7ur6o.fsf@oracle.com>


Christoph,

> From: Hannes Reinecke <hare at suse.de>
>
> When creating nvme multipath devices we should populate the 'slaves'
> and 'holders' directorys properly to aid userspace topology detection.

Reviewed-by: Martin K. Petersen <martin.petersen at oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
