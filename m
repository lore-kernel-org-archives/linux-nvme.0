Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42FD7CD1284
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Apr 2024 09:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XIqRfgEy/L6lYO+lVF7E1EL2Hg3bqx5jfUAwzOfn4PQ=; b=1LYgMFjHuyKXGOnzMbR98WS34C
	rPCIs1YT1X5WMXnryi2s/ypvpfXAKb907ZZgNz+C72RKQpPFru6mUayt3R2Ha2o15giwW6bvAyQH6
	00XMsccpEt8CF7FXwV7WILVQMgAArGYXQ2Skp9V2aPnQhjgNLeuxfiEF9hf9Vp9XXJ/7d/ipXrG9+
	qoPMhb+F98eqvGga1mpry9KUSziT7hemltt70smpxtqPlifrByPj+yAFKfUnSa2yKJEJKYh0xTdcE
	gNDaxwA2ZW7deBHX3sWHIbzk8AKNtrlcanPmEMQRbX2lOZjDWg/0fis8X0DO7ul1DThEjLcvxVOsJ
	QL8xyr9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ru7t4-00000001ERp-40Ag;
	Tue, 09 Apr 2024 09:35:30 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ru7ss-00000001EMq-0FId
	for linux-nvme@lists.infradead.org;
	Tue, 09 Apr 2024 09:35:23 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B5AED338F3;
	Tue,  9 Apr 2024 09:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712655316; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XIqRfgEy/L6lYO+lVF7E1EL2Hg3bqx5jfUAwzOfn4PQ=;
	b=fD+SdJZEQKcGad53sw8FDngnjd+m7WP2kEoYZ6JNVfTKx0zlGPub1V1MXKcns3eBrhBGwR
	pFS34CCVGYdX0XdjQ4/PuGHFmZzUoXqNZtccm1S9Pg8LUH8Qe26r0EIH3bKUd+u/IhryPD
	KFFzUMcK+RBtPEc9p1Z3QsqeotIEq4A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712655316;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XIqRfgEy/L6lYO+lVF7E1EL2Hg3bqx5jfUAwzOfn4PQ=;
	b=UW57XE38XurvQQ7LB0UHqmz4VUZ1pZlUXFbfblMHl3JwspHZo7s8loNnnTnSiU71z6WoUq
	NNQjaF4pFwpWEODQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712655316; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XIqRfgEy/L6lYO+lVF7E1EL2Hg3bqx5jfUAwzOfn4PQ=;
	b=fD+SdJZEQKcGad53sw8FDngnjd+m7WP2kEoYZ6JNVfTKx0zlGPub1V1MXKcns3eBrhBGwR
	pFS34CCVGYdX0XdjQ4/PuGHFmZzUoXqNZtccm1S9Pg8LUH8Qe26r0EIH3bKUd+u/IhryPD
	KFFzUMcK+RBtPEc9p1Z3QsqeotIEq4A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712655316;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XIqRfgEy/L6lYO+lVF7E1EL2Hg3bqx5jfUAwzOfn4PQ=;
	b=UW57XE38XurvQQ7LB0UHqmz4VUZ1pZlUXFbfblMHl3JwspHZo7s8loNnnTnSiU71z6WoUq
	NNQjaF4pFwpWEODQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id A39C11332F;
	Tue,  9 Apr 2024 09:35:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id jpZtJtQLFWarRwAAn2gu4w
	(envelope-from <dwagner@suse.de>); Tue, 09 Apr 2024 09:35:16 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v5 3/6] nvme-tcp: short-circuit reconnect retries
Date: Tue,  9 Apr 2024 11:35:07 +0200
Message-ID: <20240409093510.12321-4-dwagner@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240409093510.12321-1-dwagner@suse.de>
References: <20240409093510.12321-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240409_023518_282377_6B261AEC 
X-CRM114-Status: GOOD (  21.37  )
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

Returning an nvme status from nvme_tcp_setup_ctrl() indicates that the
association was established and we have received a status from the
controller; consequently we should honour the DNR bit. If not any future
reconnect attempts will just return the same error, so we can
short-circuit the reconnect attempts and fail the connection directly.

Signed-off-by: Hannes Reinecke <hare@suse.de>
[dwagner: add helper to decide to reconnect]
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/host/nvme.h | 24 ++++++++++++++++++++++++
 drivers/nvme/host/tcp.c  | 23 +++++++++++++++--------
 2 files changed, 39 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 9b8904a476b8..dfe103283a3d 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -701,6 +701,30 @@ static inline bool nvme_is_path_error(u16 status)
 	return (status & 0x700) == 0x300;
 }
 
+/*
+ * Evaluate the status information returned by the LLDD in order to
+ * decided if a reconnect attempt should be scheduled.
+ *
+ * There are two cases where no reconnect attempt should be attempted:
+ *
+ * 1) The LLDD reports an negative status. There was an error (e.g. no
+ *    memory) on the host side and thus abort the operation.
+ *    Note, there are exception such as ENOTCONN which is
+ *    not an internal driver error, thus we filter these errors
+ *    out and retry later.
+ * 2) The DNR bit is set and the specification states no further
+ *    connect attempts with the same set of paramenters should be
+ *    attempted.
+ */
+static inline bool nvme_ctrl_reconnect(int status)
+{
+	if (status < 0 && status != -ENOTCONN)
+		return false;
+	else if (status > 0 && (status & NVME_SC_DNR))
+		return false;
+	return true;
+}
+
 /*
  * Fill in the status and result information from the CQE, and then figure out
  * if blk-mq will need to use IPI magic to complete the request, and if yes do
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index fdbcdcedcee9..7e25a96e9870 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2155,9 +2155,11 @@ static void nvme_tcp_teardown_io_queues(struct nvme_ctrl *ctrl,
 	nvme_tcp_destroy_io_queues(ctrl, remove);
 }
 
-static void nvme_tcp_reconnect_or_remove(struct nvme_ctrl *ctrl)
+static void nvme_tcp_reconnect_or_remove(struct nvme_ctrl *ctrl,
+		int status)
 {
 	enum nvme_ctrl_state state = nvme_ctrl_state(ctrl);
+	bool recon = nvme_ctrl_reconnect(status);
 
 	/* If we are resetting/deleting then do nothing */
 	if (state != NVME_CTRL_CONNECTING) {
@@ -2165,13 +2167,14 @@ static void nvme_tcp_reconnect_or_remove(struct nvme_ctrl *ctrl)
 		return;
 	}
 
-	if (nvmf_should_reconnect(ctrl)) {
+	if (recon && nvmf_should_reconnect(ctrl)) {
 		dev_info(ctrl->device, "Reconnecting in %d seconds...\n",
 			ctrl->opts->reconnect_delay);
 		queue_delayed_work(nvme_wq, &to_tcp_ctrl(ctrl)->connect_work,
 				ctrl->opts->reconnect_delay * HZ);
 	} else {
-		dev_info(ctrl->device, "Removing controller...\n");
+		dev_info(ctrl->device, "Removing controller (%d)...\n",
+			 status);
 		nvme_delete_ctrl(ctrl);
 	}
 }
@@ -2252,10 +2255,12 @@ static void nvme_tcp_reconnect_ctrl_work(struct work_struct *work)
 	struct nvme_tcp_ctrl *tcp_ctrl = container_of(to_delayed_work(work),
 			struct nvme_tcp_ctrl, connect_work);
 	struct nvme_ctrl *ctrl = &tcp_ctrl->ctrl;
+	int ret;
 
 	++ctrl->nr_reconnects;
 
-	if (nvme_tcp_setup_ctrl(ctrl, false))
+	ret = nvme_tcp_setup_ctrl(ctrl, false);
+	if (ret)
 		goto requeue;
 
 	dev_info(ctrl->device, "Successfully reconnected (%d attempt)\n",
@@ -2268,7 +2273,7 @@ static void nvme_tcp_reconnect_ctrl_work(struct work_struct *work)
 requeue:
 	dev_info(ctrl->device, "Failed reconnect attempt %d\n",
 			ctrl->nr_reconnects);
-	nvme_tcp_reconnect_or_remove(ctrl);
+	nvme_tcp_reconnect_or_remove(ctrl, ret);
 }
 
 static void nvme_tcp_error_recovery_work(struct work_struct *work)
@@ -2295,7 +2300,7 @@ static void nvme_tcp_error_recovery_work(struct work_struct *work)
 		return;
 	}
 
-	nvme_tcp_reconnect_or_remove(ctrl);
+	nvme_tcp_reconnect_or_remove(ctrl, -ENOTCONN);
 }
 
 static void nvme_tcp_teardown_ctrl(struct nvme_ctrl *ctrl, bool shutdown)
@@ -2315,6 +2320,7 @@ static void nvme_reset_ctrl_work(struct work_struct *work)
 {
 	struct nvme_ctrl *ctrl =
 		container_of(work, struct nvme_ctrl, reset_work);
+	int ret;
 
 	nvme_stop_ctrl(ctrl);
 	nvme_tcp_teardown_ctrl(ctrl, false);
@@ -2328,14 +2334,15 @@ static void nvme_reset_ctrl_work(struct work_struct *work)
 		return;
 	}
 
-	if (nvme_tcp_setup_ctrl(ctrl, false))
+	ret = nvme_tcp_setup_ctrl(ctrl, false);
+	if (ret)
 		goto out_fail;
 
 	return;
 
 out_fail:
 	++ctrl->nr_reconnects;
-	nvme_tcp_reconnect_or_remove(ctrl);
+	nvme_tcp_reconnect_or_remove(ctrl, ret);
 }
 
 static void nvme_tcp_stop_ctrl(struct nvme_ctrl *ctrl)
-- 
2.44.0


