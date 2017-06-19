From: keith.busch@intel.com (Keith Busch)
Date: Mon, 19 Jun 2017 12:50:06 -0400
Subject: [PATCH 2/6] nvme: read the subsystem NQN from Identify Controller
In-Reply-To: <20170619095754.4602-3-hch@lst.de>
References: <20170619095754.4602-1-hch@lst.de>
 <20170619095754.4602-3-hch@lst.de>
Message-ID: <20170619165005.GG21765@localhost.localdomain>

On Mon, Jun 19, 2017@11:57:50AM +0200, Christoph Hellwig wrote:
> NVMe 1.2.1 or later requires controllers to provide a subsystem NQN in the
> Identify controller data structures.  Use this NQN for the subsysnqn
> sysfs attribute by storing it in the nvme_ctrl structure after verifying
> it.  For older controllers we generate a "fake" NQN per non-normative
> text in the NVMe 1.3 spec.

Looks good.

Reviewed-by: Keith Busch <keith.busch at intel.com>
