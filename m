Return-Path: <SRS0=/7z5=N7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A9BC433F5
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Sep 2021 14:57:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B9F6610E8
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Sep 2021 14:57:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2B9F6610E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:CC
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=oaYIWSpB1OuV37TXDy89pIcPfSy69YDEx7rJ44GAB1Y=; b=LkF2rKRB1YsVKw
	k94tCVAa9BuUpg+hpVexDp8FnpAbYgcJl/imTaqpLFzcUCBPtg/QGeuMj1RhKJQhf92TdyqPIzTTb
	7LgT3EOwUMmGIs2PYGeh2QRFMmm3j+ea8800P0LHPwo3gQwkVbdgUWs/gSY4vUq2QukMlbn8voL+x
	J5yArndHtvboFmjEu2qUsM9GVVEFlVFvAz2oKhCHmFoa8qpzkMVangLOB/1nWcVv/EW/NCKyW3EsR
	eIxhDB3GmZLAlWBSun/ZBF/f1knTVwS+M6dLI20QiTvgJkCzF+vS8IuOZh7Nla9DocQJ3ZA0roGmf
	0TJXn7WYTm0xfkxfwCgg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mOLUW-00ACkL-CT; Thu, 09 Sep 2021 14:57:28 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mOLUS-00ACjb-FB
 for linux-nvme@lists.infradead.org; Thu, 09 Sep 2021 14:57:26 +0000
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4H526n0sJ2z8y6v;
 Thu,  9 Sep 2021 22:52:49 +0800 (CST)
Received: from dggpeml500006.china.huawei.com (7.185.36.76) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Thu, 9 Sep 2021 22:57:10 +0800
Received: from huawei.com (10.169.63.14) by dggpeml500006.china.huawei.com
 (7.185.36.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Thu, 9 Sep 2021
 22:57:10 +0800
From: chengjike <chengjike.cheng@huawei.com>
To: <kbusch@kernel.org>, <linux-nvme@lists.infradead.org>
CC: <sunao.sun@huawei.com>, <chengjike.cheng@huawei.com>,
 <jiangtao62@huawei.com>
Subject: [PATCH nvme-cli] fix path->nentry bugs
Date: Thu, 9 Sep 2021 22:57:09 +0800
Message-ID: <20210909145709.2079-1-chengjike.cheng@huawei.com>
X-Mailer: git-send-email 2.24.0.windows.2
MIME-Version: 1.0
X-Originating-IP: [10.169.63.14]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500006.china.huawei.com (7.185.36.76)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210909_075725_406857_6FB32BBB 
X-CRM114-Status: UNSURE (   9.31  )
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

The "path->nentry" is initialized after it is added to the list in "nvme_subsystem_set_path_ns" function.

Signed-off-by: chengjike <chengjike.cheng@huawei.com>
---
 src/nvme/tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/nvme/tree.c b/src/nvme/tree.c
index 49815db..293b0c0 100644
--- a/src/nvme/tree.c
+++ b/src/nvme/tree.c
@@ -534,7 +534,6 @@ static int nvme_ctrl_scan_path(struct nvme_ctrl *c, char *name)
 	p->name = strdup(name);
 	p->sysfs_dir = path;
 	p->ana_state = nvme_get_path_attr(p, "ana_state");
-	nvme_subsystem_set_path_ns(c->s, p);
 
 	grpid = nvme_get_path_attr(p, "ana_grpid");
 	if (grpid) {
@@ -543,6 +542,7 @@ static int nvme_ctrl_scan_path(struct nvme_ctrl *c, char *name)
 	}
 
 	list_node_init(&p->nentry);
+	nvme_subsystem_set_path_ns(c->s, p);
 	list_node_init(&p->entry);
 	list_add(&c->paths, &p->entry);
 	return 0;
-- 
2.21.0.windows.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
