From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 25 Feb 2016 09:07:54 +0100
Subject: [PATCHv4-4.5 2/7] NVMe: Use IDA for namespace disk naming
In-Reply-To: <1456330558-819-3-git-send-email-keith.busch@intel.com>
References: <1456330558-819-1-git-send-email-keith.busch@intel.com>
 <1456330558-819-3-git-send-email-keith.busch@intel.com>
Message-ID: <20160225080754.GB29716@c203.arch.suse.de>

On Wed, Feb 24, 2016@09:15:53AM -0700, Keith Busch wrote:
> A namespace may be detached from a controller, but a user may be holding
> a reference to it. Attaching a new namespace with the same NSID will create
> duplicate names when using the NSID to name the disk.
> 
> This patch uses an IDA that is released only when the last reference is
> released instead of using the namespace ID.
> 
> Signed-off-by: Keith Busch <keith.busch at intel.com>
> Reviewed-by: Sagi Grimberg <sagig at mellanox.com>

Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
