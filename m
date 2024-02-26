Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE1C1C48BF6
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Feb 2024 14:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=i0J4tdGzEBv9NQspVqIc4kUZomgY2qJnAceJO4uXsHE=; b=YSa5YOnCjXHpIqU+5aD3F34Six
	ofGmpLdE8spU9+12HaXfC7H23euwoX3rLDe7zWb083ZldhIH2bdE141yMNKZ+uzMc6sRh7FUTuokq
	7zrErQ61cCUElvnBf3JpzTdPZcX6brhHAAxmB2FUAIkshU8G3sCqAnw8jlZ9WQeVAcA2woXZqIelq
	rYIvFpQv/kXk0fSlssrnLk9iFiqQIplg0p4EgPZDrV+x0H24+XeeG3s02V3Li4LaoS3jw/xk53Yl4
	lAFvbKsSFgvnr0L9+q02TwW4GpelXtnugwyEO855Bt7m1gRdYbsDuACSZXVrIiPmqJ/4qTXwCeaEl
	8GxkBAew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rebzq-000000018go-1U8t;
	Mon, 26 Feb 2024 14:30:22 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rebzn-000000018dl-0RIn
	for linux-nvme@lists.infradead.org;
	Mon, 26 Feb 2024 14:30:20 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id E31A2611DE;
	Mon, 26 Feb 2024 14:30:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71774C433F1;
	Mon, 26 Feb 2024 14:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708957817;
	bh=JsnuTfj1YWHYuQgCo2kkNZv1YH2oh+AZvEH4jUOV9cU=;
	h=From:To:Cc:Subject:Date:From;
	b=twZwb4i2m3smFZDtHtBq+d8xDXujhyZSN8vODmB3Hd4YQgONSh8mKb6v2ysjPvlzd
	 BvMCFdhJ9znHfRUwzeTATZ4yqfedpyLPN845he/60XyVcsap1uPaAE0/AhJzDwllLN
	 HlgjCaZPmRLvcDGTpR21VQzuW3++jBS9fMCPB3t9KAE/35KbpxJKNSefKUDO1oVhmi
	 c5tzrCLTP1wbTImhn0OcQmkBF1UhgJboGi6eJB2wFmUSxDpqAgZ4kZseaDWAJMVVC1
	 aUtBK49dmGxmm1XGcGQpm4kf+NG6F3XYm14llV9czh/KTn3Q5ABgeAuTNphWI5v/nP
	 sLXAPOkF3NYTw==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCHv3] nvme: authentication error are always non-retryable
Date: Mon, 26 Feb 2024 15:30:13 +0100
Message-Id: <20240226143013.39119-1-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240226_063019_439329_7BB07654 
X-CRM114-Status: GOOD (  14.20  )
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

From: Hannes Reinecke <hare@suse.de>

Any authentication errors which are generated internally are always
non-retryable, so set the DNR bit to ensure they are not retried.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/core.c    |  6 +++---
 drivers/nvme/host/fabrics.c | 29 +++++++++++++++++------------
 drivers/nvme/host/nvme.h    |  2 +-
 3 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 5e9a0cf43636..0a8a595070c0 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -374,14 +374,14 @@ static inline enum nvme_disposition nvme_decide_disposition(struct request *req)
 	if (likely(nvme_req(req)->status == 0))
 		return COMPLETE;
 
-	if ((nvme_req(req)->status & 0x7ff) == NVME_SC_AUTH_REQUIRED)
-		return AUTHENTICATE;
-
 	if (blk_noretry_request(req) ||
 	    (nvme_req(req)->status & NVME_SC_DNR) ||
 	    nvme_req(req)->retries >= nvme_max_retries)
 		return COMPLETE;
 
+	if ((nvme_req(req)->status & 0x7ff) == NVME_SC_AUTH_REQUIRED)
+		return AUTHENTICATE;
+
 	if (req->cmd_flags & REQ_NVME_MPATH) {
 		if (nvme_is_path_error(nvme_req(req)->status) ||
 		    blk_queue_dying(req->q))
diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index ab5ac219b70a..32e993781236 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -467,7 +467,7 @@ int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl)
 		if (result & NVME_CONNECT_AUTHREQ_ASCR) {
 			dev_warn(ctrl->device,
 				 "qid 0: secure concatenation is not supported\n");
-			ret = NVME_SC_AUTH_REQUIRED;
+			ret = NVME_SC_AUTH_REQUIRED | NVME_SC_DNR;
 			goto out_free_data;
 		}
 		/* Authentication required */
@@ -475,14 +475,16 @@ int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl)
 		if (ret) {
 			dev_warn(ctrl->device,
 				 "qid 0: authentication setup failed\n");
-			ret = NVME_SC_AUTH_REQUIRED;
+			ret = NVME_SC_AUTH_REQUIRED | NVME_SC_DNR;
 			goto out_free_data;
 		}
 		ret = nvme_auth_wait(ctrl, 0);
-		if (ret)
+		if (ret) {
 			dev_warn(ctrl->device,
-				 "qid 0: authentication failed\n");
-		else
+				 "qid 0: authentication failed, error %d\n",
+				 ret);
+			ret = NVME_SC_AUTH_REQUIRED | NVME_SC_DNR;
+		} else
 			dev_info(ctrl->device,
 				 "qid 0: authenticated\n");
 	}
@@ -541,7 +543,7 @@ int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16 qid)
 		if (result & NVME_CONNECT_AUTHREQ_ASCR) {
 			dev_warn(ctrl->device,
 				 "qid 0: secure concatenation is not supported\n");
-			ret = NVME_SC_AUTH_REQUIRED;
+			ret = NVME_SC_AUTH_REQUIRED | NVME_SC_DNR;
 			goto out_free_data;
 		}
 		/* Authentication required */
@@ -549,12 +551,15 @@ int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16 qid)
 		if (ret) {
 			dev_warn(ctrl->device,
 				 "qid %d: authentication setup failed\n", qid);
-			ret = NVME_SC_AUTH_REQUIRED;
-		} else {
-			ret = nvme_auth_wait(ctrl, qid);
-			if (ret)
-				dev_warn(ctrl->device,
-					 "qid %u: authentication failed\n", qid);
+			ret = NVME_SC_AUTH_REQUIRED | NVME_SC_DNR;
+			goto out_free_data;
+		}
+		ret = nvme_auth_wait(ctrl, qid);
+		if (ret) {
+			dev_warn(ctrl->device,
+				 "qid %u: authentication failed, error %d\n",
+				 qid, ret);
+			ret = NVME_SC_AUTH_REQUIRED | NVME_SC_DNR;
 		}
 	}
 out_free_data:
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 6ed2ca6b35e4..c08c220a68cf 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -1123,7 +1123,7 @@ static inline int nvme_auth_negotiate(struct nvme_ctrl *ctrl, int qid)
 }
 static inline int nvme_auth_wait(struct nvme_ctrl *ctrl, int qid)
 {
-	return NVME_SC_AUTH_REQUIRED;
+	return NVME_SC_AUTH_REQUIRED | NVME_SC_DNR;
 }
 static inline void nvme_auth_free(struct nvme_ctrl *ctrl) {};
 #endif
-- 
2.35.3


