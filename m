Return-Path: <SRS0=GC6h=CE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34794C433E1
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Aug 2020 01:27:30 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0025E20737
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Aug 2020 01:27:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uSgH6/f7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0025E20737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=z8fzgRlFUUNqxJuYMi2da/vxcEqUoh7E6WgeAkWwjJU=; b=uSgH6/f75myG98ujMBgBsr/Xtq
	0/UFfqxev+H2WbMouTXvpmUlCovA8EYuk3+jcVLaRtExmLGkxnVE2IkS9lLI5HyBOxQNlos9QuQQX
	Jq22zRRZ1Fnhs83XEgyntYAG+83JknSI/QPMzqdv8U2vgrVCmGyNtHkaMqapjvRW6aMXitqwHe3cD
	5IalNr4gZX3iZtC+vC3XYdoD8BLSvh3xpgA24O5nnQKxeyJW5rYLJy13BV0j1ao7pfFC54gADUKQx
	xPuECJlBNFxrGIMP6U6n93uP0svvhDVLV3mrNotR4s2tOlCS7R6FDk9E03Wk/bf3ILKVc5oqBk6N1
	lQx8bmeg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kAkDk-00006s-R8; Wed, 26 Aug 2020 01:27:24 +0000
Received: from szxga06-in.huawei.com ([45.249.212.32] helo=huawei.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kAkDh-00006C-ES
 for linux-nvme@lists.infradead.org; Wed, 26 Aug 2020 01:27:22 +0000
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 96878FC90063F8FB198C;
 Wed, 26 Aug 2020 09:23:05 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Wed, 26 Aug 2020 09:22:57 +0800
From: Tian Tao <tiantao6@hisilicon.com>
To: <kbusch@kernel.org>, <axboe@fb.com>, <hch@lst.de>, <sagi@grimberg.me>,
 <linux-nvme@lists.infradead.org>
Subject: [PATCH] nvme: Use kobj_to_dev() instead of container_of()
Date: Wed, 26 Aug 2020 09:20:48 +0800
Message-ID: <1598404848-37313-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200825_212721_802512_443338F9 
X-CRM114-Status: GOOD (  10.06  )
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
Cc: linuxarm@huawei.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Use kobj_to_dev() instead of container_of()

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 drivers/nvme/host/core.c     | 4 ++--
 drivers/nvme/host/lightnvm.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 154942f..eb50615 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3422,7 +3422,7 @@ static struct attribute *nvme_ns_id_attrs[] = {
 static umode_t nvme_ns_id_attrs_are_visible(struct kobject *kobj,
 		struct attribute *a, int n)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct nvme_ns_ids *ids = &dev_to_ns_head(dev)->ids;
 
 	if (a == &dev_attr_uuid.attr) {
@@ -3665,7 +3665,7 @@ static struct attribute *nvme_dev_attrs[] = {
 static umode_t nvme_dev_attrs_are_visible(struct kobject *kobj,
 		struct attribute *a, int n)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
 
 	if (a == &dev_attr_delete_controller.attr && !ctrl->ops->delete_ctrl)
diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index 8e562d0..70c87ff 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -1241,7 +1241,7 @@ static struct attribute *nvm_dev_attrs[] = {
 static umode_t nvm_dev_attrs_visible(struct kobject *kobj,
 				     struct attribute *attr, int index)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct gendisk *disk = dev_to_disk(dev);
 	struct nvme_ns *ns = disk->private_data;
 	struct nvm_dev *ndev = ns->ndev;
-- 
2.7.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
