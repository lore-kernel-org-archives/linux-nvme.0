From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Tue, 21 Aug 2018 09:35:33 +0200
Subject: [PATCH 2/2] nvme-connect: parse 'nvme_info' sysfs attribute for
 fc transport
In-Reply-To: <3868e631-add5-bbe3-6e11-ebb687fb1e4a@broadcom.com>
References: <20180820103407.92783-1-hare@suse.de>
 <20180820103407.92783-3-hare@suse.de>
 <3868e631-add5-bbe3-6e11-ebb687fb1e4a@broadcom.com>
Message-ID: <20180821073533.pt6zb5pqoxqsxfxu@linux-x5ow.site>

On Mon, Aug 20, 2018@09:23:20AM -0700, James Smart wrote:
> 3. I also don't like parsing scsi stuff in the nvme cli. If we really need
> to pull fc-isms from it, then we should start the work for moving the fc
> transport out of scsi and into it's own layer that binds with scsi and
> nvme.

This is something I'd love to see actually. Something like net/fc or
drivers/fc. IIRC we had drivers/fc back in the 2.4 days, didn't we?

Byte,
	Johannes
-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
