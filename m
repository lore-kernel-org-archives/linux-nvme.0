Return-Path: <SRS0=W+Vz=CJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F74DC433E7
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Aug 2020 15:32:05 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE91D21556
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Aug 2020 15:32:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="2JCXZF7n";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="AXOIdLCO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE91D21556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=cbHOJ8/ivCP8T1g7vs8rVLg2A2ZS8FxUpIBg/ejDzek=; b=2JCXZF7nAFAo8aA3g+OdR0fzX
	KCMOaYjNCcV8TuzJKCj3/W9umn2ILFYHRdU6Qgi/BFKnF6Y4ybIU2/fcoeV7STzimbfT675AhWHP8
	32ux757Vu9W739SoXD/Wl3JkRJKLaend06L3gjJPcWoyOCq5nqBxZT2rFQ1p2/tVuTd4/vQgF6zdr
	L+T1Dskq/Qm603LYZQBoIjyvyWRgGlbe9GrRDIH4qO9OFo8B3Mg6F8/HCKk+rNaFPJ+RybpatQh5H
	+JA4URkR9WBAp76oaMzulaFFYFJCQw3zvt3VvJu0MripRYc0G9ORZPy0O89aov9dhtsDpmV5ZX7si
	Wnb1YzUnA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kClms-0001Iq-BR; Mon, 31 Aug 2020 15:32:02 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kClmm-0001HC-KD
 for linux-nvme@lists.infradead.org; Mon, 31 Aug 2020 15:31:57 +0000
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id F187F2158C;
 Mon, 31 Aug 2020 15:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1598887916;
 bh=MwxD5VJzHt3uN3NMF6cZstG6zJoHeJtlRavYi1XCW/4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=AXOIdLCO3UAHTyvRHpp+x/YinvY95tertdXrWiWrNYb+EzLCO+2Utbkg7PHrvCDQy
 FO4ib3D9w8x2JSqob7LfGJbdDCYJZZBuMaBbeg5y6I5J/d9xcuFjbKW4PN6SWuaRpr
 z3dD97ADekVOrFztYYm5JuSETWBJNkgBg9tHImLc=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 3/6] nvmet: Disable keep-alive timer when kato is
 cleared to 0h
Date: Mon, 31 Aug 2020 11:31:46 -0400
Message-Id: <20200831153150.1024799-3-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200831153150.1024799-1-sashal@kernel.org>
References: <20200831153150.1024799-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200831_113156_885556_86705DB7 
X-CRM114-Status: GOOD (  12.17  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Amit Engel <amit.engel@dell.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Amit Engel <amit.engel@dell.com>

[ Upstream commit 0d3b6a8d213a30387b5104b2fb25376d18636f23 ]

Based on nvme spec, when keep alive timeout is set to zero
the keep-alive timer should be disabled.

Signed-off-by: Amit Engel <amit.engel@dell.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 96ea6c76be6e5..63b87a8472762 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -205,6 +205,9 @@ static void nvmet_keep_alive_timer(struct work_struct *work)
 
 static void nvmet_start_keep_alive_timer(struct nvmet_ctrl *ctrl)
 {
+	if (unlikely(ctrl->kato == 0))
+		return;
+
 	pr_debug("ctrl %d start keep-alive timer for %d secs\n",
 		ctrl->cntlid, ctrl->kato);
 
@@ -214,6 +217,9 @@ static void nvmet_start_keep_alive_timer(struct nvmet_ctrl *ctrl)
 
 static void nvmet_stop_keep_alive_timer(struct nvmet_ctrl *ctrl)
 {
+	if (unlikely(ctrl->kato == 0))
+		return;
+
 	pr_debug("ctrl %d stop keep-alive\n", ctrl->cntlid);
 
 	cancel_delayed_work_sync(&ctrl->ka_work);
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
