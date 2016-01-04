From: keith.busch@intel.com (Keith Busch)
Date: Mon, 4 Jan 2016 15:19:25 +0000
Subject: [PATCH 4/4] nvme: make SG_IO support optional
In-Reply-To: <1450967222-10404-5-git-send-email-hch@lst.de>
References: <1450967222-10404-1-git-send-email-hch@lst.de>
 <1450967222-10404-5-git-send-email-hch@lst.de>
Message-ID: <20160104151925.GG31375@localhost.localdomain>

On Thu, Dec 24, 2015@03:27:02PM +0100, Christoph Hellwig wrote:
> +config BLK_DEV_NVME_SCSI
> +	bool "SCSI emulation for NVMe device nodes"
> +	depends on BLK_DEV_NVME

Can we make this "default y"? I strongly advocate for native NVMe over
SCSI translations too, but I know of users relying on this. It's been
built in for years and not aware of it breaking anything, so think it
should be opt-out.
