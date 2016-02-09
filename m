From: mlin@kernel.org (Ming Lin)
Date: Tue, 09 Feb 2016 10:26:45 -0800
Subject: [PATCH 4/4] nvme: split pci module out of core module
In-Reply-To: <20160209085656.GJ27969@c203.arch.suse.de>
References: <1454970284-29543-1-git-send-email-mlin@kernel.org>
 <1454970284-29543-5-git-send-email-mlin@kernel.org>
 <20160209085656.GJ27969@c203.arch.suse.de>
Message-ID: <1455042405.8832.4.camel@ssi>

On Tue, 2016-02-09@09:56 +0100, Johannes Thumshirn wrote:
> On Mon, Feb 08, 2016@02:24:44PM -0800, Ming Lin wrote:
> > This splits nvme.ko into 2 modules:
> > nvme-core.ko: the core part
> > nvme.ko: the PCI driver
> > 
> > Also changes config name:
> > s/CONFIG_BLK_DEV_NVME/CONFIG_NVME_PCI
> > s/CONFIG_BLK_DEV_NVME_SCSI/CONFIG_NVME_SCSI
> 
> Is there any auto-migration for those who already have CONFIG_BLK_DEV_NVME set
> in their kernel configs? If not, this could lead to a bunch of non-booting
> systems.

Hi Michal(CCed),

As you saw above, I'm changing:
CONFIG_BLK_DEV_NVME to CONFIG_NVME_PCI
and 
CONFIG_BLK_DEV_NVME_SCSI to CONFIG_NVME_SCSI

Is there Kconfig magic to keep existing config working?
ie, if CONFIG_BLK_DEV_NVME was set in .config, then CONFIG_NVME_PCI
should be set automatically?

Thanks,
Ming
