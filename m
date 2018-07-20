From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Fri, 20 Jul 2018 08:52:58 +0200
Subject: [PATCH 2/2] scsi: set timed out out mq requests to complete
In-Reply-To: <20180719212618.2406-2-keith.busch@intel.com>
References: <20180719212618.2406-1-keith.busch@intel.com>
 <20180719212618.2406-2-keith.busch@intel.com>
Message-ID: <20180720065258.cucvur7n5tugl75u@linux-x5ow.site>

On Thu, Jul 19, 2018@03:26:18PM -0600, Keith Busch wrote:
> The scsi block layer requires requests claimed be the error handling be
> completed by the error handler. A previous commit allowed completions
> to proceed for blk-mq, breaking that assumption.

Ahm the first sentence is a bit hard to parse, sorry.
Did you mean something like:

"The scsi block later requires requests claimed by the error handling
to be completed by the error handler"?

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
