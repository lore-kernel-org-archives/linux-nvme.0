From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Mon, 22 Jan 2018 17:15:28 +0100
Subject: [PATCH v4 1/2] nvme: add tracepoint for nvme_setup_cmd
In-Reply-To: <20180122161027.GA7097@lst.de>
References: <20180119141819.11938-1-jthumshirn@suse.de>
 <20180119141819.11938-2-jthumshirn@suse.de>
 <20180122152301.GA5818@lst.de>
 <20180122155356.4doy32sfgzwegmq4@linux-x5ow.site>
 <20180122155956.GA6635@lst.de>
 <20180122160437.4kct2cz2ihwymvct@linux-x5ow.site>
 <20180122161027.GA7097@lst.de>
Message-ID: <20180122161528.lbiumtejfszlk7sn@linux-x5ow.site>

On Mon, Jan 22, 2018@05:10:27PM +0100, Christoph Hellwig wrote:
> Yes.  Although I'd rename trace_nvme_setup_cmd to trace_nvme_setup_nvm_cmd
> to prepare for new I/O command sets.

OK then.
-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
