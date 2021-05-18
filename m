Return-Path: <SRS0=ZIaN=KN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 812D1C433ED
	for <linux-nvme@archiver.kernel.org>; Tue, 18 May 2021 08:21:51 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2415A60FF3
	for <linux-nvme@archiver.kernel.org>; Tue, 18 May 2021 08:21:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2415A60FF3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=b6mAvYzQ4/OkpImXdMARAJ+KJMLuWw8Hy3rxmWy9vyQ=; b=cLkyaNnRnd+jfCPdnUbInLQJqJ
	R7hS+a0b8T9rW3+zVWbHh+kT5fxJjXW9k6wm2CtKtEp8CD0iB8fGXn4gk/DkkKSoQXobG9K6Su0bf
	Dw5EOmNo7bY/0ddXpSg/+WsuE+GNrNYIpkkkz4X/pFp78lg3qKik40JW7K1w1wCoToZWrzUFXAyHU
	0Ob9D04mG/9Etnr62eLGqsy6SPpTtxmW2CmSVVYO6KxOiV5krDlLWd/jtujGw9bDZX9NVvZhc57PJ
	M9zW5Nj7brqOMmM9n5LOLsDP9bnu/MXlDdGoegzfXWrFazGLLMekY6pW1QQsmGuNA5H/IIUy2Mxqd
	/e/FoIPA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1liuyq-00HWo2-TH; Tue, 18 May 2021 08:21:33 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1liuyb-00HWnw-Hg
 for linux-nvme@desiato.infradead.org; Tue, 18 May 2021 08:21:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
 Date:Subject:CC:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=QcFgFiUgMDt8QFvw+8imNWgzHpFLAkaEsd8wurelMPw=; b=bNwlWTOnzvvBPAZh37zCjeE7g1
 s6ii26L2DMDQle+WQrU3UnTYH4rHgI4axD32Ca3CV1Zg/7+SUH+6U4LHIIHwdrJuHlSfogR0+aG60
 S4b8IChwXSfAfcF8Eyo/M5pVk2P7tWSHfGC96ScYEoe2r/1CENMEkcELFvBIBp/8eB4MctEqO9TmX
 zLDPKy7BiY07ND2Ie8kgNSXvQenLBhd2p2iWE039zBam1Dl2AWJ/BuOeq+ZAV59fSHQzRUJ6kyQtw
 QDRRRVLsY7fGPjRLI8w6CU+xJsif7OnR+IHvcAiqASWCRHCN6xx7M3khyXTWsgwJO8TxO3g/d7VAV
 pzgDMx5Q==;
Received: from szxga06-in.huawei.com ([45.249.212.32])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1liuyX-00ESB7-AC
 for linux-nvme@lists.infradead.org; Tue, 18 May 2021 08:21:14 +0000
Received: from dggems706-chm.china.huawei.com (unknown [172.30.72.58])
 by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Fkpmj6lyPzlg3D;
 Tue, 18 May 2021 16:18:45 +0800 (CST)
Received: from dggpeml500019.china.huawei.com (7.185.36.137) by
 dggems706-chm.china.huawei.com (10.3.19.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 18 May 2021 16:20:49 +0800
Received: from huawei.com (10.175.124.27) by dggpeml500019.china.huawei.com
 (7.185.36.137) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 18 May
 2021 16:20:48 +0800
From: Wu Bo <wubo40@huawei.com>
To: <hch@lst.de>, <sagi@grimberg.me>, <chaitanya.kulkarni@wdc.com>,
 <kbusch@kernel.org>, <amit.engel@dell.com>, <linux-nvme@lists.infradead.org>, 
 <linux-kernel@vger.kernel.org>
CC: <linfeilong@huawei.com>, <wubo40@huawei.com>
Subject: [PATCH] nvmet: fix memory leak on nvmet_alloc_ctrl()
Date: Tue, 18 May 2021 16:46:38 +0800
Message-ID: <1621327598-542045-1-git-send-email-wubo40@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500019.china.huawei.com (7.185.36.137)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210518_012113_543446_15039640 
X-CRM114-Status: UNSURE (   9.71  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Wu Bo <wubo40@huawei.com>

When cntlid_min is greater than cntlid_max,
goto wrong label, should be goto out_free_sqs
label. Otherwise there is a memory leak problem
on the nvmet_alloc_ctrl function().

Fixes: 94a39d61f80f ("nvmet: make ctrl-id configurable")
Fixes: 6d65aeab7bf6e ("nvmet: remove unused ctrl->cqs")
Signed-off-by: Wu Bo <wubo40@huawei.com>
---
 drivers/nvme/target/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 25cc2ee8de3f..1853db38b682 100644
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
2.30.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
