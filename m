Return-Path: <SRS0=dhBa=DI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E8CBC4727E
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Oct 2020 18:54:56 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB9B620872
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Oct 2020 18:54:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="vDyMGQ5d";
	dkim=permerror (0-bit key) header.d=wdc.com header.i=@wdc.com header.b="iWebs/om"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB9B620872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ZYaM3xrlYAk8WCPuxU9UJqVpD/r9e5jfoJEBTIM955U=; b=vDyMGQ5dlvpKse4ALGi8cUAb9
	aY+DqLs8ptDdjuW3qTMvXF/RD3DFtPYKDMoScbNVyLsrWmmNJaLvYfDFjWSVXryLM/39byRBYn0Eu
	uS6yif9B5/ZAuY0hVStGPJPk0OoY3j+jTC5oI/mfB8p7h3rt0EnIArSMDv8rHTbXW4JsItkY6m6vp
	cZa9AkmCChv8pVXantJVMv1h9/km+C9tXnW2WZfyKWUF0D3acvnx85+G6ofvmT5dhI0S2mPfVcCB7
	YZNZrATeUKs644V5RgM3lbTbXkjHYHTbInhJN4uVYkPQZRt/4cdip65SsZtMQOQ7Fkr7BlEfmvl/7
	/OwuMBYnA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kO3jB-0007Xx-Tq; Thu, 01 Oct 2020 18:54:53 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kO3j7-0007XM-93
 for linux-nvme@lists.infradead.org; Thu, 01 Oct 2020 18:54:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1601579417; x=1633115417;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=jgbgXOZzISAmfbAqQSzfZb9SlSp6JbSfN8YiyqFrnZY=;
 b=iWebs/omWvHegkLzOl5IZujgrPtV/4WhKRS9sqxBkVo9l4iW4Ba33y5D
 k/IuBOSQH90nr2IKWrcYmApBfipoirOUMM6L9lGOenR8GFas5eOhNSxdF
 218tmTIV/IzV2o/CDkpYuAoVZ1aunMsXaapZola1+hjXd3FmdPvbWg1iA
 tiL4FtpGnx7fQIEL542Jdjmte016xH9EXAMEGIHTeZzTN7hPS5+dsZY4f
 YyeJdfLTssEWVryISK1k7nj30sHLeDS4ZW61LyxhJISyFHU08DitOIOL4
 vIGALDtU7avk7YmshhlqkLHXf80szSDETxuy8eQyKKHxpK7N6HgC3rS8E g==;
IronPort-SDR: q5v1MYRpnKUuztBzIUzJAkfhpGITJ8G+iSVhclTEBodKEBIIGwfhHrYV9XzkgjARmvRxfeNSVm
 kDyCnJ7WHBgEP4Q0CHfLDDcF3j5qLv2MetCexwX1Hhx+vbtpJl7LMTc1wshjcg3xy28WZ8M2l4
 aN8XC/5WvD9ZqOwcHxchL4rNQgEh4nLx+0P9u5BG4KLRIaFMwn6fVace3XBg2Gvs2MNVZUuXgS
 BVfAXeCup4M8To4eBw/4zXqIOZwZpGGcSs5n0KIF76lHVz212d/abDrLF7SFbVyYfqtECypC+k
 omc=
X-IronPort-AV: E=Sophos;i="5.77,324,1596470400"; d="scan'208";a="252242133"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 02 Oct 2020 03:10:16 +0800
IronPort-SDR: O89Dzk5i8Y37gHSIzzQRWkVgMJ9Adi67jkfxVIBT2i1uVk8rbTXf7lvO1mFP+Fpk2YC5c64jeA
 GoegpbOepG7Q==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2020 11:40:46 -0700
IronPort-SDR: LY8EOKtG3aUZiF5Bu3Pj2wCYKbR8F/vL69rZoHi1cmVrpCQ8R81wYn+YWKxhtyi5Xdcah5lWPE
 TXWh6nRJwwUA==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 01 Oct 2020 11:54:48 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V2 1/2] nvme-core: remove extra variable
Date: Thu,  1 Oct 2020 11:54:31 -0700
Message-Id: <20201001185432.5464-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201001185432.5464-1-chaitanya.kulkarni@wdc.com>
References: <20201001185432.5464-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201001_145449_445924_14B35E1D 
X-CRM114-Status: GOOD (  13.35  )
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
Cc: kbusch@kernel.org, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

In nvme_validate_ns() the exra variable ctrl is used only twice.
Using ns->ctrl directly still maintains the redability and original
length of the lines in the code. Get rid of the extra variable ctrl &
use ns->ctrl directly.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/host/core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 96dc87ea07b3..9a565096e072 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3931,20 +3931,19 @@ static void nvme_ns_remove_by_nsid(struct nvme_ctrl *ctrl, u32 nsid)
 
 static void nvme_validate_ns(struct nvme_ns *ns, struct nvme_ns_ids *ids)
 {
-	struct nvme_ctrl *ctrl = ns->ctrl;
 	struct nvme_id_ns *id;
 	int ret = -ENODEV;
 
 	if (test_bit(NVME_NS_DEAD, &ns->flags))
 		goto out;
 
-	ret = nvme_identify_ns(ctrl, ns->head->ns_id, ids, &id);
+	ret = nvme_identify_ns(ns->ctrl, ns->head->ns_id, ids, &id);
 	if (ret)
 		goto out;
 
 	ret = -ENODEV;
 	if (!nvme_ns_ids_equal(&ns->head->ids, ids)) {
-		dev_err(ctrl->device,
+		dev_err(ns->ctrl->device,
 			"identifiers changed for nsid %d\n", ns->head->ns_id);
 		goto out_free_id;
 	}
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
