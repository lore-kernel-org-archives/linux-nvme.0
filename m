Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D566C43334
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Jun 2022 06:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ooqs+GJyf8ntXL5WK5IanFgcRXaSVchI8htgUaBHD0E=; b=HcsSelNkBYELeN89GuNrn7hIoD
	pIZdKCJU/F6zFRFI4hoKSh3WeUfQhodjqjcuSzHIlq8wrDjsIpH/ubPhlykV4NJtuwJh3l9EZvYgk
	0QWRswyFh+X4JWHdcRllVeVbO0yEu6JjUi+PpRtfZvGmxJh9nj0Dkk61TMWbcGIJdXjU/hgFvOgtc
	ybABumsfZj/HeHD7M4DHWIqTxKtldftE8jIzvLhIEzF9tiXDJgUCMlJ7jAv2jpm0sVeYruf91ysX1
	ia5IOXsk728+tnLFYV6TkAUfYSmCEBRG7arWNkVvL6XvI/FCu0LcL/Lg1seSrEDVfkr66ayS4GEr1
	IpnZ134g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o4GAV-00DdhK-II; Thu, 23 Jun 2022 06:18:19 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o4G9v-00DdPa-VB
	for linux-nvme@lists.infradead.org; Thu, 23 Jun 2022 06:17:46 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id 07C8821C8B;
	Thu, 23 Jun 2022 06:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1655965056; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ooqs+GJyf8ntXL5WK5IanFgcRXaSVchI8htgUaBHD0E=;
	b=sVB+0ZLIkbpY/pKaOTJXgyKDQMYVHaFPoqwzTzeNkgO/cM1aNzwWPd08NE55D98nSVxbu4
	fSZjyAgUMu02dEndMVJ/RvfqF+4k0TDJvhxdxuXrU3Z7RNkRTXMkZuvWBpZgTYQIleaerj
	NlSxK53PVzJkzuIFnG1arvwCbkNxRPM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1655965056;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ooqs+GJyf8ntXL5WK5IanFgcRXaSVchI8htgUaBHD0E=;
	b=zginOgQCZIWVY/E7Tnnx1ApMY1BRerOi4gApJ9Xf2Xq0AHx4xW1yfLU2SHdjmPGbEeuJGy
	JbZ/KcWkCsQozaBg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id F2A3B2C161;
	Thu, 23 Jun 2022 06:17:35 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 421645194D7E; Thu, 23 Jun 2022 08:17:35 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 11/11] nvmet-auth: expire authentication sessions
Date: Thu, 23 Jun 2022 08:17:30 +0200
Message-Id: <20220623061730.51490-12-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220623061730.51490-1-hare@suse.de>
References: <20220623061730.51490-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220622_231744_204783_C26BE879 
X-CRM114-Status: GOOD (  14.18  )
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

Each authentication step is required to be completed within the
KATO interval (or two minutes if not set). So add a workqueue function
to reset the transaction ID and the expected next protocol step;
this will automatically the next authentication command referring
to the terminated authentication.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/target/auth.c             |  1 +
 drivers/nvme/target/fabrics-cmd-auth.c | 20 +++++++++++++++++++-
 drivers/nvme/target/nvmet.h            |  1 +
 3 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index d5624bdf834b..bf92435c783c 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -218,6 +218,7 @@ int nvmet_setup_auth(struct nvmet_ctrl *ctrl)
 
 void nvmet_auth_sq_free(struct nvmet_sq *sq)
 {
+	cancel_delayed_work(&sq->auth_expired_work);
 	kfree(sq->dhchap_c1);
 	sq->dhchap_c1 = NULL;
 	kfree(sq->dhchap_c2);
diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
index 5b1be7e607e2..cc56e8c821ce 100644
--- a/drivers/nvme/target/fabrics-cmd-auth.c
+++ b/drivers/nvme/target/fabrics-cmd-auth.c
@@ -12,11 +12,24 @@
 #include <crypto/kpp.h>
 #include "nvmet.h"
 
+static void nvmet_auth_expired_work(struct work_struct *work)
+{
+	struct nvmet_sq *sq = container_of(to_delayed_work(work),
+			struct nvmet_sq, auth_expired_work);
+
+	pr_debug("%s: ctrl %d qid %d transaction %u expired, resetting\n",
+		 __func__, sq->ctrl->cntlid, sq->qid, sq->dhchap_tid);
+	sq->dhchap_step = NVME_AUTH_DHCHAP_MESSAGE_NEGOTIATE;
+	sq->dhchap_tid = -1;
+}
+
 void nvmet_init_auth(struct nvmet_ctrl *ctrl, struct nvmet_req *req)
 {
 	u32 result = le32_to_cpu(req->cqe->result.u32);
 
 	/* Initialize in-band authentication */
+	INIT_DELAYED_WORK(&req->sq->auth_expired_work,
+			  nvmet_auth_expired_work);
 	req->sq->authenticated = false;
 	req->sq->dhchap_step = NVME_AUTH_DHCHAP_MESSAGE_NEGOTIATE;
 	result |= (u32)NVME_CONNECT_AUTHREQ_ATR << 16;
@@ -333,8 +346,13 @@ void nvmet_execute_auth_send(struct nvmet_req *req)
 	req->cqe->result.u64 = 0;
 	nvmet_req_complete(req, status);
 	if (req->sq->dhchap_step != NVME_AUTH_DHCHAP_MESSAGE_SUCCESS2 &&
-	    req->sq->dhchap_step != NVME_AUTH_DHCHAP_MESSAGE_FAILURE2)
+	    req->sq->dhchap_step != NVME_AUTH_DHCHAP_MESSAGE_FAILURE2) {
+		unsigned long auth_expire_secs = ctrl->kato ? ctrl->kato : 120;
+
+		mod_delayed_work(system_wq, &req->sq->auth_expired_work,
+				 auth_expire_secs * HZ);
 		return;
+	}
 	/* Final states, clear up variables */
 	nvmet_auth_sq_free(req->sq);
 	if (req->sq->dhchap_step == NVME_AUTH_DHCHAP_MESSAGE_FAILURE2)
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 8b239aec3ca2..829fb1d78ee1 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -109,6 +109,7 @@ struct nvmet_sq {
 	u32			sqhd;
 	bool			sqhd_disabled;
 #ifdef CONFIG_NVME_TARGET_AUTH
+	struct delayed_work	auth_expired_work;
 	bool			authenticated;
 	u16			dhchap_tid;
 	u16			dhchap_status;
-- 
2.29.2


