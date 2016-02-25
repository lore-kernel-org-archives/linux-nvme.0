From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 25 Feb 2016 09:13:21 +0100
Subject: [PATCHv4-4.5 7/7] NVMe: Fix 0-length integrity payload
In-Reply-To: <1456330558-819-8-git-send-email-keith.busch@intel.com>
References: <1456330558-819-1-git-send-email-keith.busch@intel.com>
 <1456330558-819-8-git-send-email-keith.busch@intel.com>
Message-ID: <20160225081321.GD29716@c203.arch.suse.de>

On Wed, Feb 24, 2016@09:15:58AM -0700, Keith Busch wrote:
> A user could send a passthrough IO command with a metadata pointer to a
> namespace without metadata. With metadata length of 0, kmalloc returns
> ZERO_SIZE_PTR. Since that is not NULL, the driver would have set this as
> the bio's integrity payload, which causes an access fault on completion.
> 
> This patch ignores the users metadata buffer if the namespace format
> does not support separate metadata.
> 
> Reported-by: Stephen Bates <stephen.bates at microsemi.com>
> Signed-off-by: Keith Busch <keith.busch at intel.com>
> Reviewed-by: Sagi Grimberg <sagig at mellanox.com>
> Reviewed-by: Christoph Hellwig <hch at lst.de>

Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
