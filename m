Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26B00C61D97
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Nov 2023 20:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=jfjvoxjM5f50l15PkwYK+W31izBUXsyXN9vp6wQSga4=; b=EqsemObnf01Z0eRWOKFACGsiNo
	U+xi8ZkBAXOpuBp5gvU7OH8wVTf+4JzfnrqSwBCVxr926B51zPNrLKXCx8s8gxF2bLGPqxsp41tg7
	7uxcTve7y1A39Ha4C0FoI0wmHyCP/8AiFtBD1JTxk7zrsPLollMVfw/un7QTZsVcKC/B9aDwwDunM
	aveWWf1emLW3A1Xo0ha+iYEnUCTRCY3pbHqphwHzE8TRH/bpzSvZWRov2jZChH1etWjK9Twtclw43
	88RKM9vqpIC8G0JgOEuS0ZYthbM3XrazZgkhbu2v0MtTboUe0EJYMZrkLngrOMOh92t8d5FYuvdUF
	D0101BvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r6dEu-0083Bb-0Y;
	Fri, 24 Nov 2023 20:57:28 +0000
Received: from mout02.posteo.de ([185.67.36.66])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r6dEq-0083As-1w
	for linux-nvme@lists.infradead.org;
	Fri, 24 Nov 2023 20:57:26 +0000
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id DD60C240104
	for <linux-nvme@lists.infradead.org>; Fri, 24 Nov 2023 21:57:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1700859438; bh=VUY/r48iuYNklA3pOPBW8jilcpXCwFMRejWJXce3tks=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
	 Content-Transfer-Encoding:From;
	b=ATwDadX1/5k2Zv9OtETrV/kpzy03/jc89TOifHaP7JU/FWHtiGOkoCiSZz3d/NBL6
	 mZEL4wBs20g4K2+C97PEQWM14oeMm434q52x2ViKkqQK4v68S1eCP2l3MJOmLZuK3h
	 KIa1tM+yrCSr3D4fbhYvvr6diYqIvy8t9uBjv+TNlbkumjBs6gD1tFrMzrSssYRIBD
	 F140F3BWnZmfMn3/Va5bXLT9EdsuCxAkDqKo8zRL6ril3YWIPY/nuHAqcg0NsqTLO8
	 QFHfxB7vHGX6e/ZgIzhvI2uxH4PmzwY663VFposVvBs12atc7dwSoXAio+60zGbgRM
	 iBMDy0+85lQoQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4ScS3H31gWz9rxR;
	Fri, 24 Nov 2023 21:57:15 +0100 (CET)
From: Mark O'Donovan <shiftee@posteo.net>
To: linux-kernel@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	sagi@grimberg.me,
	hch@lst.de,
	axboe@kernel.dk,
	kbusch@kernel.org,
	hare@suse.de,
	Mark O'Donovan <shiftee@posteo.net>
Subject: [PATCH RESEND] nvme: fine-tune sending of first keep-alive
Date: Fri, 24 Nov 2023 20:56:59 +0000
Message-Id: <20231124205659.523248-1-shiftee@posteo.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231124_125724_838614_01E27031 
X-CRM114-Status: GOOD (  12.66  )
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

Keep-alive commands are sent half-way through the kato period.
This normally works well but fails when the keep-alive system is
started when we are more than half way through the kato.
This can happen on larger setups or due to host delays.
With this change we now time the initial keep-alive command from
the controller initialisation time, rather than the keep-alive
mechanism activation time.

Signed-off-by: Mark O'Donovan <shiftee@posteo.net>
---
 drivers/nvme/host/core.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 46a4c9c5ea96..8bf24c1cd8bb 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1192,8 +1192,16 @@ static unsigned long nvme_keep_alive_work_period(struct nvme_ctrl *ctrl)
 
 static void nvme_queue_keep_alive_work(struct nvme_ctrl *ctrl)
 {
-	queue_delayed_work(nvme_wq, &ctrl->ka_work,
-			   nvme_keep_alive_work_period(ctrl));
+	unsigned long now = jiffies;
+	unsigned long delay = nvme_keep_alive_work_period(ctrl);
+	unsigned long ka_next_check_tm = ctrl->ka_last_check_time + delay;
+
+	if (time_after(now, ka_next_check_tm))
+		delay = 0;
+	else
+		delay = ka_next_check_tm - now;
+
+	queue_delayed_work(nvme_wq, &ctrl->ka_work, delay);
 }
 
 static enum rq_end_io_ret nvme_keep_alive_end_io(struct request *rq,
@@ -4471,6 +4479,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	INIT_DELAYED_WORK(&ctrl->failfast_work, nvme_failfast_work);
 	memset(&ctrl->ka_cmd, 0, sizeof(ctrl->ka_cmd));
 	ctrl->ka_cmd.common.opcode = nvme_admin_keep_alive;
+	ctrl->ka_last_check_time = jiffies;
 
 	BUILD_BUG_ON(NVME_DSM_MAX_RANGES * sizeof(struct nvme_dsm_range) >
 			PAGE_SIZE);

base-commit: 5b7ad877e4d81f8904ce83982b1ba5c6e83deccb
-- 
2.39.2


