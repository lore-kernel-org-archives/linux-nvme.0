Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D9B9C433EF
	for <linux-nvme@archiver.kernel.org>; Sun, 30 Jan 2022 09:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Vii69nfZ8k23E3DfEMKI+f5nKIzTIMy8t9Ao+ZitQ6I=; b=rss8ewQ2C9nbGMTzEWmSabfP+C
	1UBeXhADbJ+e1wEPh2AMS2oP91QFCznKZU6wsRcQ9QYD9pl9homP3l21LWhvzq6sZwsAOTHwRtUpQ
	mMP0HI4gN2Mx8YhWoIXwyQsoaLQQwxjB+aKyzrAd9LhNY7F746FqHnDxF+4r3imgdAcSAv3nVBhLW
	YgRd9QPsmKk3PiZ7Ozc88T1Snyneb9ypD/nWMm80+vo+EO9y4avWQaAvTOXT7Q3L4ZiEBIK40cvGO
	3Z2dlZPc7zGghMXYTh5euAUPh8w+LwmhEQyFeVGJhJueRRjzOT5E9XEUL99WWCNMqKMFukRkIeeU9
	zfaBlGzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nE6PE-006DJ2-0I; Sun, 30 Jan 2022 09:21:56 +0000
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nE6Oj-006DDo-Na
 for linux-nvme@lists.infradead.org; Sun, 30 Jan 2022 09:21:27 +0000
Received: by mail-wm1-f45.google.com with SMTP id n8so8026791wmk.3
 for <linux-nvme@lists.infradead.org>; Sun, 30 Jan 2022 01:21:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Vii69nfZ8k23E3DfEMKI+f5nKIzTIMy8t9Ao+ZitQ6I=;
 b=JHJp1WCiV2Z2vdBGLOAjd0NeUp5DUatasJy08MjYxMjFNv6on/jedKwgevwkK2or/9
 Ze4uJKhVMfma8ccStgnotiwTkIwQTCU2basfanJuJjCjN+ATBInuTc/AeF//v7hv5axh
 ePY4RV4dh/pSpnb7YcEpPyRihsAamS1krkMnkb6A+B3HIQYaqO02rNWPRabLj0LBAI1m
 nguplxlR3Jox+ya+FX0xbyqW72yJrSklcKUzFQWwb5fcqyVlu0CzBLHVXaRlRm1xG/6E
 4wYySS3DOHeSzd6kIEWGa7tnQxDB4p4R0WVPOve86hdLml2i1IU3eVduySOkK+lJmD2r
 AvXQ==
X-Gm-Message-State: AOAM530AOwOIbbqZJuq2klnUk3aFjxcCZ6snpPKezLlT9ceCzHJvM2Ja
 fbyVZGbrNupYBZ+jC6sMmWC3PplZqbw=
X-Google-Smtp-Source: ABdhPJwOQthdSYI5qGRCtG0rIwhcqznZ1+VOTbkLIV1Pkd9IlBq1siqFN6j3SGQGa4mf6oQO8GKb0w==
X-Received: by 2002:a1c:3bc3:: with SMTP id i186mr13679742wma.11.1643534484151; 
 Sun, 30 Jan 2022 01:21:24 -0800 (PST)
Received: from localhost.localdomain (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id o15sm6861452wms.9.2022.01.30.01.21.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Jan 2022 01:21:23 -0800 (PST)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>
Cc: Chris Leech <cleech@redhat.com>
Subject: [PATCH 3/4] nvme-rdma: fix a possible use-after-free in controller
 reset during load
Date: Sun, 30 Jan 2022 11:21:18 +0200
Message-Id: <20220130092119.595854-4-sagi@grimberg.me>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220130092119.595854-1-sagi@grimberg.me>
References: <20220130092119.595854-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220130_012125_801469_9310B820 
X-CRM114-Status: GOOD (  15.67  )
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

Unlike .queue_rq, .submit_async_event does not check the ctrl and
queue readiness for submitting a AER. This may lead to a use-after-free
condition in the following scenario:
1. nvme_rdma_reset_ctrl_work
2. -> nvme_stop_ctrl flushes ctrl async_event_work
3. ctrl sends AEN which is received by the host, which in turn
   schedules AEN handling
4. teardown admin queue (which releases the rdma queue-pair)
5. AEN processed, submits another AER, calling nvme-rdma driver to submit
   prepares the cmd posts on the admin qp
==> use-after-free accessing an already freed rdma queue-pair

In order to fix that, add ctrl and queue state check to validate the driver
is actually able to accept the rdma qp post.

This solves the above race in the reset flow because the ctrl state is
changed to RESETTING, then the async_event_work is flushed, hence from
that point, any other AER command will find the ctrl state to be RESETTING
and bail out without posting the cmd on the rdma qp.

CC: stable@vger.kernel.org
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/rdma.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 850f84d204d0..780e8fbf503f 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1714,9 +1714,13 @@ static void nvme_rdma_submit_async_event(struct nvme_ctrl *arg)
 	struct ib_device *dev = queue->device->dev;
 	struct nvme_rdma_qe *sqe = &ctrl->async_event_sqe;
 	struct nvme_command *cmd = sqe->data;
+	bool queue_ready = test_bit(NVME_RDMA_Q_LIVE, &queue->flags);
 	struct ib_sge sge;
 	int ret;
 
+	if (ctrl->ctrl.state != NVME_CTRL_LIVE || !queue_ready)
+		return;
+
 	ib_dma_sync_single_for_cpu(dev, sqe->dma, sizeof(*cmd), DMA_TO_DEVICE);
 
 	memset(cmd, 0, sizeof(*cmd));
-- 
2.30.2


