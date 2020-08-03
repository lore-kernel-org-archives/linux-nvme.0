Return-Path: <SRS0=Ae0q=BN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07406C433E0
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Aug 2020 06:59:14 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9B44206F6
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Aug 2020 06:59:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LW/Yn1Q+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9B44206F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:To:From:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UhJ2/x+4vmEewNlS39F7BPRE2whMRJLafnyz9f74Go0=; b=LW/Yn1Q+3Bt5z8oR2IgbIsC7e7
	5fwjXUOvNaFMd+scBUB8GQHIsKfMcDNpDxZbGRHHU+g52Hum/dWVQvJhxxLB1p5XgHJ2HWXUDacz0
	VoAGwSJ2KD9JjxRAb+NdoMOKbZohrXnRle9NvKaxPfsv7Rd4tJtNNG7lIVGJ8M/zlH6yqQUnUw6wf
	3u5O5XFH84f9p90mp9cZ3o/5AujmyWWDVsddN5fatlY22IS4EbKBAeBz3SEtQHMuYAhyFUEnhoA59
	8NpkS5RclcCpb9BeRN7ztWUPD9nEXOGntA36OmmtkX9XnPX/dlKPnMFpzDkONo3WWt9oMa/vbyEwN
	FkAeO3hw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k2URE-0004wQ-HL; Mon, 03 Aug 2020 06:59:12 +0000
Received: from mail-wm1-f66.google.com ([209.85.128.66])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k2URA-0004uN-Kc
 for linux-nvme@lists.infradead.org; Mon, 03 Aug 2020 06:59:09 +0000
Received: by mail-wm1-f66.google.com with SMTP id k20so14385570wmi.5
 for <linux-nvme@lists.infradead.org>; Sun, 02 Aug 2020 23:59:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=v4rJfxiBF+6n8U30DkHBXk3BsrinMBncowTB7MetAWI=;
 b=mTK4ymRB59PowQBbkqOp2Am+7SzPu04FN4WgpJ7C9O11hHvhcc2Ubhc+HpHEnYK4rR
 c5YvUvemmYMduZewA5bKAGXVe74o0QLupEpXHWDmjj1PMLeXsz82kks/ao8u+E7u3+in
 RT4Ml54jTa1dodw/DCmPXLuPhTXz3uxnSB+TwC5WJ/WCwD0p+zHZZcgtSmLdgjLiRGiq
 P+gR57eA1qUCiMo98LoyOVx4v/DJIkbNTGlCfv8bIdVxjiuP6zj4r+4mQJsS7hLMco8H
 KOMHUpiakFNn0aRm5CaToQxLADMemmvQTycSre34XUCM+UX5wlDjYUUNE2Iq4b3Jec95
 B4cA==
X-Gm-Message-State: AOAM532zcBBQq8pKj9K+VrC0jy1sDECNi/LqaSyzxGNqp3n0/9oZhVGR
 Eux+9Xpd8D5xHK6WHUX4Jfo939NQ
X-Google-Smtp-Source: ABdhPJzLrSgo+UsZ1fn9j2KpjKbbvwPW8SmUXH6XQwd9mAnCSqZx5Ly3+9dtJJObi8/783F+R/w/+A==
X-Received: by 2002:a1c:7315:: with SMTP id d21mr13913340wmb.108.1596437947398; 
 Sun, 02 Aug 2020 23:59:07 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4802:9070:6dac:e394:c378:553e])
 by smtp.gmail.com with ESMTPSA id c15sm21574511wme.23.2020.08.02.23.59.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Aug 2020 23:59:06 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, James Smart <james.smart@broadcom.com>
Subject: [PATCH 4/6] nvme-tcp: fix reset hang if controller died in the middle
 of a reset
Date: Sun,  2 Aug 2020 23:58:50 -0700
Message-Id: <20200803065852.69987-5-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200803065852.69987-1-sagi@grimberg.me>
References: <20200803065852.69987-1-sagi@grimberg.me>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200803_025908_775592_FF6AEF42 
X-CRM114-Status: GOOD (  16.01  )
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
index ddacfeaa2543..a0a5d8baddf5 100644
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
