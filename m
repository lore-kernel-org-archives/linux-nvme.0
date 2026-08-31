Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82377C624A4
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Aug 2026 13:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BEa31oEK8chBTBa5hgT2yutVrQ4YqkstTuvOGNMi48Y=; b=4x8OvLHELoYjxtwPCpB78smjCo
	ZE6cMB27qIxgy8qqe2MIlGsZW8PdmBtLjFdh2nMBBIgv2Nrr2FjZvWDOpAbUY9I8OnNajzdvKn5cB
	1n/Rq3/UownkVAXjPmvbquTG+2oaKcLFPI+tGSOIbLFJ/e2mf4ZuG+7HunKB2q4gQwtcH39L95cx6
	UphqGMRNjzNtsg5Qr6E0wRpX54YKF12S6LGFPAN/wivkmZKq5mmvwzQsKu9zBwjYJUsHEMWabn7We
	GMmHPycpO373Xnl6Z01ap/8xormDY0+i/LY+CgpveRCDKCjhLp/OOXImfoQh8Wpzanvg3GnjjXhE5
	zEMcKqeQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x12Dj-00000009RrK-3ryZ;
	Mon, 31 Aug 2026 13:38:43 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x12Di-00000009Rpq-27u2
	for linux-nvme@lists.infradead.org;
	Mon, 31 Aug 2026 13:38:42 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id EAD4F6013A;
	Mon, 31 Aug 2026 13:38:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC0D51F00ACA;
	Mon, 31 Aug 2026 13:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788183521;
	bh=BEa31oEK8chBTBa5hgT2yutVrQ4YqkstTuvOGNMi48Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QkrNs2jUsRz/RqcsWoEFt/iU0NEOKJEjVLdaAe/WtyeVFhp1qr1G1D5bDLucDNKDM
	 ejSiuOKii/xp633xJ5GfXeMAK36hw+eZat0zICcCdQMi1uVtAUQT6FI9yaMTEUaX5W
	 Zn74pmBeUbB6NUksmkmbyXNZx2q9ShAdnLv/JUupOMwlcFvU7maDcRAc0hXBzzRXHu
	 vKuRQovqTxAg29fEOq5r7xfHMV+uV9lUQzDp+BTlp0ANmGU+qvLaMRYQxY4CH2RVFp
	 NRGDsMtDknGAGfpWAzkav7N0ORTIDpsMcfxVBj2KVh+MkQXh8/MmEn6thK0iapD1Ol
	 p1C3l57CYEjKA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Yao Sang <sangyao@kylinos.cn>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.18-6.12] nvme: refresh multipath head zoned limits from path limits
Date: Mon, 31 Aug 2026 09:22:54 -0400
Message-ID: <20260831133314.4125787-146-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260831133314.4125787-1-sashal@kernel.org>
References: <20260831133314.4125787-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.18.48
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

From: Yao Sang <sangyao@kylinos.cn>

[ Upstream commit 59c0517123f2757c41d7795f841bc4c836577d17 ]

queue_limits_stack_bdev() updates the multipath head limits from the
path queue, but it does not propagate max_open_zones or
max_active_zones. As a result, a zoned multipath namespace head can
keep stale 0/0 values even after a ready path reports finite zoned
resource limits.

When refreshing the head limits in nvme_update_ns_info(), stack the
zoned resource limits directly after stacking the path queue limits.
Use min_not_zero() so the block layer's 0 value keeps its "no limit"
meaning while finite limits are combined conservatively.

This avoids advertising "no limit" on the multipath head while keeping
the zoned-limit handling local to the NVMe multipath update path.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Yao Sang <sangyao@kylinos.cn>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

The background searches finished:

- **Local tree search** (`git log --grep=...`): No match for this patch
  in the checked-out **6.18.44** tree — expected, since
  `nvme_stack_zone_resources()` isn’t there yet.
- **Mainline search** (`build/master`): Timed out after ~3 minutes.
  Partial output only showed unrelated zoned-limit commits; no sign of
  this NVMe multipath fix on the fetched `master` tip.

That lines up with the earlier analysis: the bug is present in
**6.18.y**, the fix is small and correct, and the backport
recommendation remains **YES**.

 drivers/nvme/host/core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 8feb774616029..43cbbcd3796b1 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2450,6 +2450,14 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 	return ret;
 }
 
+static void nvme_stack_zone_resources(struct queue_limits *t,
+				      const struct queue_limits *b)
+{
+	t->max_open_zones = min_not_zero(t->max_open_zones, b->max_open_zones);
+	t->max_active_zones =
+		min_not_zero(t->max_active_zones, b->max_active_zones);
+}
+
 static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_ns_info *info)
 {
 	bool unsupported = false;
@@ -2516,6 +2524,8 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_ns_info *info)
 		lim.io_opt = ns_lim->io_opt;
 		queue_limits_stack_bdev(&lim, ns->disk->part0, 0,
 					ns->head->disk->disk_name);
+		if (lim.features & BLK_FEAT_ZONED)
+			nvme_stack_zone_resources(&lim, ns_lim);
 		if (unsupported)
 			ns->head->disk->flags |= GENHD_FL_HIDDEN;
 		else
-- 
2.53.0


