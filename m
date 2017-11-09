From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Thu, 09 Nov 2017 15:23:30 -0500
Subject: [PATCH 1/7] nvme: track subsystems
In-Reply-To: <20171109174450.17142-2-hch@lst.de> (Christoph Hellwig's message
 of "Thu, 9 Nov 2017 18:44:44 +0100")
References: <20171109174450.17142-1-hch@lst.de>
 <20171109174450.17142-2-hch@lst.de>
Message-ID: <yq1lgjfw69p.fsf@oracle.com>


Christoph,

> This adds a new nvme_subsystem structure so that we can track multiple
> controllers that belong to a single subsystem.  For now we only use it
> to store the NQN, and to check that we don't have duplicate NQNs
> unless the involved subsystems support multiple controllers.
>
> Includes code originally from Hannes Reinecke to expose the subsystems
> in sysfs.

Reviewed-by: Martin K. Petersen <martin.petersen at oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
