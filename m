Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82742C43334
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jun 2022 17:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=qNwE5zoU0WZ/izmhnwqSFeEkYOJ9wXbU64jkp5gdCnI=; b=IjbkdlbI3AQMXXUtqDgpFENDsL
	3FSNokYqpWH2gg7NH3i8OGtI44fBKxJyAubbENjiWeqLWQDxqgeGRA6ef2X/WFjVeHz8gF+j0FEEl
	n5sNzGKD87IaqpJ7QCZvfdwM6V1630yx0bD+I9DtLPH52YmTXcZlkPv0zUvyDhX9aPLh5S9WC2Y5u
	WfXAYvhN8eH/NcONdPLKxY4L6QVnZ6SV4ixPzB1/gbBwc8yui5+lcaCI01wuVxfsxI+z8i3sva4YM
	pnGJ5EEHZUX5h1LwgFJ9rbV9YZ4Md5mLQNgFeZibsWQK900FopK7lmH468DidCzedpgwiofJilaOT
	9HADstTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nzM6K-003DXm-7C; Thu, 09 Jun 2022 17:37:44 +0000
Received: from mail-qv1-xf2c.google.com ([2607:f8b0:4864:20::f2c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nzM6F-003DVV-Kl
	for linux-nvme@lists.infradead.org; Thu, 09 Jun 2022 17:37:41 +0000
Received: by mail-qv1-xf2c.google.com with SMTP id b11so17046119qvv.4
        for <linux-nvme@lists.infradead.org>; Thu, 09 Jun 2022 10:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=enfabrica.net; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qNwE5zoU0WZ/izmhnwqSFeEkYOJ9wXbU64jkp5gdCnI=;
        b=d7UCKzpPk0vX8yVgmCWpLOKTVtpzxSsiVG+gdYPkuecHW1mgiBhHbTHWZWd1ovBmpp
         KwlJXumq8M7ErBb6E/3GAfeOJfEvpKWvXZqw8sp2r7loVS5pTMPpnwx5cmSkJ2II7qJS
         5+MxoclhpF0x4+0ewmLJzVxurychjLV3PAY2NQa18AEqJwQYTy3WQQKtR7GJItnXiwiX
         gIoi7wKPltgTA6z4JLbrWz1jG4tom9O1JMXKj6kJ3Qq6GgGm0uY9fpqXNNt+fD0lZa8k
         KvTJ46d69tBVvV5GYwt+GglrWOka0UH2G98sPNtlbUAP66bFbDwfQ/uYQ9wLolX1mNkP
         ZCuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qNwE5zoU0WZ/izmhnwqSFeEkYOJ9wXbU64jkp5gdCnI=;
        b=enQggXi9oqs2PGax8tyfq8O4jDommYwyefovc9bryckKHrJs93RrqERzgMq7t4hY5e
         c0RUKdx11T7HXcFnnZaG+Z5caM49+/DClJkT+ScnuxGfFKen+2YuavxiHiFAKrkLISJG
         FA5fxjkMIBjrmmEF/4s7VuEra5VKGFpKN15IfeqxBMUbnDDFEG+YADF0ji6flK3SCR2v
         cNQW1Y6HYUns7tVzMN/ckXUarK+ZaSljBlqJ7YLaET6DHzfolnznLaT5Mw/QCWisca5w
         nrXwzdOoEQO3oDCcWbM+mC7UDo5wdj9cnx5V0/PSximYY6A9UmUoeYWqeSrkAGoCCBfs
         kasw==
X-Gm-Message-State: AOAM530fEr1RSYJ+O/bLdiV0TB/2t6oSglTMBZSK8zh0qEhR+JhdxZQL
	9B8kZXM/+twH0xSi4vRq+CRYtYI+MAs344DO12eawcN0Ajxq65lwrC6+sNCKhDssOTr6wWCCDpI
	6ZsXA0qkVzc8Z/nCm3JO1qBUfTkHLQ37E8yQhWT+P455M4VsDG/JQyHTTo9t1M4CseTPnVIrQ1a
	+ca+gMb+VcdA==
X-Google-Smtp-Source: ABdhPJzf4/J7IwqNGrtjeYEkCgJYvScEf3xOxsqBi17cJwpYiIAecomGgefMb/QN33NWUvJUAn1fgw==
X-Received: by 2002:ad4:5d49:0:b0:46a:66a2:d73f with SMTP id jk9-20020ad45d49000000b0046a66a2d73fmr22733924qvb.45.1654796255158;
        Thu, 09 Jun 2022 10:37:35 -0700 (PDT)
Received: from gravicappa.gravicappa.info (pool-96-233-74-252.bstnma.fios.verizon.net. [96.233.74.252])
        by smtp.gmail.com with ESMTPSA id 82-20020a370755000000b006a73ad95d40sm967806qkh.55.2022.06.09.10.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 10:37:34 -0700 (PDT)
From: Vitaly Mayatskikh <vitaly@enfabrica.net>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH] nvme-multipath: allocate MQ disk
Date: Thu,  9 Jun 2022 13:37:34 -0400
Message-Id: <20220609173734.381654-1-vitaly@enfabrica.net>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220609_103740_155260_9C25960B 
X-CRM114-Status: GOOD (  11.13  )
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

nvme_mpath_alloc_disk() allocates gendisk with blk_alloc_disk(), which
results in no MQ support even if the head device has it.

Signed-off-by: Vitaly Mayatskikh <vitaly@enfabrica.net>
---
 drivers/nvme/host/multipath.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index d3e2440d8abb..3f085f838910 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -490,7 +490,7 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
 	    !nvme_is_unique_nsid(ctrl, head) || !multipath)
 		return 0;
 
-	head->disk = blk_alloc_disk(ctrl->numa_node);
+	head->disk = blk_mq_alloc_disk(ctrl->tagset, NULL);
 	if (!head->disk)
 		return -ENOMEM;
 	head->disk->fops = &nvme_ns_head_ops;
-- 
2.25.1


