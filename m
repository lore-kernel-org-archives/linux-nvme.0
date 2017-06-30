From: judy.brock@samsung.com (Judy Brock)
Date: Fri, 30 Jun 2017 13:07:59 +0000
Subject: remove long broken SCSI to NVMe translations
In-Reply-To: <20170622192105.GC4445@linux-x5ow.site>
References: <20170614063537.1044-1-hch@lst.de>
 <20170614150025.GD26073@localhost.localdomain> <20170614150138.GA9428@lst.de>
 <af9655ff-f5ae-0d86-7b84-dd48caa7c35f@suse.de>
 <20170616083151.GB14698@infradead.org>
 <922f6c05-cb61-9973-2c2c-823f31b5d082@hpe.com>
 <20170622192105.GC4445@linux-x5ow.site>
 <CGME20170630130801uscas1p1dbf0997e3149e6aac5bc710a3c56e292@uscas1p1.samsung.com>
Message-ID: <7143d854b1454646a84bfbb468194e06@samsung.com>



Adding some input fr Dell that didn't make it out to this reflector:

From: managementif@nvmexpress.org [mailto:managementif@nvmexpress.org] On Behalf Of Austin.Bolen@dell.com

	>>> The SNTL in Linux has been deprecated and disabled by default for almost 1?  years now.

Has it made it to all the distros?  I can check on distros like RHEL to see if/when they disabled it but any given OS will be used by customers for many years and so I think the majority of our customers are still running with the translation layer enabled and will only find out if things are broken when the migrate to a distro that has it disabled.
. . .
I checked on our most recent distros and looks like everything we ship today has the SNTL enabled:

-          RHEL 7.3:            Does not have the CONFIG_BLK_DEV_NVME_SCSI option at all so looks like SNTL is always enabled.
-          SLES 12 SP1:       Does not have the CONFIG_BLK_DEV_NVME_SCSI option at all so looks like SNTL is always enabled.
-          Ubuntu 16.04:   Has CONFIG_BLK_DEV_NVME_SCSI=y so looks like so looks like SNTL is enabled by default.

Thanks,
Austin


-----Original Message-----
From: Linux-nvme [mailto:linux-nvme-bounces@lists.infradead.org] On Behalf Of Johannes Thumshirn
Sent: Thursday, June 22, 2017 12:21 PM
To: Micah Parrish
Cc: Joseph Szczypek; Sagi Grimberg; linux-nvme at lists.infradead.org; Christoph Hellwig; David Milburn; Hannes Reinecke; keith.busch at intel.com; Robert Elliott
Subject: Re: remove long broken SCSI to NVMe translations

On Thu, Jun 22, 2017@12:31:55PM -0600, Micah Parrish wrote:
> From HPE's perspective, we don't want NVME-SCSI translation removed 
> from Linux.  We do drive firmware updates and other management 
> functions using a common cross platform management API which works on 
> VMWare, Windows and Linux, and it relies on SCSI on all 3.  This 
> software (called SOULAPI) is common across most of our drives and 
> enclosures, so putting in a special case for nvme on linux would be 
> difficult.  In the short term we'd have to wrap nvme-cli, which would 
> introduce a new dependency.  Long term maybe we could rewrite our API to use native NVME commands on all supported OSes.
> 
> The reason the scsi translation has been broken so long is that we 
> don't test firmware updates with upstream kernels.  From our 
> perspective it broke in the last enterprise update cycle, but we 
> didn't discover it because we didn't have a firmware update for these 
> drives.  There are some process improvements we could make there to 
> catch this kind of bug sooner, and I will be discussing them internally.

There's no need to wrap nvme-cli, the firmware download litterally is the
following:

int nvme_download_firmware(int fd, uint32_t offset, uint32_t len, void *data,
			   uint32_t slot)
{
	struct nvme_admin_cmd cmd = {
		.opcode = nvme_admin_download_fw,
		.addr = (uint64_t)data,
		.data_len = len,
		.cdw10 = (len >> 2) - 1,
		.cdw11 = offset >> 2,
	};

	ioctl(fd, NVME_IOCTL_ADMIN_CMD, &cmd);

	struct nvme_admin_cmd cmd = {
		.opcode = nvme_admin_activate_fw,
		.cd10 = (action << 3) | slot; 
	};

	ioctl(fd, NVME_IOCTL_ADMIN_CMD, &cmd);
}

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton HRB 21284 (AG N?rnberg) Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850

_______________________________________________
Linux-nvme mailing list
Linux-nvme at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
