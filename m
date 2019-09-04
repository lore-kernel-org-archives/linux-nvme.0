Return-Path: <SRS0=Tecl=W7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7AA5C3A59E
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Sep 2019 22:00:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B882E20870
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Sep 2019 22:00:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="X9yGyNoT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B882E20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=AcISIOAWlg5BHaPs3jQ1rIxtNYQSxAPw/Rp0l3NDfto=; b=X9yGyNoTyEChbNPfxgqku/TkKj
	TkK6j6lUvoRX54NP394mbClYTd3NxXGc4PNUSDJPw93+o8YrN3DHrx++/SuA1Y2PNkpatSf7SywRQ
	JhoFFX5BAYJN7AkEUpFXYUJrMo2b8BGf16OH/Hr44X0pwqBhs9DMu0oM7oCwXYebh6/wIDkV/HcOf
	ABPn0XqJ/2TJmg6xlMB2byqNwJTxcVBPqLdepo0dEIQNRmOgAlrRIxp+ErnPzVdu2LYzqyX07EG6I
	hPkkiYfHDVekY5bCcZGOrKYXV5lS68bypbrBbpJtlejIeq/cX1mUl71GmMBDpvEfh9EFpHR5TT7YZ
	/km88aAA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i5dK4-0007HJ-16; Wed, 04 Sep 2019 22:00:16 +0000
Received: from [2600:1700:65a0:78e0:514:7862:1503:8e4d]
 (helo=bombadil.infradead.org)
 by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
 id 1i5dJm-0005pf-Oz; Wed, 04 Sep 2019 21:59:58 +0000
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Subject: [PATCH v4 1/4] nvme-fabrics: allow discovery subsystems accept a kato
Date: Wed,  4 Sep 2019 14:59:50 -0700
Message-Id: <20190904215954.15423-2-sagi@grimberg.me>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190904215954.15423-1-sagi@grimberg.me>
References: <20190904215954.15423-1-sagi@grimberg.me>
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
Cc: Keith Busch <keith.busch@intel.com>, Hannes Reinecke <hare@suse.de>,
 Christoph Hellwig <hch@lst.de>, James Smart <james.smart@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This modifies the behavior of discovery subsystems to accept
a kato as a preparation to support discovery log change
events. This also means that now every discovery controller
will have a default kato value, and for non-persistent connections
the host needs to pass in a zero kato value (keep_alive_tmo=0).

Reviewed-by: Minwoo Im <minwoo.im.dev@gmail.com>
Reviewed-by: James Smart <james.smart@broadcom.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/fabrics.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 145c210edb03..74b8818ac9a1 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -381,8 +381,8 @@ int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl)
 	 * Set keep-alive timeout in seconds granularity (ms * 1000)
 	 * and add a grace period for controller kato enforcement
 	 */
-	cmd.connect.kato = ctrl->opts->discovery_nqn ? 0 :
-		cpu_to_le32((ctrl->kato + NVME_KATO_GRACE) * 1000);
+	cmd.connect.kato = ctrl->kato ?
+		cpu_to_le32((ctrl->kato + NVME_KATO_GRACE) * 1000) : 0;
 
 	if (ctrl->opts->disable_sqflow)
 		cmd.connect.cattr |= NVME_CONNECT_DISABLE_SQFLOW;
@@ -740,13 +740,6 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 				pr_warn("keep_alive_tmo 0 won't execute keep alives!!!\n");
 			}
 			opts->kato = token;
-
-			if (opts->discovery_nqn && opts->kato) {
-				pr_err("Discovery controllers cannot accept KATO != 0\n");
-				ret = -EINVAL;
-				goto out;
-			}
-
 			break;
 		case NVMF_OPT_CTRL_LOSS_TMO:
 			if (match_int(args, &token)) {
@@ -883,7 +876,6 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 	}
 
 	if (opts->discovery_nqn) {
-		opts->kato = 0;
 		opts->nr_io_queues = 0;
 		opts->nr_write_queues = 0;
 		opts->nr_poll_queues = 0;
-- 
2.17.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
