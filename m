From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 20 Apr 2017 10:56:09 +0200
Subject: [PATCH] nvme/pci: Poll CQ on timeout
In-Reply-To: <6c0cacb0-ab91-6270-8bae-dbd18a8dbd0e@fb.com>
References: <1487977168-5347-1-git-send-email-keith.busch@intel.com>
 <20170228141017.GC20317@lst.de>
 <20170228160056.GA15639@localhost.localdomain>
 <6c0cacb0-ab91-6270-8bae-dbd18a8dbd0e@fb.com>
Message-ID: <20170420085609.GA6217@linux-x5ow.site>

On Tue, Feb 28, 2017@10:44:21AM -0700, Jens Axboe wrote:
> IMHO that can go at a later time, if we do remove polling for
> specific entries. For now it's fine.
> 
> And I do think this is a nice addition - it's free, and it provides
> us extra info for debugging an issue. That's a big deal, especially
> if it's a user report.

JFYI, we did have I/O timeout issues on one of our internal systems.
Keith suggested to give this patch a shot and indeed it cought missed IRQs,
which after being polled at least didn't result in filesystem errors.

So if you want you can have my:
Tested-by: Johannes Thumshirn <jthumshirn at suse.de>
Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
