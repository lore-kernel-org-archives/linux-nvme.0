Return-Path: <SRS0=adoP=K2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC71C47080
	for <linux-nvme@archiver.kernel.org>; Mon, 31 May 2021 10:37:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4509C60FF3
	for <linux-nvme@archiver.kernel.org>; Mon, 31 May 2021 10:37:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4509C60FF3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=HB9tmMGuWCDIgaAh7UoWa67/jKenwvV64uF3G/ohteA=; b=2oZ0PzGTar7Jig
	GXoDcJEXdLaFxGx0xAvYlbvMjimMXVM12ld8tRB08hEMVfdgWiXQ5VORtT7VxNug97BuqB/cbxIPy
	QplXIBRoQ2aggX0P63v21k4hNEv/7SwN0gAd277QBN7Dxzz89bpgEbkd4vyklPx7I2uGW/5kNtZvr
	DSyRb9jwu3opBldPXhEaTgM16PgvcWTkUa0CEohgFXciors6nDMq44rmjnx0+PKhlVSXPUVXpz2vN
	XqmIA3L/SpuFWDl1JcJYar/Rtd0srRX/bqVzw+TREesTUW8rKcGyCN+qAeChvtqNogpOZydkMd39Q
	IRf2omcFUOcuoCmOZ2Yg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lnfIF-00BsJK-Gs; Mon, 31 May 2021 10:37:11 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lnfI0-00BsIg-No
 for linux-nvme@lists.infradead.org; Mon, 31 May 2021 10:36:58 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1622457413; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=spA1WpO8iPOW7X7Idno4u2SyDNrcS/UVwi7LqykGzYY=;
 b=HF8BnQwNDq7jA0Z/NRVOmZUW2OeI3vziHM4gCVcXUu8QS08TKOXZOzHRnrQqW/qvkwDXmu
 RMQLsopql4cqMM59ldVhjvuRdoZP2cwUZ0OvV1bZ+PQKkwMBNpQ6VHzqlELDRFCmY0MHvx
 /v1f+lZqeajy2pNbKEPrTv04MD9z+5A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1622457413;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=spA1WpO8iPOW7X7Idno4u2SyDNrcS/UVwi7LqykGzYY=;
 b=M91Qa1eZM9y91OgG+J6EbX/7qNYePKUlEeZgOpqEOWKPhneXRvvM0q5rHHA3FDhXS2zcsQ
 H/iDKro39JCfZ6Dw==
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 802EAAE72;
 Mon, 31 May 2021 10:36:53 +0000 (UTC)
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH] nvme: verify MNAN value if ANA is enabled
Date: Mon, 31 May 2021 12:36:51 +0200
Message-Id: <20210531103651.109426-1-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210531_033656_943052_9EBCE5B9 
X-CRM114-Status: GOOD (  11.74  )
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

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
This is a follow up to the discussion in

  https://lore.kernel.org/linux-nvme/20210521144734.90044-1-dwagner@suse.de/

 drivers/nvme/host/core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index cb1a76a3d42a..4c412adc9e14 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2972,6 +2972,16 @@ static int nvme_init_identify(struct nvme_ctrl *ctrl)
 	if (ret < 0)
 		goto out_free;
 
+#ifdef CONFIG_NVME_MULTIPATH
+	if (ctrl->ana_log_buf && (!ctrl->max_namespaces ||
+				  ctrl->max_namespaces > le32_to_cpu(id->nn))) {
+		dev_err(ctrl->device,
+			"Invalid MNAN value %u\n", ctrl->max_namespaces);
+		ret = -EINVAL;
+		goto out_free;
+	}
+#endif
+
 	if (ctrl->apst_enabled && !prev_apst_enabled)
 		dev_pm_qos_expose_latency_tolerance(ctrl->device);
 	else if (!ctrl->apst_enabled && prev_apst_enabled)
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
