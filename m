From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Fri, 07 Jun 2019 11:18:41 -0400
Subject: [PATCH 1/2] nvme: Introduce NVMe 1.4 Identify Namespace fields in
 struct nvme_id_ns
In-Reply-To: <20190606212854.122478-2-bvanassche@acm.org> (Bart Van Assche's
 message of "Thu, 6 Jun 2019 14:28:53 -0700")
References: <20190606212854.122478-1-bvanassche@acm.org>
 <20190606212854.122478-2-bvanassche@acm.org>
Message-ID: <yq1imthjuem.fsf@oracle.com>


Bart,

> Several new fields have been introduced in version 1.4 of the NVMe spec
> at offsets that were defined as reserved in version 1.3d of the NVMe
> spec. Update the definition of the nvme_id_ns data structure such that
> it is in sync with version 1.4 of the NVMe spec.

Looks good.

Reviewed-by: Martin K. Petersen <martin.petersen at oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
