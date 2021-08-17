Return-Path: <SRS0=LLxJ=NI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADCCDC4338F
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Aug 2021 15:07:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 671AE60E78
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Aug 2021 15:07:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 671AE60E78
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=akyD7p7CQ0AKPB7Pxrcbco+7gzJtZoyLC4Q4oKk0Zok=; b=qaDGzKkmmhkkF1
	/Rg4cyAJY395Z/VVVlpsknLZLqpqco+MAhCpAHBPP43YWVTPWWlXJwH3HUmNgKeaA7R6Fbo8ja9+1
	ZIfIFEKyCx15i/wl/kmpIk+08h3kJ3onF+xe/obb+i+Hvdl7DHeEx0ZX005u7m0M0pJ1l41F5GQ0i
	oVahbWv5y00mlV/9ot5hRPGK6G9TE0BOazvOsJRRLYgZRp3Wy36lBLKQisg03a+7+alQjq5wAGufJ
	p/YSlbAO+sXQddlEOvmozKtSELQMjYhKrEyRfp7jJ5M+vl0aIzEP7HmBMXxzqtNeF5CXdvXGZqzQn
	4XeXdFkcG2QJXWerbarg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mG0gk-002l7q-Fd; Tue, 17 Aug 2021 15:07:38 +0000
Received: from szxga08-in.huawei.com ([45.249.212.255])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mG0gX-002l3E-47
 for linux-nvme@lists.infradead.org; Tue, 17 Aug 2021 15:07:26 +0000
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4GpvWf224tz1CXqL;
 Tue, 17 Aug 2021 23:06:54 +0800 (CST)
Received: from dggpeml500006.china.huawei.com (7.185.36.76) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 17 Aug 2021 23:07:17 +0800
Received: from huawei.com (10.169.63.14) by dggpeml500006.china.huawei.com
 (7.185.36.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 17 Aug
 2021 23:07:16 +0800
From: chengjike <chengjike.cheng@huawei.com>
To: <kbusch@kernel.org>, <linux-nvme@lists.infradead.org>
CC: <sunao.sun@huawei.com>, <chengjike.cheng@huawei.com>,
 <liuzhouhua@huawei.com>, <lengchao@huawei.com>, <jiangtao62@huawei.com>
Subject: [PATCH nvme-cli 1/3] filter disk partitions in command "nvme huawei
 list"
Date: Tue, 17 Aug 2021 23:07:13 +0800
Message-ID: <20210817150715.1173-2-chengjike.cheng@huawei.com>
X-Mailer: git-send-email 2.24.0.windows.2
In-Reply-To: <20210817150715.1173-1-chengjike.cheng@huawei.com>
References: <20210817150715.1173-1-chengjike.cheng@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.169.63.14]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500006.china.huawei.com (7.185.36.76)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210817_080725_479309_FB386B21 
X-CRM114-Status: UNSURE (   9.15  )
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

When using "nvme huawei list" command, if the current disk has partitions,
disk partitions will be displayed. This is not expected!
So filter out the disk partitions.

Signed-off-by: chengjike <chengjike.cheng@huawei.com>
---
 plugins/huawei/huawei-nvme.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/plugins/huawei/huawei-nvme.c b/plugins/huawei/huawei-nvme.c
index b39d861..f36c7a5 100644
--- a/plugins/huawei/huawei-nvme.c
+++ b/plugins/huawei/huawei-nvme.c
@@ -301,6 +301,7 @@ static int huawei_list(int argc, char **argv, struct command *command,
 	unsigned int i, n, fd, ret;
 	unsigned int huawei_num = 0;
 	int fmt;
+	int ctrl, ns, part;
 	const char *desc = "Retrieve basic information for the given huawei device";
 	struct config {
 		char *output_format;
@@ -331,6 +332,8 @@ static int huawei_list(int argc, char **argv, struct command *command,
 	}
 
 	for (i = 0; i < n; i++) {
+		if (sscanf(devices[i]->d_name, "nvme%dn%dp%d", &ctrl, &ns, &part) == 3) 
+			continue;
 		snprintf(path, sizeof(path), "/dev/%s", devices[i]->d_name);
 		fd = open(path, O_RDONLY);
 		ret = huawei_get_nvme_info(fd, &list_items[huawei_num], path);
-- 
2.24.0.windows.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
