Return-Path: <SRS0=kLfw=OL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83847C433FE
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Sep 2021 17:43:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F07B610A0
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Sep 2021 17:43:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4F07B610A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9m153lerixKnmJEflwqnOXC8AL9I9LwgPavNQhfvxW4=; b=zCwCWklLylG+wX
	dDRoNXSf88ufC3X0FeJPvjKjZo8eUYr3AzbDT1rDUJp3Ehk/s7XSeBmHK5LJC6Lf8LB0lCnKvO3NP
	+9yV0hidfSrbbVdUmTAk+4OGCqmSGIzeFDPGbmvBuaHjCBbxmKBLSt6yOg8QY0sjEmax5y1AwW3Ot
	XHIE8xTnuUh5NkpZoKFDFWealoYt/0sQbd4g3SGZNxp4EKTkDM6KdjCIukuQRiEuD90QLswD/zktv
	8kpNBsaVazfTjWSm5OegLBeTl6bh0U7xto95AAaTwY9rt9a2yzhQKDQUJ5Gdjz/BbsxAv2kYt1f0z
	OBAG63x76pclgGpSv1jw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mSjnQ-005MDd-2D; Tue, 21 Sep 2021 17:43:08 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mSjmz-005M6H-3F
 for linux-nvme@lists.infradead.org; Tue, 21 Sep 2021 17:42:44 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 236E51FF05;
 Tue, 21 Sep 2021 17:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1632246159; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JRW7skpv3FZfyFsWMEM1N1vxVdal0H1XyoUuSxNTIAY=;
 b=OVo+Bh+yvpYj1Wy8akIS8o2z2sl+weYg3LB0UrVqu++ZdaL8HBzeCT0FCNucbBhTwYuEek
 KIMJ19CX/Tjjtsx8quM4NGijTe2OHzzMpxSP6ztdb/riLZPzZduet/TwVjgvtqaLZa9+vj
 dW1fsSaiOIFepDAsnRkHU2QSXU8AS8Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1632246159;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JRW7skpv3FZfyFsWMEM1N1vxVdal0H1XyoUuSxNTIAY=;
 b=JzLtHNVxVuP+xxYt/PXdSbUTirMFmgDNf6V9U09McrLn80FP5uHo7FsGBAo6aYmlIYQ3Up
 FijWqyRgcUWQTbAg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id F0027A3B8A;
 Tue, 21 Sep 2021 17:42:38 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id DF2EC518EAA7; Tue, 21 Sep 2021 19:42:38 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 2/3] nvme: add new discovery log page entry definitions
Date: Tue, 21 Sep 2021 19:42:29 +0200
Message-Id: <20210921174230.30552-3-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210921174230.30552-1-hare@suse.de>
References: <20210921174230.30552-1-hare@suse.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210921_104241_349683_CC8BA620 
X-CRM114-Status: GOOD (  12.46  )
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

TP8014 adds a new SUBTYPE value and a new field EFLAGS for the
discovery log page entry.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 include/linux/nvme.h | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index ed2428918bca..9e816fab1e58 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -27,8 +27,9 @@
 #define NVME_NSID_ALL		0xffffffff
 
 enum nvme_subsys_type {
-	NVME_NQN_DISC	= 1,		/* Discovery type target subsystem */
+	NVME_NQN_DISC	= 1,		/* Referral to another discovery type target subsystem */
 	NVME_NQN_NVME	= 2,		/* NVME type target subsystem */
+	NVME_NQN_CURR	= 3,		/* Current discovery type target subsystem */
 };
 
 enum nvme_ctrl_type {
@@ -1311,6 +1312,13 @@ struct nvmf_common_command {
 
 #define MAX_DISC_LOGS	255
 
+/* Discovery log page entry flags (EFLAGS): */
+enum {
+	NVME_DISC_EFLAGS_EPCSD		= (1 << 1),
+	NVME_DISC_EFLAGS_DUPRETINFO	= (1 << 0),
+};
+
+
 /* Discovery log page entry */
 struct nvmf_disc_rsp_page_entry {
 	__u8		trtype;
@@ -1320,7 +1328,8 @@ struct nvmf_disc_rsp_page_entry {
 	__le16		portid;
 	__le16		cntlid;
 	__le16		asqsz;
-	__u8		resv8[22];
+	__le16		eflags;
+	__u8		resv10[20];
 	char		trsvcid[NVMF_TRSVCID_SIZE];
 	__u8		resv64[192];
 	char		subnqn[NVMF_NQN_FIELD_LEN];
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
