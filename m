From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Wed, 11 May 2016 11:40:02 +0200
Subject: [PATCH] NVMe: User initiated rescan
In-Reply-To: <1462919010-2569-1-git-send-email-keith.busch@intel.com>
References: <1462919010-2569-1-git-send-email-keith.busch@intel.com>
Message-ID: <20160511093930.GA25134@c203.arch.suse.de>

On Tue, May 10, 2016@04:23:30PM -0600, Keith Busch wrote:
> This provides user ioctl and sysfs methods that can be used to request
> the driver rescan a controller and its namespaces. This is less harsh
> than doing a controller reset, which temporarily halts all IO just to
> surface a newly attached namespace.
> 
> This is mainly useful for controllers that implement namespace management,
> but do not support the namespace notify change asynchronous event
> notification.
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
