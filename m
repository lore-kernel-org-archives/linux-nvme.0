Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 572F7C3DA7F
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Aug 2024 00:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Vpz/TjxzvYDFnb/aK7sPozaW7iCDnwdqwffyL7H0rew=; b=na4f3yelpdPRP+2se5k6uoGczr
	4yX/BUZbp7edTqZcsXr/KO/ncLDR++ALCQj0MjVbtLYpMO5HtIOwHSf9yHfdvdIPQ/R92mH5KLOpF
	vhQDcMO+4JrGuwN1yefovXzPOwPp4bnpc43dxpRFwgeozgrEn2WYTJKR7N9Mn6oVyGhazvu9OKQ5y
	Z4T5SIBNWDi2Ia55Y3jjqExponsScRFKmKJ1A4L2HoQDctR2rf/Uz1JNvdB4XRwTkMdYF1ezd+Bm+
	al+K79psQscyBcMM6+1vQRkLRDWeu/7I7Cmpq90aLGL0nDti0JMmaIEfxzpdkdssEGrEjkmYJNMVg
	hNAWA8lA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sb8OM-000000006k7-430H;
	Tue, 06 Aug 2024 00:49:34 +0000
Received: from out28-88.mail.aliyun.com ([115.124.28.88])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sb8OK-000000006jR-06lO
	for linux-nvme@lists.infradead.org;
	Tue, 06 Aug 2024 00:49:33 +0000
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.8700965|0.07665365;CH=green;DM=|AD|false|;DS=CONTINUE|ham_system_inform|0.00207762-0.000184275-0.997738;FP=1556031182001423922|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037088118;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.YjAOSiP_1722905368;
Received: from T640.e16-tech.com(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.YjAOSiP_1722905368)
          by smtp.aliyun-inc.com;
          Tue, 06 Aug 2024 08:49:29 +0800
From: Wang Yugui <wangyugui@e16-tech.com>
To: linux-nvme@lists.infradead.org
Cc: Wang Yugui <wangyugui@e16-tech.com>
Subject: [PATCH RFC] nvmet: basic RMEDIA support for target
Date: Tue,  6 Aug 2024 08:49:28 +0800
Message-ID: <20240806004928.27605-1-wangyugui@e16-tech.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240806004823.27417-1-wangyugui@e16-tech.com>
References: <20240806004823.27417-1-wangyugui@e16-tech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240805_174932_251995_84629E8B 
X-CRM114-Status: GOOD (  12.94  )
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

Rotational media(RMEDIA) support is added to the NVMe 2.0 specification.
We add Rotational media(RMEDIA) basic support to nvme target.

Signed-off-by: Wang Yugui <wangyugui@e16-tech.com>
---
 drivers/nvme/target/admin-cmd.c   | 50 +++++++++++++++++++++++++++++++
 drivers/nvme/target/core.c        |  2 ++
 drivers/nvme/target/io-cmd-bdev.c |  1 +
 drivers/nvme/target/nvmet.h       |  1 +
 4 files changed, 54 insertions(+)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index f7e1156ac7ec..20a28102f8a0 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -489,6 +489,53 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 	nvmet_req_complete(req, status);
 }
 
+static void nvmet_execute_identify_indep(struct nvmet_req *req)
+{
+	struct nvme_id_ns_cs_indep  *id;
+	u16 status;
+
+	id = kzalloc(sizeof(*id), GFP_KERNEL);
+	if (!id) {
+		status = NVME_SC_INTERNAL;
+		goto out;
+	}
+
+	/* return an all zeroed buffer if we can't find an active namespace */
+	status = nvmet_req_find_ns(req);
+	if (status) {
+		status = 0;
+		goto done;
+	}
+
+	if (nvmet_ns_revalidate(req->ns)) {
+		mutex_lock(&req->ns->subsys->lock);
+		nvmet_ns_changed(req->ns->subsys, req->ns->nsid);
+		mutex_unlock(&req->ns->subsys->lock);
+	}
+
+	/*
+	 * Our namespace might always be shared.  Not just with other
+	 * controllers, but also with any other user of the block device.
+	 */
+	id->nmic = NVME_NS_NMIC_SHARED;
+	id->anagrpid = cpu_to_le32(req->ns->anagrpid);
+
+	if (req->ns->readonly)
+		id->nsattr |= NVME_NS_ATTR_RO;
+
+	id->nstat |= NVME_NSTAT_NRDY;
+
+	if(req->ns->rotational)
+		id->nsfeat |= NVME_INDEP_NS_FEAT_RMEDIA;
+
+done:
+	if (!status)
+		status = nvmet_copy_to_sgl(req, 0, id, sizeof(*id));
+	kfree(id);
+out:
+	nvmet_req_complete(req, status);
+}
+
 static void nvmet_execute_identify_ns(struct nvmet_req *req)
 {
 	struct nvme_id_ns *id;
@@ -706,6 +724,9 @@ static void nvmet_execute_identify(struct nvmet_req *req)
 			break;
 		}
 		break;
+	case NVME_ID_CNS_NS_CS_INDEP:
+		nvmet_execute_identify_indep(req);
+		return;
 	case NVME_ID_CNS_CS_CTRL:
 		switch (req->cmd->identify.csi) {
 		case NVME_CSI_NVM:
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index ed2424f8a396..2790fedb593b 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1254,6 +1254,8 @@ static void nvmet_init_cap(struct nvmet_ctrl *ctrl)
 	else
 		ctrl->cap |= ctrl->port->max_queue_size - 1;
 
+	ctrl->cap |= NVME_CAP_CRMS_CRIMS;
+
 	if (nvmet_is_passthru_subsys(ctrl->subsys))
 		nvmet_passthrough_override_cap(ctrl);
 }
diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 0bda83d0fc3e..d15ad1a864bc 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -104,6 +104,7 @@ int nvmet_bdev_ns_enable(struct nvmet_ns *ns)
 
 	ns->pi_type = 0;
 	ns->metadata_size = 0;
+	ns->rotational = bdev_nonrot(ns->bdev);
 	if (IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY))
 		nvmet_bdev_ns_enable_integrity(ns);
 
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 190f55e6d753..86eeeadf3787 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -62,6 +62,7 @@ struct nvmet_ns {
 	struct block_device	*bdev;
 	struct file		*file;
 	bool			readonly;
+	bool			rotational;
 	u32			nsid;
 	u32			blksize_shift;
 	loff_t			size;
-- 
2.36.2


