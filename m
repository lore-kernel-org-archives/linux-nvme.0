Return-Path: <SRS0=CEZP=BQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3322BC433E1
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2020 19:11:53 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BC722086A
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2020 19:11:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mfCLoRap"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BC722086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:To:From:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uKAcoYA+ikf5drQIbsVBFNLEIlGavDruSIaiyNCwJN8=; b=mfCLoRaphPmXlKkdIkiAfzEYCQ
	TZyQ9ZJALI7Mz7dOe93wwnrb2rUtr5mA9sATFBhviPHNW2YNrHgZs2txbxlRzdHy6Wbkd49qWiGLj
	h+xi5YscmERxCJVWo51MQ4edhDE20xNOflLvyvH0MQIaith9bhjuemGKGnf9CuqeLIlc7DKn8dKYn
	N7fw+4Pd8DuzKHI2lZzSggCiheArJY2NttfRFOm9o+cZ8i1e3RDH0lkUdt/I3bDEyOmQa0W64rQ6h
	T17GF4ATEIKQXbaZXpWeMO9r+dc9N1HauNmcDb7DJVM01LwpK4FGoYqp3ky7IKF2pXxDL9RIgszQz
	YbSjJJnQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k3lIs-0008Gl-J5; Thu, 06 Aug 2020 19:11:50 +0000
Received: from mail-pg1-f194.google.com ([209.85.215.194])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k3lIh-0008Ai-08
 for linux-nvme@lists.infradead.org; Thu, 06 Aug 2020 19:11:39 +0000
Received: by mail-pg1-f194.google.com with SMTP id o13so27473334pgf.0
 for <linux-nvme@lists.infradead.org>; Thu, 06 Aug 2020 12:11:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ksHqrOVMuic4/yRWAjLO0K/reB59N3nyhRQ+j/kXQes=;
 b=DYyp7C8mb37qXNc9iJ+bTuYP+Ahan4MUay2wJZCFjmK0MtqPrfI7ejRuFvr+NaRPkP
 DAWUyHpGyiXEb/F/18GYp4cQfaeRzOjjX6OoUvHcPlkqyhibbkUzBFMn32HXQ6fO2IBa
 pgURNph8998b/ag5bvhYs+31H0i0EJSKrMRx/1YuGolwCknwHXEJMCRxjzSZvejRbxWQ
 w4PV+jIKWCa4xwhxCusj3wBmYtA7KenP5xH5NsA2EyC+eBGAhxjAAhN1YSWeA0eEH7+D
 f7iHYS6DU7vG+Mn7o80eGbUz+JXpOe6esYhOAxIyg6WP7+XbTYXU0rBkSp1T8apSZVyU
 Wvww==
X-Gm-Message-State: AOAM532cQpCtkO4pJO1IpRwTzs/usF/cDWBBKi8+v3MC0JEgHDolqy//
 e4Y1v1JeL0iOhWwWR8TszTsku7yY
X-Google-Smtp-Source: ABdhPJyfDyFmCk2zeYaSX/lk46gkK7gO1/YT8MCUqpeZmHH4VU9LxN/Fr+fCb4qnC22PHqGEETsKWg==
X-Received: by 2002:aa7:9ac2:: with SMTP id x2mr9531236pfp.57.1596741097505;
 Thu, 06 Aug 2020 12:11:37 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4802:9070:d88d:857c:b14c:519a])
 by smtp.gmail.com with ESMTPSA id gn13sm7801348pjb.17.2020.08.06.12.11.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2020 12:11:36 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, James Smart <james.smart@broadcom.com>
Subject: [PATCH v2 5/8] nvme-tcp: fix reset hang if controller died in the
 middle of a reset
Date: Thu,  6 Aug 2020 12:11:24 -0700
Message-Id: <20200806191127.592062-6-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200806191127.592062-1-sagi@grimberg.me>
References: <20200806191127.592062-1-sagi@grimberg.me>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200806_151139_090229_5D9D5376 
X-CRM114-Status: GOOD (  15.66  )
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

If the controller becomes unresponsive in the middle of a reset, we
will hang because we are waiting for the freeze to complete, but that
cannot happen since we have commands that are inflight holding the
q_usage_counter, and we can't blindly fail requests that times out.

So give a timeout and if we cannot wait for queue freeze before
unfreezing, fail and have the error handling take care how to
proceed (either schedule a reconnect of remove the controller).

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/tcp.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index d472fb5e79fc..489a3350b9d3 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1783,7 +1783,13 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
 
 	if (!new) {
 		nvme_start_queues(ctrl);
-		nvme_wait_freeze(ctrl);
+		if (!nvme_wait_freeze_timeout(ctrl, NVME_IO_TIMEOUT)) {
+			/* if we timed out waiting for freeze we are
+			 * likely stuck, fail just to be safe
+			 */
+			ret = -ENODEV;
+			goto out_wait_freeze_timed_out;
+		}
 		blk_mq_update_nr_hw_queues(ctrl->tagset,
 			ctrl->queue_count - 1);
 		nvme_unfreeze(ctrl);
@@ -1791,6 +1797,9 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
 
 	return 0;
 
+out_wait_freeze_timed_out:
+	nvme_stop_queues(ctrl);
+	nvme_tcp_stop_io_queues(ctrl);
 out_cleanup_connect_q:
 	if (new)
 		blk_cleanup_queue(ctrl->connect_q);
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
