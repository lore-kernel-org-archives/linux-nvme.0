Return-Path: <SRS0=Qo8g=CQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6082BC2D0E0
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Sep 2020 16:33:08 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1518021789
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Sep 2020 16:33:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nUS5SZgT";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TZHJrjLg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1518021789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=XB06FFIZ8HBiq6BI9Y2u6SIEZQg5oA8sA3L3jo8LBWE=; b=nUS5SZgT/HGNaLp5gfw9vy/78
	4SRBmGauUbZSqqDl48i044xqGk5ZUer3MjOy9W/LuRzSB0cVovE6pm2rZ5KICkzaroOSqY6c+mcz+
	q2Eh9njsGp6TTqXz6gD0mOpdo60zBuQ+UzXfXVn2IeEmqsvPiKw4jepZO/Z4XuAxoB/n/5IbAXqm2
	Ne/wPCCqL+3W3VB2Mr50OzuGjcsKSAwbUxl39NLBfUsrdHPBMYIeVOcHcE8EpOr+deKciCmmbVd02
	Z9V4z9bbICplkNndbdsciNFjRNa+XJeND/4SQV/HDyJMKgsnjClg07TGnObCrW8212+SgDuEk7LG6
	hShBG7bTg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kFK4o-0005KS-5H; Mon, 07 Sep 2020 16:33:06 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kFK4h-0005HW-Qo
 for linux-nvme@lists.infradead.org; Mon, 07 Sep 2020 16:33:00 +0000
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B07DA21919;
 Mon,  7 Sep 2020 16:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1599496379;
 bh=v1HrhUB5Bh/hZ+mDpG2XsSC2WgHqy40+3yG7tfKwR/Q=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=TZHJrjLgrmxWNIDbx1po+vwGOHjGPIH1UMRufHQ5dFjgKGCG7oojm2b9dgt1USKaB
 u5MuMfWUI8NELCgs2rgAXi8yuR60U/VTpVyIJ6iEynv4eF+KOLGDzNe8aXCtxusY9S
 0UCFmGu7sLm/Tx9xFbEPAjNONRSwyx6Qw2A0wlUA=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.8 30/53] nvme-tcp: serialize controller teardown
 sequences
Date: Mon,  7 Sep 2020 12:31:56 -0400
Message-Id: <20200907163220.1280412-30-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200907163220.1280412-1-sashal@kernel.org>
References: <20200907163220.1280412-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200907_123300_014279_8D2A1B42 
X-CRM114-Status: GOOD (  17.08  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Sasha Levin <sashal@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Sagi Grimberg <sagi@grimberg.me>

[ Upstream commit d4d61470ae48838f49e668503e840e1520b97162 ]

In the timeout handler we may need to complete a request because the
request that timed out may be an I/O that is a part of a serial sequence
of controller teardown or initialization. In order to complete the
request, we need to fence any other context that may compete with us
and complete the request that is timing out.

In this case, we could have a potential double completion in case
a hard-irq or a different competing context triggered error recovery
and is running inflight request cancellation concurrently with the
timeout handler.

Protect using a ctrl teardown_lock to serialize contexts that may
complete a cancelled request due to error recovery or a reset.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/tcp.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index a6d2e3330a584..d1e5b27675b1b 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -122,6 +122,7 @@ struct nvme_tcp_ctrl {
 	struct sockaddr_storage src_addr;
 	struct nvme_ctrl	ctrl;
 
+	struct mutex		teardown_lock;
 	struct work_struct	err_work;
 	struct delayed_work	connect_work;
 	struct nvme_tcp_request async_req;
@@ -1497,7 +1498,6 @@ static void nvme_tcp_stop_queue(struct nvme_ctrl *nctrl, int qid)
 
 	if (!test_and_clear_bit(NVME_TCP_Q_LIVE, &queue->flags))
 		return;
-
 	__nvme_tcp_stop_queue(queue);
 }
 
@@ -1845,6 +1845,7 @@ static int nvme_tcp_configure_admin_queue(struct nvme_ctrl *ctrl, bool new)
 static void nvme_tcp_teardown_admin_queue(struct nvme_ctrl *ctrl,
 		bool remove)
 {
+	mutex_lock(&to_tcp_ctrl(ctrl)->teardown_lock);
 	blk_mq_quiesce_queue(ctrl->admin_q);
 	nvme_tcp_stop_queue(ctrl, 0);
 	if (ctrl->admin_tagset) {
@@ -1855,13 +1856,16 @@ static void nvme_tcp_teardown_admin_queue(struct nvme_ctrl *ctrl,
 	if (remove)
 		blk_mq_unquiesce_queue(ctrl->admin_q);
 	nvme_tcp_destroy_admin_queue(ctrl, remove);
+	mutex_unlock(&to_tcp_ctrl(ctrl)->teardown_lock);
 }
 
 static void nvme_tcp_teardown_io_queues(struct nvme_ctrl *ctrl,
 		bool remove)
 {
+	mutex_lock(&to_tcp_ctrl(ctrl)->teardown_lock);
 	if (ctrl->queue_count <= 1)
-		return;
+		goto out;
+	blk_mq_quiesce_queue(ctrl->admin_q);
 	nvme_start_freeze(ctrl);
 	nvme_stop_queues(ctrl);
 	nvme_tcp_stop_io_queues(ctrl);
@@ -1873,6 +1877,8 @@ static void nvme_tcp_teardown_io_queues(struct nvme_ctrl *ctrl,
 	if (remove)
 		nvme_start_queues(ctrl);
 	nvme_tcp_destroy_io_queues(ctrl, remove);
+out:
+	mutex_unlock(&to_tcp_ctrl(ctrl)->teardown_lock);
 }
 
 static void nvme_tcp_reconnect_or_remove(struct nvme_ctrl *ctrl)
@@ -2384,6 +2390,7 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
 			nvme_tcp_reconnect_ctrl_work);
 	INIT_WORK(&ctrl->err_work, nvme_tcp_error_recovery_work);
 	INIT_WORK(&ctrl->ctrl.reset_work, nvme_reset_ctrl_work);
+	mutex_init(&ctrl->teardown_lock);
 
 	if (!(opts->mask & NVMF_OPT_TRSVCID)) {
 		opts->trsvcid =
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
