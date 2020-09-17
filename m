Return-Path: <SRS0=U7CH=C2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D4CC433E2
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Sep 2020 01:11:25 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2682C206E6
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Sep 2020 01:11:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="E9sxPZKb";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="rXAxqWzh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2682C206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=bu0+P0nKwVKEAJeofoE8+ein/T/qJVJeFhYcAxo9xms=; b=E9sxPZKbE2yvbkHvpCXS1Ov5H
	UJ6LuZAghl9YqZOj5/4qpzzlHVkigGwhuLv+2UdmoR76jhEmbJq+khEa1CzpCZwg6TQRK+sStCD37
	gsVukcjSJ2f6VavS7o3XCxwm+Xm7d9WJQLrIcX852tX4jjaO3XdYvGOa2Dw09e2wrv08e0DQb9aB8
	0ck/cCEb65Y35jZHGym7C8Vnmg5Dhv92yyraOsFJ+rGLeWZdM/Vn0T58gwhwizzE6t4pgNFT6oCCA
	Lhh38RoQYUBeSmg4evfRL01G1v70UvYYvsQ5x3+Z+PY8R3HdxX0pWyu3Y2tuN9VmNMRn2GBhhX553
	610K2gnEA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kIiSJ-00074i-Ci; Thu, 17 Sep 2020 01:11:23 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kIiSH-00074D-HC
 for linux-nvme@lists.infradead.org; Thu, 17 Sep 2020 01:11:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1600305147; x=1631841147;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=VhZ+nFQNRRZU23Xrc74s3mNm1uXyOFNfQgvhuExwqZ0=;
 b=rXAxqWzhEbE1dnPQDA1G/7Tgejtd4M1MbLpJ4fGmXYqB+X+weqsWHUcZ
 U//y6gckmMwu3d5SJj1VxjghMMNTUVkjw4vINct1+6cI+f+af38ki5FWM
 Pvye5l5UN8Ms1Ng4P7Pc3pXTNPRjHPCNdNxlmT2FAqrmsx1s4rjpbEFM/
 gQ1Zzn3jwiBBS+eX1l/wHVKSGRcAvKQSo0sOIYLATF5A30rhGVslzkM46
 z748v34qeqIVivF75Y6mo/aT3/JpuG6SGL+mM3EMphNeeZHqEKDkJjIGg
 tSr9tVwPGiuk5qTkFOSmT7sIpsKGjKBBnE29MfPGxWf7Cs9chR5OEjzLF g==;
IronPort-SDR: aNFJJY1lm7X4FOx1Zea/TmFa4OS6o4xI0bQ+MbugIqpQGP1rZDgPfrFn+XBdRhY72U+zBARtbL
 7lj084KYEXvARbyJDQVz92UcII/YiDdEMj3YHeM2x06vmeK4tkxey1KssXszAvoZPPLwNuIG6c
 SFN8NwZPsmbFoumczUgJhg3M0dUBsxED5zGDGG1otyL1R8KAehAXQl70+4mkBxkMleRhWKNprm
 yyeOYoCmNQ+5DqiDc4+iAh6kz5JLLtMBx7vmy4EyynV1s4sUqG9hpJOQ6BR8VphHmxm29ONaBn
 J5E=
X-IronPort-AV: E=Sophos;i="5.76,434,1592841600"; d="scan'208";a="250918879"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 17 Sep 2020 09:12:25 +0800
IronPort-SDR: 3CcXpVNm9z7MyTtTLLb29/ZpmGBqUAO4tZJ79DBKJzdpNHJqYdD+B8ocAIO87x0HdP2Ny6cCXd
 sXNx+OTNWVLw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2020 17:57:34 -0700
IronPort-SDR: YcuBxmHJKRNc47FmxxomcVWLbSRWtvzuq/oS2LPNb7OywO3AUgaveRuULMrhm9nHyVBMsagqUZ
 /NrkxqhDbBmw==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 16 Sep 2020 18:11:21 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V3 2/3] nvmet: get transport reference for passthru ctrl
Date: Wed, 16 Sep 2020 18:11:01 -0700
Message-Id: <20200917011102.14819-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20200917011102.14819-1-chaitanya.kulkarni@wdc.com>
References: <20200917011102.14819-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200916_211121_697655_41B8AB30 
X-CRM114-Status: GOOD (  12.83  )
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
Cc: logang@deltatee.com, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Christoph Hellwig <hch@lst.de>

Grab a reference to the transport driver to ensure it can't be unloaded
while a passthrough controller is active.

Fixes: c1fef73f793b ("nvmet: add passthru code to process commands")
Reported-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/nvme/target/passthru.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index 8bd7f656e240..dacfa7435d0b 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -517,6 +517,7 @@ int nvmet_passthru_ctrl_enable(struct nvmet_subsys *subsys)
 		subsys->ver = NVME_VS(1, 2, 1);
 	}
 
+	__module_get(subsys->passthru_ctrl->ops->module);
 	mutex_unlock(&subsys->lock);
 	return 0;
 
@@ -531,6 +532,7 @@ static void __nvmet_passthru_ctrl_disable(struct nvmet_subsys *subsys)
 {
 	if (subsys->passthru_ctrl) {
 		xa_erase(&passthru_subsystems, subsys->passthru_ctrl->cntlid);
+		module_put(subsys->passthru_ctrl->ops->module);
 		nvme_put_ctrl(subsys->passthru_ctrl);
 	}
 	subsys->passthru_ctrl = NULL;
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
