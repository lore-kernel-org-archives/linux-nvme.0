Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8B1BC54798
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Feb 2024 10:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=2A3iuxrthiNSvqQe98gwBzpmsSW/tVcJPTJ9MfTwer4=; b=FMZV+6KA/j6fHEbKroaDj+4Ys0
	RSlQt53Jqf7KAsVPpCNYH1AvEuRwAkWED5CGKuqwms9KBDzU9tyH4p26Kq5hJZ8xYoBGFwzl+rhnw
	vi6nHFpZJvYr38U34eaz7FSZBiLkm7Umf58v3IOagW/ZljJ5YTNDBMMnI9P0Jzb+XhI66m344Q0Qo
	sKV1Ns5En7yqqNnP+Gf3/Ysb7/A0bB7sq395r+teq3BmtBqqSwtaOOy07mnVHRPvleMMwK2SZ1wcA
	WC/LT6jSx8AC0rfisPbvZNDODCk9cVvKRK3e/p7L2zOt8W+DS7pC7OXUWgY+QGnjBF7K8GOJzpZhJ
	+puvx0xg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdTFz-000000092w3-3Vyb;
	Fri, 23 Feb 2024 10:58:19 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdTFr-000000092v7-18xn
	for linux-nvme@lists.infradead.org;
	Fri, 23 Feb 2024 10:58:12 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 2FECC63425;
	Fri, 23 Feb 2024 10:58:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FC63C433F1;
	Fri, 23 Feb 2024 10:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708685889;
	bh=bBOxzJeZXf3FGE2KIvuBN1uYMCuFGGxjC+tNEqEO5fk=;
	h=From:To:Cc:Subject:Date:From;
	b=fXKXQmaO80j8aV2bNGu3blvW3r8Gl6N98OegPDNFOTfhNHmiNv6qGj3Cizr1g+MPo
	 6wuGn2u5tKrzcq0uvsVFUM+VHDYeyPL1Dv0SXZC6qfTwIvhMPF0XtdCDp1gquuWy1f
	 8VEnSNSIB+6YWtOK9rhUTjJBnL2KemIjUvxmpcVIYZFCwEespAUkZiXJRjyR+y3Q+u
	 ex07lQlmb/4J8a8iB2qN5pY99IHhWG71pR6A6k/Keb8CClLUrpvmX4hHUCyEcuQ4la
	 nSs7SPJQeoqBqa7/iEGjRfgRSsiWPofw4fDsjDEkLNynnaxOvPxbwAfl0iR0mkjMo4
	 Z4tL2JRVQGnLw==
From: hare@kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH] nvme: authentication error are always non-retryable
Date: Fri, 23 Feb 2024 11:58:04 +0100
Message-Id: <20240223105804.44473-1-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240223_025811_426657_C4889457 
X-CRM114-Status: GOOD (  13.59  )
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
 drivers/nvme/host/fabrics.c | 16 +++++++---------
 drivers/nvme/host/nvme.h    |  2 +-
 3 files changed, 11 insertions(+), 13 deletions(-)

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
index ab5ac219b70a..2b66fa5cd43f 100644
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
@@ -475,7 +475,6 @@ int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl)
 		if (ret) {
 			dev_warn(ctrl->device,
 				 "qid 0: authentication setup failed\n");
-			ret = NVME_SC_AUTH_REQUIRED;
 			goto out_free_data;
 		}
 		ret = nvme_auth_wait(ctrl, 0);
@@ -541,7 +540,7 @@ int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16 qid)
 		if (result & NVME_CONNECT_AUTHREQ_ASCR) {
 			dev_warn(ctrl->device,
 				 "qid 0: secure concatenation is not supported\n");
-			ret = NVME_SC_AUTH_REQUIRED;
+			ret = NVME_SC_AUTH_REQUIRED | NVME_SC_DNR;
 			goto out_free_data;
 		}
 		/* Authentication required */
@@ -549,13 +548,12 @@ int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16 qid)
 		if (ret) {
 			dev_warn(ctrl->device,
 				 "qid %d: authentication setup failed\n", qid);
-			ret = NVME_SC_AUTH_REQUIRED;
-		} else {
-			ret = nvme_auth_wait(ctrl, qid);
-			if (ret)
-				dev_warn(ctrl->device,
-					 "qid %u: authentication failed\n", qid);
+			goto out_free_data;
 		}
+		ret = nvme_auth_wait(ctrl, qid);
+		if (ret)
+			dev_warn(ctrl->device,
+				 "qid %u: authentication failed\n", qid);
 	}
 out_free_data:
 	kfree(data);
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


