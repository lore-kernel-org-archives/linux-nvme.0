Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C073C001DE
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Aug 2023 09:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=JYWS0AZBdaisLH3Jm7l4Dt9SCEbqEZipVudJfdzNaOU=; b=vNGoqWvReF+L/9rlr75vp9ilv3
	Oc6pxP3FpV8n5ghBnke5NWtHnxzaQJs4yQllBI7BOxPujfRvA7FSm7c5k9c7t2DlpeTi+2CIH4bX7
	SqYCP93w7pFh7vC/ftP3kPVO7vu/WrgmjHgIoqKv/Wq/xZe1fCD8UZpUMWetxi1M6wAIFhUouuq/+
	q56xLsxlx7SWdI+8Ajil/vi+YniiGPGd+9KnKbDtzeIEHgA8HaE7NeE2N782dTM3oMnZ6XyLgU450
	fkDFZtw9nojyLdUfPjzqNag2eBjLfSYe9u30HpPZ00MjWdxt6FiQ+1ace4DllGa5xZdIb/h74Plwf
	c6x+5Z2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qVput-001AcU-33;
	Tue, 15 Aug 2023 09:00:43 +0000
Received: from szxga08-in.huawei.com ([45.249.212.255])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qVpur-001Abj-1d
	for linux-nvme@lists.infradead.org;
	Tue, 15 Aug 2023 09:00:43 +0000
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.56])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RQ4vG3krDz1GDTK;
	Tue, 15 Aug 2023 16:59:06 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 15 Aug
 2023 17:00:24 +0800
From: Ruan Jinjie <ruanjinjie@huawei.com>
To: <linux-nvme@lists.infradead.org>, Keith Busch <kbusch@kernel.org>, Jens
 Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg
	<sagi@grimberg.me>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next] nvme: switch to use kmemdup_nul() helper
Date: Tue, 15 Aug 2023 16:59:27 +0800
Message-ID: <20230815085927.1155834-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230815_020041_750363_98191572 
X-CRM114-Status: UNSURE (   9.19  )
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

Use kmemdup_nul() helper instead of open-coding to
simplify the code.

Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
---
 drivers/nvme/host/sysfs.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 212e1b05d298..8d60948be485 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -435,10 +435,9 @@ static ssize_t nvme_ctrl_dhchap_secret_store(struct device *dev,
 	if (memcmp(buf, "DHHC-1:", 7))
 		return -EINVAL;
 
-	dhchap_secret = kzalloc(count + 1, GFP_KERNEL);
+	dhchap_secret = kmemdup_nul(buf, count, GFP_KERNEL);
 	if (!dhchap_secret)
 		return -ENOMEM;
-	memcpy(dhchap_secret, buf, count);
 	nvme_auth_stop(ctrl);
 	if (strcmp(dhchap_secret, opts->dhchap_secret)) {
 		struct nvme_dhchap_key *key, *host_key;
@@ -493,10 +492,9 @@ static ssize_t nvme_ctrl_dhchap_ctrl_secret_store(struct device *dev,
 	if (memcmp(buf, "DHHC-1:", 7))
 		return -EINVAL;
 
-	dhchap_secret = kzalloc(count + 1, GFP_KERNEL);
+	dhchap_secret = kmemdup_nul(buf, count, GFP_KERNEL);
 	if (!dhchap_secret)
 		return -ENOMEM;
-	memcpy(dhchap_secret, buf, count);
 	nvme_auth_stop(ctrl);
 	if (strcmp(dhchap_secret, opts->dhchap_ctrl_secret)) {
 		struct nvme_dhchap_key *key, *ctrl_key;
-- 
2.34.1


