Return-Path: <SRS0=7vxi=YC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2373ECE597
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Oct 2019 19:25:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E0B9206B6
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Oct 2019 19:25:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EgwvdIzD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E0B9206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Subject:MIME-Version:References:
	In-Reply-To:Message-Id:Date:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WDMozLpDnCiZucLvyVugGF7GnSUm7R1VJXhScITosyg=; b=EgwvdIzD+yslOe
	66yqb0A5ma1WkZPzv6yP3ueYvzInH+l5+nxzuSJocf1aQuVHA49Czq1mBE8evSrZuRSMLwVe3ncDt
	NfzPsfHHOxOjN8jpdoNV1wQ+RbfzGfrlljsyWmXbGjFZlJAME/WevfgXWIvqXn7kCGnyq2mXTwShF
	qlrIPnLbtC65cflpV14qVo5VVrwk0YHkNYY7IQfEZczI6etAPgv0crJppSJpwK3bjoBsKd62fco8j
	Oi4Jn8MGUyNOAytHTcyTAyzZ7cxgCMQEq9awXAWCzkwJ2C29NMmGN3+Z3KbNAgKRhTHh0WLaSbLkJ
	VnjDhl3/jNWf8Rj1veEw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iIHaq-0008Gb-TJ; Wed, 09 Oct 2019 19:25:52 +0000
Received: from ale.deltatee.com ([207.54.116.67])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iIHag-00085Y-Iv
 for linux-nvme@lists.infradead.org; Wed, 09 Oct 2019 19:25:44 +0000
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <gunthorp@deltatee.com>)
 id 1iIHaa-0002g7-6l; Wed, 09 Oct 2019 13:25:39 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
 (envelope-from <gunthorp@deltatee.com>)
 id 1iIHaY-0003QD-Ns; Wed, 09 Oct 2019 13:25:34 -0600
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Date: Wed,  9 Oct 2019 13:25:24 -0600
Message-Id: <20191009192530.13079-8-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191009192530.13079-1-logang@deltatee.com>
References: <20191009192530.13079-1-logang@deltatee.com>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, hch@lst.de,
 sagi@grimberg.me, kbusch@kernel.org, axboe@fb.com, maxg@mellanox.com,
 sbates@raithlin.com, logang@deltatee.com, Chaitanya.Kulkarni@wdc.com,
 chaitanya.kulkarni@wdc.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v9 06/12] nvmet-passthru: add enable/disable helpers
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191009_122542_680286_B613D5C9 
X-CRM114-Status: GOOD (  15.26  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 Stephen Bates <sbates@raithlin.com>, Jens Axboe <axboe@fb.com>,
 Keith Busch <kbusch@kernel.org>, Max Gurtovoy <maxg@mellanox.com>,
 Logan Gunthorpe <logang@deltatee.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This patch adds helper functions which are used in the NVMeOF configfs
when the user is configuring the passthru subsystem. Here we ensure
that only one subsys is assigned to each nvme_ctrl by using an xarray
on the cntlid.

[chaitanya.kulkarni@wdc.com: this patch is very roughly based
 on a similar one by Chaitanya]
Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/nvme/target/core.c            |  8 +++
 drivers/nvme/target/io-cmd-passthru.c | 77 +++++++++++++++++++++++++++
 drivers/nvme/target/nvmet.h           | 10 ++++
 3 files changed, 95 insertions(+)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 256f765e772b..986b2511d284 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -520,6 +520,12 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
 
 	mutex_lock(&subsys->lock);
 	ret = 0;
+
+	if (nvmet_passthru_ctrl(subsys)) {
+		pr_info("cannot enable both passthru and regular namespaces for a single subsystem");
+		goto out_unlock;
+	}
+
 	if (ns->enabled)
 		goto out_unlock;
 
@@ -1440,6 +1446,8 @@ static void nvmet_subsys_free(struct kref *ref)
 
 	WARN_ON_ONCE(!list_empty(&subsys->namespaces));
 
+	nvmet_passthru_subsys_free(subsys);
+
 	kfree(subsys->subsysnqn);
 	kfree(subsys);
 }
diff --git a/drivers/nvme/target/io-cmd-passthru.c b/drivers/nvme/target/io-cmd-passthru.c
index 1eb855b4071c..c482e55f0fb8 100644
--- a/drivers/nvme/target/io-cmd-passthru.c
+++ b/drivers/nvme/target/io-cmd-passthru.c
@@ -11,6 +11,11 @@
 #include "../host/nvme.h"
 #include "nvmet.h"
 
+/*
+ * xarray to maintain one passthru subsystem per nvme controller.
+ */
+static DEFINE_XARRAY(passthru_subsystems);
+
 static struct workqueue_struct *passthru_wq;
 
 int nvmet_passthru_init(void)
@@ -27,6 +32,78 @@ void nvmet_passthru_destroy(void)
 	destroy_workqueue(passthru_wq);
 }
 
+int nvmet_passthru_ctrl_enable(struct nvmet_subsys *subsys)
+{
+	struct nvme_ctrl *ctrl;
+	int ret = -EINVAL;
+	void *old;
+
+	mutex_lock(&subsys->lock);
+	if (!subsys->passthru_ctrl_path)
+		goto out_unlock;
+	if (subsys->passthru_ctrl)
+		goto out_unlock;
+
+	if (subsys->nr_namespaces) {
+		pr_info("cannot enable both passthru and regular namespaces for a single subsystem");
+		goto out_unlock;
+	}
+
+	ctrl = nvme_ctrl_get_by_path(subsys->passthru_ctrl_path);
+	if (IS_ERR(ctrl)) {
+		ret = PTR_ERR(ctrl);
+		pr_err("failed to open nvme controller %s\n",
+		       subsys->passthru_ctrl_path);
+
+		goto out_unlock;
+	}
+
+	old = xa_cmpxchg(&passthru_subsystems, ctrl->cntlid, NULL,
+			 subsys, GFP_KERNEL);
+	if (xa_is_err(old)) {
+		ret = xa_err(old);
+		goto out_put_ctrl;
+	}
+
+	if (old)
+		goto out_put_ctrl;
+
+	subsys->passthru_ctrl = ctrl;
+
+	mutex_unlock(&subsys->lock);
+	return 0;
+
+out_put_ctrl:
+	nvme_put_ctrl(ctrl);
+out_unlock:
+	mutex_unlock(&subsys->lock);
+	return ret;
+}
+
+static void __nvmet_passthru_ctrl_disable(struct nvmet_subsys *subsys)
+{
+	if (subsys->passthru_ctrl) {
+		xa_erase(&passthru_subsystems, subsys->passthru_ctrl->cntlid);
+		nvme_put_ctrl(subsys->passthru_ctrl);
+	}
+	subsys->passthru_ctrl = NULL;
+}
+
+void nvmet_passthru_ctrl_disable(struct nvmet_subsys *subsys)
+{
+	mutex_lock(&subsys->lock);
+	__nvmet_passthru_ctrl_disable(subsys);
+	mutex_unlock(&subsys->lock);
+}
+
+void nvmet_passthru_subsys_free(struct nvmet_subsys *subsys)
+{
+	mutex_lock(&subsys->lock);
+	__nvmet_passthru_ctrl_disable(subsys);
+	kfree(subsys->passthru_ctrl_path);
+	mutex_unlock(&subsys->lock);
+}
+
 static void nvmet_passthru_req_complete(struct nvmet_req *req,
 		struct request *rq, u16 status)
 {
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index daec1240307c..2c287d13ed83 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -230,6 +230,7 @@ struct nvmet_subsys {
 
 #ifdef CONFIG_NVME_TARGET_PASSTHRU
 	struct nvme_ctrl	*passthru_ctrl;
+	char			*passthru_ctrl_path;
 #endif /* CONFIG_NVME_TARGET_PASSTHRU */
 };
 
@@ -509,6 +510,9 @@ static inline u32 nvmet_rw_len(struct nvmet_req *req)
 
 int nvmet_passthru_init(void);
 void nvmet_passthru_destroy(void);
+void nvmet_passthru_subsys_free(struct nvmet_subsys *subsys);
+int nvmet_passthru_ctrl_enable(struct nvmet_subsys *subsys);
+void nvmet_passthru_ctrl_disable(struct nvmet_subsys *subsys);
 u16 nvmet_parse_passthru_cmd(struct nvmet_req *req);
 
 static inline
@@ -526,6 +530,12 @@ static inline int nvmet_passthru_init(void)
 static inline void nvmet_passthru_destroy(void)
 {
 }
+static inline void nvmet_passthru_subsys_free(struct nvmet_subsys *subsys)
+{
+}
+static inline void nvmet_passthru_ctrl_disable(struct nvmet_subsys *subsys)
+{
+}
 static inline u16 nvmet_parse_passthru_cmd(struct nvmet_req *req)
 {
 	return 0;
-- 
2.20.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
