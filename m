Return-Path: <SRS0=9COT=NS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6536BC432BE
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Aug 2021 09:29:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A75D60FD8
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Aug 2021 09:29:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1A75D60FD8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=+qGVM4fgEfBHLisJreJjozXFevcs+/y60RobRS2e6vU=; b=V9GGpb5PbEDFST
	4ZWNJYks/yqwLXg4x8+LzYF/XXU6s3aOGPtpy8zppguLUt6GgJR3393uGiIHxlB1gGP+Y3Aa034DX
	A9NH3QOx8aZ+hR5RFDz+mdnVwom9xdwJi42yTVXuBCFxTyQxXSFiJsYIGeijvGCKMbSwuk/GW+Wbp
	UNcOZ63VduwE19TfsEduBf9mtdQKzG3/VFYDtnmJQrBBhPUO8rqhQREFoLixgAGStdzfmVMUVp0CA
	TcT0z72XMZXggLOd9gKHENxLT4ICASHTBGVuylhCJSVXefHXCsMDUI0uNBgE+XEzSJ6UyAMaTqsYl
	Ii5UM542KNdzSS5HObyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mJYB7-00C33b-8s; Fri, 27 Aug 2021 09:29:37 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mJYB1-00C32C-26
 for linux-nvme@lists.infradead.org; Fri, 27 Aug 2021 09:29:36 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 9E0B222377;
 Fri, 27 Aug 2021 09:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1630056567; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=l+kUkUmt4Yq5oe5ANi4aUW+j6s03jbFEP4ZRYT99Bxs=;
 b=jcUud7Eaqb4SjDRn9tJaq695nAEZMdscpYiK/Sy4G+BGul3L2jBubAJ1J5hZA7Xgwp5K/a
 Ndzen+GAEPmutD/S5+ayvogdtBGQ8twe6BCBHv4TBnh33E3pMgpybqwEb0A+2fONM/Lka8
 LU7FgVNroCsI7Mb4yL6tmV/tf6P1/6k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1630056567;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=l+kUkUmt4Yq5oe5ANi4aUW+j6s03jbFEP4ZRYT99Bxs=;
 b=iEYSkJwtPMsanH/q2JsmIRn3ZTHrWMNnJkMyIBb9ASvn8Kv8erVpp1rXieDBK0Sgz68oKO
 ZIWaUE89aYb9t2BQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 9651DA3B97;
 Fri, 27 Aug 2021 09:29:27 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 80918518DB10; Fri, 27 Aug 2021 11:29:27 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>
Subject: [PATCH] nvmet: fixup buffer overrun in nvmet_subsys_attr_serial()
Date: Fri, 27 Aug 2021 11:29:26 +0200
Message-Id: <20210827092926.9525-1-hare@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210827_022931_297284_010CF0FE 
X-CRM114-Status: GOOD (  10.69  )
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

The serial number is copied into the buffer via memcpy_and_pad()
with the length NVMET_SN_MAX_SIZE. So when printing out we also
need to take just that length as anything beyond that will be
uninitialized.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/target/configfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 008be02fbac9..255db21b73ee 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -1113,7 +1113,7 @@ static ssize_t nvmet_subsys_attr_serial_show(struct config_item *item,
 {
 	struct nvmet_subsys *subsys = to_subsys(item);
 
-	return snprintf(page, PAGE_SIZE, "%s\n", subsys->serial);
+	return snprintf(page, NVMET_SN_MAX_SIZE, "%s\n", subsys->serial);
 }
 
 static ssize_t
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
