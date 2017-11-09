From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Thu, 09 Nov 2017 15:28:13 -0500
Subject: [PATCH 3/7] nvme: track shared namespaces
In-Reply-To: <20171109174450.17142-4-hch@lst.de> (Christoph Hellwig's message
 of "Thu, 9 Nov 2017 18:44:46 +0100")
References: <20171109174450.17142-1-hch@lst.de>
 <20171109174450.17142-4-hch@lst.de>
Message-ID: <yq18tffw61u.fsf@oracle.com>


Christoph,

> Introduce a new struct nvme_ns_head that holds information about an
> actual namespace, unlike struct nvme_ns, which only holds the
> per-controller namespace information.  For private namespaces there is
> a 1:1 relation of the two, but for shared namespaces this lets us
> discover all the paths to it.  For now only the identifiers are moved
> to the new structure, but most of the information in struct nvme_ns
> should eventually move over.
>
> To allow lockless path lookup the list of nvme_ns structures per
> nvme_ns_head is protected by SRCU, which requires freeing the nvme_ns
> structure through call_srcu.

Reviewed-by: Martin K. Petersen <martin.petersen at oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
