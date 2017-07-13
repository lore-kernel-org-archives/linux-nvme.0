From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 13 Jul 2017 14:52:12 +0200
Subject: [PATCH] nvmet: preserve controller serial number between reboots
In-Reply-To: <d32c32f6-3f8f-c63a-f961-ee16407c2fd6@grimberg.me>
References: <20170713104806.12353-1-jthumshirn@suse.de>
 <d32c32f6-3f8f-c63a-f961-ee16407c2fd6@grimberg.me>
Message-ID: <20170713125212.GI5212@linux-x5ow.site>

On Thu, Jul 13, 2017@03:30:39PM +0300, Sagi Grimberg wrote:
> It seems weird that a subsystem has a serial.

The subsystem is more of a hack I admit. But we don't maintain
configurations for controllers in configfs, do we?

> I'm not sure that a dynamic controller should maintain
> a serial. Dynamic controllers by definition are allocated
> on demand with no state of prior associations. But not sure
> if a serial is a state (it probably isn't). The area is a little
> fuzzy for me.

I'm not certain as well, the only thing I know for sure currently is,
it changes but we use in the standard 60-persistent-storage.rules [1]
as a part of /dev/disk/by-id/nvme-$model-$serial-part%n [2] and I have a bit
of a headace when users use it to identify their partitions in say /etc/fstab
and the link changes as the target generated serial changes.

Maybe we should consider this more as an RFD than a patch.

I'm happy to withdraw if we find a better solution.

[1] https://github.com/systemd/systemd/blob/master/rules/60-persistent-storage.rules
[2] https://github.com/systemd/systemd/blob/master/rules/60-persistent-storage.rules#L27

Thanks,
	Johannes
-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
