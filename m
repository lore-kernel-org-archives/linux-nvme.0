Return-Path: <SRS0=yMBa=LB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A2F3C47082
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Jun 2021 16:18:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62BC26108E
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Jun 2021 16:18:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62BC26108E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CFAz2JNOckqJiwM5IxTiC5Mm9h0xwtgfgyuTb7uSf5M=; b=zJcd02utKvkUzz
	8ZTAObEW1Au2LwH7H+lttMiUgRnLJtM9i8ko66mHZuTG4+9iBSPT7vlOi1mK1z5LPaBrAMK5WQb0j
	g3jjjU3hZNu4Oyobf/TEjc4MmklbalcCs1x1MzxmSKqrraTKAjbER+Du1jWxtD1O4RA3PLS1kZi3H
	fS7MTXsYu/s8dyFxnImrDUKhEl//tU489RjQwVUb6j0BskA2mLWbeHravm0IZX69B5CxUUTC+C1gI
	4Awf/BeZdo+UDPh2uZvAFihZHvVqtGjf7KCvBpa/ZkCtd8UwdCCc4ZPJYo+Gke7WdFAexMHagLujS
	PbfzOf2x9IdHOahg92Xg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lqHwt-004RQI-Ig; Mon, 07 Jun 2021 16:17:59 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lqHsy-004P2v-5S
 for linux-nvme@lists.infradead.org; Mon, 07 Jun 2021 16:13:58 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1948761462;
 Mon,  7 Jun 2021 16:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1623082435;
 bh=JLiPSW/F3RteIc4jb/cRphFsajUUSG+Yu0jZClB4Iw8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=mP2eOg3+Wn0ZMTlCbHlHlbePuNplAQ4bdxhgFP4VSDs0kpC093sUe1PW93SAfTawt
 EvOjTO5tevPH2L185ok3PvracnM40WpGrwPVi3V+4cNbHdqJ+fDTldMypiIz5cIaTb
 pqJzfRtloFC8TarGrqvf5fSC93/KOY/MxLPKCI/UyeCR6iHILuOhqhM+Zn/bnmSm5h
 duOoRDlwLiETkaTcau6rC7dYRFXAFM1FxEANd2pdaA+L9LwWO6IIZjjEL/dfxs2Xtu
 BnmM34zvx+nTHSwJ+bWONiwZIiLvTMLDyPojRZZF8hTKpBgFfnxOel0v07nkKg6mGp
 ekLgVfWMhjAkw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
 Sasha Levin <sashal@kernel.org>, linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.10 29/39] nvme-loop: do not warn for deleted
 controllers during reset
Date: Mon,  7 Jun 2021 12:13:08 -0400
Message-Id: <20210607161318.3583636-29-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210607161318.3583636-1-sashal@kernel.org>
References: <20210607161318.3583636-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210607_091356_254254_D3DB6556 
X-CRM114-Status: GOOD (  11.53  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Hannes Reinecke <hare@suse.de>

[ Upstream commit 6622f9acd29cd4f6272720e827e6406f5a970cb0 ]

During concurrent reset and delete calls the reset workqueue is
flushed, causing nvme_loop_reset_ctrl_work() to be executed when
the controller is in state DELETING or DELETING_NOIO.
But this is expected, so we shouldn't issue a WARN_ON here.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/loop.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index df0e5288ae6e..16d71cc5a50e 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -453,8 +453,10 @@ static void nvme_loop_reset_ctrl_work(struct work_struct *work)
 	nvme_loop_shutdown_ctrl(ctrl);
 
 	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING)) {
-		/* state change failure should never happen */
-		WARN_ON_ONCE(1);
+		if (ctrl->ctrl.state != NVME_CTRL_DELETING &&
+		    ctrl->ctrl.state != NVME_CTRL_DELETING_NOIO)
+			/* state change failure for non-deleted ctrl? */
+			WARN_ON_ONCE(1);
 		return;
 	}
 
-- 
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
