From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 27 Oct 2016 10:27:20 +0200
Subject: [PATCH 10/12] SRP transport, scsi-mq: Wait for .queue_rq() if
 necessary
In-Reply-To: <0cd77719-1f11-d5c3-3186-1c7c3cfd6886@sandisk.com>
References: <b22edafc-725f-0419-d074-34d35d57d126@sandisk.com>
 <0cd77719-1f11-d5c3-3186-1c7c3cfd6886@sandisk.com>
Message-ID: <20161027082720.4tjw3wnapqnfahxu@linux-x5ow.site>

On Wed, Oct 26, 2016@03:55:34PM -0700, Bart Van Assche wrote:
> Ensure that if scsi-mq is enabled that scsi_wait_for_queuecommand()
> waits until ongoing shost->hostt->queuecommand() calls have finished.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche at sandisk.com>
> Reviewed-by: Christoph Hellwig <hch at lst.de>

Looks good,
Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
