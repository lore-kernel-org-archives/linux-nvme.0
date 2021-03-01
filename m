Return-Path: <SRS0=Uoxm=H7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 412D5C433DB
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Mar 2021 08:21:42 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4F8364E45
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Mar 2021 08:21:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4F8364E45
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=bvd6cIrovKSx6mLZa2W6bS9UaLDouMGITP1m8JW91So=; b=2Pn8O391mpdJ7kiFEXC7Z2rOU0
	AehXoTMMSy91pUaC/IzLRZfUTnfjzxuP3AUSfPuthnWQH1mcLWoJ/FEYzRc1OUz+qP6R7Cqksay7g
	Ou/50MmhM1/yXLKn76zY8/o/ackFus9q1GtRmMGb3ZUWZcB06NtUB/dWJF8dazGCI6Qzq8XEwHIIj
	KqKUZeUM4P3bhlmenW92K0iV8nJ+7+h4MBnQHtbu+bW1srZgp/vZGvt/wM41KxV2tp0cxyko5aOah
	aWbYbdxL5X3QU/my1XUCfgtHZeaKaX07hQXilm6pIt+QuW+jn7I2G18/h5IsI8ZOvuhAfxvXSHAxH
	SOHZDSEg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lGdnw-0005tO-Rv; Mon, 01 Mar 2021 08:21:24 +0000
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lGdns-0005sm-Mn
 for linux-nvme@lists.infradead.org; Mon, 01 Mar 2021 08:21:22 +0000
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R131e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04426; MF=yang.lee@linux.alibaba.com;
 NM=1; PH=DS; RN=7; SR=0; TI=SMTPD_---0UPvxPBj_1614586871; 
Received: from
 j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com
 fp:SMTPD_---0UPvxPBj_1614586871) by smtp.aliyun-inc.com(127.0.0.1);
 Mon, 01 Mar 2021 16:21:12 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: kbusch@kernel.org
Subject: [PATCH] lightnvm: Switch to using the new API kobj_to_dev()
Date: Mon,  1 Mar 2021 16:21:09 +0800
Message-Id: <1614586869-1479-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210301_032121_067271_9A8E0255 
X-CRM114-Status: GOOD (  10.57  )
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
Cc: sagi@grimberg.me, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, axboe@fb.com,
 Yang Li <yang.lee@linux.alibaba.com>, hch@lst.de
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

fixed the following coccicheck:
./drivers/nvme/host/lightnvm.c:1243:60-61: WARNING opportunity for
kobj_to_dev()

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/nvme/host/lightnvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index b705988..e3240d1 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -1240,7 +1240,7 @@ static ssize_t nvm_dev_attr_show_20(struct device *dev,
 static umode_t nvm_dev_attrs_visible(struct kobject *kobj,
 				     struct attribute *attr, int index)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct gendisk *disk = dev_to_disk(dev);
 	struct nvme_ns *ns = disk->private_data;
 	struct nvm_dev *ndev = ns->ndev;
-- 
1.8.3.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
