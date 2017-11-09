From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Thu, 09 Nov 2017 15:33:10 -0500
Subject: [PATCH 5/7] nvme: also expose the namespace identification sysfs
 files for mpath nodes
In-Reply-To: <20171109174450.17142-6-hch@lst.de> (Christoph Hellwig's message
 of "Thu, 9 Nov 2017 18:44:48 +0100")
References: <20171109174450.17142-1-hch@lst.de>
 <20171109174450.17142-6-hch@lst.de>
Message-ID: <yq1zi7vur95.fsf@oracle.com>


Christoph,

> We do this by adding a helper that returns the ns_head for a device
> that can belong to either the per-controller or per-subsystem block
> device nodes, and otherwise reuse all the existing code.

Reviewed-by: Martin K. Petersen <martin.petersen at oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
