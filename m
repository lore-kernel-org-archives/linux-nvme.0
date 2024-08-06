Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A54BCC3DA7F
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Aug 2024 00:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OSQgrT19AxS3hLfItho0XbwwgOO3fv7uycX9+eNg63k=; b=v6qitp5Qn5Ys2jfZ0oCyCitrq6
	y3gF1kZopMqYtfx/NxaFUCSQsGwlopCNY/3REl8g/4c2N7fiEak0pBw1p9tqlsfitVh89JhXLBwkA
	30UbDPvDGRQJcdb+LlcGm4zp3lK1jEZp8dEulH14NmDYAWYnAxZvOa+zYUnF5kWixvn8RjVU5fih/
	dMZ6Q8TC+GLo0bm/kEbt/4N+H/zxeSyzdOuxHd7c1vM6mgUr4IxNg9edRbkEBfwfT3OsFbfyo/G1D
	mcWAUFQz1fQOsNQsJFUYgulxFRxHi04bfb8PCEqHmA8wNgH+8pwyIdi6ZiCIbSEokgKR9n/qiZlLi
	ergpg3Pw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sb8NP-000000006eA-1rrG;
	Tue, 06 Aug 2024 00:48:35 +0000
Received: from out28-79.mail.aliyun.com ([115.124.28.79])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sb8NM-000000006cW-2QFb
	for linux-nvme@lists.infradead.org;
	Tue, 06 Aug 2024 00:48:35 +0000
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.8943517|0.07638286;CH=green;DM=|AD|false|;DS=CONTINUE|ham_enroll_verification|0.0204372-0.00150517-0.978058;FP=8373677206662632614|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033038033188;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.Yj9xG7y_1722905304;
Received: from T640.e16-tech.com(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.Yj9xG7y_1722905304)
          by smtp.aliyun-inc.com;
          Tue, 06 Aug 2024 08:48:24 +0800
From: Wang Yugui <wangyugui@e16-tech.com>
To: linux-nvme@lists.infradead.org
Cc: Wang Yugui <wangyugui@e16-tech.com>
Subject: [PATCH RFC v3] nvme: basic RMEDIA support for host
Date: Tue,  6 Aug 2024 08:48:23 +0800
Message-ID: <20240806004823.27417-1-wangyugui@e16-tech.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240723232419.19753-1-wangyugui@e16-tech.com>
References: <20240723232419.19753-1-wangyugui@e16-tech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240805_174832_818062_4E1557E6 
X-CRM114-Status: GOOD (  11.33  )
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
We add Rotational media(RMEDIA) basic support to nvme host firstly.

Signed-off-by: Wang Yugui <wangyugui@e16-tech.com>
---
changelog of RFC v3
 - rename var based on comments.
   change is_rmedia to is_rotational;
   but keep RMEDIA of NVME_INDEP_NS_FEAT_RMEDIA to match NVME spec 2.0.

 drivers/nvme/host/core.c      | 5 +++++
 drivers/nvme/host/multipath.c | 3 +++
 drivers/nvme/host/nvme.h      | 1 +
 include/linux/nvme.h          | 1 +
 4 files changed, 10 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 19917253ba7b..f4c41bf70b19 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -40,6 +40,7 @@ struct nvme_ns_info {
 	bool is_readonly;
 	bool is_ready;
 	bool is_removed;
+	bool is_rotational;
 };
 
 unsigned int admin_timeout = 60;
@@ -1622,6 +1623,7 @@ static int nvme_ns_info_from_id_cs_indep(struct nvme_ctrl *ctrl,
 		info->is_shared = id->nmic & NVME_NS_NMIC_SHARED;
 		info->is_readonly = id->nsattr & NVME_NS_ATTR_RO;
 		info->is_ready = id->nstat & NVME_NSTAT_NRDY;
+		info->is_rotational = id->nsfeat & NVME_INDEP_NS_FEAT_RMEDIA;
 	}
 	kfree(id);
 	return ret;
@@ -3613,6 +3618,7 @@ static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
 	head->ns_id = info->nsid;
 	head->ids = info->ids;
 	head->shared = info->is_shared;
+	head->rotational = info->is_rotational;
 	ratelimit_state_init(&head->rs_nuse, 5 * HZ, 1);
 	ratelimit_set_flags(&head->rs_nuse, RATELIMIT_MSG_ON_RELEASE);
 	kref_init(&head->ref);
@@ -3816,6 +3816,8 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
 
 	if (ctrl->opts && ctrl->opts->data_digest)
 		lim.features |= BLK_FEAT_STABLE_WRITES;
+	if (info->is_rotational)
+		lim.features |= BLK_FEAT_ROTATIONAL;
 	if (ctrl->ops->supports_pci_p2pdma &&
 	    ctrl->ops->supports_pci_p2pdma(ctrl))
 		lim.features |= BLK_FEAT_PCI_P2PDMA;
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 91d9eb3c22ef..a3cd6525d24d 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -626,6 +626,9 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
 	head->disk->private_data = head;
 	sprintf(head->disk->disk_name, "nvme%dn%d",
 			ctrl->subsys->instance, head->instance);
+
+	if (head->rotational)
+		lim.features |= BLK_FEAT_ROTATIONAL;
 	return 0;
 }
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index f900e44243ae..9f2789c44249 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -465,6 +465,7 @@ struct nvme_ns_head {
 	struct list_head	entry;
 	struct kref		ref;
 	bool			shared;
+	bool			rotational;
 	bool			passthru_err_log_enabled;
 	int			instance;
 	struct nvme_effects_log *effects;
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index c12a329dd463..2c259d126f80 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -546,6 +546,7 @@ enum {
 	NVME_NS_FEAT_THIN	= 1 << 0,
 	NVME_NS_FEAT_ATOMICS	= 1 << 1,
 	NVME_NS_FEAT_IO_OPT	= 1 << 4,
+	NVME_INDEP_NS_FEAT_RMEDIA = 1 << 4,
 	NVME_NS_ATTR_RO		= 1 << 0,
 	NVME_NS_FLBAS_LBA_MASK	= 0xf,
 	NVME_NS_FLBAS_LBA_UMASK	= 0x60,
-- 
2.36.2


