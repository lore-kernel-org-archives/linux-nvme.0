From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Tue, 23 Jan 2018 08:31:50 -0500
Subject: [PATCH v5 1/2] nvme: add tracepoint for nvme_setup_cmd
In-Reply-To: <20180123124616.GA20827@lst.de> (Christoph Hellwig's message of
 "Tue, 23 Jan 2018 13:46:16 +0100")
References: <20180123105641.24930-1-jthumshirn@suse.de>
 <20180123105641.24930-2-jthumshirn@suse.de>
 <20180123124616.GA20827@lst.de>
Message-ID: <yq1vafshfax.fsf@oracle.com>


Christoph,

> Seems like this is still missing the qid in the tracepoint, as it only
> got added to the completion side.

Yup, noticed the same thing.

-- 
Martin K. Petersen	Oracle Linux Engineering
