From: mmarek@suse.com (Michal Marek)
Date: Wed, 10 Feb 2016 14:35:53 +0100
Subject: [PATCH 4/4] nvme: split pci module out of core module
In-Reply-To: <1455042405.8832.4.camel@ssi>
References: <1454970284-29543-1-git-send-email-mlin@kernel.org>
 <1454970284-29543-5-git-send-email-mlin@kernel.org>
 <20160209085656.GJ27969@c203.arch.suse.de> <1455042405.8832.4.camel@ssi>
Message-ID: <56BB3CB9.2070608@suse.com>

On 2016-02-09 19:26, Ming Lin wrote:
> On Tue, 2016-02-09@09:56 +0100, Johannes Thumshirn wrote:
>> On Mon, Feb 08, 2016@02:24:44PM -0800, Ming Lin wrote:
>>> This splits nvme.ko into 2 modules:
>>> nvme-core.ko: the core part
>>> nvme.ko: the PCI driver
>>>
>>> Also changes config name:
>>> s/CONFIG_BLK_DEV_NVME/CONFIG_NVME_PCI
>>> s/CONFIG_BLK_DEV_NVME_SCSI/CONFIG_NVME_SCSI
>>
>> Is there any auto-migration for those who already have CONFIG_BLK_DEV_NVME set
>> in their kernel configs? If not, this could lead to a bunch of non-booting
>> systems.
> 
> Hi Michal(CCed),
> 
> As you saw above, I'm changing:
> CONFIG_BLK_DEV_NVME to CONFIG_NVME_PCI
> and 
> CONFIG_BLK_DEV_NVME_SCSI to CONFIG_NVME_SCSI
> 
> Is there Kconfig magic to keep existing config working?

Not if you remove the old option from the Kconfig file. You could keep
the old option and make it select the new one. But then the benefit of
the whole operation becomes questionable.

Michal
