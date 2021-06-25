Return-Path: <SRS0=COHi=LT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9880C2B9F4
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Jun 2021 10:46:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74D1C6143B
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Jun 2021 10:46:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74D1C6143B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ILmo/Nxl1lO27WihurZDBvUiUVbd47FCd/npin0BoTE=; b=1n2RYUlfP/9LNz
	uaL2DblRVhZQW3dxlj/qsILVYsM77PyYckHrlkiEPkU8NaWW6QRG1xfYGih0zMhgMwSQKuYwX65OW
	DBJMeLOj2yoocsvvvCSxkonFBIBiAxQUd8kfDtJJ4C6/MoBuehw+2o8ajLMO12A0RZEln9jQbpXVe
	WN0OoTn9+tZ2C6rj+PONDCaRPtC+sUIbMLNleordCNcD/sZUaX1kn5mAaDpqQzAmS6Y+rTdDSrA/H
	tycduWcDxkB+TeN8EkDECVD0vD9p4hHPDd9gYN25SqPE/VefhAtXbwOSiXRlwb555lnKjeozgSvfp
	hWSlBWTs8L5Cz81rzRxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lwjLj-0015p0-R4; Fri, 25 Jun 2021 10:46:15 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lwitR-000tvK-W9
 for linux-nvme@lists.infradead.org; Fri, 25 Jun 2021 10:17:03 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 6EB2C1FE7C;
 Fri, 25 Jun 2021 10:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1624616218; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s9hSmUQi/uItysocwytSweliul09PnWtr02fcj5NE5o=;
 b=Cf/HaNyATUvsW2DAfvFHzHba4R9qgdyi9PC+WuMN9y6ExPkBdA//hw579j/8Brb3SMApfu
 oyQXn+3bd3Dp0E7CAKmNHZPGFlF9iI9YEk0xq98A2W52x7VhPCriZa3bJYUC2mP3GHm59d
 yHObh4g7i4CwD5M0I/MuqAczz4qluDI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1624616218;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s9hSmUQi/uItysocwytSweliul09PnWtr02fcj5NE5o=;
 b=+POG0CK7HWJx5LQeDadW35/ZB7Ib+WUKt+alw/P3wb2sRDGL3PjY2atko9LTVttF8RWnl7
 rlo+776djKcxdeBg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 9D42AA3BF1;
 Fri, 25 Jun 2021 10:16:57 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 17828)
 id 8A32951709BF; Fri, 25 Jun 2021 12:16:57 +0200 (CEST)
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, James Smart <james.smart@broadcom.com>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Ming Lei <ming.lei@redhat.com>, Sagi Grimberg <sagi@grimberg.me>,
 Daniel Wagner <dwagner@suse.de>
Subject: [PATCH 2/2] nvme-fc: Wait with a timeout for queue to freeze
Date: Fri, 25 Jun 2021 12:16:49 +0200
Message-Id: <20210625101649.49296-3-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210625101649.49296-1-dwagner@suse.de>
References: <20210625101649.49296-1-dwagner@suse.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210625_031702_286115_BBD10CE2 
X-CRM114-Status: GOOD (  11.33  )
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

Do not wait indifinitly for all queues to freeze. Instead use a
timeout and abort the operation if we get stuck.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/host/fc.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index a9645cd89eca..d8db85aa5417 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2955,7 +2955,14 @@ nvme_fc_recreate_io_queues(struct nvme_fc_ctrl *ctrl)
 		dev_info(ctrl->ctrl.device,
 			"reconnect: revising io queue count from %d to %d\n",
 			prior_ioq_cnt, nr_io_queues);
-		nvme_wait_freeze(&ctrl->ctrl);
+		if (!nvme_wait_freeze_timeout(&ctrl->ctrl, NVME_IO_TIMEOUT)) {
+			/*
+			 * If we timed out waiting for freeze we are likely to
+			 * be stuck.  Fail the controller initialization just
+			 * to be safe.
+			 */
+			return -ENODEV;
+		}
 		blk_mq_update_nr_hw_queues(&ctrl->tag_set, nr_io_queues);
 		nvme_unfreeze(&ctrl->ctrl);
 	}
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
