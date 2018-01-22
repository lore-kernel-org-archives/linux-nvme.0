From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Mon, 22 Jan 2018 14:35:23 -0500
Subject: [PATCH v4 2/2] nvme: add tracepoint for nvme_complete_rq
In-Reply-To: <20180122153040.2myfgm7hvjtd5n3d@linux-x5ow.site> (Johannes
 Thumshirn's message of "Mon, 22 Jan 2018 16:30:41 +0100")
References: <20180119141819.11938-1-jthumshirn@suse.de>
 <20180119141819.11938-3-jthumshirn@suse.de>
 <20180122152340.GB5818@lst.de>
 <20180122153040.2myfgm7hvjtd5n3d@linux-x5ow.site>
Message-ID: <yq18tcplm9w.fsf@oracle.com>


Johannes,

> On Mon, Jan 22, 2018@04:23:40PM +0100, Christoph Hellwig wrote:
>> Wouldn't some indication on which queue this completion happens
>> be useful?
>
> Probably yes. I'll add it in v5.

Yes, that would be great. I always end up having to use custom printks
for this.

-- 
Martin K. Petersen	Oracle Linux Engineering
