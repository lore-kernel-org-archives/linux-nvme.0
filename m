Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ED14C678D4
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Mar 2023 09:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=09JyYZQRQ8ugij2/pSUWUfHvBlPvz33a7rVpeNw9+mY=; b=XJGtN0JoMdF1Sn30s/j8azJmEX
	Zkme+IWGL4FsSlrqXn94H5OwV0EPX73SeNbLlk8GD1ZvtoxgUOmntDgRXxsL1B1w+ecDKVkCP/+mZ
	N06GfX+o/rA2SPAmmtTbag0J0PSyMX0bUm1+Fyvx7C40/7NG5RWtXpX594aEAg6gYqes3KrUmitbF
	Tva1bwV57xz7pYsQPk2tB7AUM8YBOeJPgdJYq7N50TTrB7cL/lohi/VKafQ7kaU99K+11iiwq7FwJ
	ZGQzP0vGJTtvJDdR/iZlkrlLhTgVpNss6c28tWdfQmkgS8sVU/u/mHwSKTe74+fe6k8r2ezgBNapb
	x/1KvcTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZ7DU-00C69W-MX; Mon, 06 Mar 2023 09:33:12 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZ7D8-00C62g-0P
	for linux-nvme@lists.infradead.org; Mon, 06 Mar 2023 09:32:53 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CAC3C21A7A;
	Mon,  6 Mar 2023 09:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1678095168; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=09JyYZQRQ8ugij2/pSUWUfHvBlPvz33a7rVpeNw9+mY=;
	b=Sn3Rns2eQaBEJ8wM+0kwWYDMgca6FNEa2SscDaE0tfoNlnZWqAdMOnyRfRWhfvrJdkSGF5
	XIV9VJWnjKMe/piN91nlwgfNI+5PcJTQTD1p235f+fnAPExrfQfmGslFtuXg4Y7iE85cBk
	1UUBrzS63WYQUySrn5/V+21C5yR50VU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1678095168;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=09JyYZQRQ8ugij2/pSUWUfHvBlPvz33a7rVpeNw9+mY=;
	b=SwUGaQ4Iz71Aoeb3+ar5fhrVyZbQbfbQYw7XwpgANG1W5uUYdP50nqsj+uYw9BF8XJMxAA
	GmYyw7p+fya6M+AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BE90213513;
	Mon,  6 Mar 2023 09:32:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id y5GELkCzBWR4YAAAMHmgww
	(envelope-from <dwagner@suse.de>); Mon, 06 Mar 2023 09:32:48 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: Daniel Wagner <dwagner@suse.de>
Subject: [RFC v2 3/6] nvme-tcp: move error and connect work to nvme_ctrl
Date: Mon,  6 Mar 2023 10:32:41 +0100
Message-Id: <20230306093244.20775-4-dwagner@suse.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230306093244.20775-1-dwagner@suse.de>
References: <20230306093244.20775-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230306_013250_219925_7CCDD4AD 
X-CRM114-Status: GOOD (  13.20  )
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

Move common data structures for fabrics to nvme_ctrl so that we are able
to use them in fabrcis.c later.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/host/nvme.h |  3 +++
 drivers/nvme/host/tcp.c  | 24 ++++++++++--------------
 2 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index bf46f122e9e1..5aa30b00dd17 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -339,6 +339,9 @@ struct nvme_ctrl {
 	struct work_struct ana_work;
 #endif
 
+	struct work_struct	err_work;
+	struct delayed_work	connect_work;
+
 #ifdef CONFIG_NVME_AUTH
 	struct work_struct dhchap_auth_work;
 	struct mutex dhchap_auth_mutex;
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index d6100a787d39..75d9144faa1a 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -165,8 +165,6 @@ struct nvme_tcp_ctrl {
 	struct sockaddr_storage src_addr;
 	struct nvme_ctrl	ctrl;
 
-	struct work_struct	err_work;
-	struct delayed_work	connect_work;
 	struct nvme_tcp_request async_req;
 	u32			io_queues[HCTX_MAX_TYPES];
 };
@@ -526,7 +524,7 @@ static void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl)
 		return;
 
 	dev_warn(ctrl->device, "starting error recovery\n");
-	queue_work(nvme_reset_wq, &to_tcp_ctrl(ctrl)->err_work);
+	queue_work(nvme_reset_wq, &ctrl->err_work);
 }
 
 static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
@@ -2019,7 +2017,7 @@ static void nvme_tcp_reconnect_or_remove(struct nvme_ctrl *ctrl)
 	if (nvmf_should_reconnect(ctrl)) {
 		dev_info(ctrl->device, "Reconnecting in %d seconds...\n",
 			ctrl->opts->reconnect_delay);
-		queue_delayed_work(nvme_wq, &to_tcp_ctrl(ctrl)->connect_work,
+		queue_delayed_work(nvme_wq, &ctrl->connect_work,
 				ctrl->opts->reconnect_delay * HZ);
 	} else {
 		dev_info(ctrl->device, "Removing controller...\n");
@@ -2101,9 +2099,8 @@ static int nvme_tcp_setup_ctrl(struct nvme_ctrl *ctrl, bool new)
 
 static void nvme_tcp_reconnect_ctrl_work(struct work_struct *work)
 {
-	struct nvme_tcp_ctrl *tcp_ctrl = container_of(to_delayed_work(work),
-			struct nvme_tcp_ctrl, connect_work);
-	struct nvme_ctrl *ctrl = &tcp_ctrl->ctrl;
+	struct nvme_ctrl *ctrl = container_of(to_delayed_work(work),
+			struct nvme_ctrl, connect_work);
 
 	++ctrl->nr_reconnects;
 
@@ -2125,9 +2122,8 @@ static void nvme_tcp_reconnect_ctrl_work(struct work_struct *work)
 
 static void nvme_tcp_error_recovery_work(struct work_struct *work)
 {
-	struct nvme_tcp_ctrl *tcp_ctrl = container_of(work,
-				struct nvme_tcp_ctrl, err_work);
-	struct nvme_ctrl *ctrl = &tcp_ctrl->ctrl;
+	struct nvme_ctrl *ctrl = container_of(work,
+				struct nvme_ctrl, err_work);
 
 	nvme_stop_keep_alive(ctrl);
 	flush_work(&ctrl->async_event_work);
@@ -2188,8 +2184,8 @@ static void nvme_reset_ctrl_work(struct work_struct *work)
 
 static void nvme_tcp_stop_ctrl(struct nvme_ctrl *ctrl)
 {
-	flush_work(&to_tcp_ctrl(ctrl)->err_work);
-	cancel_delayed_work_sync(&to_tcp_ctrl(ctrl)->connect_work);
+	flush_work(&ctrl->err_work);
+	cancel_delayed_work_sync(&ctrl->connect_work);
 }
 
 static void nvme_tcp_free_ctrl(struct nvme_ctrl *nctrl)
@@ -2569,9 +2565,9 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
 	ctrl->ctrl.sqsize = opts->queue_size - 1;
 	ctrl->ctrl.kato = opts->kato;
 
-	INIT_DELAYED_WORK(&ctrl->connect_work,
+	INIT_DELAYED_WORK(&ctrl->ctrl.connect_work,
 			nvme_tcp_reconnect_ctrl_work);
-	INIT_WORK(&ctrl->err_work, nvme_tcp_error_recovery_work);
+	INIT_WORK(&ctrl->ctrl.err_work, nvme_tcp_error_recovery_work);
 	INIT_WORK(&ctrl->ctrl.reset_work, nvme_reset_ctrl_work);
 
 	if (!(opts->mask & NVMF_OPT_TRSVCID)) {
-- 
2.39.2


