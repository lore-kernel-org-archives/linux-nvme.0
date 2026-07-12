Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3825EC43458
	for <linux-nvme@archiver.kernel.org>; Sun, 12 Jul 2026 02:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1rYDxzyuopFsvKHCSX2IcMInl87/tUE3AM2EYHgQ9pk=; b=pIwfZwy6OD3aV+QZzR4gkHW7M/
	JZvMMc9g/IEio3n94BThoW9SFNAQGc7mKdvEBeoIg23/BUhcrMC1Bvuy1dGAeICV/PxkKfbyV4FrN
	f71vg0zZLOaM6MszP98uAqS8/Dl+kV503onNjsEQIvrf64iJZTr1OMHydFEuB8EcuYpNE2E0yZuLl
	xLTt12DVjgVRqWzoYjkwjgtla3iTCn5Q/zmwur6TjVdEE8likJW5SAv5pcGHaRAcU4r2o05PKecrD
	iTtoPO5iEMIN13sE0bnNzAbQuc/CNV+YvQzXDzGenrGGH4pmGN25+UA6ODNo36ttUFiLFuzC2qZHQ
	HxFOYqvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wijt9-000000071wa-2Vyo;
	Sun, 12 Jul 2026 02:25:51 +0000
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wijt3-000000071oF-0Hru
	for linux-nvme@lists.infradead.org;
	Sun, 12 Jul 2026 02:25:50 +0000
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-2ccdb73f0e1so17634195ad.3
        for <linux-nvme@lists.infradead.org>; Sat, 11 Jul 2026 19:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1783823144; x=1784427944; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1rYDxzyuopFsvKHCSX2IcMInl87/tUE3AM2EYHgQ9pk=;
        b=XZiu+uXYBsTBcfjJiX2RoOj9PmhuGsTHYzbo9OqMOP1nZ5WbQV1xtRN1N3rru13Llm
         Bzd5tgIDYxsYIuzdhJZSLfRHVBD4JTf06srMdBR1zkUHUkrw0NRiD9DxzIo5ieYRVYs8
         7Lv4Dg7JNQYaRp/0buoRQKPCgd1x1YAb1EkNgjcMgWxr8yujvILt9rRBMPfpVVflJXjc
         x71ANENkryfo6iIGNNlWNBEnTEN9h1qJb5s0TZwpWDhy25pQo8wbykRjn8AbaBCD7S+c
         ttmlbWozlz0q6MGZDBWQRa7iC5wQaIs5YdS59QgmId0xn+lqiY8umDoNcpHmG4l/d0e8
         xDQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783823144; x=1784427944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1rYDxzyuopFsvKHCSX2IcMInl87/tUE3AM2EYHgQ9pk=;
        b=oJ2JHP2ZEed8En9anZtYOIdWWpY3rkVQiwuxJK2Y55cxMPr9BFXAL2Au3XRZcBJIrA
         kxwBF/Dzo/MtdIFF5CQ2OewtU34Uok9KvxBQg9Sugndqz0HY1ITqyF5Hf9j0M3yBmzc7
         H6Zgkcu3enkNCYUHOFyJGGnskqHeBwEIM1CYoZiTMTFaUsgTTCP5TO4Oeu0uxVei2XQH
         DhEAD9eSXTPcWerzmmzqLlNclfQj8tbxxyqK2GLGWmdd2pIetOmqKTljzdYNZIu9S2mo
         /yF6jmP2GCerw9XksvhdwwP/HExKGdZMa3XqWoEE3HNOoKN2GaAoFtQRZIuedWF1MBAe
         4d0g==
X-Forwarded-Encrypted: i=1; AHgh+RoCmrJI617tnmoyRS+tSg2uBXtONv/XA99f4zqQDY5N7GSrJq5bzH/9KPlbqY9BIQ13LCUj1y1C11Mt@lists.infradead.org
X-Gm-Message-State: AOJu0YzXMYsGQf94HggzWLMSPHvG2H08y3baQdit+n6TzkdzjsqKnosD
	MMIQc+Qq7ezM3ruJLpcz/JfAgMLeEKvgv7o/IbKLp7k6fD0ewOmXGJ/xRn7x1D6xrS8=
X-Gm-Gg: AfdE7cmp0r1ae2dO+nlirqn4DnIh0ud2Ui0dY5jdtl9K1gG1RdqnQmioCgxVhsO2HC4
	5z92gm2gby7Lq1IzcqwZmMTZCaWlD/TVAarVHxfoNfp7/GKR5NQI3YKxe3j7V6Kv7nszM7R6oG+
	urtv3HYLLampY/K6waHLfj6UAmL6NJB0sqSVXYbp2ax8A6Q73Wwn32NJrTeDOYChARhAQgjv8tS
	uvw1fTwTU3+0TnwrjIRtVDE+WKsBE4jBkJuaSKd5t9uWsVgg5c1la4CtQg8O28caikj55NK5XC0
	dKl+5Zr3YEhXRO94e9OcauzkRMs5fYRQBRMF/cXYOreolTmrqmwNMYPAEpgCMrG1IwPwyNFWkSf
	JDRhdYqP52ZbmLRn2P/ibX+IdMULKcO00n/ln+0Pp/KQge7EEHmBYAeXYnNryVEQGWN/MK/C4JK
	T/X/+S9yaEzLI4vKoLnlSTwkECow==
X-Received: by 2002:a17:90b:3a81:b0:37f:e1b6:4c7d with SMTP id 98e67ed59e1d1-38dc782ab92mr4293115a91.6.1783823143929;
        Sat, 11 Jul 2026 19:25:43 -0700 (PDT)
Received: from ceto.lan ([2607:fb90:9c20:2264::1c31])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-3117462f5c7sm60704693eec.0.2026.07.11.19.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 19:25:43 -0700 (PDT)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <jsmart833426@gmail.com>,
	Hannes Reinecke <hare@suse.de>,
	Randy Jennings <randyj@purestorage.com>,
	Dhaval Giani <dgiani@purestorage.com>
Cc: Aaron Dailey <adailey@purestorage.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mohamed Khalfella <mkhalfella@purestorage.com>
Subject: [PATCH v5 15/16] nvmet: Add support for CQT to nvme target
Date: Sat, 11 Jul 2026 19:23:36 -0700
Message-ID: <20260712022437.3743117-16-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260712022437.3743117-1-mkhalfella@purestorage.com>
References: <20260712022437.3743117-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260711_192545_116355_48BCEE9E 
X-CRM114-Status: GOOD (  18.07  )
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

TP4129 KATO Corrections and Clarifications defined CQT (Command Quiesce
Time) which is used along with KATO (Keep Alive Timeout) to set an upper
time limit for attempting Cross-Controller Recovery. CQT is added as a
subsystem attribute that defaults to 0 to maintain the current behavior.

Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
---
 drivers/nvme/target/admin-cmd.c |  1 +
 drivers/nvme/target/configfs.c  | 36 +++++++++++++++++++++++++++++++++
 drivers/nvme/target/core.c      |  3 +++
 drivers/nvme/target/nvmet.h     |  2 ++
 include/linux/nvme.h            |  5 ++++-
 5 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index ea2566a9b83f..fbfc226c9830 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -737,6 +737,7 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 	id->cntlid = cpu_to_le16(ctrl->cntlid);
 	id->ver = cpu_to_le32(ctrl->subsys->ver);
 	if (!nvmet_is_disc_subsys(ctrl->subsys)) {
+		id->cqt = cpu_to_le16(ctrl->cqt);
 		id->ciu = ctrl->ciu;
 		id->cirn = cpu_to_le64(ctrl->cirn);
 		id->ccrl = NVMF_CCR_LIMIT;
diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 2b69ffcfc8df..b99f31c0a640 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -1661,6 +1661,41 @@ static ssize_t nvmet_subsys_attr_pi_enable_store(struct config_item *item,
 CONFIGFS_ATTR(nvmet_subsys_, attr_pi_enable);
 #endif
 
+static ssize_t nvmet_subsys_attr_cqt_show(struct config_item *item,
+					  char *page)
+{
+	return snprintf(page, PAGE_SIZE, "%u\n", to_subsys(item)->cqt);
+}
+
+static ssize_t nvmet_subsys_attr_cqt_store(struct config_item *item,
+					   const char *page, size_t cnt)
+{
+	struct nvmet_subsys *subsys = to_subsys(item);
+	struct nvmet_ctrl *ctrl;
+	u16 cqt;
+
+	if (nvmet_is_disc_subsys(subsys))
+		return -EINVAL;
+
+	if (sscanf(page, "%hu\n", &cqt) != 1)
+		return -EINVAL;
+
+	down_write(&nvmet_config_sem);
+	mutex_lock(&subsys->lock);
+	if (subsys->cqt == cqt)
+		goto out;
+
+	subsys->cqt = cqt;
+	/* Force reconnect */
+	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry)
+		ctrl->ops->delete_ctrl(ctrl);
+out:
+	mutex_unlock(&subsys->lock);
+	up_write(&nvmet_config_sem);
+	return cnt;
+}
+CONFIGFS_ATTR(nvmet_subsys_, attr_cqt);
+
 static ssize_t nvmet_subsys_attr_qid_max_show(struct config_item *item,
 					      char *page)
 {
@@ -1701,6 +1736,7 @@ static struct configfs_attribute *nvmet_subsys_attrs[] = {
 	&nvmet_subsys_attr_attr_vendor_id,
 	&nvmet_subsys_attr_attr_subsys_vendor_id,
 	&nvmet_subsys_attr_attr_model,
+	&nvmet_subsys_attr_attr_cqt,
 	&nvmet_subsys_attr_attr_qid_max,
 	&nvmet_subsys_attr_attr_ieee_oui,
 	&nvmet_subsys_attr_attr_firmware,
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 9b16b15f5093..e59026ca449f 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1729,6 +1729,7 @@ struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args)
 	ctrl->cntlid = ret;
 
 	if (!nvmet_is_disc_subsys(ctrl->subsys)) {
+		ctrl->cqt = subsys->cqt;
 		ctrl->ciu = get_random_u8() ? : 1;
 		ctrl->cirn = get_random_u64();
 	}
@@ -1969,10 +1970,12 @@ struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
 
 	switch (type) {
 	case NVME_NQN_NVME:
+		subsys->cqt = NVMF_CQT_MS;
 		subsys->max_qid = NVMET_NR_QUEUES;
 		break;
 	case NVME_NQN_DISC:
 	case NVME_NQN_CURR:
+		subsys->cqt = 0;
 		subsys->max_qid = 0;
 		break;
 	default:
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index da80377c3795..4ff458c3ccdc 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -269,6 +269,7 @@ struct nvmet_ctrl {
 
 	uuid_t			hostid;
 	u16			cntlid;
+	u16			cqt;
 	u8			ciu;
 	u32			kato;
 	u64			cirn;
@@ -346,6 +347,7 @@ struct nvmet_subsys {
 #ifdef CONFIG_NVME_TARGET_DEBUGFS
 	struct dentry		*debugfs_dir;
 #endif
+	u16			cqt;
 	u16			max_qid;
 
 	u64			ver;
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 3757d11ffea3..0b69ed53f347 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -21,6 +21,7 @@
 #define NVMF_TRADDR_SIZE	256
 #define NVMF_TSAS_SIZE		256
 
+#define NVMF_CQT_MS		0
 #define NVMF_CCR_LIMIT		4
 #define NVMF_CCR_PER_PAGE	511
 
@@ -368,7 +369,9 @@ struct nvme_id_ctrl {
 	__u8			anacap;
 	__le32			anagrpmax;
 	__le32			nanagrpid;
-	__u8			rsvd352[160];
+	__u8			rsvd352[34];
+	__le16			cqt;
+	__u8			rsvd388[124];
 	__u8			sqes;
 	__u8			cqes;
 	__le16			maxcmd;
-- 
2.54.0


