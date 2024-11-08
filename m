Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CF3AD5E145
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Nov 2024 08:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=cHgfD40/uBxO7n/N9CZMxvkgHThLBvJfxi9cBFxuTVg=; b=Z9APda5b5JfyXd9QnMjWkiAenU
	4VSBck96vCerXntEPzuV8Av+vdrXK+bCtQtc+mEX4V6SD1GZYC6UAUbegS7ZnQLBTyvppiDEtMK/K
	QCwRve3LaPCMRTxfakP7ZIQj0myZq1iV2o26C7wa5irJWAVpkvpqc9FwmWsa6RDgvUI7eGtboU5f7
	LTLz9nJjvaQ6R7OgtHfVUD5nLm1qbrO5nK0hrzwxn3+SyhmMM6lm8ZOaFWsjcdbDvY91mwqvKwGCE
	hGktR32tDLzR5GfL9Q219sJCFA+KQNTZcPzQ6WVohvk2LIXxqgAD5aBNBpgxye74J5GumB7hqwObG
	vIpkx3BQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t9KTd-00000009noY-1IVs;
	Fri, 08 Nov 2024 08:36:21 +0000
Received: from out30-100.freemail.mail.aliyun.com ([115.124.30.100])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t9KO9-00000009mEP-1XH2
	for linux-nvme@lists.infradead.org;
	Fri, 08 Nov 2024 08:30:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731054637; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=cHgfD40/uBxO7n/N9CZMxvkgHThLBvJfxi9cBFxuTVg=;
	b=J2LWOfI9AC2Q13NlzTgjHYfYHHCETqmlsMS+bF38SN4PPrbS9JhheLCf4cx14czR99zivwH+A4E/PVnDuQCUCIUGj8ADlUvYl5v+C8FbFpRMjaKTwEfi46YA40xpp5ElVWLlCTO0wG5JpUBf041TEqtLrGDeQykiRELaXVc4icY=
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WIyji7u_1731054630 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 08 Nov 2024 16:30:34 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH] nvmet: fix the warning of assigne int to __le16
Date: Fri,  8 Nov 2024 16:30:30 +0800
Message-ID: <20241108083030.22555-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241108_003041_930713_A1954434 
X-CRM114-Status: GOOD (  10.17  )
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

Even though NVME_CNTLID_DYNAMIC is 0xffff, we still need use
cpu_to_le16 to translate it to litte-endian.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/target/pr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/pr.c b/drivers/nvme/target/pr.c
index 60899c22e7b6..bef82135a0e7 100644
--- a/drivers/nvme/target/pr.c
+++ b/drivers/nvme/target/pr.c
@@ -854,7 +854,7 @@ static void nvmet_execute_pr_report(struct nvmet_req *req)
 		/*
 		 * Dynamic controller, set cntlid to 0xffff.
 		 */
-		ctrl_eds->cntlid = NVME_CNTLID_DYNAMIC;
+		ctrl_eds->cntlid = cpu_to_le16(NVME_CNTLID_DYNAMIC);
 		if (rtype == NVME_PR_WRITE_EXCLUSIVE_ALL_REGS ||
 		    rtype == NVME_PR_EXCLUSIVE_ACCESS_ALL_REGS)
 			ctrl_eds->rcsts = 1;
-- 
2.43.0


