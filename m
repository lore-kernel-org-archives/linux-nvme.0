From: keith.busch@intel.com (Keith Busch)
Date: Wed, 18 Jun 2014 09:13:27 -0600 (MDT)
Subject: [PATCH] NVMe: Fail SCSI->NVMe translation for UNMAP when anchor
 is set
In-Reply-To: <1403082188-4852-1-git-send-email-daniel.mcleran@intel.com>
References: <1403082188-4852-1-git-send-email-daniel.mcleran@intel.com>
Message-ID: <alpine.LRH.2.03.1406180908390.4699@AMR>

On Wed, 18 Jun 2014, Dan McLeran wrote:
> SCSI UNMAP should fail if the host sends down the command with Anchor set. The
> current code does not check this condition. This patch checks Anchor and fails
> Scsi->NVMe translation if Anchor is set.

The reference on nvmexpress.org says the command with anchor set is
premissible "for resource-provisioned devices".

> Signed-off-by: Dan McLeran <daniel.mcleran at intel.com>
