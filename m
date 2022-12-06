Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B92BC3A5A7
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Dec 2022 05:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dV8FFVi+ppXoSPI6BQOk097hk8tMgvc+UEl7bQteqcM=; b=VgRXmY1crSa1fo29wY9Pkdaa9a
	bgLBrwHign+VoANvWipaxXXRYJjbUzTuDm3EU+FxPlFiawZrdiPtGPckzOOPI5d92rqR+36oBnO8H
	PL49PxWUyu8vKjeAzOgf/paurq/NulqYIgyThKWxpkTgve/5422EFwcS6vbsKc4pNX3iv8mNZFe4I
	aZQyzSHXzkcxXkv/nU6Mi5WmYCjj2VLmPh2eL4C2AijVswDXzNH+Zwt9+MUZTx5J8hcHLj6tjX+Ds
	hfEklJkEb0pNBV+pUTvwfcZrW52nYOXL1o5QxdfdBTrOLqZq+zQ5PCetBEo+tmQbLu/K+ewrgp0Uk
	v5LRG4lg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2QzU-001g88-Bc; Tue, 06 Dec 2022 05:59:40 +0000
Received: from mga06b.intel.com ([134.134.136.31] helo=mga06.intel.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2Qyk-001fVG-Bn
	for linux-nvme@lists.infradead.org; Tue, 06 Dec 2022 05:58:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670306334; x=1701842334;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9CnQAmoATTPKUFpttCxBP0OKKTyZY2W0SyyLmyVLCtc=;
  b=FhrU31d4SYeFySW27+SzBXK4UHNOsErowVVDpUCUPqXFJ4HHNp5gGxaq
   s2fNSdfje4ErVlv3LDzW01T5BFy5IPYGqaJXWRCnP1kcB/hoxr6f8T00t
   yam0Q3Lrb1SYDJSrwA+U4tA6D0/kpJRTlZJPfAjFgX7RWm8u3xcaB3kBj
   nikReZ3yG17FnbQQjJKza1nHkScA/pgteGVUYKuEbFRh29YHhSfp+czfQ
   gFLYWnBsxXzAPL9V5yOtHEQLcqPl+uU7SAqlH9dA3eaAJh0ztMKL1z3Nr
   iH0ibkwaa5Uqa08NoQzlcdd2impF2YUsRMA99x/47Y+ybGRNE5OE5Bu5q
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="378706726"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; 
   d="scan'208";a="378706726"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 21:58:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="648211408"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; 
   d="scan'208";a="648211408"
Received: from leirao-pc.bj.intel.com ([10.238.156.101])
  by fmsmga007.fm.intel.com with ESMTP; 05 Dec 2022 21:58:48 -0800
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
Subject: [RFC PATCH 4/5] nvme-vfio: check if the hardware supports live migration
Date: Tue,  6 Dec 2022 13:58:15 +0800
Message-Id: <20221206055816.292304-5-lei.rao@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221206055816.292304-1-lei.rao@intel.com>
References: <20221206055816.292304-1-lei.rao@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221205_215854_495386_D4186D69 
X-CRM114-Status: GOOD (  11.21  )
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

NVMe device can extend the vendor-specific field in the identify
controller data structure to indicate whether live migration
is supported. This patch checks if the NVMe device supports
live migration.

Signed-off-by: Lei Rao <lei.rao@intel.com>
Signed-off-by: Yadong Li <yadong.li@intel.com>
Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Eddie Dong <eddie.dong@intel.com>
Reviewed-by: Hang Yuan <hang.yuan@intel.com>
---
 drivers/vfio/pci/nvme/nvme.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/vfio/pci/nvme/nvme.c b/drivers/vfio/pci/nvme/nvme.c
index 698e470a4e53..2ffc90ad556d 100644
--- a/drivers/vfio/pci/nvme/nvme.c
+++ b/drivers/vfio/pci/nvme/nvme.c
@@ -473,6 +473,36 @@ static void nvmevf_pci_close_device(struct vfio_device *core_vdev)
 	vfio_pci_core_close_device(core_vdev);
 }
 
+static bool nvmevf_check_migration(struct pci_dev *pdev)
+{
+	struct nvme_command c = { };
+	struct nvme_id_ctrl *id;
+	u8 live_mig_support;
+	int ret;
+
+	c.identify.opcode = nvme_admin_identify;
+	c.identify.cns = NVME_ID_CNS_CTRL;
+
+	id = kmalloc(sizeof(struct nvme_id_ctrl), GFP_KERNEL);
+	if (!id)
+		return false;
+
+	ret = nvme_submit_vf_cmd(pdev, &c, NULL, id, sizeof(struct nvme_id_ctrl));
+	if (ret) {
+		dev_warn(&pdev->dev, "Get identify ctrl failed (ret=0x%x)\n", ret);
+		goto out;
+	}
+
+	live_mig_support = id->vs[0];
+	if (live_mig_support) {
+		kfree(id);
+		return true;
+	}
+out:
+	kfree(id);
+	return false;
+}
+
 static const struct vfio_migration_ops nvmevf_pci_mig_ops = {
 	.migration_set_state = nvmevf_pci_set_device_state,
 	.migration_get_state = nvmevf_pci_get_device_state,
@@ -489,6 +519,10 @@ static int nvmevf_migration_init_dev(struct vfio_device *core_vdev)
 	if (!pdev->is_virtfn)
 		return ret;
 
+	/* Get the identify controller data structure to check the live migration support */
+	if (!nvmevf_check_migration(pdev))
+		return ret;
+
 	nvmevf_dev->migrate_cap = 1;
 
 	vf_id = pci_iov_vf_id(pdev);
-- 
2.34.1


