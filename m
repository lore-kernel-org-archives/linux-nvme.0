Return-Path: <SRS0=UXA3=OE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B0E0C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Sep 2021 07:12:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1578661151
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Sep 2021 07:12:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1578661151
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ISxVrbkssUr9Ljp2oTDQLXx9Vp0GxU1F/oFQ+Z/FXgM=; b=AmHNbEEKd7pMVl
	hxiLZ/pqoTcp4Zo72lBE2iO1vyCVq8qI8199BcWj8GQaXTlNGW6EvYkDVBXQVQ/hD50XgI5GaLX5x
	SyPgPMWGIusIP6F/gdJX+qiyE4VYO07AlFouAKq9a7v/Fuh8/Dk01fQs2hqGIqxgmJt8E2IohnbU6
	Ntim10dFAMBCcseaafAGSU/gnvmYNmpqGA4RYF9+KYI4Oju57B4fJTrk3zhZYj4vpN8uBeZOE/4Jk
	j5iP2kuNSfk7YQ9x1j0krwwRIBr3JsFSvmmW2Weoz57GI0VNE66UptT9jkzV90cUV1zE/Qp3izqIN
	56T9Ssl/252tpeVg2NVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mQ2bz-004Ozu-Sk; Tue, 14 Sep 2021 07:12:11 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mQ2bx-004Oz9-NJ
 for linux-nvme@bombadil.infradead.org; Tue, 14 Sep 2021 07:12:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=Df9SelIUYBc0yVIr3NKOtMbMq+ENDsJbIcDBQ82Woao=; b=I3S6UN9HoeiIfMU2tlMAjjNoPU
 9+xzYED3dpLFGNCT12RtZfLNwaBM88oO5EHQ7jJ177lh0QuRJnCVQnGVNBcKcmp3HzKx54T1V2BQr
 OmBYJ4hObv+rxOhXbxTAMMtpgaxXC6Sp/htiFsoB0mn3ngqNAsc7sbJNmEwxqfP5gjB005chvT+7U
 Wrah02H5wY0w25rHJsmczxSk/i6ee2r5nd2YVqIaKSUUjT76VVQ14/5lqizU6lOlm1FRpI4R08Q08
 SJP9pBsQUmuxO0iDO4+KpiyaWbE3REs6bGto6gCZwk3luBv6FhiF6fJfb9NTjlzPtvk/VN1HMePm+
 bV7hTHZg==;
Received: from [2001:4bb8:184:72db:7baf:b601:6734:7149] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mQ2aZ-00EMxO-PE; Tue, 14 Sep 2021 07:10:59 +0000
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk,
	martin.petersen@oracle.com
Cc: Lihong Kou <koulihong@huawei.com>, kbusch@kernel.org, sagi@grimberg.me,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: [PATCH 3/3] nvme: remove the call to nvme_update_disk_info in
 nvme_ns_remove
Date: Tue, 14 Sep 2021 09:06:57 +0200
Message-Id: <20210914070657.87677-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210914070657.87677-1-hch@lst.de>
References: <20210914070657.87677-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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

There is no need to explicitly unregister the integrity profile when
deleting the gendisk.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 97f8211cf92c1..6600e138945e2 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3862,8 +3862,6 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 		nvme_cdev_del(&ns->cdev, &ns->cdev_device);
 	del_gendisk(ns->disk);
 	blk_cleanup_queue(ns->queue);
-	if (blk_get_integrity(ns->disk))
-		blk_integrity_unregister(ns->disk);
 
 	down_write(&ns->ctrl->namespaces_rwsem);
 	list_del_init(&ns->list);
-- 
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
