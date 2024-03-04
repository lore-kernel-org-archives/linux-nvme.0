Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 197D7C54E4A
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Mar 2024 16:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vLtcjlvrwoa9mW3sD3lbVLi4AeeGaJBT2U6OInUBd9M=; b=m9udUrGdjP2e5+JHfp5XCAp4+F
	e4GcbAc6oAZ+dOKvOpTDHUy4/2BEqvLbRSXZbgktbPCPIDHFSf8+gix6qp4rgowHW0fm7yj0RGER2
	ddqzCCNU9Zxxlmo1N2KDUM6zCgifOQxXdKT5c8wR7U+XF6mdCNzSl9olaGJ7Upv2005UkK/UE2KMO
	+Hyq4sV7kvqHtDHJ2iFwA6GGgfqaY9jtF8KwFVdf7Fa4lImiG8jbb+WcJW8oUIIuxsjXcIT2WNAvE
	VE0GzkCLduTld86Z1SP24EjYbbfBRUUfqR3H2R8eYr0ICXgb/yOwEOeSej+PEadZ68tdkwWJ0jVTe
	7U8ybkPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhAtZ-00000009lKk-1CoI;
	Mon, 04 Mar 2024 16:10:29 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhAtP-00000009lHY-0CQo
	for linux-nvme@lists.infradead.org;
	Mon, 04 Mar 2024 16:10:24 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F0BD27675C;
	Mon,  4 Mar 2024 16:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709568617; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vLtcjlvrwoa9mW3sD3lbVLi4AeeGaJBT2U6OInUBd9M=;
	b=xT5I5TXnOU6R0RFLI0Do++YDmax2EgctW0FD0H+8X4mirzyvigQ/TIwaWgvr+uCOdP2Hnq
	/oKORn46Nnj3uBy4nGVHXeUDQwFKh6JqNQqy9LkL3GhDaxXFYZe5deAD+0GnCxG2hiONSl
	7z6fSLGmf6iywLEi5GhO+DWZ9kOy0CU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709568617;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vLtcjlvrwoa9mW3sD3lbVLi4AeeGaJBT2U6OInUBd9M=;
	b=efwqzRHYEpV4PLKMReB7JrykYUzvnV3GMJoqd6+lEb9BPhKPHIAYosRaoub3y0bWOJD+SO
	NWKSk2T5Av8WWzBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709568616; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vLtcjlvrwoa9mW3sD3lbVLi4AeeGaJBT2U6OInUBd9M=;
	b=UJCAiWgAvvg7PIUXijGUv7TJOJNlhRUJ99DiCWNX9VI43Hf4dcLw43pbiqMTQn1G4UFxSc
	lnHJPyB/f+AtiSMzypZ5c5hyXLVxCvAJ8VPVjWvvSG+eOYINZ0vvB/l/UUTRyC5mZvUgz1
	p8fVME1VSA05O9SXGc1qNRanoj2qSYI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709568616;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vLtcjlvrwoa9mW3sD3lbVLi4AeeGaJBT2U6OInUBd9M=;
	b=tiOSyjICZmDeN8B3xB+f2EKWTGp6kTk0vd768t7WX3lOuJ4NkTb1h6bglPNJPIZkQUZ/Rv
	fRXTg5BtNxl6iIAA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id DC80C139C6;
	Mon,  4 Mar 2024 16:10:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 0oMqNGjy5WUnegAAn2gu4w
	(envelope-from <dwagner@suse.de>); Mon, 04 Mar 2024 16:10:16 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <keith.busch@wdc.com>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	James Smart <jsmart2021@gmail.com>,
	Chao Leng <lengchao@huawei.com>
Subject: [PATCH v2 1/2] nvme-tcp: short-circuit reconnect retries
Date: Mon,  4 Mar 2024 17:10:05 +0100
Message-ID: <20240304161006.19328-2-dwagner@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240304161006.19328-1-dwagner@suse.de>
References: <20240304161006.19328-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=UJCAiWgA;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=tiOSyjIC
X-Spamd-Result: default: False [4.69 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 R_MISSING_CHARSET(2.50)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[grimberg.me,wdc.com,suse.de,lists.infradead.org,gmail.com,huawei.com];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[12.06%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: F0BD27675C
X-Spamd-Bar: ++++
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240304_081019_686229_FDDF7916 
X-CRM114-Status: GOOD (  15.04  )
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

Returning an nvme status from nvme_tcp_setup_ctrl() indicates
that the association was established and we have received a status
from the controller; consequently we should honour the DNR bit.
If not any future reconnect attempts will just return the same error, so
we can short-circuit the reconnect attempts and fail the connection
directly.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/tcp.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 3b20c5ed033f..6b5f0b5f7fd3 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2149,9 +2149,10 @@ static void nvme_tcp_teardown_io_queues(struct nvme_ctrl *ctrl,
 	nvme_tcp_destroy_io_queues(ctrl, remove);
 }
 
-static void nvme_tcp_reconnect_or_remove(struct nvme_ctrl *ctrl)
+static void nvme_tcp_reconnect_or_remove(struct nvme_ctrl *ctrl, int status)
 {
 	enum nvme_ctrl_state state = nvme_ctrl_state(ctrl);
+	bool recon = status > 0 && (status & NVME_SC_DNR) ? false : true;
 
 	/* If we are resetting/deleting then do nothing */
 	if (state != NVME_CTRL_CONNECTING) {
@@ -2159,13 +2160,13 @@ static void nvme_tcp_reconnect_or_remove(struct nvme_ctrl *ctrl)
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
+		dev_info(ctrl->device, "Removing controller (%d)...\n", status);
 		nvme_delete_ctrl(ctrl);
 	}
 }
@@ -2246,10 +2247,12 @@ static void nvme_tcp_reconnect_ctrl_work(struct work_struct *work)
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
@@ -2262,7 +2265,7 @@ static void nvme_tcp_reconnect_ctrl_work(struct work_struct *work)
 requeue:
 	dev_info(ctrl->device, "Failed reconnect attempt %d\n",
 			ctrl->nr_reconnects);
-	nvme_tcp_reconnect_or_remove(ctrl);
+	nvme_tcp_reconnect_or_remove(ctrl, ret);
 }
 
 static void nvme_tcp_error_recovery_work(struct work_struct *work)
@@ -2289,7 +2292,7 @@ static void nvme_tcp_error_recovery_work(struct work_struct *work)
 		return;
 	}
 
-	nvme_tcp_reconnect_or_remove(ctrl);
+	nvme_tcp_reconnect_or_remove(ctrl, -ENOTCONN);
 }
 
 static void nvme_tcp_teardown_ctrl(struct nvme_ctrl *ctrl, bool shutdown)
@@ -2309,6 +2312,7 @@ static void nvme_reset_ctrl_work(struct work_struct *work)
 {
 	struct nvme_ctrl *ctrl =
 		container_of(work, struct nvme_ctrl, reset_work);
+	int ret;
 
 	nvme_stop_ctrl(ctrl);
 	nvme_tcp_teardown_ctrl(ctrl, false);
@@ -2322,14 +2326,15 @@ static void nvme_reset_ctrl_work(struct work_struct *work)
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


