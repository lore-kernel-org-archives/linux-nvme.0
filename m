Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 253F9EB64D7
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Jun 2023 09:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=BDavSwpL/emrL0jmEVu/MjjYXCNOIEGexx7M/IfOglA=; b=htM4z0mNCqskMd/pCvu8+tKH3t
	ZDWJ3Uf5QAt4ay+y/2qc0wWrbqjGy3MVWPJiHSZO+czTtALoANTXeWRh6TjPg63YubSsMqwXTw7Dg
	ec/1XEamBv9hmJ5mNWNtkUAfH+xTCr9arH9PVXGqBxKLqkd73APCK9awkvc4T9awmZhfKC0xjw1DG
	onvlTrlwWKfZ6ZfB77nDSn93Yl1BTgv0gPgjIoJS137hHavimMAgGmB94XkLBKSOhxTjpV4SG23fj
	sjU0YTqmQaoGGrFmaxnzbcCeXsrbBgLamwhTV7us49E4ejwmYb6P+bcPKr31d6QOims313XUz0kaR
	3pIvwODw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qBu3Q-00DqHk-1R;
	Wed, 21 Jun 2023 09:23:08 +0000
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qBu3N-00DqGw-2v
	for linux-nvme@lists.infradead.org;
	Wed, 21 Jun 2023 09:23:07 +0000
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f9bece8e19so5552935e9.1
        for <linux-nvme@lists.infradead.org>; Wed, 21 Jun 2023 02:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687339383; x=1689931383;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BDavSwpL/emrL0jmEVu/MjjYXCNOIEGexx7M/IfOglA=;
        b=DPbv19/WveFHJNHFv0ZJXUzxtx6VxswdMJEhxs0KqZaeELEXc2jKaAE18IMo4FWGKv
         o6nNd0At6zlpFmciLyZvRA9XqkOYEeItU+1IfEBd097KDR9k9BAfYL9M5Dz4JJ09NCrH
         UNaylIcR/7YE7iNwo/XN3Uwk24Od2Kly6FkYiviUzV3ByXduXeykRLqa5mGiveVqjc/Z
         8QgU9GMpRcpa1dY1tnh6p2Idr52pK99sm9C2KS4OMCy28e82PxfhyDnykuGlrr2U/K9x
         VS+9v+trd4FwM3zSlmfDF61hC581v9ntTRrg2XzMdifHNV63WXpUusQgE/4G4f9UnXJx
         eYTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687339383; x=1689931383;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BDavSwpL/emrL0jmEVu/MjjYXCNOIEGexx7M/IfOglA=;
        b=XI+8CLIgyiovjF5muQn0hgcXu+q2E04qEqqfsTvBDyIcZYhnKfOfhSXJGDee9DmfgP
         b3UrwsC5rcBDz8E/+M3clybzRATP4EZa0CPTLDt8d10AnX5b9T9iMTiXFHAgtRRnyl9k
         dPcu7q1/5f8S205MoFqQqROSyS74BoqNqmf3bGIfxcPuVWE5RjvnTMJb/Ihnlm/rCxsY
         J5Z5PF2mqp16Bswf5Wwnkb71DAkREfztfIu52jdBGzL2eYTTjcthB/UK07TvfZifXKcc
         gJsHXZdMhD0HR14Xlpsq2gYLqWEH0ZecXQNsZ4xbumnRqS1g+v/hgAQxWvdLZfHpgg8f
         BhJw==
X-Gm-Message-State: AC+VfDwAhMle2ncr8ElAvhczH6/4t2PCFuVaBqoMqiMfA1w0OeSxLjjR
	v7hAQpkaqvcSD6JIfNKjH+ElfOpPcWQ=
X-Google-Smtp-Source: ACHHUZ6nFoTJNbrKMzfAaOf9XahYrXr9ORvb4E0GZhScQ5eQEmgXUhztD7g2JSRXZ7xkbpyXkOfMKw==
X-Received: by 2002:a1c:7705:0:b0:3f9:7a6:3cae with SMTP id t5-20020a1c7705000000b003f907a63caemr11857635wmi.9.1687339383049;
        Wed, 21 Jun 2023 02:23:03 -0700 (PDT)
Received: from localhost.localdomain ([37.169.177.177])
        by smtp.gmail.com with ESMTPSA id x23-20020a05600c21d700b003f427687ba7sm4362049wmj.41.2023.06.21.02.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 02:23:02 -0700 (PDT)
From: Irvin Cote <irvincoteg@gmail.com>
To: hch@lst.de
Cc: kbusch@kernel.org,
	axboe@kernel.dk,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	Irvin Cote <irvincoteg@gmail.com>
Subject: [PATCH] nvme-core: checking nlbaf when retrieving lbaf index
Date: Wed, 21 Jun 2023 11:22:58 +0200
Message-Id: <20230621092258.34678-1-irvincoteg@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230621_022305_941348_08DCA7ED 
X-CRM114-Status: GOOD (  12.97  )
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

As per NVM-Express-NVM-Command-Set-Specification-1.0c
ignore the two most significant bits of flbas if nlbaf
is inferior or equal to 16

Signed-off-by: Irvin Cote <irvincoteg@gmail.com>
---
 drivers/nvme/host/core.c |  4 ++--
 include/linux/nvme.h     | 11 ++++++++---
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 3ec38e2b9173..cbabed94b4c7 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1753,7 +1753,7 @@ static bool nvme_ns_ids_equal(struct nvme_ns_ids *a, struct nvme_ns_ids *b)
 static int nvme_init_ms(struct nvme_ns *ns, struct nvme_id_ns *id)
 {
 	bool first = id->dps & NVME_NS_DPS_PI_FIRST;
-	unsigned lbaf = nvme_lbaf_index(id->flbas);
+	unsigned lbaf = nvme_lbaf_index(id);
 	struct nvme_ctrl *ctrl = ns->ctrl;
 	struct nvme_command c = { };
 	struct nvme_id_ns_nvm *nvm;
@@ -2024,7 +2024,7 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 		return ret;
 
 	blk_mq_freeze_queue(ns->disk->queue);
-	lbaf = nvme_lbaf_index(id->flbas);
+	lbaf = nvme_lbaf_index(id);
 	ns->lba_shift = id->lbaf[lbaf].ds;
 	nvme_set_queue_limits(ns->ctrl, ns->queue);
 
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 779507ac750b..edfb6140a063 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -569,10 +569,15 @@ enum {
 	NVME_NVM_NS_64B_GUARD	= 2,
 };
 
-static inline __u8 nvme_lbaf_index(__u8 flbas)
+static inline __u8 nvme_lbaf_index(struct nvme_id_ns *id)
 {
-	return (flbas & NVME_NS_FLBAS_LBA_MASK) |
-		((flbas & NVME_NS_FLBAS_LBA_UMASK) >> NVME_NS_FLBAS_LBA_SHIFT);
+	__u8 lbaf_index = id->flbas & NVME_NS_FLBAS_LBA_MASK;
+
+	if (id->nlbaf > 16)
+		lbaf_index |= ((id->flbas & NVME_NS_FLBAS_LBA_UMASK) >> NVME_NS_FLBAS_LBA_SHIFT);
+
+	return lbaf_index;
+
 }
 
 /* Identify Namespace Metadata Capabilities (MC): */
-- 
2.40.1


