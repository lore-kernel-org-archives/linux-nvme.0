From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Tue, 23 Jan 2018 14:35:30 +0100
Subject: [PATCH v5 1/2] nvme: add tracepoint for nvme_setup_cmd
In-Reply-To: <yq1vafshfax.fsf@oracle.com>
References: <20180123105641.24930-1-jthumshirn@suse.de>
 <20180123105641.24930-2-jthumshirn@suse.de>
 <20180123124616.GA20827@lst.de> <yq1vafshfax.fsf@oracle.com>
Message-ID: <20180123133530.a6ulnx3knihs7c7g@linux-x5ow.site>

On Tue, Jan 23, 2018@08:31:50AM -0500, Martin K. Petersen wrote:
> 
> Christoph,
> 
> > Seems like this is still missing the qid in the tracepoint, as it only
> > got added to the completion side.
> 
> Yup, noticed the same thing.

Yep already fixed and about to send out the fixed version if no one as any
further comments.

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
