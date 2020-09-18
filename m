Return-Path: <SRS0=7z9d=C3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F194EC43463
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Sep 2020 02:19:59 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42B1723600
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Sep 2020 02:19:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="n6+ROpGX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SeMpluox"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42B1723600
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=G5oznSSV2l1vQcOpaEP2D/5s6lBTsARrMG1oklaIhiM=; b=n6+ROpGXo3GkAJ9p7SlbYpLwC
	Xxb7jI47a/rtoq0XfRxlkv68bLFNMZxXbduLtdMsS8MBJfjUpxXd8pJUKO5IoZYKnLPPYh6dgl3DX
	i68szF6VBEp9sCYlRLmxts0/HjEfgrixFiGT4Nx/K5mp4tqwjKldPldShMAeo0GrpJIHRlwx6tWao
	xilsuW9TCbZSTdYqClDNM6EfY58aHoRWRfQAiuAYaxoW4QAjPHrc7xw+0l8uiDlfBoRy3DD6/hvny
	bXwYw2TrBjcncn9RL7w2xkL0rDDz6fmHazcFET+DZMCzvASBlWAWaa01GXECdfXkWmvjIafon4z7w
	DaL779mwQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kJ607-0002k2-LZ; Fri, 18 Sep 2020 02:19:51 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kJ5of-00059Z-90
 for linux-nvme@lists.infradead.org; Fri, 18 Sep 2020 02:08:02 +0000
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 52DA82395B;
 Fri, 18 Sep 2020 02:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600394880;
 bh=b0QaQkPQUvGb0i1tDsh+9kqSe2KgUtokEip5fnHtNmY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=SeMpluox2+GRRmu7XiCVsusUxtes/cVV225EPhMfjzAazUnQ+Lk+5YazVYqVxKUyo
 xmxSxuqL8sRtm0ldDugDWnvOkJq+nExp6zfOIA0SRxVPvGfV+zMGjAj4sf26K3xlET
 jVi4U+WKyfKr4Cgtjmxk6Jqv0nAIz3cyYXy+BX78=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 330/330] nvme: explicitly update mpath disk
 capacity on revalidation
Date: Thu, 17 Sep 2020 22:01:10 -0400
Message-Id: <20200918020110.2063155-330-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200918020110.2063155-1-sashal@kernel.org>
References: <20200918020110.2063155-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200917_220801_596345_24CEE349 
X-CRM114-Status: GOOD (  14.81  )
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
Cc: Anthony Iliopoulos <ailiop@suse.com>, Sasha Levin <sashal@kernel.org>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Anthony Iliopoulos <ailiop@suse.com>

[ Upstream commit 05b29021fba5e725dd385151ef00b6340229b500 ]

Commit 3b4b19721ec652 ("nvme: fix possible deadlock when I/O is
blocked") reverted multipath head disk revalidation due to deadlocks
caused by holding the bd_mutex during revalidate.

Updating the multipath disk blockdev size is still required though for
userspace to be able to observe any resizing while the device is
mounted. Directly update the bdev inode size to avoid unnecessarily
holding the bdev->bd_mutex.

Fixes: 3b4b19721ec652 ("nvme: fix possible deadlock when I/O is
blocked")

Signed-off-by: Anthony Iliopoulos <ailiop@suse.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c |  1 +
 drivers/nvme/host/nvme.h | 13 +++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index bbf52e88f045a..038ef9d113388 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1864,6 +1864,7 @@ static void __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
 	if (ns->head->disk) {
 		nvme_update_disk_info(ns->head->disk, ns, id);
 		blk_queue_stack_limits(ns->head->disk->queue, ns->queue);
+		nvme_mpath_update_disk_size(ns->head->disk);
 	}
 #endif
 }
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 7d57c42a641ca..aab976737f9a9 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -561,6 +561,16 @@ static inline void nvme_trace_bio_complete(struct request *req,
 					 req->bio, status);
 }
 
+static inline void nvme_mpath_update_disk_size(struct gendisk *disk)
+{
+	struct block_device *bdev = bdget_disk(disk, 0);
+
+	if (bdev) {
+		bd_set_size(bdev, get_capacity(disk) << SECTOR_SHIFT);
+		bdput(bdev);
+	}
+}
+
 extern struct device_attribute dev_attr_ana_grpid;
 extern struct device_attribute dev_attr_ana_state;
 extern struct device_attribute subsys_attr_iopolicy;
@@ -636,6 +646,9 @@ static inline void nvme_mpath_wait_freeze(struct nvme_subsystem *subsys)
 static inline void nvme_mpath_start_freeze(struct nvme_subsystem *subsys)
 {
 }
+static inline void nvme_mpath_update_disk_size(struct gendisk *disk)
+{
+}
 #endif /* CONFIG_NVME_MULTIPATH */
 
 #ifdef CONFIG_NVM
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
