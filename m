Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C985C433FE
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Feb 2022 18:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bpwA04HlgpnPYUM6jG7TKSvrFbaKgl0Zu18OIR5Wft4=; b=m2V8a6g1978kviDYpQsqZT1T5b
	LvOtpnBCMJOQmSvzKnK6vyrMlMSp+Op8Hfiw1liv7U++Gt1w9x2lVPZnNp8RX+DexxmVjVsJnlDET
	GjfaPp4+CDJay9eMBdyrAnVEvLG0Lv7bdfu20VW3EbJ9sW2hiFgkVZ5WFYmnLSuz3owDKI90ubXlX
	G2zJTDGqHEUlczCEDru+osN8mDxOFqjiV02i9ia4mWK0wVR69gsI9MeJt2VKwAm9+XjsOCkdebJ4n
	JWbnYMFIXzVKAcJeO9XGwJ2+3atLYK9PDgKqMceNITvdC0SbXm6je2kjuS4eQK3U1eGWicHvpy8HP
	XxueIzMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nHrpZ-001859-CG; Wed, 09 Feb 2022 18:36:41 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nHrpS-00181g-LI
 for linux-nvme@lists.infradead.org; Wed, 09 Feb 2022 18:36:36 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 2020961C55;
 Wed,  9 Feb 2022 18:36:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F9C7C340EE;
 Wed,  9 Feb 2022 18:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1644431793;
 bh=oaexEo1n/fmSwflUo0Lwc/rDGF0py2hBb4yzWuhSC9c=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=T1pZMrYHqUxn652EQpByplLzqEqUZWs0kGREuz4CJiavVBOhiuyl+OYXJ/flTFXsw
 KvRVX1kZTARMaaT5Gtjfq7R0mdCbHLFdTXCBhHfEIFbqjtplVzuhM/DTvD3WFIxy6t
 fzPUW3sasTAOfV9WUw7HpmaFjv6mo970kS8yJt8Z0tGzOLoeyiY/dBc13viH0jvfHJ
 +Q68v98ugzHHxiifDhjOC1QpbPc3+0G2Y1+GBaZiS3DqTzTx3Szp4RQ812uHfI0oAq
 1TXKK3qU/OtVsZ+spCGsEEPQyTDr6tga73kNMxCuXaEBGzlqybrXlG0QYdA83/wbSz
 98ZH1c538U0Kg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sagi Grimberg <sagi@grimberg.me>, Sasha Levin <sashal@kernel.org>,
 kbusch@kernel.org, axboe@fb.com, linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.16 32/42] nvme: fix a possible use-after-free in
 controller reset during load
Date: Wed,  9 Feb 2022 13:33:04 -0500
Message-Id: <20220209183335.46545-32-sashal@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220209183335.46545-1-sashal@kernel.org>
References: <20220209183335.46545-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220209_103634_770432_9FE6D015 
X-CRM114-Status: GOOD (  16.02  )
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

From: Sagi Grimberg <sagi@grimberg.me>

[ Upstream commit 0fa0f99fc84e41057cbdd2efbfe91c6b2f47dd9d ]

Unlike .queue_rq, in .submit_async_event drivers may not check the ctrl
readiness for AER submission. This may lead to a use-after-free
condition that was observed with nvme-tcp.

The race condition may happen in the following scenario:
1. driver executes its reset_ctrl_work
2. -> nvme_stop_ctrl - flushes ctrl async_event_work
3. ctrl sends AEN which is received by the host, which in turn
   schedules AEN handling
4. teardown admin queue (which releases the queue socket)
5. AEN processed, submits another AER, calling the driver to submit
6. driver attempts to send the cmd
==> use-after-free

In order to fix that, add ctrl state check to validate the ctrl
is actually able to accept the AER submission.

This addresses the above race in controller resets because the driver
during teardown should:
1. change ctrl state to RESETTING
2. flush async_event_work (as well as other async work elements)

So after 1,2, any other AER command will find the
ctrl state to be RESETTING and bail out without submitting the AER.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1af8a4513708a..9a6586c69afe8 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4258,7 +4258,14 @@ static void nvme_async_event_work(struct work_struct *work)
 		container_of(work, struct nvme_ctrl, async_event_work);
 
 	nvme_aen_uevent(ctrl);
-	ctrl->ops->submit_async_event(ctrl);
+
+	/*
+	 * The transport drivers must guarantee AER submission here is safe by
+	 * flushing ctrl async_event_work after changing the controller state
+	 * from LIVE and before freeing the admin queue.
+	*/
+	if (ctrl->state == NVME_CTRL_LIVE)
+		ctrl->ops->submit_async_event(ctrl);
 }
 
 static bool nvme_ctrl_pp_status(struct nvme_ctrl *ctrl)
-- 
2.34.1


