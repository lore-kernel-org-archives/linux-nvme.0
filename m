Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B99BC352A1
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Dec 2022 05:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qmeF+cGEc/z2Nj6/HPcoeLZPAHM8b40fEf8SlnmDTLU=; b=3+SKaQ5oXUlqmB/KhgZdgF9fkb
	kPjBeBU40/k+BDz5y+cQvhuemnksmdwmf/grncwGd1OfyQn4msVvZ6k/c0siWjFjJ9ahl3mA/xHL9
	2omgzkxntSCV7Z38lx5eUpci4b9nEG4gORh2g/7pB53rSRu6h17PyF77YaRzAQxvtvgMjPPTjjpH5
	RtEWadCkJTYC+FcvYD3X+eSkjQs1EwoLp9kydQ2c//+2Ee71SLy2sbC6PtlA4+GYgTcPG13n3DqT8
	CVeUlqoY7f/IlvGPXwLoCxqzthA0SVzVv8oPVFSQ8bUooWiXYu3cOnq9tVRBRcRq2nBGFVyFk2R0c
	b0SGA4SA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2Qyb-001fTy-HL; Tue, 06 Dec 2022 05:58:45 +0000
Received: from mga06b.intel.com ([134.134.136.31] helo=mga06.intel.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2QyR-001fJj-7U
	for linux-nvme@lists.infradead.org; Tue, 06 Dec 2022 05:58:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670306315; x=1701842315;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9tscb8eIosHw9BslFqEXbDs27VxieMXwgkEh6RsBQDE=;
  b=aHuBepdwiqmRB6NerVm44L6r7YWbGKK1kQGiyivS//+h3RfVSE+hwTGc
   TkbAk71WZwmMamn3kyDZrX8tmS9/+0uXOQvlkogI2BeOx3xdr804pgh7k
   lABz2NklRnytnEifZCkM/ZdejZ/9qL05XPbtdui6GHhRHd87HXddj0t9Z
   GkccAXwK22Su2jL2sCfgQIpJYjt05IDSOttuwpaC8gAoAdi6r0uu9v+1H
   QLUt0uv+iwww3tyF7YEi1rh7XuVzGVYFymQSw8XYRmrG9da7dTpySpf2W
   iEO7sEeGZWHp/qLQ9aDyp3kp4CM5LsyC8H/tSsJrxfLIRTqjUQ6bXyOpq
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="378706626"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; 
   d="scan'208";a="378706626"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 21:58:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="648211267"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; 
   d="scan'208";a="648211267"
Received: from leirao-pc.bj.intel.com ([10.238.156.101])
  by fmsmga007.fm.intel.com with ESMTP; 05 Dec 2022 21:58:29 -0800
From: Lei Rao <lei.rao@intel.com>
To: kbusch@kernel.org,
	axboe@fb.com,
	kch@nvidia.com,
	hch@lst.de,
	sagi@grimberg.me,
	alex.williamson@redhat.com,
	cohuck@redhat.com,
	jgg@ziepe.ca,
	yishaih@nvidia.com,
	shameerali.kolothum.thodi@huawei.com,
	kevin.tian@intel.com,
	mjrosato@linux.ibm.com,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	kvm@vger.kernel.org
Cc: eddie.dong@intel.com,
	yadong.li@intel.com,
	yi.l.liu@intel.com,
	Konrad.wilk@oracle.com,
	stephen@eideticom.com,
	hang.yuan@intel.com,
	Lei Rao <lei.rao@intel.com>
Subject: [RFC PATCH 1/5] nvme-pci: add function nvme_submit_vf_cmd to issue admin commands for VF driver.
Date: Tue,  6 Dec 2022 13:58:12 +0800
Message-Id: <20221206055816.292304-2-lei.rao@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221206055816.292304-1-lei.rao@intel.com>
References: <20221206055816.292304-1-lei.rao@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221205_215835_425617_1CCE5F22 
X-CRM114-Status: GOOD (  10.94  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The new function nvme_submit_vf_cmd() helps the host VF driver to issue
VF admin commands. It's helpful in some cases that the host NVMe driver
does not control VF's admin queue. For example, in the virtualization
device pass-through case, the VF controller's admin queue is governed
by the Guest NVMe driver. Host VF driver relies on PF device's admin
queue to control VF devices like vendor-specific live migration commands.

Signed-off-by: Lei Rao <lei.rao@intel.com>
Signed-off-by: Yadong Li <yadong.li@intel.com>
Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Eddie Dong <eddie.dong@intel.com>
Reviewed-by: Hang Yuan <hang.yuan@intel.com>
---
 drivers/nvme/host/pci.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 488ad7dabeb8..3d9c54d8e7fc 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3585,6 +3585,24 @@ static struct pci_driver nvme_driver = {
 	.err_handler	= &nvme_err_handler,
 };
 
+int nvme_submit_vf_cmd(struct pci_dev *dev, struct nvme_command *cmd,
+			      size_t *result, void *buffer, unsigned int bufflen)
+{
+	struct nvme_dev *ndev = NULL;
+	union nvme_result res = { };
+	int ret;
+
+	ndev = pci_iov_get_pf_drvdata(dev, &nvme_driver);
+	if (IS_ERR(ndev))
+		return PTR_ERR(ndev);
+	ret = __nvme_submit_sync_cmd(ndev->ctrl.admin_q, cmd, &res, buffer, bufflen,
+			      NVME_QID_ANY, 0, 0);
+	if (ret >= 0 && result)
+		*result = le32_to_cpu(res.u32);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(nvme_submit_vf_cmd);
+
 static int __init nvme_init(void)
 {
 	BUILD_BUG_ON(sizeof(struct nvme_create_cq) != 64);
-- 
2.34.1


