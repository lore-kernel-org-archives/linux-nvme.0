Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80FC4CDB483
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Oct 2023 02:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=zm5VsIvK+4k6L9mQUsZAA7CDADc1I1kBEODLAOG/QSQ=; b=xB4Sig70oSKLIre3WriJ12Z6XR
	uK7VtoOtL9aOzzpHS7VgwhIHnmMyYFCmuR+p9vjlPzCP9JRzEOOfEY3DuRh9KQ6vrVfVwe2VYHyCj
	pVI5V/kgCG2yDvF09neK/JSbFp30obL98aHyXwBheWcYEcIHzXdb12DGFDSrAoQKnYQBX0mStn6gq
	o0gUnkeqEII0Fo0pItf/sBL7lWlX5lq/zLCuOXBv4TP3o9VVWhdjsMHuIXjhtdXCehgsl78XcWE28
	eBsRzCOon0jBKqPDSGg+kdeOwUmtrTFUFydEk2QbDyr56NcaZXW40ZDU7WKsfbVLE2oc6wHwWbXTD
	gP0juGyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qtJDF-00GAnb-0r;
	Thu, 19 Oct 2023 02:56:41 +0000
Received: from out30-113.freemail.mail.aliyun.com ([115.124.30.113])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qtJD8-00GAlp-1b
	for linux-nvme@lists.infradead.org;
	Thu, 19 Oct 2023 02:56:39 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VuSNO8Y_1697684173;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VuSNO8Y_1697684173)
          by smtp.aliyun-inc.com;
          Thu, 19 Oct 2023 10:56:25 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: james.smart@broadcom.com
Cc: hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] nvmet-fc: Remove unused function
Date: Thu, 19 Oct 2023 10:56:11 +0800
Message-Id: <20231019025611.30228-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231018_195634_964110_BAC3AD9C 
X-CRM114-Status: UNSURE (   6.73  )
X-CRM114-Notice: Please train this message.
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

The function are defined in the fc.c file, but not called
elsewhere, so delete the unused function.

drivers/nvme/target/fc.c:177:1: warning: unused function 'nvmet_fc_iodnum'.
drivers/nvme/target/fc.c:183:1: warning: unused function 'nvmet_fc_fodnum'.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=6936
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/nvme/target/fc.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index bd59990b5250..433517bbd3ac 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -172,20 +172,6 @@ struct nvmet_fc_tgt_assoc {
 	struct rcu_head			rcu;
 };
 
-
-static inline int
-nvmet_fc_iodnum(struct nvmet_fc_ls_iod *iodptr)
-{
-	return (iodptr - iodptr->tgtport->iod);
-}
-
-static inline int
-nvmet_fc_fodnum(struct nvmet_fc_fcp_iod *fodptr)
-{
-	return (fodptr - fodptr->queue->fod);
-}
-
-
 /*
  * Association and Connection IDs:
  *
-- 
2.20.1.7.g153144c


