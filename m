From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Thu, 09 Nov 2017 15:34:01 -0500
Subject: [PATCH 6/7] block: create 'slaves' and 'holders' entries for
 hidden gendisks
In-Reply-To: <20171109174450.17142-7-hch@lst.de> (Christoph Hellwig's message
 of "Thu, 9 Nov 2017 18:44:49 +0100")
References: <20171109174450.17142-1-hch@lst.de>
 <20171109174450.17142-7-hch@lst.de>
Message-ID: <yq1vaijur7q.fsf@oracle.com>


Christoph,

> From: Hannes Reinecke <hare at suse.de>
>
> When creating nvme multipath devices we should populate the 'slaves'
> and 'holders' directorys properly to aid userspace topology detection.

Reviewed-by: Martin K. Petersen <martin.petersen at oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
