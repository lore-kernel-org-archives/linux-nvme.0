Return-Path: <SRS0=UQCu=LC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9572C4743D
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Jun 2021 14:32:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8984360E08
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Jun 2021 14:32:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8984360E08
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:CC
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=cGgZuRo4agr/p5ehKDnG95DYQhyjn69NydSQbdGF7Uw=; b=CUNaqAAm3vuecI
	TVC5RFQ/GhmE02QZ4uVDRFA7+YS6ED8QZu5eKEUVQhwDcUGgj2J2Pms7bpNsJnioD3Cq8ZW3AzRLS
	VIDZYuQUDBGinSXSTk2uJBny0a52bJwt77hJzUmAWcN73g1U5lL3TM0ndfuxTd8J9G10r3N23vq8n
	k+Nvud9zPhGdEaK8YXtE9GaCyc8H3gOAYv9CbnNgIy8cUVQkXTeazJRNXkSSXUdDrhbw5TDruzIsZ
	20azypryYZR7tyZsK3WAu1vQlOr9mSCZgpIpoX5CdN/pOVx7MRdyj8eqvGuy9zqnxxehvRDZaO/gq
	qCs8WTSsobQPO3yvWU3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lqcmY-008w4M-No; Tue, 08 Jun 2021 14:32:42 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lqcic-008ubm-A1
 for linux-nvme@lists.infradead.org; Tue, 08 Jun 2021 14:28:40 +0000
Received: from dggeml759-chm.china.huawei.com (unknown [172.30.72.55])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Fzssw0SQszWsXc;
 Tue,  8 Jun 2021 22:23:32 +0800 (CST)
Received: from localhost.localdomain (10.175.102.38) by
 dggeml759-chm.china.huawei.com (10.1.199.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 8 Jun 2021 22:28:22 +0800
From: Wei Yongjun <weiyongjun1@huawei.com>
To: <weiyongjun1@huawei.com>, Arie Gershberg <agershberg@marvell.com>, Shai
 Malin <smalin@marvell.com>, Ariel Elior <aelior@marvell.com>, Keith Busch
 <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>, Christoph Hellwig
 <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
CC: <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <kernel-janitors@vger.kernel.org>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH -next] nvme-tcp-offload: Fix error return code in
 nvme_tcp_ofld_setup_ctrl()
Date: Tue, 8 Jun 2021 14:38:54 +0000
Message-ID: <20210608143854.4154005-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Originating-IP: [10.175.102.38]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggeml759-chm.china.huawei.com (10.1.199.138)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210608_072838_721207_2E66E640 
X-CRM114-Status: UNSURE (   9.18  )
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

Fix to return negative error code -EINVAL if mandatory sgls
are not supported.

Fixes: 5aadd5f9311e ("nvme-tcp-offload: Add controller level implementation")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/nvme/host/tcp-offload.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/tcp-offload.c b/drivers/nvme/host/tcp-offload.c
index c76822e5ada7..3879d5ed7497 100644
--- a/drivers/nvme/host/tcp-offload.c
+++ b/drivers/nvme/host/tcp-offload.c
@@ -622,6 +622,7 @@ static int nvme_tcp_ofld_setup_ctrl(struct nvme_ctrl *nctrl, bool new)
 
 	if (!(nctrl->sgls & ((1 << 0) | (1 << 1)))) {
 		dev_err(nctrl->device, "Mandatory sgls are not supported!\n");
+		rc = -EINVAL;
 		goto destroy_admin;
 	}
 


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
