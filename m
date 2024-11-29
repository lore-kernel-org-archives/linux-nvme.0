Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3377ED6EC0B
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Nov 2024 14:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=W7fi5Qfhxlfx5J7eFX1Tj07ZPaHUxET81ZP9gVn9Zb8=; b=OjZ0m5sQxIBGn6ymKknQ61Lvk0
	lZlGKE63ClHWdI80+9qFClgzUNqbl0OnHu8zEDuYZ8S2PiyFBLjfQc5PqyXvLnG2S2RPG9Oexgycn
	FW0C4ZMDRmRKNWip7hUsqDmbOGfYH2G+6DZJ2aSckmqvy5gg8s5+1P/Eo4DlLpy8vz33UzZQgx/9B
	FY1efmnRvi9qFoSGpiFSKzC+JBK34/+/cyV95FBJ3cntX2JzqBFJgoaZ2MmAMjY0wwL/olx9Fu/jB
	8PmDS0/gOFgoPibf2LXIIQm8a2HFQUHVX8UzJCOT5IXX4CPgMpJjWSt6o5n2Yap31mKKzdTSb5XD/
	wGF6f/zA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tH1dT-00000000GtE-0zfm;
	Fri, 29 Nov 2024 14:06:19 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tH1dR-00000000Gsi-09OZ
	for linux-nvme@lists.infradead.org;
	Fri, 29 Nov 2024 14:06:18 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id D392C5C4540;
	Fri, 29 Nov 2024 14:05:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EDBAC4CED2;
	Fri, 29 Nov 2024 14:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732889173;
	bh=KfeMttm7ng/myQ6H8f8TZsjJuUgfLQdUGeY6+FV9I+o=;
	h=From:To:Cc:Subject:Date:From;
	b=BTV0g36mD8jZW7vszsNbL8N/z9UDpjbDjCawOyXVQotqpS2H7ahv2e9qGwvwgP0IJ
	 fu0lsSB6WpPaI5clqiLJbiePdCBUnqdI1zZV+hW+Xs8HOGDsJvQs+h5lnASV+AKoJH
	 ehDUY5WLz7D14AilQbxBX2ffpOC+R0ShZLqDQ5xncBMaaeAWAlbwdCXcCH/5ttTKG+
	 dNiH5TlpDiHpL3dO/uQZP3cJbejYiiXI5+XwKTber7TP7DQ/5wahzTwqZJQs+2x6rJ
	 ODSXT5Gn7J3pDUfVz8DAr0b8g0B3MT4wONEee3TW0Nhj2SeWh6m9hEE5Nh9/fBKni4
	 YLMHDm6ytOnjA==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH] nvme: Remove namespace when nvme_identify_ns_descs() failed
Date: Fri, 29 Nov 2024 15:06:08 +0100
Message-Id: <20241129140608.115282-1-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241129_060617_118115_7F9B63CD 
X-CRM114-Status: GOOD (  12.95  )
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

When a namespace gets unmapped on the target during scanning
nvme_identify_ns_descs() returns with a non-retryable error.
With the currrent code we will ignore that error on the grounds
that we failed to get information, and hence cannot make any
decisions whether to keep or remove that namespace.
But a non-retryable error implies that the namespace is _not_
present as we cannot retry that command and will never get
information about that namespace.
And we need to remove the namespace during scanning, as otherwise
the AEN informing us about a namespace change will find the NSID
present, but nvme_validate_ns() will fail, and the namespace
will never be updated with the correct information.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/host/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 9e7e63e10e5a..396520cb3ce6 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3999,8 +3999,11 @@ static void nvme_scan_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	struct nvme_ns *ns;
 	int ret;
 
-	if (nvme_identify_ns_descs(ctrl, &info))
+	ret = nvme_identify_ns_descs(ctrl, &info);
+	if (ret > 0 && (ret & NVME_STATUS_DNR)) {
+		nvme_ns_remove_by_nsid(ctrl, nsid);
 		return;
+	}
 
 	if (info.ids.csi != NVME_CSI_NVM && !nvme_multi_css(ctrl)) {
 		dev_warn(ctrl->device,
-- 
2.35.3


