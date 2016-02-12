From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Fri, 12 Feb 2016 09:16:19 +0100
Subject: [PATCHv2-4.5 10/10] NVMe: Rate limit nvme IO warnings
In-Reply-To: <1455221147-24228-11-git-send-email-keith.busch@intel.com>
References: <1455221147-24228-1-git-send-email-keith.busch@intel.com>
 <1455221147-24228-11-git-send-email-keith.busch@intel.com>
Message-ID: <20160212081619.GN27969@c203.arch.suse.de>

On Thu, Feb 11, 2016@01:05:47PM -0700, Keith Busch wrote:
> We don't need to spam the kernel logs with thousands of IO cancelling
> messages. We can infer all IO's are being cancelled with fewer, or
> even none at all. This patch rate limits the message and uses the debug
> log level as it is mainly used for testing purposes.
> 
> Signed-off-by: Keith Busch <keith.busch at intel.com>

Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
