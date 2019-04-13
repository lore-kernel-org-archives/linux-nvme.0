From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Fri, 12 Apr 2019 20:10:04 -0400
Subject: [PATCH] nvme,scsi: display FC-NVMe port roles
In-Reply-To: <20190410141619.146391-1-hare@suse.de> (Hannes Reinecke's message
 of "Wed, 10 Apr 2019 16:16:19 +0200")
References: <20190410141619.146391-1-hare@suse.de>
Message-ID: <yq1ftqmkboj.fsf@oracle.com>


Hannes,

> Currently the FC-NVMe driver is leverating the SCSI FC transport class
> to access the remote ports. Which means that all FC-NVMe remote ports
> will be visible to the fc transport layer, but due to missing
> definitions the port roles will always be 'unknown'.  This patch adds
> the missing definitions to the fc transport class to that the port
> roles are correctly displayed.

Applied to 5.2/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
