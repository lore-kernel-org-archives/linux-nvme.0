From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Sat, 20 Jul 2019 17:13:02 +0900
Subject: [PATCH 1/4] nvme: have nvme_init_identify set ctrl->cap
In-Reply-To: <20190720075546.GB22395@minwoo-desktop>
References: <20190719194546.24229-1-sagi@grimberg.me>
 <20190719194546.24229-2-sagi@grimberg.me>
 <20190720075546.GB22395@minwoo-desktop>
Message-ID: <20190720081302.GE22395@minwoo-desktop>

Sagi,

I think the ctrl->cap is already configured frmo the following
functions which are all before the nvme_init_identify():
	pci: nvme_pci_enable()
	rdma: nvme_rdma_configure_admin_queue()
	fc: nvme_fc_create_association()

Even it's already stored before it can be read again, but should we
really make it read again here?

Also I can see the 2nd patch description which tells that
nvme_init_identify() loaded the ctrl->cap value instead of the functinos
above.

If there's somethiig I missed here, Please let me know!

Thanks!
