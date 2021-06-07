Return-Path: <SRS0=yMBa=LB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B43DC47082
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Jun 2021 09:24:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C225061159
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Jun 2021 09:24:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C225061159
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=tW2Sgtc79KXxexyadQAXFiPeqsgZLY+NBqmutIOREm0=; b=0D4061L2bKzSRu
	pB99+1OgdirjMQ6vq0q1k995aYAlS/m80BTTr1J1DE3ENxZKM8qKHAamTukhxG0KAylpySR5FpcIM
	ydlqfQfEg++uh8gyi0Cq2P+9snGz3NFbNWDXFK5YBw58GuubFVd0hRbpVZlNZeaT/3D9yB5WRjaOT
	WGKtLQURfizUaMAnH4MlpVZSf9Qgt9X1u8490fE7SuM0KjPWj6Sm3GJgm0MDslUa/+BebDBgT9wjt
	u9Hnw9o/g8Cpahovbsb25dWghhL5iRBfUeKbrhA9ZMsFXno3A4IVpH4Ka7b4aYvFSGemsZxAfYFYN
	U9BIMS+cZPKaAVidebBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lqBUp-002ZZA-NH; Mon, 07 Jun 2021 09:24:35 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lqB4M-002RGz-P7
 for linux-nvme@lists.infradead.org; Mon, 07 Jun 2021 08:57:18 +0000
Received: from relay2.suse.de (unknown [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 297F121A5B;
 Mon,  7 Jun 2021 08:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1623056232; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=70d+eeUNUJUrApqI9dcysM+A4Ouzv/oKGOxjeF7oXZo=;
 b=jWgCRi59aEiHaDvW/KVX0XjMm20RZwopSJiDit2t46cZbiXznJ7t3XhxHg+bVH6jNAvcgx
 40W103nVzIqtB2LfpOTYG3unnCnkURo3c/+YO8DiacHJq+16wXhRvEOgIgcw8WtWYo7OKY
 PO8PcLSbzcdg9m34g4vfGGUrUvhJIk0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1623056232;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=70d+eeUNUJUrApqI9dcysM+A4Ouzv/oKGOxjeF7oXZo=;
 b=3IYcJthl7lzsUQ9np6thDiH1QtqT+G3oQEEA3Bxv63MhPO96ocbjjSbhCRaBjTHFGnoGju
 lIXfTDc0b8pm29BQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id EC4C4A3B83;
 Mon,  7 Jun 2021 08:57:11 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 17828)
 id DF693516FDED; Mon,  7 Jun 2021 10:57:11 +0200 (CEST)
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>,
 Hannes Reinecke <hare@suse.de>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH v2] nvme: verify MNAN value if ANA is enabled
Date: Mon,  7 Jun 2021 10:56:56 +0200
Message-Id: <20210607085656.101772-1-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210607_015715_021761_F4F1FED2 
X-CRM114-Status: GOOD (  10.72  )
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

The controller is required to have a non-zero MNAN value if it supports
ANA:

   If the controller supports Asymmetric Namespace Access Reporting, then
   this field shall be set to a non-zero value that is less than or equal
   to the NN value.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---

v2: - moved the check to nvme_mpath_init_identify
    - added reviewed tags

 drivers/nvme/host/multipath.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index a501917d4c6e..23573fe3fc7d 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -813,6 +813,13 @@ int nvme_mpath_init_identify(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 	    !(ctrl->subsys->cmic & NVME_CTRL_CMIC_ANA))
 		return 0;
 
+	if (!ctrl->max_namespaces ||
+	    ctrl->max_namespaces > le32_to_cpu(id->nn)) {
+		dev_err(ctrl->device,
+			"Invalid MNAN value %u\n", ctrl->max_namespaces);
+		return -EINVAL;
+	}
+
 	ctrl->anacap = id->anacap;
 	ctrl->anatt = id->anatt;
 	ctrl->nanagrpid = le32_to_cpu(id->nanagrpid);
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
