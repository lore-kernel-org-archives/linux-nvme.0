Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22C6AC19F2C
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Aug 2022 09:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=fLdDAv8WJpBwoT19ZPoCfhol6hf+bQXZVuG1GPDLW7I=; b=XludwJspuu4oKjC0+92dWjGMnN
	/8mQ9dlKlaz9N6jDft388+DbrqUmlhkCF0f3OpZWSAJNt+DA8jtzqjA/cBCICZeJN2vPTbbc/63uL
	8RGacUVkyn5Aio7ZRQZ8WCYJpGbacrHz2hAuUwUY4mKsdY0djm/A9XPKPZ82MndXkhMAD9szu+aoW
	JhhKtnRmhW8JiuLlHbN8wNBG4fZto9faJePZVuOiqAEzJGk2z4CtAfRjmJOMs7M/iDIqt49Bq45hW
	fs+5pk1R722dYNEKHpWZkRZdV2ma7UlDE7wnS+A14x674hZlJ53b+4W1yKgMCV2H1Y5JutdoTubMn
	Md7zBdkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oJAw0-004Rdp-A8; Wed, 03 Aug 2022 09:45:00 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oJAvu-004RXL-0q
	for linux-nvme@lists.infradead.org; Wed, 03 Aug 2022 09:44:56 +0000
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LyRjW6NY3zmV7V;
	Wed,  3 Aug 2022 17:42:39 +0800 (CST)
Received: from huawei.com (10.29.88.127) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 3 Aug
 2022 17:44:36 +0800
From: Chao Leng <lengchao@huawei.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <sagi@grimberg.me>, <kbusch@kernel.org>,
	<lengchao@huawei.com>
Subject: [PATCH] nvme: allow ioctl to submit io command with dif for NVMeoF
Date: Wed, 3 Aug 2022 17:44:36 +0800
Message-ID: <20220803094436.23407-1-lengchao@huawei.com>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.29.88.127]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220803_024454_689498_D15F416B 
X-CRM114-Status: GOOD (  10.64  )
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

If nvme over fabrics support t10dif, NVME_NS_EXT_LBAS and
NVME_NS_METADATA_SUPPORTED of ns->features will be set to 1.
Now nvme_submit_io do not allow the metadata if NVME_NS_EXT_LBAS of
ns->features is setted. Indeed It should allow the metadata if both
NVME_NS_EXT_LBAS and NVME_NS_METADATA_SUPPORTED of ns->features are setted.

Signed-off-by: Chao Leng <lengchao@huawei.com>
---
 drivers/nvme/host/ioctl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index a2e89db1cd63..408ba0cc111f 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -199,7 +199,8 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 		metadata = nvme_to_user_ptr(io.metadata);
 	}
 
-	if (ns->features & NVME_NS_EXT_LBAS) {
+	if ((ns->features & (NVME_NS_EXT_LBAS | NVME_NS_METADATA_SUPPORTED)) ==
+		NVME_NS_EXT_LBAS) {
 		length += meta_len;
 		meta_len = 0;
 	} else if (meta_len) {
-- 
2.16.4


