From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Wed, 1 Jun 2016 09:20:35 +0200
Subject: [PATCH 2/2] NVMe: Synchronize resets with scan work
In-Reply-To: <1464724148-11169-2-git-send-email-keith.busch@intel.com>
References: <1464724148-11169-1-git-send-email-keith.busch@intel.com>
 <1464724148-11169-2-git-send-email-keith.busch@intel.com>
Message-ID: <20160601072035.bpctrskpwpwxdxrz@c203.arch.suse.de>

On Tue, May 31, 2016@01:49:08PM -0600, Keith Busch wrote:
> A user could continuously reset a controller, which aborts active
> commands. If the controller is currently scanning live namespaces, the
> aborted commands could cause namespaces to fail. This patch synchronizes
> the reset on a live controller with namespace scanning work to prevent
> this from occuring.
> 
> Reported-by: Ming Lin <mlin at kernel.org>
> Signed-off-by: Keith Busch <keith.busch at intel.com>

Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
