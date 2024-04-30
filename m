Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DEB8C19F53
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Apr 2024 13:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IqmLcu21VKVleGdDKkyS5kWnZkHjeaB7QlqTWzxzX+Q=; b=JPSGCpyhNeRkLVouGw5CwAYbgx
	E+hhsrNwbcAbK/u51YUNMy9cuJn71SqF6l9rwG0+Vs7+hF84ntH2DGafGc4TpSyUNhSnQTf3OHYqG
	Yn9nedQgc3Yv2Uwi8+DTiZ+PSDhBUupbnq5OBCu0pCopCGASeVM/j0I3pH8RzIl4WTESiYwOTC7RE
	mtkIvq7s3g9VbO4ZAkKU4JTDECuSqgkyXEvIoJ4KRBKe0JgmRzhrzM85LxjdNNyCW68wHRxLSGOBs
	v8MnmFtRz7fcqInnFWseHrTrdH2lSeSIZkYpPjb9l8VzWh6NEGjxnIC1zqn0XiV0o7Q1fm6bNDih+
	SYZDR/hg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1nOx-00000006Uuv-3xRL;
	Tue, 30 Apr 2024 13:20:07 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1nOb-00000006UhD-3XPd
	for linux-nvme@lists.infradead.org;
	Tue, 30 Apr 2024 13:20:01 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8259E1F7E5;
	Tue, 30 Apr 2024 13:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714483177; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IqmLcu21VKVleGdDKkyS5kWnZkHjeaB7QlqTWzxzX+Q=;
	b=ri79Gfyt2hjCszVM2HXT7m6dJtRVBDt7pz+7Xz3DIr3rvgd6RFzaYp5snlcAeSOus6a4SP
	+asZDdC+KPTH9jAEfxJG5WkuQ/UcnkPZTyaHivCw8+lxR5ZTDSlWJfa4HfnBB2grD6jLxR
	fWMsci6J+HPxjoJ2/poLD9EaI3ItfZ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714483177;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IqmLcu21VKVleGdDKkyS5kWnZkHjeaB7QlqTWzxzX+Q=;
	b=Yp/18S0BUq6vlyHbUavon5SWh59FIXkm6fJ2fa7uSuc3dHni+GVvbLgBmWWQZ4Dtq5frh/
	FTYKNhgvLOTcprBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714483177; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IqmLcu21VKVleGdDKkyS5kWnZkHjeaB7QlqTWzxzX+Q=;
	b=ri79Gfyt2hjCszVM2HXT7m6dJtRVBDt7pz+7Xz3DIr3rvgd6RFzaYp5snlcAeSOus6a4SP
	+asZDdC+KPTH9jAEfxJG5WkuQ/UcnkPZTyaHivCw8+lxR5ZTDSlWJfa4HfnBB2grD6jLxR
	fWMsci6J+HPxjoJ2/poLD9EaI3ItfZ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714483177;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IqmLcu21VKVleGdDKkyS5kWnZkHjeaB7QlqTWzxzX+Q=;
	b=Yp/18S0BUq6vlyHbUavon5SWh59FIXkm6fJ2fa7uSuc3dHni+GVvbLgBmWWQZ4Dtq5frh/
	FTYKNhgvLOTcprBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 70A95133A7;
	Tue, 30 Apr 2024 13:19:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id z1EMGunvMGZ1MAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 30 Apr 2024 13:19:37 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v7 3/5] nvme: return kernel error codes for admin queue connect
Date: Tue, 30 Apr 2024 15:19:26 +0200
Message-ID: <20240430131928.29766-4-dwagner@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430131928.29766-1-dwagner@suse.de>
References: <20240430131928.29766-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240430_061946_215966_502659D9 
X-CRM114-Status: GOOD (  17.94  )
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

nvmf_connect_admin_queue returns NVMe error status codes and kernel
error codes. This mixes the different domains which makes maintainability
difficult.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/host/core.c    |  6 +++---
 drivers/nvme/host/fabrics.c | 31 +++++++++++++------------------
 drivers/nvme/host/nvme.h    |  2 +-
 3 files changed, 17 insertions(+), 22 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 504dc352c458..66387bcca8ae 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -383,14 +383,14 @@ static inline enum nvme_disposition nvme_decide_disposition(struct request *req)
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
index 1f0ea1f32d22..f7eaf9580b4f 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -428,12 +428,6 @@ static void nvmf_connect_cmd_prep(struct nvme_ctrl *ctrl, u16 qid,
  * fabrics-protocol connection of the NVMe Admin queue between the
  * host system device and the allocated NVMe controller on the
  * target system via a NVMe Fabrics "Connect" command.
- *
- * Return:
- *	0: success
- *	> 0: NVMe error status code
- *	< 0: Linux errno error code
- *
  */
 int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl)
 {
@@ -467,7 +461,7 @@ int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl)
 		if (result & NVME_CONNECT_AUTHREQ_ASCR) {
 			dev_warn(ctrl->device,
 				 "qid 0: secure concatenation is not supported\n");
-			ret = NVME_SC_AUTH_REQUIRED;
+			ret = -EOPNOTSUPP;
 			goto out_free_data;
 		}
 		/* Authentication required */
@@ -475,14 +469,14 @@ int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl)
 		if (ret) {
 			dev_warn(ctrl->device,
 				 "qid 0: authentication setup failed\n");
-			ret = NVME_SC_AUTH_REQUIRED;
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
+		} else
 			dev_info(ctrl->device,
 				 "qid 0: authenticated\n");
 	}
@@ -542,7 +536,7 @@ int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16 qid)
 		if (result & NVME_CONNECT_AUTHREQ_ASCR) {
 			dev_warn(ctrl->device,
 				 "qid 0: secure concatenation is not supported\n");
-			ret = NVME_SC_AUTH_REQUIRED;
+			ret = -EOPNOTSUPP;
 			goto out_free_data;
 		}
 		/* Authentication required */
@@ -550,12 +544,13 @@ int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16 qid)
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
+		}
+		ret = nvme_auth_wait(ctrl, qid);
+		if (ret) {
+			dev_warn(ctrl->device,
+				 "qid %u: authentication failed, error %d\n",
+				 qid, ret);
 		}
 	}
 out_free_data:
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index d0ed64dc7380..9b8904a476b8 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -1122,7 +1122,7 @@ static inline int nvme_auth_negotiate(struct nvme_ctrl *ctrl, int qid)
 }
 static inline int nvme_auth_wait(struct nvme_ctrl *ctrl, int qid)
 {
-	return NVME_SC_AUTH_REQUIRED;
+	return -EPROTONOSUPPORT;
 }
 static inline void nvme_auth_free(struct nvme_ctrl *ctrl) {};
 #endif
-- 
2.44.0


