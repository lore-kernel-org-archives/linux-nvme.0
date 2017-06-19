From: keith.busch@intel.com (Keith Busch)
Date: Mon, 19 Jun 2017 12:11:23 -0400
Subject: [PATCH v2 1/4] nvme-pci: Introduce nvme_ring_cq_doorbell
In-Reply-To: <1497796090-14808-2-git-send-email-sagi@grimberg.me>
References: <1497796090-14808-1-git-send-email-sagi@grimberg.me>
 <1497796090-14808-2-git-send-email-sagi@grimberg.me>
Message-ID: <20170619161123.GB21765@localhost.localdomain>

On Sun, Jun 18, 2017@05:28:07PM +0300, Sagi Grimberg wrote:
> Nice abstraction of the actual mechanics of how to do it.
> Note the change that we call it after we assign nvmeq->cq_head
> to avoid passing it.
> 
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>

Looks good.

Reviewed-by: Keith Busch <keith.busch at intel.com>
