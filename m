Return-Path: <SRS0=TIQn=6U=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 330B4C28CBC
	for <linux-nvme@archiver.kernel.org>; Wed,  6 May 2020 22:44:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0062720659
	for <linux-nvme@archiver.kernel.org>; Wed,  6 May 2020 22:44:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eaidRcLi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0062720659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=GqAIkRI4hP+hebo5HDd419Zty5S5poLzH7Dp5nqs/jI=; b=eaidRcLi0pdBPg
	LLqLW8Y9L5H64jK+MhYsu1wkZ9BEFfMCaMpLUoXfy23D2/TXv3oXaXkEv30vSHHvVmjZ9nIdoCl8h
	9y7teJK14736/Yjg1LDxBQeaLbU/UU22ZrrOcayiYtk7VLKKJTQphDMMronVSmaqwfH6dd/JH2BIB
	+WrhFrZUwr8vjTXNZixpU00j9XsoXpLZqwxblMmtQkOM394dRxLgv4Ffzfig+fgf/cSoA4cAT9H5t
	IxLkWtSN49RyqClJl9xuWhrYXT0bViiBdyToHjZMPc3HCtp/ARoJ+2SZ5D+Omb4E/npaoDNlF5ElP
	FCcQE4vTFKTLbh8dS2kA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jWSlr-0004U3-44; Wed, 06 May 2020 22:44:07 +0000
Received: from [2601:647:4802:9070:75a3:623e:9ea4:11b3]
 (helo=bombadil.infradead.org)
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jWSlo-0004TW-Co; Wed, 06 May 2020 22:44:04 +0000
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>
Subject: [PATCH] nvme: fix possible hang when ns scanning fails during error
 recovery
Date: Wed,  6 May 2020 15:44:02 -0700
Message-Id: <20200506224402.19952-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
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
Cc: Anton Eidelman <anton@lightbitslabs.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

When the controller is reconnecting, the host fails I/O and admin
commands as the host cannot reach the controller. ns scanning may
revalidate namespaces during that period and it is wrong to remove
namespaces due to these failures as we may hang (see 205da2434301).

One command that may fail is nvme_identify_ns_descs. Since we return
success due to having ns identify descriptor list optional, we continue
to compare ns identifiers in nvme_revalidate_disk, obviously fail and
return -ENODEV to nvme_validate_ns, which will remove the namespace.

Exactly what we don't want to happen.

Fixes: 22802bf742c2 ("nvme: Namepace identification descriptor list is optional")
Tested-by: Anton Eidelman <anton@lightbitslabs.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 2df6eb4dfe5c..fd81115edb82 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1125,7 +1125,7 @@ static int nvme_identify_ns_descs(struct nvme_ctrl *ctrl, unsigned nsid,
 		  * Don't treat an error as fatal, as we potentially already
 		  * have a NGUID or EUI-64.
 		  */
-		if (status > 0)
+		if (status > 0 && !(status & NVME_SC_DNR))
 			status = 0;
 		goto free_data;
 	}
-- 
2.20.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
