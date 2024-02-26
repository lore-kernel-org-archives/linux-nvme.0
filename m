Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51FC1C5478C
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Feb 2024 08:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=DGLol2wZoiNqVHSoNSQgGni1DQCHlWDKIhER1IxMFj0=; b=gcJIO8RodEIXvVlynrjo47TBbf
	Tts8ySFmz6cGwdFIZcjgQcmztRja9uDUCN3ZNZhrICCT65t+Ij7cOQWHCd/0WRetU9N9Bv8YOSMX1
	ZbLb+NB3dTSq/JhhVb2DdKb2FjkOiOJ3Ztrz++QwRqwaKjG2KW9CJYEPgW5s8VicQ6wC1bZQ1b7Ya
	dIHdY6zwobToZ5FflkXbMgYYUlKhigWEcF4EKxZGW1RZ+UbKAn/SYn3U/P3lg/hEwSh/cajhGj+Sv
	nm8hWF5T2B9kVSqcmMNztvFMUuvsQ+aH5/nfYeb+Rmsq0SqzhQRXMKkgigvPq6BTeHrU3Efz/5pBa
	oxDxFE1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1reW0d-0000000GvCC-2dJ2;
	Mon, 26 Feb 2024 08:06:47 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1reW0Z-0000000GvBc-3d3I
	for linux-nvme@lists.infradead.org;
	Mon, 26 Feb 2024 08:06:45 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 8C1A760F21;
	Mon, 26 Feb 2024 08:06:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4489C433C7;
	Mon, 26 Feb 2024 08:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708934802;
	bh=GsTRMbFJ2quOdtIE0q9AHFZDtqILoz7QUkC4HBYXvas=;
	h=From:To:Cc:Subject:Date:From;
	b=NWrZSp06FdlNIKbzbj+TShiljPpMgA6Md7Zm019Lu86Y6w7bIPCGEYICQEZDYWaaL
	 oWS1eEUcH1DohkwbmDW75G2HAS8dI3o6Op/nk+nrHBr2o2f0oFxjHJ6oqGeAifqpoK
	 m9oh2yKC2peNwp8Z9dwdlC+2R4MDDVrZaDbU0GWbjm9w2Evbt+1yIbBecs4vEgNE8c
	 160mVlkBc5zweW15xwP2j5wgW+qRFDL8FPJM/JBMFLhe93ajyJjFks+DTX1qmMsVuA
	 f9sUzH5/BbbPfyOZz6Js08rWe3chCmxrCKl3S0QB6OqyRJslg7O/JSxNlpfAD/lrYX
	 Nl3VKazzEMixQ==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCHv2] nvme: authentication error are always non-retryable
Date: Mon, 26 Feb 2024 09:06:28 +0100
Message-Id: <20240226080628.21220-1-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240226_000644_078943_A86798C1 
X-CRM114-Status: GOOD (  13.11  )
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

Any authentication errors which are generated internally are always
non-retryable, so set the DNR bit to ensure they are not retried.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/core.c    |  6 +++---
 drivers/nvme/host/fabrics.c | 22 ++++++++++++----------
 drivers/nvme/host/nvme.h    |  2 +-
 3 files changed, 16 insertions(+), 14 deletions(-)

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
index ab5ac219b70a..a7d0d2841b38 100644
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
@@ -475,13 +475,14 @@ int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl)
 		if (ret) {
 			dev_warn(ctrl->device,
 				 "qid 0: authentication setup failed\n");
-			ret = NVME_SC_AUTH_REQUIRED;
+			ret = NVME_SC_AUTH_REQUIRED | NVME_SC_DNR;
 			goto out_free_data;
 		}
 		ret = nvme_auth_wait(ctrl, 0);
 		if (ret)
 			dev_warn(ctrl->device,
-				 "qid 0: authentication failed\n");
+				 "qid 0: authentication failed, error %d\n",
+				 ret);
 		else
 			dev_info(ctrl->device,
 				 "qid 0: authenticated\n");
@@ -541,7 +542,7 @@ int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16 qid)
 		if (result & NVME_CONNECT_AUTHREQ_ASCR) {
 			dev_warn(ctrl->device,
 				 "qid 0: secure concatenation is not supported\n");
-			ret = NVME_SC_AUTH_REQUIRED;
+			ret = NVME_SC_AUTH_REQUIRED | NVME_SC_DNR;
 			goto out_free_data;
 		}
 		/* Authentication required */
@@ -549,13 +550,14 @@ int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16 qid)
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
 		}
+		ret = nvme_auth_wait(ctrl, qid);
+		if (ret)
+			dev_warn(ctrl->device,
+				 "qid %u: authentication failed, error %d\n",
+				 qid, ret);
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


