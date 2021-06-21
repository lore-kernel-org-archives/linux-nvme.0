Return-Path: <SRS0=I4H8=LP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9032FC48BDF
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Jun 2021 03:10:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F22761151
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Jun 2021 03:10:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F22761151
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=GjRm5VoQhwAH2pHVj24VaGG1yL5LsS40kmr0/WcRXnU=; b=ps2O3OJLwLF+r3
	YvxFZuhN+ZwzTem8IG4S/3AZEnUm2DmrfNhXpR/wqA7v4ZQHsE2acZag8w96MTk8qvh1Lwysbhg80
	HdfsXu+Hmpr0uVjjkNn2FCYYAEm4/RJ5YZXsE+O0vHItyrLml8PETF1bbuGq3LPoMHxHNyB+7jSL6
	UVzDYpn7yAet9ZvJsY5+CDATn6nkoXc+1r9gZ0DMlSgRvJd/mSE2J/i1pxvXuiemAQeOaitjlpjxu
	UDnRikP6z9+nt2Qh2eyfgxDcifRL4yY/YwWXPlnTv0UQrQgh3PF+Q/AnrZHdhVch6rrzoYS5mnVMp
	n8Hgl00qvTuav8njvC6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lvAJo-001wR2-OP; Mon, 21 Jun 2021 03:09:48 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lvAJl-001wQS-RQ
 for linux-nvme@lists.infradead.org; Mon, 21 Jun 2021 03:09:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1624244985; x=1655780985;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=hJghrh6yC1JhWXB/wUUFdePL6ln2xkdkk7K0MUzskdM=;
 b=hye+DSxxs+bxGugntjwzQOtyxhijQ5IZCFSKcASmp5B8JjuU8lbXKf+a
 gyHSMWNyry31R5cEsm6HfZF5YN6ph/uvAymSKtjk9VsFJqiFosaJe42o5
 /8R+C5tbL5lmARLKk7VcvwamCRzlC3D8ItiROgrKyG2MiSdPHbuP9m6nf
 38JYP4koxui+Spfhl/Z06aYRqSaRHIaOJ+VjtkQXd4VPrX8ffWFLEyc4z
 wB4ZoOyhlIFPgcsU/rOuSoEE0rdkEa8omGT7LdeffjOC5u4mLOLRcKyhn
 xVJand8VXBpT9KlUdRlzfqWEyPAwCZ6wwXlTNcJBx3wDgyqKAzyiBTjcG w==;
IronPort-SDR: 2ObBNnJUjZncjB1vi0xCRpTd21ByesYjRUNAynkjNmMdI9WlInWR4nvcZPQSAslu85NnCT0OgR
 p+e24XequmlhUF4dcH7NnIbfOYiWGKpXO41Gs/wtD3948JkPLN21t3YWs3DphN9TsTYMndIos6
 w2qXuFc4L7qKFLkVidkUnBE7+WNhCMMVDdmNhw1GT7D0zBSOT7PoUh1/04Y384NnujQ5VezZdP
 9wGeElc7sjCGugQm4MuMpI998a/uOsVziOhherdQI0qAB73PoMBEvFFgj7huWiAL4adR/S4mHL
 MxI=
X-IronPort-AV: E=Sophos;i="5.83,288,1616428800"; d="scan'208";a="171699966"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 21 Jun 2021 11:09:43 +0800
IronPort-SDR: /HG2IJLat+gxMbtStBH5LYg6wddJoFgXfi87q6jHKLVn1WHMgqmEldCbkFBbq0Fi+Sd/w6Lln8
 95oApxfQgj387mXzrD/A4nzcKi09wJw+RfaQwAfGkf3sHcl30az38z0MnpTTIhuTURF4E88iLo
 c7T1mamF0w8BFj7m71F/QFGAjTxixVJNbvjJ8721NlmofRsNfUVlxxUsvKs1PHuFBEs3qkp9tz
 NPdi25TRc035B47tOo0M8845F4pLEK4CX7Zpv57wUZQmWZBlcyiHIpjNd3IN/Rw+BF4EQxyzgd
 z0/pwYYvN7Ki18zrSv/bvarJ
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jun 2021 19:47:02 -0700
IronPort-SDR: hSh20Fomt9XyBLjMlVvirACe2eYadzkuE2flxB8uWvFsbK2kuiHglcHPBIxuJxQQCIvZKVxN8z
 mgc7mYI5uMZ1PLUkDSJZaopwnobwOYh1kUt9QsA1Pxyfadr34REOfKVxOO3cXy0/n6pZiKBK6I
 ZQe145c3GEwIOhYgq/ifSJve5usUphWqNa4q5j1Q3NuBdg8d5O+KQ8fVd7xcszMFXLLgNsqhsQ
 qSXrEh943p6hzEEfleUo6/JxYEWR7yewNoJkk/gnKnXGbWF5PnUqLbIZnw35nuO/zhXHvyNLjJ
 jdI=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 20 Jun 2021 20:09:43 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, sagi@grimberg.me, kbusch@kernel.org,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH] nvme: add comment to not use kobj_to_dev()
Date: Sun, 20 Jun 2021 20:09:40 -0700
Message-Id: <20210621030940.22286-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210620_200946_013005_DE9D20F1 
X-CRM114-Status: GOOD (  12.30  )
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

Add a comment in nvme_ns_id_attrs_are_visible() and
nvme_dev_attrs_are_visible() not to replace container_of() with
kobj_to_dev(). Since use of kobj_to_dev() makes code harder to read.

Suggested-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/host/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 14d96ee4d341..559637ebda25 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3191,6 +3191,7 @@ static struct attribute *nvme_ns_id_attrs[] = {
 static umode_t nvme_ns_id_attrs_are_visible(struct kobject *kobj,
 		struct attribute *a, int n)
 {
+	/* Don't use kobj_to_dev(), since it makes code harder to read. */
 	struct device *dev = container_of(kobj, struct device, kobj);
 	struct nvme_ns_ids *ids = &dev_to_ns_head(dev)->ids;
 
@@ -3463,6 +3464,7 @@ static struct attribute *nvme_dev_attrs[] = {
 static umode_t nvme_dev_attrs_are_visible(struct kobject *kobj,
 		struct attribute *a, int n)
 {
+	/* Don't use kobj_to_dev(), since it makes code harder to read. */
 	struct device *dev = container_of(kobj, struct device, kobj);
 	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
 
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
