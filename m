Return-Path: <SRS0=ANWg=B6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E613C433E1
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Aug 2020 05:37:20 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C3072072D
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Aug 2020 05:37:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="H7eXkOP+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C3072072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:To:From:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4IE/GgX+EGNEb4V6F93fJ2S9mHxBB48qfSaiMDRHMP0=; b=H7eXkOP+o5qi/2ZlqZ7unXMvxh
	lrkIW1HMJRF00OxzmHnsQUgikWseRaraTjDENQ+b2lYkZrcn683RYTu54nKH3Le62dZuvco7iq1wX
	nrqMQgeI0qvAlOMo5A3iw73jAChg19QLd0TjLv3AwYvyQNBV38TyDHvlMtTyPlzbt846QUG9BzQzG
	DE2Wc/HDEkvU6z25TIt10hszK/OAD58uuL32SoqoHfgoGcMW9hf5tfo6SdiB7Xhkz7wKIW+vytkZ2
	w0LygmisWnefQsnXfxsXMyRslAbWs/W/a7iIt9UmTvDtudUG13UJ57UvVRDqiyGb4L7EBTSe39hp4
	LdgYR/ng==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k8dGH-0000fw-Ll; Thu, 20 Aug 2020 05:37:17 +0000
Received: from mail-wm1-f66.google.com ([209.85.128.66])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8dGF-0000ed-Cy
 for linux-nvme@lists.infradead.org; Thu, 20 Aug 2020 05:37:16 +0000
Received: by mail-wm1-f66.google.com with SMTP id 9so492556wmj.5
 for <linux-nvme@lists.infradead.org>; Wed, 19 Aug 2020 22:37:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UliSSXAiXvI2izr4AJM7XNBFo140s+62bPXPMoUXH6s=;
 b=gMG1kFAJDx8ncoGfHEqhTW6fVjAf+wPp/DVyW63WS7+a5LnJiUQ1xQQsthYFm4DV/F
 9EBa2RiJHvMjj+o2n3wpiHBqs0zMPQpRhhXXtGYoKxwEhF9udmQ4sA/4aYWq00NRjd1t
 6t/UIwtywnJ9j1O9DNRJZnzOWlBP3a12xFIeBv0t2KOTn4IpdkgHntCn7iD+GODbQl3T
 uFIiwiAJoufQX8dpKUrtN1UxRNdn/dPuz+R0IYN0GbUfK3vQRewOJD/n7SRCBTDp2KMK
 vspS9HelDKUsjEfWLLP0vMuYWzyC2/8dlkreQ8BNq64r4CBPuTUB4pgfHmFksYmk7Kw6
 V/qg==
X-Gm-Message-State: AOAM5323r7Aj4aLEALs5ZxTVdYfR1D3n8reyUhLxnKTCi2U97tB1uH3Q
 VJLbsYu2VY5NbIpZWb2YMxEO/OWrQIW8Xg==
X-Google-Smtp-Source: ABdhPJxy05s+BQcoJ+XDAl6wDV33ndoI+CxaRu8zRStc3H09ZHoNA0JvPubCWEQ4vs2V/1RXRe0lyw==
X-Received: by 2002:a1c:de85:: with SMTP id v127mr1785797wmg.156.1597901834001; 
 Wed, 19 Aug 2020 22:37:14 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4802:9070:7ced:8569:4373:1bd3])
 by smtp.gmail.com with ESMTPSA id a10sm1900353wro.35.2020.08.19.22.37.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2020 22:37:13 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, James Smart <james.smart@broadcom.com>
Subject: [PATCH v3 4/9] nvme-tcp: serialize controller teardown sequences
Date: Wed, 19 Aug 2020 22:36:46 -0700
Message-Id: <20200820053651.197057-5-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200820053651.197057-1-sagi@grimberg.me>
References: <20200820053651.197057-1-sagi@grimberg.me>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200820_013715_482902_108CE241 
X-CRM114-Status: GOOD (  17.38  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

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
---
 drivers/nvme/host/tcp.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 3be4749dbf11..d58a6e2a4ab1 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -124,6 +124,7 @@ struct nvme_tcp_ctrl {
 	struct sockaddr_storage src_addr;
 	struct nvme_ctrl	ctrl;
 
+	struct mutex		teardown_lock;
 	struct work_struct	err_work;
 	struct delayed_work	connect_work;
 	struct nvme_tcp_request async_req;
@@ -1527,7 +1528,6 @@ static void nvme_tcp_stop_queue(struct nvme_ctrl *nctrl, int qid)
 
 	if (!test_and_clear_bit(NVME_TCP_Q_LIVE, &queue->flags))
 		return;
-
 	__nvme_tcp_stop_queue(queue);
 }
 
@@ -1875,6 +1875,7 @@ static int nvme_tcp_configure_admin_queue(struct nvme_ctrl *ctrl, bool new)
 static void nvme_tcp_teardown_admin_queue(struct nvme_ctrl *ctrl,
 		bool remove)
 {
+	mutex_lock(&to_tcp_ctrl(ctrl)->teardown_lock);
 	blk_mq_quiesce_queue(ctrl->admin_q);
 	nvme_tcp_stop_queue(ctrl, 0);
 	if (ctrl->admin_tagset) {
@@ -1885,13 +1886,16 @@ static void nvme_tcp_teardown_admin_queue(struct nvme_ctrl *ctrl,
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
@@ -1903,6 +1907,8 @@ static void nvme_tcp_teardown_io_queues(struct nvme_ctrl *ctrl,
 	if (remove)
 		nvme_start_queues(ctrl);
 	nvme_tcp_destroy_io_queues(ctrl, remove);
+out:
+	mutex_unlock(&to_tcp_ctrl(ctrl)->teardown_lock);
 }
 
 static void nvme_tcp_reconnect_or_remove(struct nvme_ctrl *ctrl)
@@ -2423,6 +2429,7 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
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
