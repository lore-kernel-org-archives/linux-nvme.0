Return-Path: <SRS0=9COT=NS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8D9CC432BE
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Aug 2021 06:19:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5877160F92
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Aug 2021 06:19:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5877160F92
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=l7LsHwQa9HYOWJh7ZO464yUAOvaRKBmbJkbcLRy7Ge8=; b=s3Ik5Xcr4RL9F7
	YlENmNIPmu8iDJzc9fFMa36n22FFZf1U/DVdl2nZ2pEYmjxl6B3Il8V4Yv8TACAhU0PBYqKSyOZVz
	MMSHFiZ81UibJ7WAP6z6FKl9/56yFlE6QiUQBXSaDMBXNBCAyhjsfMiA2Ydejog75d198L8/0eO+Z
	WQcaCF1yi3vFDE5KwpcoEERvx9bLNacTWv8gxQ6T9cFCmysbBBeYoLIEpRzj3aUlwwQka2AoQjEBq
	AgPcvuqlRXJ6NmzCz6snMv18yGD6SBE0fsWvfKYEuefKu2p+xqdkXpRD0aqVzn8qJ5LOrn9+5DdIN
	PCx+P7iOdMTal4YxkSFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mJVCk-00BfbU-1f; Fri, 27 Aug 2021 06:19:06 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mJVCi-00BfbM-LR
 for linux-nvme@bombadil.infradead.org; Fri, 27 Aug 2021 06:19:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=c95YKKpK+i7aViFCx8V1r/BPhzMApLQU6nZ7QzQ1l14=; b=BVU3hCdyHmv3XdcogGid5CvOZH
 vJDcDMwjwT3HL7k8lQ4HWYI1qssQW3y9LOtqDOTA2YkeA8PPUvpTSRZsMk04K6u3YHMT7yTExbTNy
 XJ0lYd2rLp+U+5Gns3lzlGSsWrkpjgwCNEkWFfX4iJ2BWYmqynlUlnR8O8mTtl+BM+9xjhccqAzT5
 giBSm/tj1tqfl6dFx9xuIHunkhUUfVbnf6WUq1pocgm4Rr9yicLQMyOMiCAYYcMiSDlJQ2vTjVxcz
 ZQ0wUFIfk4GgUVVKJgbIMdugDK96cCP2jz3AKJACSnnw+q+BDaY7UU4hxN5qoeyfa+urbemyiaGLL
 z9ksgr6Q==;
Received: from [2001:4bb8:193:fd10:df14:e35c:a5db:21da] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mJVBz-00EBx7-B6; Fri, 27 Aug 2021 06:18:39 +0000
From: Christoph Hellwig <hch@lst.de>
To: kbusch@kernel.org,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH] nvmet: return bool from nvmet_passthru_ctrl and
 nvmet_is_passthru_req
Date: Fri, 27 Aug 2021 08:18:18 +0200
Message-Id: <20210827061818.170603-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The target core code never needs the host-side nvme_ctrl structure.
Open code two uses of nvmet_is_passthru_req in passthru.c, and then
switch the helpers used by the core to return bool.  Also rename the
fuctions to better match their usage:

  nvmet_passthru_ctrl -> nvmet_is_passthru_subsys
  nvmet_req_passthru_ctrl -> nvmet_is_passthru_req

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/target/admin-cmd.c | 2 +-
 drivers/nvme/target/configfs.c  | 2 +-
 drivers/nvme/target/core.c      | 6 +++---
 drivers/nvme/target/nvmet.h     | 9 ++++-----
 drivers/nvme/target/passthru.c  | 4 ++--
 5 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 0cb98f2bbc8c..aa6d84d8848e 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -1015,7 +1015,7 @@ u16 nvmet_parse_admin_cmd(struct nvmet_req *req)
 	if (unlikely(ret))
 		return ret;
 
-	if (nvmet_req_passthru_ctrl(req))
+	if (nvmet_is_passthru_req(req))
 		return nvmet_parse_passthru_admin_cmd(req);
 
 	switch (cmd->common.opcode) {
diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 273555127188..f74485c705ff 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -1028,7 +1028,7 @@ nvmet_subsys_attr_version_store_locked(struct nvmet_subsys *subsys,
 	}
 
 	/* passthru subsystems use the underlying controller's version */
-	if (nvmet_passthru_ctrl(subsys))
+	if (nvmet_is_passthru_subsys(subsys))
 		return -EINVAL;
 
 	ret = sscanf(page, "%d.%d.%d\n", &major, &minor, &tertiary);
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 11c44706dc2d..b8425fa34300 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -553,7 +553,7 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
 	mutex_lock(&subsys->lock);
 	ret = 0;
 
-	if (nvmet_passthru_ctrl(subsys)) {
+	if (nvmet_is_passthru_subsys(subsys)) {
 		pr_info("cannot enable both passthru and regular namespaces for a single subsystem");
 		goto out_unlock;
 	}
@@ -869,7 +869,7 @@ static u16 nvmet_parse_io_cmd(struct nvmet_req *req)
 	if (unlikely(ret))
 		return ret;
 
-	if (nvmet_req_passthru_ctrl(req))
+	if (nvmet_is_passthru_req(req))
 		return nvmet_parse_passthru_io_cmd(req);
 
 	ret = nvmet_req_find_ns(req);
@@ -1207,7 +1207,7 @@ static void nvmet_init_cap(struct nvmet_ctrl *ctrl)
 	/* maximum queue entries supported: */
 	ctrl->cap |= NVMET_QUEUE_SIZE - 1;
 
-	if (nvmet_passthru_ctrl(ctrl->subsys))
+	if (nvmet_is_passthru_subsys(ctrl->subsys))
 		nvmet_passthrough_override_cap(ctrl);
 }
 
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 183119607968..7143c7fa7464 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -582,7 +582,7 @@ int nvmet_passthru_ctrl_enable(struct nvmet_subsys *subsys);
 void nvmet_passthru_ctrl_disable(struct nvmet_subsys *subsys);
 u16 nvmet_parse_passthru_admin_cmd(struct nvmet_req *req);
 u16 nvmet_parse_passthru_io_cmd(struct nvmet_req *req);
-static inline struct nvme_ctrl *nvmet_passthru_ctrl(struct nvmet_subsys *subsys)
+static inline bool nvmet_is_passthru_subsys(struct nvmet_subsys *subsys)
 {
 	return subsys->passthru_ctrl;
 }
@@ -601,16 +601,15 @@ static inline u16 nvmet_parse_passthru_io_cmd(struct nvmet_req *req)
 {
 	return 0;
 }
-static inline struct nvme_ctrl *nvmet_passthru_ctrl(struct nvmet_subsys *subsys)
+static inline bool nvmet_is_passthru_subsys(struct nvmet_subsys *subsys)
 {
 	return NULL;
 }
 #endif /* CONFIG_NVME_TARGET_PASSTHRU */
 
-static inline struct nvme_ctrl *
-nvmet_req_passthru_ctrl(struct nvmet_req *req)
+static inline bool nvmet_is_passthru_req(struct nvmet_req *req)
 {
-	return nvmet_passthru_ctrl(nvmet_req_subsys(req));
+	return nvmet_is_passthru_subsys(nvmet_req_subsys(req));
 }
 
 void nvmet_passthrough_override_cap(struct nvmet_ctrl *ctrl);
diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index 8784c487e462..f0efb3537989 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -228,7 +228,7 @@ static int nvmet_passthru_map_sg(struct nvmet_req *req, struct request *rq)
 
 static void nvmet_passthru_execute_cmd(struct nvmet_req *req)
 {
-	struct nvme_ctrl *ctrl = nvmet_req_passthru_ctrl(req);
+	struct nvme_ctrl *ctrl = nvmet_req_subsys(req)->passthru_ctrl;
 	struct request_queue *q = ctrl->admin_q;
 	struct nvme_ns *ns = NULL;
 	struct request *rq = NULL;
@@ -309,7 +309,7 @@ static void nvmet_passthru_execute_cmd(struct nvmet_req *req)
  */
 static void nvmet_passthru_set_host_behaviour(struct nvmet_req *req)
 {
-	struct nvme_ctrl *ctrl = nvmet_req_passthru_ctrl(req);
+	struct nvme_ctrl *ctrl = nvmet_req_subsys(req)->passthru_ctrl;
 	struct nvme_feat_host_behavior *host;
 	u16 status = NVME_SC_INTERNAL;
 	int ret;
-- 
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
