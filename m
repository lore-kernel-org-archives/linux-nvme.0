Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A13FC021A1
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Feb 2025 18:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ge0IZaVhj6bYPb7IYImWFci1To9h0GU7LfN7WXAzDQg=; b=y3/UHu1RO1ypOxzH2+W7dX6LHp
	2WcN8Wt6x4jQFMr1OxE6Kdcffn2z1+Wre3iUP1d1yT915B0zx/IwZCNftEmwSNgypxK3UOTrK6OOP
	sBhbjXRHsziNqMygzyLj2deBslvGMF1UyG/M+XJ7Pi7TS/PKfi1Fp55D7iPV5oSActyF4T5tTgs0k
	0ht3+cUrOgg/C4t0lG/xNWEjYo0Mx6g6c6/c4cj+uF6b2r+suJH25LTFQsym64iSNkhOHC3NsbNlm
	DMn8UAOMZ+fd+KN3jvvzLt0QORJQIWtA7sV3FHLQUcIB2GUjfixUchXGGskRPYOfma+8k6P26/z8L
	MHz5zRfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1thvBj-00000004saQ-3dRD;
	Tue, 11 Feb 2025 18:40:51 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1thuxf-00000004q6q-3BXL
	for linux-nvme@bombadil.infradead.org;
	Tue, 11 Feb 2025 18:26:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Sender:Reply-To:Content-ID:Content-Description;
	bh=Ge0IZaVhj6bYPb7IYImWFci1To9h0GU7LfN7WXAzDQg=; b=cN5i88awiredRI/YxM3XJsktjc
	phpG6V+UxgWTQtC3BAA/OgWJQoTmefUKhL1weyfs9r7ss4D4lfdaRkBKrJttK5zw0PqnTVc8xbDPa
	t9jGQR3PGxsTUKxB+iTStpgCk1H6eL0APZUj3IIFRjnTXiXL9YkDceVwyGnb1CcciFg96YTDYSpuX
	nLPEM/ZxoCsXe+rVeoRXBvuN7g8OArbAAnQyivrGeiPUmvIy4+qTMLxUs0lXPB01XpddpTS9TaLoU
	M7NvuMcLkKipg346ZgjOpeMo6j9sDa/9dOAOuxbSM6Q72w1RBE0q9UpamPOlHLymIQ7gMK3WpYpJR
	LpVg2oAw==;
Received: from out-184.mta0.migadu.com ([91.218.175.184])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1thuxc-00000000g0Q-3kCx
	for linux-nvme@lists.infradead.org;
	Tue, 11 Feb 2025 18:26:18 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosenzweig.io;
	s=key1; t=1739298367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ge0IZaVhj6bYPb7IYImWFci1To9h0GU7LfN7WXAzDQg=;
	b=Ybmo94hD5UHHt5O9IVJN0SV8pvCtcE0ivNp3/n1zhklYBqNjltkMOMPFHyeJx5KMlCElq6
	E4kQU2TxImK8S2dl/koS4OlfG2yvr1MNzTylIpBcfIFx87VuQ6QfngqCUqtA5SuYb5drXi
	cQjoZWnVadk4ndtTaQ5eJ61exw5vEA2w2+aOjegisGHupEq8T+UvqjexQgfXfvN//uguy9
	8fIzc7A66BIF2Mk8NeqrPmY0tx+V4v+iObyK9n4CawAT2TIvCHD3kekscg7lHo6IumTVLy
	6Tww43KxYN1itL4og2plMDX+2NldcDAY4Ezcqmur0VZJ2bor+yqtupo0aZaQYQ==
From: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Date: Tue, 11 Feb 2025 13:25:59 -0500
Subject: [PATCH 3/3] apple-nvme: defer cache flushes by a specified amount
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250211-nvme-fixes-v1-3-6958b3aa49fe@rosenzweig.io>
References: <20250211-nvme-fixes-v1-0-6958b3aa49fe@rosenzweig.io>
In-Reply-To: <20250211-nvme-fixes-v1-0-6958b3aa49fe@rosenzweig.io>
To: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, 
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>
X-Developer-Signature: v=1; a=openpgp-sha256; l=4209; i=alyssa@rosenzweig.io;
 h=from:subject:message-id; bh=XdAPgabJp3Th1VF3dW5IHPK3KhszAX1ZDwJh3vdU+rs=;
 b=owEBbQKS/ZANAwAIAf7+UFoK9VgNAcsmYgBnq5Y3LVwFvjEt/Oee7LPZ30kNPyq8CqXKwpOxw
 cgxkAAh8ICJAjMEAAEIAB0WIQRDXuCbsK8A0B2q9jj+/lBaCvVYDQUCZ6uWNwAKCRD+/lBaCvVY
 Df8pD/41JdixnbjBPDORaqiQEXeFWOiGuKrkuQnkmT4IDcLlme7arNTYhFy4qlp1QSVcgeWHLsI
 Hed2NG2jpq0DD5uWlXx5fe1asg4+KvdwJ9EBGBHz29MLxM/PMBSa2k9RYvGfQlcFvAfdRUHQE5T
 d/PnE+t0vHutgLo5Ba9/rNuyvIaq+qkle/OwXSsjeq0q/L8vOtlJBvoYWuod0C1G2+EV21KkGhq
 XL98CYSgN5uPiA4WBt3x3NoWRFzXUK23fXQ/jE2EkxAFHX9k1VUUJC1OV4DwOaCCHLSCywLq/qX
 4aYYECjAAQlgjq/oBH3vyTc05BaWoQceQzceLVYR+U+vtH0iC6354OdeeEz6lld9JzMnkSZaKQI
 qAuxX07xFR8osmSkWSFb8+/IzmO9mHjuqS0+/qXZ6hJ1C3wGlpWYjx3xSsBkJiKFbSnV6zRyfFy
 e+owMrQ27m4YV4NoqcE6rSR/aqrQAEBh9meE0O0aWOwM8ShJolQPM+WerbUN63G0XwWNIrP0X/Z
 4hZKEfqnhDbS3yuhr7bIzEc4ZZDCBUvBIeIPr2YsyMjRfhWinT0hiw4KVOT580lPyknu3zeFod9
 4+v0hP4Tuj42OaPcMc/HtBdLHL7jUOfb/ZzLVy/fMFZS0WECDRCJJ3NuddFW4G7WeKyOO+87dC7
 WFM2C460AzrUvLw==
X-Developer-Key: i=alyssa@rosenzweig.io; a=openpgp;
 fpr=435EE09BB0AF00D01DAAF638FEFE505A0AF5580D
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250211_182617_097891_666348ED 
X-CRM114-Status: GOOD (  15.90  )
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

From: Jens Axboe <axboe@kernel.dk>

Cache flushes on the M1 nvme are really slow, taking 17-18 msec to
complete. This can slow down workloads considerably, pure random writes
end up being bound by the flush latency and hence run at 55-60 IOPS.

Add a deferred flush work around to provide better performance, at a
minimal risk. By default, flushes are delayed at most 1 second, but this
is configurable.

With this work-around, a pure random write workload runs at ~12K IOPS
rather than 56 IOPS.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
---
 drivers/nvme/host/apple.c | 69 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index a060f69558e76970bfba046cca5127243e8a51b7..2dfb0442d56195756df91e0fbc913b751c74d0ea 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -195,8 +195,20 @@ struct apple_nvme {
 
 	int irq;
 	spinlock_t lock;
+
+	/*
+	 * Delayed cache flush handling state
+	 */
+	struct nvme_ns *flush_ns;
+	unsigned long flush_interval;
+	unsigned long last_flush;
+	struct delayed_work flush_dwork;
 };
 
+unsigned int flush_interval = 1000;
+module_param(flush_interval, uint, 0644);
+MODULE_PARM_DESC(flush_interval, "Grace period in msecs between flushes");
+
 static_assert(sizeof(struct nvme_command) == 64);
 static_assert(sizeof(struct apple_nvmmu_tcb) == 128);
 
@@ -729,6 +741,26 @@ static int apple_nvme_remove_sq(struct apple_nvme *anv)
 	return nvme_submit_sync_cmd(anv->ctrl.admin_q, &c, NULL, 0);
 }
 
+static bool apple_nvme_delayed_flush(struct apple_nvme *anv, struct nvme_ns *ns,
+				     struct request *req)
+{
+	if (!anv->flush_interval || req_op(req) != REQ_OP_FLUSH)
+		return false;
+	if (delayed_work_pending(&anv->flush_dwork))
+		return true;
+	if (time_before(jiffies, anv->last_flush + anv->flush_interval)) {
+		kblockd_mod_delayed_work_on(WORK_CPU_UNBOUND, &anv->flush_dwork,
+						anv->flush_interval);
+		if (WARN_ON_ONCE(anv->flush_ns && anv->flush_ns != ns))
+			goto out;
+		anv->flush_ns = ns;
+		return true;
+	}
+out:
+	anv->last_flush = jiffies;
+	return false;
+}
+
 static blk_status_t apple_nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 					const struct blk_mq_queue_data *bd)
 {
@@ -764,6 +796,12 @@ static blk_status_t apple_nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 	}
 
 	nvme_start_request(req);
+
+	if (apple_nvme_delayed_flush(anv, ns, req)) {
+		blk_mq_complete_request(req);
+		return BLK_STS_OK;
+	}
+
 	apple_nvme_submit_cmd(q, cmnd);
 	return BLK_STS_OK;
 
@@ -1398,6 +1436,28 @@ static void devm_apple_nvme_mempool_destroy(void *data)
 	mempool_destroy(data);
 }
 
+static void apple_nvme_flush_work(struct work_struct *work)
+{
+	struct nvme_command c = { };
+	struct apple_nvme *anv;
+	struct nvme_ns *ns;
+	int err;
+
+	anv = container_of(work, struct apple_nvme, flush_dwork.work);
+	ns = anv->flush_ns;
+	if (WARN_ON_ONCE(!ns))
+		return;
+
+	c.common.opcode = nvme_cmd_flush;
+	c.common.nsid = cpu_to_le32(anv->flush_ns->head->ns_id);
+	err = nvme_submit_sync_cmd(ns->queue, &c, NULL, 0);
+	if (err) {
+		dev_err(anv->dev, "Deferred flush failed: %d\n", err);
+	} else {
+		anv->last_flush = jiffies;
+	}
+}
+
 static struct apple_nvme *apple_nvme_alloc(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -1553,6 +1613,14 @@ static int apple_nvme_probe(struct platform_device *pdev)
 		goto out_uninit_ctrl;
 	}
 
+	if (flush_interval) {
+		anv->flush_interval = msecs_to_jiffies(flush_interval);
+		anv->flush_ns = NULL;
+		anv->last_flush = jiffies - anv->flush_interval;
+	}
+
+	INIT_DELAYED_WORK(&anv->flush_dwork, apple_nvme_flush_work);
+
 	nvme_reset_ctrl(&anv->ctrl);
 	async_schedule(apple_nvme_async_probe, anv);
 
@@ -1590,6 +1658,7 @@ static void apple_nvme_shutdown(struct platform_device *pdev)
 {
 	struct apple_nvme *anv = platform_get_drvdata(pdev);
 
+	flush_delayed_work(&anv->flush_dwork);
 	apple_nvme_disable(anv, true);
 	if (apple_rtkit_is_running(anv->rtk)) {
 		apple_rtkit_shutdown(anv->rtk);

-- 
2.48.1


