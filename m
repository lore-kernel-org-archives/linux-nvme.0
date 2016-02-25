From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 25 Feb 2016 09:12:34 +0100
Subject: [PATCHv4-4.5 6/7] NVMe: Don't allow unsupported flags
In-Reply-To: <1456330558-819-7-git-send-email-keith.busch@intel.com>
References: <1456330558-819-1-git-send-email-keith.busch@intel.com>
 <1456330558-819-7-git-send-email-keith.busch@intel.com>
Message-ID: <20160225081233.GC29716@c203.arch.suse.de>

On Wed, Feb 24, 2016@09:15:57AM -0700, Keith Busch wrote:
> The command flags can change the meaning of other fields in the command
> that the driver is not prepared to handle. Specifically, the user could
> passthrough an SGL flag, causing the controller to misinterpret the PRP
> list the driver created, potentially corrupting memory or data.
> 
> Signed-off-by: Keith Busch <keith.busch at intel.com>
> Reviewed-by: Jon Derrick <jonathan.derrick at intel.com>

Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
