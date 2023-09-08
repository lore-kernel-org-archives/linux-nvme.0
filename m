Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC06DEE57ED
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Sep 2023 10:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QQWgfw5I+IZ7vJ7tZ82vJNLkJaEDut8m0q/uLaDf34k=; b=sZuRmlvKg9BEp1uPdNP3expDuG
	5CMP1WSVrlT072jH2RfSZIKZdpg3SLlUTiOnMLE8YFxg2mzjr+NjV9L94Cf32F80JWnPicVN9pVVe
	69Lw8E4epzsO3y97UZkWspx1XV8yQL+ZdlzUbUxMoLnE1gdTHaqOOJPSKBmxoc6Me9utueziNdEO9
	ae56KhGhaSL0vyRy6qwZmRHgnUEntLqqCPBIyLmXl9gpGAVcnIqTOncEzitqupXg/OnOx2ncTimrz
	2vawGlFLIdweev6Q2D6pJTmm9TG9RQh7N42RbiaeHwGQi2kwem+SbIE97kMKsvN4DzxhuZezReaGn
	7fcMfVbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qeYIR-00DRLR-35;
	Fri, 08 Sep 2023 10:01:03 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qeYIM-00DRIO-0d
	for linux-nvme@lists.infradead.org;
	Fri, 08 Sep 2023 10:01:00 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id EE775219CC;
	Fri,  8 Sep 2023 10:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1694167253; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QQWgfw5I+IZ7vJ7tZ82vJNLkJaEDut8m0q/uLaDf34k=;
	b=KvQHJjJAJScdpWk8y5YjBQODrLvt/gsehB8WtA/fUpBATwAMreUJ1rHs5dBTyd6cbuhZxe
	6Dm5enNlSB3jFokETLzNBHVOI66Q+BqMP/jeUTkM3fGciZ7GwjFgBh+Fw4UXd0+EAJRL4v
	bPrmoW5OjdOgCEaS2vlW0HoejwuqcU8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1694167253;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QQWgfw5I+IZ7vJ7tZ82vJNLkJaEDut8m0q/uLaDf34k=;
	b=2uiNaNbUd5LeoU1jgvwkJU+mD3zFmjEajAovqNA9bXeDxQwXtcQOZvSO5r98x7ujMd+VKs
	cDn7V2yGcoyFe/AA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id DB9392C146;
	Fri,  8 Sep 2023 10:00:52 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id D77C251CC67F; Fri,  8 Sep 2023 12:00:52 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 2/3] nvme-tcp: make 'err_work' a delayed work
Date: Fri,  8 Sep 2023 12:00:48 +0200
Message-Id: <20230908100049.80809-3-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230908100049.80809-1-hare@suse.de>
References: <20230908100049.80809-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230908_030058_379884_97DED00F 
X-CRM114-Status: GOOD (  13.95  )
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

Move 'err_work' to a delayed work such that the error recovery
can be invoked at a later time.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/tcp.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 1faef1cf5c94..990bd863ae34 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -166,7 +166,7 @@ struct nvme_tcp_ctrl {
 	struct sockaddr_storage src_addr;
 	struct nvme_ctrl	ctrl;
 
-	struct work_struct	err_work;
+	struct delayed_work	err_work;
 	struct delayed_work	connect_work;
 	struct nvme_tcp_request async_req;
 	u32			io_queues[HCTX_MAX_TYPES];
@@ -539,7 +539,7 @@ static void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl)
 		return;
 
 	dev_warn(ctrl->device, "starting error recovery\n");
-	queue_work(nvme_reset_wq, &to_tcp_ctrl(ctrl)->err_work);
+	queue_delayed_work(nvme_reset_wq, &to_tcp_ctrl(ctrl)->err_work, 0);
 }
 
 static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
@@ -2109,7 +2109,7 @@ static void nvme_tcp_reconnect_ctrl_work(struct work_struct *work)
 
 static void nvme_tcp_error_recovery_work(struct work_struct *work)
 {
-	struct nvme_tcp_ctrl *tcp_ctrl = container_of(work,
+	struct nvme_tcp_ctrl *tcp_ctrl = container_of(to_delayed_work(work),
 				struct nvme_tcp_ctrl, err_work);
 	struct nvme_ctrl *ctrl = &tcp_ctrl->ctrl;
 
@@ -2172,7 +2172,7 @@ static void nvme_reset_ctrl_work(struct work_struct *work)
 
 static void nvme_tcp_stop_ctrl(struct nvme_ctrl *ctrl)
 {
-	flush_work(&to_tcp_ctrl(ctrl)->err_work);
+	flush_delayed_work(&to_tcp_ctrl(ctrl)->err_work);
 	cancel_delayed_work_sync(&to_tcp_ctrl(ctrl)->connect_work);
 }
 
@@ -2279,7 +2279,7 @@ static enum blk_eh_timer_return nvme_tcp_timeout(struct request *rq)
 	 * aborted anyway, and nothing is to be done here.
 	 */
 	if (ctrl->state == NVME_CTRL_RESETTING &&
-	    work_pending(&to_tcp_ctrl(ctrl)->err_work))
+	    delayed_work_pending(&to_tcp_ctrl(ctrl)->err_work))
 		return BLK_EH_RESET_TIMER;
 
 	if (ctrl->state != NVME_CTRL_LIVE) {
@@ -2533,7 +2533,8 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
 
 	INIT_DELAYED_WORK(&ctrl->connect_work,
 			nvme_tcp_reconnect_ctrl_work);
-	INIT_WORK(&ctrl->err_work, nvme_tcp_error_recovery_work);
+	INIT_DELAYED_WORK(&ctrl->err_work,
+			  nvme_tcp_error_recovery_work);
 	INIT_WORK(&ctrl->ctrl.reset_work, nvme_reset_ctrl_work);
 
 	if (!(opts->mask & NVMF_OPT_TRSVCID)) {
-- 
2.35.3


