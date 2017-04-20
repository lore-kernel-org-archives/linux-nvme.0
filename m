From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Wed, 19 Apr 2017 21:43:00 -0400
Subject: [PATCH 08/23] scsi: introduce a result field in struct
 scsi_request
In-Reply-To: <20170419192708.22098-9-hch@lst.de> (Christoph Hellwig's message
 of "Wed, 19 Apr 2017 21:26:53 +0200")
References: <20170419192708.22098-1-hch@lst.de>
 <20170419192708.22098-9-hch@lst.de>
Message-ID: <yq160hzsvkr.fsf@oracle.com>

Christoph Hellwig <hch at lst.de> writes:

> This passes on the scsi_cmnd result field to users of passthrough
> requests.  Currently we abuse req->errors for this purpose, but that
> field will go away in its current form.

Reviewed-by: Martin K. Petersen <martin.petersen at oracle.com>

> Note that the old IDE code abuses the errors field in very creative
> ways and stores all kinds of different values in it.  I didn't dare
> to touch this magic, so the abuses are brought forward 1:1.

Really wish we could just obliterate drivers/ide.

-- 
Martin K. Petersen	Oracle Linux Engineering
