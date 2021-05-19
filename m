Return-Path: <SRS0=q7uG=KO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC48C433ED
	for <linux-nvme@archiver.kernel.org>; Wed, 19 May 2021 04:36:04 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C54A6139A
	for <linux-nvme@archiver.kernel.org>; Wed, 19 May 2021 04:36:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C54A6139A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-ID:Date:
	Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=KHYG0PoFC8O/g6+AAO7AZyZ1V906JBzBzn5oYlWj/4M=; b=QIgkXmT1ncU/6wwwuxBcfklYc
	oU9LO8YrpUWPy0mkyV/+DnjEwnMnVD4yV+ZiAA8FatfZMbT9e5X1+KPXVxMmzGrfYpAT10/8+3eeX
	VQMiXdVHGl1FhCp2wNYqVM/wi+lvwIKibkPEXVK/0XE1Mwor7Bg4VeOtWbpY0GW6iaCXYp6bozPXd
	pzN3uTwl93ncwcRAMfDL6+ZmHjHY5Q9TmICArYP1teloH/dDoCx6AWKZcaN/2jh+pUFbAsdQ9ARl/
	3EcJY42sfuvTC6zLI/4GlGGC8XqWJREbDnVjLT1klp1nQumi/VFT2NXuY/SQTXjrP289Pnq+juRf3
	fpScteSNw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ljDvj-002kYL-VG; Wed, 19 May 2021 04:35:36 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ljDvY-002kXO-4K
 for linux-nvme@desiato.infradead.org; Wed, 19 May 2021 04:35:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=2G47Sfhz8LgDvpBLctH/CnX9qNhgpEUQPmqPsKIYV2k=; b=vpBlXClh5KDIRUXRxIr+NLxeWw
 YowwHMvMHnwac5pO2QdlOoK7eB+Tj4xWWzPbMaWohIKluEXyhKiDnapl2MWRF0TMpXymu+7Qi6ZPt
 I3n4J3P0Sgughxq7fsQusDnrenJlH5Wek624qRBJv6KvCc4LXxPXnee8sEqYw8Tebbd1V/6YIDRDt
 kJTYJtElgdZOHD0kKgcFVwOjjYOO7O9cbNwUZwTROOoRvBHsx/BbuwEsSuydjFVTGGOhYLzGC5FQY
 hrOm1NqKyFkalcMbKxHPZolXURVa7Dq7tD07xd5dGXWXC0Zp0uMT3FNJ2XSl3+gFUfczTcLRc2m9s
 9ob96aDA==;
Received: from szxga07-in.huawei.com ([45.249.212.35])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ljDvV-00F7af-Hk
 for linux-nvme@lists.infradead.org; Wed, 19 May 2021 04:35:22 +0000
Received: from dggems703-chm.china.huawei.com (unknown [172.30.72.58])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FlKjF3HFHzCswC;
 Wed, 19 May 2021 12:32:33 +0800 (CST)
Received: from dggpeml500019.china.huawei.com (7.185.36.137) by
 dggems703-chm.china.huawei.com (10.3.19.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 19 May 2021 12:35:19 +0800
Received: from huawei.com (10.175.124.27) by dggpeml500019.china.huawei.com
 (7.185.36.137) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 19 May
 2021 12:35:19 +0800
From: Wu Bo <wubo40@huawei.com>
To: <hch@lst.de>, <sagi@grimberg.me>, <chaitanya.kulkarni@wdc.com>,
 <kbusch@kernel.org>, <amit.engel@dell.com>, <linux-nvme@lists.infradead.org>, 
 <linux-kernel@vger.kernel.org>
CC: <linfeilong@huawei.com>, <wubo40@huawei.com>
Subject: [PATCH 1/2] nvmet: Fix memory leak in nvmet_alloc_ctrl()
Date: Wed, 19 May 2021 13:01:09 +0800
Message-ID: <1621400470-593256-2-git-send-email-wubo40@huawei.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1621400470-593256-1-git-send-email-wubo40@huawei.com>
References: <1621400470-593256-1-git-send-email-wubo40@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500019.china.huawei.com (7.185.36.137)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210518_213521_773203_FEDE4546 
X-CRM114-Status: GOOD (  10.83  )
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

From: Wu Bo <wubo40@huawei.com>

When creating ctrl in nvmet_alloc_ctrl(), if the cntlid_min is
large than cntlid_max of the subsystem, and jumps to
"out_free_changed_ns_list" label, but the ctrl->sqs lack of be freed.
So to fix this issuse modify jumps to "out_free_sqs" label.

Fixes: 94a39d61f80f ("nvmet: make ctrl-id configurable")
Fixes: 6d65aeab7bf6e ("nvmet: remove unused ctrl->cqs")
Signed-off-by: Wu Bo <wubo40@huawei.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 25cc2ee..1853db3 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1372,7 +1372,7 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 		goto out_free_changed_ns_list;
 
 	if (subsys->cntlid_min > subsys->cntlid_max)
-		goto out_free_changed_ns_list;
+		goto out_free_sqs;
 
 	ret = ida_simple_get(&cntlid_ida,
 			     subsys->cntlid_min, subsys->cntlid_max,
-- 
1.8.3.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
