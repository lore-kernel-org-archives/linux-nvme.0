Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7497EC4345F
	for <linux-nvme@archiver.kernel.org>; Sun, 28 Apr 2024 09:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=8IBMe0n4DR1fnVh89DLADwCWieEPdI3qqQ5HAPwzf5E=; b=GCNnfuONLKTpVIvNUC364DU0b8
	7AI4iwcd5I/snnZovqGJG3I0PZa1dqUlVwsCEUWfhR/KUMn+GTxyIgSTlsREYuBjH7E0dsUEe9u/k
	do458VlQR7CU+8nZjFrMV/zSdDI0kYrUXj4Ox1RHtc+ehCEoxPY9kf+H7K2mhOR2aZvaiJ0o47UPk
	XmzbJUVoALrhV5dEB64OrhaH6NDMqd+LLbNeCDGsE7wKRpoYX27wTQCiRWJnOdkKBVjSqBgXj9lls
	B1PaEQV38MSSUtqIbObp10EMrCE/CV/SY0Lbvh9IwVHLuJQcxsCOw2rroQ6Qzs0361J0L9vxi6No+
	5WNQKPuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s10n7-0000000HFdu-3b08;
	Sun, 28 Apr 2024 09:25:49 +0000
Received: from mail-wm1-f51.google.com ([209.85.128.51])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s10n3-0000000HFdC-3uCF
	for linux-nvme@lists.infradead.org;
	Sun, 28 Apr 2024 09:25:47 +0000
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-41c02fb8cebso23045e9.1
        for <linux-nvme@lists.infradead.org>; Sun, 28 Apr 2024 02:25:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714296343; x=1714901143;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8IBMe0n4DR1fnVh89DLADwCWieEPdI3qqQ5HAPwzf5E=;
        b=FyuX9Pn2mmUm9I1JaL907Y6ZiFGYmyUkDVmnzfY0vmcq8WkkWYFUmhil3gVQe1i200
         V9K057luZ3B/XAuPeyRLV8jxmLneq7ViKad/PdDvkgJx0YqWb1G8Q8lR4SBepA9aPWnJ
         cF0A1nJUwQxenHlYYYsPsHI77bjUJ+wu//2Hj+VB3FX3/eA/RA83C1zQwG79bsSv8WI5
         3lamZK18PNLamxMAvgUQ7l415u3yPbHBhjjdKmgEl32c71nBtStjqMRh0V0Mq+mddySr
         x+5/zxeaYBu9kF9qwl/Kg+987fTkwtgajy8fOSS3/eVHaMkqoabte0tqLsZXz79XSTZN
         v1Ow==
X-Gm-Message-State: AOJu0YxnvVj59/8dd17mtw2xaKS/W/5YikRElbgh3rIsI0sXQUOhAc1i
	e7568DTpWWK4XDg/9TXItgkw9RC5IJrd0IaQUiZsqYXOzEqPXGSAfQwaFg==
X-Google-Smtp-Source: AGHT+IGeCa/a8SqaEyMK956JazpqfDBt1nyx1R9VrmTg9cI57bGet6S70jo56NXKgI6XRZQK1nzvyg==
X-Received: by 2002:a05:600c:5112:b0:418:9941:ca28 with SMTP id o18-20020a05600c511200b004189941ca28mr5192110wms.2.1714296342686;
        Sun, 28 Apr 2024 02:25:42 -0700 (PDT)
Received: from vastdata-ubuntu2.vstd.int (85.65.192.64.dynamic.barak-online.net. [85.65.192.64])
        by smtp.gmail.com with ESMTPSA id f17-20020a05600c4e9100b004182b87aaacsm37298519wmq.14.2024.04.28.02.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 02:25:42 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	jirong.feng@easystack.cn
Subject: [PATCH] nvmet: fix nvme status code when namespace is disabled
Date: Sun, 28 Apr 2024 12:25:40 +0300
Message-Id: <20240428092540.77366-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240428_022545_995988_858003F2 
X-CRM114-Status: GOOD (  17.45  )
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

If the user disabled a nvmet namesapce, it is removed from
the subsystem namespaces list. When nvmet processes a command
directed to an nsid that was disabled, it cannot differentiate
between a nsid that is disabled vs. a non-existent namespace,
and resorts to return NVME_SC_INVALID_NS with the dnr bit set.

This translates to a non-retryable status for the host, which
translates to a user error. We should expect disabled namespaces
to not cause an I/O error in a multipath environment.

Address this by searching a configfs item for the namespace nvmet
failed to find, and if we found one, conclude that the namespace
is disabled (perhaps temporarily). Return NVME_SC_INTERNAL_PATH_ERROR
in this case and keep DNR bit cleared.

Reported-by: Jirong Feng <jirong.feng@easystack.cn>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
Jirong Feng, can you please re-run the test as requested and verify
that the I/O error goes away. If so, please reply with your "Tested-by"
tag.

 drivers/nvme/target/configfs.c | 13 +++++++++++++
 drivers/nvme/target/core.c     |  8 ++++++--
 drivers/nvme/target/nvmet.h    |  1 +
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 77a6e817b315..e744bd0a9cc2 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -754,6 +754,19 @@ static struct configfs_attribute *nvmet_ns_attrs[] = {
 	NULL,
 };
 
+bool nvmet_subsys_nsid_exists(struct nvmet_subsys *subsys, u32 nsid)
+{
+	struct config_item *ns_item;
+	char name[4] = {};
+
+	if (sprintf(name, "%u", nsid) <= 0)
+		return false;
+	mutex_lock(&subsys->namespaces_group.cg_subsys->su_mutex);
+	ns_item = config_group_find_item(&subsys->namespaces_group, name);
+	mutex_unlock(&subsys->namespaces_group.cg_subsys->su_mutex);
+	return ns_item != NULL;
+}
+
 static void nvmet_ns_release(struct config_item *item)
 {
 	struct nvmet_ns *ns = to_nvmet_ns(item);
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 78cba026610a..ed0b8f3707b4 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -437,11 +437,15 @@ void nvmet_stop_keep_alive_timer(struct nvmet_ctrl *ctrl)
 u16 nvmet_req_find_ns(struct nvmet_req *req)
 {
 	u32 nsid = le32_to_cpu(req->cmd->common.nsid);
+	struct nvmet_subsys *subsys = nvmet_req_subsys(req);
 
-	req->ns = xa_load(&nvmet_req_subsys(req)->namespaces, nsid);
+	req->ns = xa_load(&subsys->namespaces, nsid);
 	if (unlikely(!req->ns)) {
 		req->error_loc = offsetof(struct nvme_common_command, nsid);
-		return NVME_SC_INVALID_NS | NVME_SC_DNR;
+		if (nvmet_subsys_nsid_exists(subsys, nsid))
+			return NVME_SC_INTERNAL_PATH_ERROR;
+		else
+			return NVME_SC_INVALID_NS | NVME_SC_DNR;
 	}
 
 	percpu_ref_get(&req->ns->ref);
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index f460728e1df1..c1306de1f4dd 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -543,6 +543,7 @@ void nvmet_subsys_disc_changed(struct nvmet_subsys *subsys,
 		struct nvmet_host *host);
 void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
 		u8 event_info, u8 log_page);
+bool nvmet_subsys_nsid_exists(struct nvmet_subsys *subsys, u32 nsid);
 
 #define NVMET_MIN_QUEUE_SIZE	16
 #define NVMET_MAX_QUEUE_SIZE	1024
-- 
2.40.1


