Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6C9CC10F1A
	for <linux-nvme@archiver.kernel.org>; Tue,  7 May 2024 23:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3px0O0rssgaGwosZBO+aNwHjAmRpLfklgwg3rKAk0Sg=; b=dcW6EuyJEKg7z5PVowS2Q7NhnZ
	HnMHUT4LGUA7YJyduoTFHwQ1zziwbEZwDdZ9VBPg4yovSGIVoCT6sAtlI9s2MHJYd7A/QvWQxFcwx
	hJ2fkVBXC4pntC3ibXAY3UVT4lUGFIrsq0GNdFYuUjMtRpP4k6JO0/5OSyJRmZi4tJ7IjpApgEQy4
	za/KCiygr/0wJbBiOpwXwEwupU5C45YIIIgimmBUh1Chu43ga9MZaZHykhyRIaCEzEqX8Y1JA6ZLf
	4NWwGr+Nko0Nv/eOpdl2H8nBYpG2WbIitWzMYqBWuBIUkn3cb6KcSFJzEbF7d2aY3EyH2LkrDwssd
	AGdYr6ew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4Tz7-0000000DBm7-3o00;
	Tue, 07 May 2024 23:12:33 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4Tyn-0000000DBVO-0HEi
	for linux-nvme@lists.infradead.org;
	Tue, 07 May 2024 23:12:16 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 5CB37CE1753;
	Tue,  7 May 2024 23:12:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 875F5C4AF63;
	Tue,  7 May 2024 23:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123530;
	bh=q5GGfzLI64XXDKv3h5EWtd05guNvaUcELij2oNTxdyo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RwNnrAmM3mlO+gvKoAUXH9AKoF8BWfhvFaUN4tRWxslsicNh775jl1noY9Otki9CQ
	 Y+eloisWdP+XNaUvmuNH24GKfyvBwZr8htMsb/+zpz+5q7AJxyWwqUjqO5kWd0a/Tb
	 7+sh71orQ/3vrgEbw3r+J+M4X82CTdHGtdSE8fNyTfvUrTcBY+hL7XCi4RWWas2ObB
	 8aNNJRYWrzr5q9NxRBPT2p+WHXBZTqJEDzWUzrm+iM33xQC1eewbbuM+ejW8ACvGh+
	 7Vil/w2YFG0q63uPPr9RUebHen36ALxZ0GbLB8+Adl1Ovij8cE4TLeQ4+dO+ovOG+H
	 Mp1pa/tuMpT1g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Jirong Feng <jirong.feng@easystack.cn>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 42/43] nvmet: fix nvme status code when namespace is disabled
Date: Tue,  7 May 2024 19:10:03 -0400
Message-ID: <20240507231033.393285-42-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507231033.393285-1-sashal@kernel.org>
References: <20240507231033.393285-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.30
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240507_161214_404429_2D09C5E8 
X-CRM114-Status: GOOD (  17.24  )
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

From: Sagi Grimberg <sagi@grimberg.me>

[ Upstream commit 505363957fad35f7aed9a2b0d8dad73451a80fb5 ]

If the user disabled a nvmet namespace, it is removed from the subsystem
namespaces list. When nvmet processes a command directed to an nsid that
was disabled, it cannot differentiate between a nsid that is disabled
vs. a non-existent namespace, and resorts to return NVME_SC_INVALID_NS
with the dnr bit set.

This translates to a non-retryable status for the host, which translates
to a user error. We should expect disabled namespaces to not cause an
I/O error in a multipath environment.

Address this by searching a configfs item for the namespace nvmet failed
to find, and if we found one, conclude that the namespace is disabled
(perhaps temporarily). Return NVME_SC_INTERNAL_PATH_ERROR in this case
and keep DNR bit cleared.

Reported-by: Jirong Feng <jirong.feng@easystack.cn>
Tested-by: Jirong Feng <jirong.feng@easystack.cn>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/configfs.c | 13 +++++++++++++
 drivers/nvme/target/core.c     |  5 ++++-
 drivers/nvme/target/nvmet.h    |  1 +
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 01b2a3d1a5e6c..3670a1103863b 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -616,6 +616,19 @@ static struct configfs_attribute *nvmet_ns_attrs[] = {
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
index 3935165048e74..ce7e945cb4f7e 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -425,10 +425,13 @@ void nvmet_stop_keep_alive_timer(struct nvmet_ctrl *ctrl)
 u16 nvmet_req_find_ns(struct nvmet_req *req)
 {
 	u32 nsid = le32_to_cpu(req->cmd->common.nsid);
+	struct nvmet_subsys *subsys = nvmet_req_subsys(req);
 
-	req->ns = xa_load(&nvmet_req_subsys(req)->namespaces, nsid);
+	req->ns = xa_load(&subsys->namespaces, nsid);
 	if (unlikely(!req->ns)) {
 		req->error_loc = offsetof(struct nvme_common_command, nsid);
+		if (nvmet_subsys_nsid_exists(subsys, nsid))
+			return NVME_SC_INTERNAL_PATH_ERROR;
 		return NVME_SC_INVALID_NS | NVME_SC_DNR;
 	}
 
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 8cfd60f3b5648..15b00ed7be16a 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -530,6 +530,7 @@ void nvmet_subsys_disc_changed(struct nvmet_subsys *subsys,
 		struct nvmet_host *host);
 void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
 		u8 event_info, u8 log_page);
+bool nvmet_subsys_nsid_exists(struct nvmet_subsys *subsys, u32 nsid);
 
 #define NVMET_QUEUE_SIZE	1024
 #define NVMET_NR_QUEUES		128
-- 
2.43.0


