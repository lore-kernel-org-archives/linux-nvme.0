From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 11 Feb 2016 13:19:44 +0100
Subject: [PATCH for-4.5 05/13] NVMe: Fix namespace removal deadlock
In-Reply-To: <1455128250-5984-6-git-send-email-keith.busch@intel.com>
References: <1455128250-5984-1-git-send-email-keith.busch@intel.com>
 <1455128250-5984-6-git-send-email-keith.busch@intel.com>
Message-ID: <20160211121944.GF27969@c203.arch.suse.de>

On Wed, Feb 10, 2016@11:17:22AM -0700, Keith Busch wrote:
> Namespace removal holds the namespace list mutex. If the controller
> fails during namespace removal, the reset work will deadlock trying to
> acquire the mutex, and no progress will be made.
> 
> This patch completes the potentially blocking parts of namespace
> removal in a controller work queue so that reset work can cleanup a
> failed controller.
> 
> Signed-off-by: Keith Busch <keith.busch at intel.com>
> ---

Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
