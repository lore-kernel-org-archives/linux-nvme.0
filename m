From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 27 Oct 2016 10:27:59 +0200
Subject: [PATCH 09/12] SRP transport: Move queuecommand() wait code to
 SCSI core
In-Reply-To: <e86cdaf9-6305-d2cb-6068-0a050c023d73@sandisk.com>
References: <b22edafc-725f-0419-d074-34d35d57d126@sandisk.com>
 <e86cdaf9-6305-d2cb-6068-0a050c023d73@sandisk.com>
Message-ID: <20161027082759.4j56p3yjqu27lhhq@linux-x5ow.site>

On Wed, Oct 26, 2016@03:55:00PM -0700, Bart Van Assche wrote:
> Additionally, rename srp_wait_for_queuecommand() into
> scsi_wait_for_queuecommand() and add a comment about the
> queuecommand() call from scsi_send_eh_cmnd().
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
