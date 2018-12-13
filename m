From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 13 Dec 2018 10:33:13 +0100
Subject: [PATCH 0/4] nvme multipath: expose slaves/holders
In-Reply-To: <20181206164812.30925-1-cascardo@canonical.com>
References: <20181206164812.30925-1-cascardo@canonical.com>
Message-ID: <bd4405c7-560c-f138-78f0-023807f96367@suse.de>

On 06/12/2018 17:48, Thadeu Lima de Souza Cascardo wrote:
> Exposing slaves/holders is necessary in order to find out the real PCI device
> and its driver for the root filesystem when generating an initramfs with
> initramfs-tools. That fails right now for nvme multipath devices, which this
> patchset fixes.
> 
> However, because the slave devices are hidden, lsblk fails without some extra
> patches, as it can't find the device numbers for the slave devices, and exits.

Sorry for chiming in so late, can someone give me an explanation what
actually is broken?

I know this is technically a user visible regression, but isn't lsblk
(and others) already fixed? I believe it's [1] in util-linux.

And to find out the PCI device, why do you need slaves/holders here?
Have a look at blktest's _get_pci_dev_from_blkdev() function [2].

[1] d51f05bfecb2 ("lsblk: try device/dev to read devno")
[2] https://github.com/osandov/blktests/blob/master/common/rc#L185

Byte,
	Johannes
-- 
Johannes Thumshirn                            SUSE Labs Filesystems
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
