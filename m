From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 26 Apr 2018 14:21:36 -0600
Subject: [PATCH] nvme: change order of qid and cmdid in completion trace
In-Reply-To: <3e927f7f-fa84-1792-b80e-bf5679e71bcf@kernel.dk>
References: <20180426194926.18767-1-jthumshirn@suse.de>
 <3e927f7f-fa84-1792-b80e-bf5679e71bcf@kernel.dk>
Message-ID: <20180426202136.owimd773x5p5upxn@linux-x5ow.site>

On Thu, Apr 26, 2018@02:01:59PM -0600, Jens Axboe wrote:
> On 4/26/18 1:49 PM, Johannes Thumshirn wrote:
> > Keith reported that command submission and command completion
> > tracepoints have the order of the cmdid and qid fileds swapped.
> > 
> > While it isn't easily possible to change the command submission
> > tracepoint, as there is a regression test parsing it in blktests we
> > can swap the command completion tracepoint to have the fileds aligned.
> 
> It also makes more sense to have qid before cmdid.
> 
> Also, fileds -> fields, in two spots.

Args. Thanks

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
