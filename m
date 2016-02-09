From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Tue, 9 Feb 2016 09:56:57 +0100
Subject: [PATCH 4/4] nvme: split pci module out of core module
In-Reply-To: <1454970284-29543-5-git-send-email-mlin@kernel.org>
References: <1454970284-29543-1-git-send-email-mlin@kernel.org>
 <1454970284-29543-5-git-send-email-mlin@kernel.org>
Message-ID: <20160209085656.GJ27969@c203.arch.suse.de>

On Mon, Feb 08, 2016@02:24:44PM -0800, Ming Lin wrote:
> This splits nvme.ko into 2 modules:
> nvme-core.ko: the core part
> nvme.ko: the PCI driver
> 
> Also changes config name:
> s/CONFIG_BLK_DEV_NVME/CONFIG_NVME_PCI
> s/CONFIG_BLK_DEV_NVME_SCSI/CONFIG_NVME_SCSI

Is there any auto-migration for those who already have CONFIG_BLK_DEV_NVME set
in their kernel configs? If not, this could lead to a bunch of non-booting
systems.

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
