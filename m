Return-Path: <SRS0=Br1a=5M=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C69C0C43331
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Mar 2020 17:20:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CDE3206DB
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Mar 2020 17:20:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YIIpfMXL";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gpRx97oL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CDE3206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vC0mZZTE7ohjm3Le8Hc90uA8PKa7olmMpayeWxW249U=; b=YIIpfMXLbKZ2gh
	oHH0FYUYWwS6yYbkI5a8hVL0Zo/2BzdtzNJtiDFBjxG1bzQXbyEZZaIBhZtiRxghK6wXFcjdiqkw8
	ccAZvpytsaUOVleCH2S09fLxSvI+rsaUI7CRipl5UrGcO3SALEhnQhsoNxREH5GYTkX+TfUQWQvPS
	l/gnYehorq7eGFmiuVQOhK2Usc3FUgP+jynOtiQCy6QzOtiRafi00nobNV2BEd98jXpOHcpO3tmNe
	C974mdLDHcW4tAQv0+5X3hG9LHdwy9pcGfGlp952khy2ncnw1+RFM1elvoGgBNsCYEQpTg3O6DYCT
	ZiLkCkZThmp5mliHAePw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jHseY-0004Gf-1g; Fri, 27 Mar 2020 17:20:18 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jHsaW-000870-H6
 for linux-nvme@bombadil.infradead.org; Fri, 27 Mar 2020 17:16:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=QHfQLJTfMGror98Sjx3hlFU3CIU0kxw1STvVJMzOyJs=; b=gpRx97oLA4L+nSNgkFX4BgNI69
 ksvt3VHjpCUIfiVbv0wbIPVoqiJW1EWY8/ssXK/wWfQzfwSZr/ckQX87VNKrKHmwrQjY7KSuOyhdU
 Y+gAHpkmkNjbPV/aJm4lWcZ5lT5qxlCqWFwHc/rB6vDJTC5BJ/z+XD5e14qGT7/hZPoJihvEZXtnB
 JC+aeMN0UW2aL0QYrpuhSePkaTUKbB+e2lrbMwg6ldMJQYqfooSiYFhX8a3c5/iY2EHH9ZzWK4/1E
 XDr24efHmwn4wV8NMaHLgqEcMkmjqncblvKQLJf5mfFpA+TKPEwPnfCLTNWrAL8HVpItjF0WaLIsx
 ihRcEgvg==;
Received: from mail-il-dmz.mellanox.com ([193.47.165.129] helo=mellanox.co.il)
 by casper.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jHsaN-0005Dp-Q5
 for linux-nvme@lists.infradead.org; Fri, 27 Mar 2020 17:16:07 +0000
Received: from Internal Mail-Server by MTLPINE1 (envelope-from
 maxg@mellanox.com)
 with ESMTPS (AES256-SHA encrypted); 27 Mar 2020 20:15:46 +0300
Received: from mtr-vdi-031.wap.labs.mlnx. (mtr-vdi-031.wap.labs.mlnx
 [10.209.102.136])
 by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 02RHFjj6004869;
 Fri, 27 Mar 2020 20:15:46 +0300
From: Max Gurtovoy <maxg@mellanox.com>
To: linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@lst.de,
 sagi@grimberg.me, martin.petersen@oracle.com, jsmart2021@gmail.com,
 linux-rdma@vger.kernel.org
Subject: [PATCH 03/17] nvme: Enforce extended LBA format for fabrics metadata
Date: Fri, 27 Mar 2020 20:15:31 +0300
Message-Id: <20200327171545.98970-5-maxg@mellanox.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200327171545.98970-1-maxg@mellanox.com>
References: <20200327171545.98970-1-maxg@mellanox.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200327_171600_745989_4B611656 
X-CRM114-Status: GOOD (  13.84  )
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
Cc: axboe@kernel.dk, vladimirk@mellanox.com, shlomin@mellanox.com,
 israelr@mellanox.com, idanb@mellanox.com, jgg@mellanox.com, oren@mellanox.com,
 maxg@mellanox.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

An extended LBA is a larger LBA that is created when metadata associated
with the LBA is transferred contiguously with the LBA data (AKA
interleaved). The metadata may be either transferred as part of the LBA
(creating an extended LBA) or it may be transferred as a separate
contiguous buffer of data. According to the NVMeoF spec, a fabrics ctrl
supports only an Extended LBA format. Fail revalidation in case we have a
spec violation. Also initialize the integrity profile for the block device
for fabrics ctrl.

Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
Signed-off-by: Israel Rukshin <israelr@mellanox.com>
---
 drivers/nvme/host/core.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f34ff34..b93a8c6 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1856,7 +1856,7 @@ static void nvme_update_disk_info(struct gendisk *disk,
 	blk_mq_unfreeze_queue(disk->queue);
 }
 
-static void __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
+static int __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
 {
 	struct nvme_ns *ns = disk->private_data;
 
@@ -1884,11 +1884,21 @@ static void __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
 			ns->features |= NVME_NS_EXT_LBAS;
 
 		/*
+		 * For Fabrics, only metadata as part of extended data LBA is
+		 * supported. Fail in case of a spec violation.
+		 */
+		if (ns->ctrl->ops->flags & NVME_F_FABRICS) {
+			if (WARN_ON_ONCE(!(ns->features & NVME_NS_EXT_LBAS)))
+				return -EINVAL;
+		}
+
+		/*
 		 * For PCI, Extended logical block will be generated by the
 		 * controller.
 		 */
 		if (ns->ctrl->ops->flags & NVME_F_METADATA_SUPPORTED) {
-			if (!(ns->features & NVME_NS_EXT_LBAS))
+			if (ns->ctrl->ops->flags & NVME_F_FABRICS ||
+			    !(ns->features & NVME_NS_EXT_LBAS))
 				ns->features |= NVME_NS_MD_HOST_SUPPORTED;
 		}
 	}
@@ -1903,6 +1913,7 @@ static void __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
 		revalidate_disk(ns->head->disk);
 	}
 #endif
+	return 0;
 }
 
 static int nvme_revalidate_disk(struct gendisk *disk)
@@ -1927,7 +1938,10 @@ static int nvme_revalidate_disk(struct gendisk *disk)
 		goto free_id;
 	}
 
-	__nvme_revalidate_disk(disk, id);
+	ret = __nvme_revalidate_disk(disk, id);
+	if (ret)
+		goto free_id;
+
 	ret = nvme_report_ns_ids(ctrl, ns->head->ns_id, id, &ids);
 	if (ret)
 		goto free_id;
@@ -3614,7 +3628,8 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	memcpy(disk->disk_name, disk_name, DISK_NAME_LEN);
 	ns->disk = disk;
 
-	__nvme_revalidate_disk(disk, id);
+	if (__nvme_revalidate_disk(disk, id))
+		goto out_free_disk;
 
 	if ((ctrl->quirks & NVME_QUIRK_LIGHTNVM) && id->vs[0] == 0x1) {
 		ret = nvme_nvm_register(ns, disk_name, node);
@@ -3639,6 +3654,8 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	return;
  out_put_disk:
 	put_disk(ns->disk);
+ out_free_disk:
+	del_gendisk(ns->disk);
  out_unlink_ns:
 	mutex_lock(&ctrl->subsys->lock);
 	list_del_rcu(&ns->siblings);
-- 
1.8.3.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
