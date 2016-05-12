From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 12 May 2016 16:16:50 +0200
Subject: [PATCHv2] NVMe: Allow user initiated rescan
In-Reply-To: <1463061497-8742-1-git-send-email-keith.busch@intel.com>
References: <1463061497-8742-1-git-send-email-keith.busch@intel.com>
Message-ID: <20160512141650.GB17154@c203.arch.suse.de>

On Thu, May 12, 2016@07:58:17AM -0600, Keith Busch wrote:
> This exposes ioctl and sysfs methods a user can invoke to request the
> driver rescan a controller and its namespaces. This is less harsh than
> doing a controller reset, which temporarilly halts all IO, just to
> surface a newly attached namespace.
> 
> This is mainly useful for controllers that implement the namespace
> management command, but do not support the namespace notify change
> asynchronous event notification.
> 
> Signed-off-by: Keith Busch <keith.busch at intel.com>

Still looks OK for me,
Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
