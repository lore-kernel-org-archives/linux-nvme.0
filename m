Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EB77C624CE
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Aug 2026 13:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZD6YygNg9Pn50603e1dS0QGpNkDGVP0AuhXi1ZDDeIA=; b=j+R4qyMOm3YVDyVG1OPdqRlBuQ
	TBg4MTK31WZHpD638AEu9vIXUJ20JxtNxh8+4QN1xrU8vUQ4GCuT4qnw5suOSX7jibh8Syu9iWx1/
	Oz2r93zB7uYY2kuw/BjPKPYxLPQfFoPqg1zKn20WAQrZcYtgVTRF3cGJvUKyO7P+MZbj+onZ3p1Ri
	Jayc66ZWXfQJPXGLdJQX2a2iP2oEKrmxIOtFwbMqR1xI9l6xbQTybB5nea6GsfbaPnu6rg6LaWd/K
	vclUNbAhsyJu3Btsp7lqerMqxuiL+eatv7zvmR/8JtHxcdCz9+/owesyInvnEQqsIXou015egSR88
	wspX5G/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x12Nn-00000009XGr-3CiU;
	Mon, 31 Aug 2026 13:49:07 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x12Nl-00000009XFO-0qWy
	for linux-nvme@lists.infradead.org;
	Mon, 31 Aug 2026 13:49:05 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id A40F76013A;
	Mon, 31 Aug 2026 13:49:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30DF71F00A3E;
	Mon, 31 Aug 2026 13:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788184144;
	bh=ZD6YygNg9Pn50603e1dS0QGpNkDGVP0AuhXi1ZDDeIA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=E/BCO+tWyAeWBTmvREia8CtO+LONh+GsQQTKfVsIwend/NokAsFiSUvz8AEZabzbX
	 ylY9M86Pk19aMhbpMiJdR3uRFxn/oYjbOYGQGiHz/0D19SB1XRvyqx5MKE47PLiWZe
	 1MHhJyickMd11vAyRN/4qYIoFfCfLv4BQCzC3geE9VsWUTQVL6RqXG+jx1VwFcSplp
	 Ni/WN0GqY6aI9NDpFM625GopLtmNVE8e/JzOQhV222/FTum1zApX4sm4JXWBy3//0c
	 n937TI6QGp311AtOZayiKtUygyttNVIayTtm9n8KW4nntiTu3m5aPt/P9YPrA8725I
	 9zyMY6dnK9NRg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Maurizio Lombardi <mlombard@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Daniel Wagner <dwagner@suse.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.18-6.1] nvme-core: align fabrics_q teardown with admin_q in nvme_free_ctrl
Date: Mon, 31 Aug 2026 09:29:06 -0400
Message-ID: <20260831133314.4125787-518-sashal@kernel.org>
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

From: Maurizio Lombardi <mlombard@redhat.com>

[ Upstream commit f702badaf7d31dc3dea6c66da92b5f35fadd89dc ]

Currently, the final reference for the fabrics admin queue (fabrics_q)
is dropped inside nvme_remove_admin_tag_set(). However, the primary admin
queue (admin_q) defers dropping its final reference until
nvme_free_ctrl().

Move the blk_put_queue() call for fabrics_q from
nvme_remove_admin_tag_set() to nvme_free_ctrl(). This aligns the
lifecycle management of both admin queues, ensuring they are freed
symmetrically when the controller is finally torn down.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Daniel Wagner <dwagner@suse.de>
Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

The background git searches finished: all three lookups (`git log
--grep='align fabrics_q'` and `--grep='fabrics_q teardown'` on HEAD and
`stable/linux-6.18.y`) returned no matches. That confirms the fabrics_q
alignment fix is not in this `6.18.44` tree yet, which matches the
earlier analysis — the asymmetry from `03b3bcd319b3a` is still present,
and the backport recommendation remains **YES**.

 drivers/nvme/host/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 24a5ca35aeb25..8feb774616029 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4908,10 +4908,8 @@ void nvme_remove_admin_tag_set(struct nvme_ctrl *ctrl)
 	 */
 	nvme_stop_keep_alive(ctrl);
 	blk_mq_destroy_queue(ctrl->admin_q);
-	if (ctrl->ops->flags & NVME_F_FABRICS) {
+	if (ctrl->fabrics_q)
 		blk_mq_destroy_queue(ctrl->fabrics_q);
-		blk_put_queue(ctrl->fabrics_q);
-	}
 	blk_mq_free_tag_set(ctrl->admin_tagset);
 }
 EXPORT_SYMBOL_GPL(nvme_remove_admin_tag_set);
@@ -5053,6 +5051,8 @@ static void nvme_free_ctrl(struct device *dev)
 
 	if (ctrl->admin_q)
 		blk_put_queue(ctrl->admin_q);
+	if (ctrl->fabrics_q)
+		blk_put_queue(ctrl->fabrics_q);
 	if (!subsys || ctrl->instance != subsys->instance)
 		ida_free(&nvme_instance_ida, ctrl->instance);
 	nvme_free_cels(ctrl);
-- 
2.53.0


