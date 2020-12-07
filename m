Return-Path: <SRS0=D68J=FL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5612FC4361B
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Dec 2020 13:21:43 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 554EA23436
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Dec 2020 13:21:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 554EA23436
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EynZudSxd3b/ywi49MVzfRGlaLJZfZ0de5z06+7zGmM=; b=i9fbhCh7WvjpYTS6XFiNaY8h9
	KPRrvKgWf1vpWAPPf4Yx+Y6v4LHkX4PpNVHeycQdX0ah5gNauO0iAaNx65O0uueSz3Kq78dvogRH6
	MIda+1ISe7//CuK1D/O5DNKshiqd4iFtcOrs3ryggrs9QlHUBjZiDOsK5qUOgBYvqAsBAHlJfSDX6
	C2Aahen+K5QK4V+ZTxAWnhwn+kIor8+7xTDSlCRz0eC853l6wG+450wLp7Q6bb+5pwaCLPUJU8GIo
	yxwGCW2pw2ug96jNw4C9+LqxkfFSrHOkBLpzigCnZtn9+em8NADuPrA1mt+JQyym652wRzUa6hS6T
	CzxNLWqig==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kmGSP-0005uD-HH; Mon, 07 Dec 2020 13:21:37 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kmGSM-0005tU-4w
 for linux-nvme@merlin.infradead.org; Mon, 07 Dec 2020 13:21:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=t4ldQ8fl+qMM38iWV+5KSLcBJhRozKefuNXGg7W4oNc=; b=ReOLFRag9Ufifj+Ml28vixFG3O
 MQsGWqCuidV5jVN4y/nZaly1x0YxiAby/j5JMkYZe5PF6EUBTT0Dk0NVsisDIJwLaCL4vhZHcB67m
 O3W6SDfWzVIxTC+ZcO2n4RP9oKYeM+xpp73wUe8PnsiJtV4O17TUMpGy5NdXJB5WtH14HBGnBBwkP
 1MNKCk5/R6FQB/8NNO7P5w7pmE1J69JPBnvWQ8QmgYo/fVphHK3Cip8j8n1rjw4aVksBzm8FhDdCK
 ur4REu5ZJHmPUoSiQ95QWJ3ETyAQHxWoupAJHaZbChIdKxnfAjDjEnVRdb3bc+8so3g0iIoqQK2kx
 dgzR01NQ==;
Received: from [2001:4bb8:188:f36:4fd9:254f:b3b5:5284] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kmGSJ-0006Ow-LL; Mon, 07 Dec 2020 13:21:31 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/6] dm: use bdev_read_only to check if a device is read-only
Date: Mon,  7 Dec 2020 14:19:13 +0100
Message-Id: <20201207131918.2252553-2-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201207131918.2252553-1-hch@lst.de>
References: <20201207131918.2252553-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: Sagi Grimberg <sagi@grimberg.me>, Mike Snitzer <snitzer@redhat.com>,
 Oleksii Kurochko <olkuroch@cisco.com>,
 Dongsheng Yang <dongsheng.yang@easystack.cn>, linux-block@vger.kernel.org,
 dm-devel@redhat.com, linux-nvme@lists.infradead.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
 Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

dm-thin and dm-cache also work on partitions, so use the proper
interface to check if the device is read-only.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/md/dm-cache-metadata.c | 2 +-
 drivers/md/dm-thin-metadata.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/md/dm-cache-metadata.c b/drivers/md/dm-cache-metadata.c
index af6d4f898e4c1d..89a73204dbf47f 100644
--- a/drivers/md/dm-cache-metadata.c
+++ b/drivers/md/dm-cache-metadata.c
@@ -449,7 +449,7 @@ static int __check_incompat_features(struct cache_disk_superblock *disk_super,
 	/*
 	 * Check for read-only metadata to skip the following RDWR checks.
 	 */
-	if (get_disk_ro(cmd->bdev->bd_disk))
+	if (bdev_read_only(cmd->bdev))
 		return 0;
 
 	features = le32_to_cpu(disk_super->compat_ro_flags) & ~DM_CACHE_FEATURE_COMPAT_RO_SUPP;
diff --git a/drivers/md/dm-thin-metadata.c b/drivers/md/dm-thin-metadata.c
index 6ebb2127f3e2e0..e75b20480e460e 100644
--- a/drivers/md/dm-thin-metadata.c
+++ b/drivers/md/dm-thin-metadata.c
@@ -636,7 +636,7 @@ static int __check_incompat_features(struct thin_disk_superblock *disk_super,
 	/*
 	 * Check for read-only metadata to skip the following RDWR checks.
 	 */
-	if (get_disk_ro(pmd->bdev->bd_disk))
+	if (bdev_read_only(pmd->bdev))
 		return 0;
 
 	features = le32_to_cpu(disk_super->compat_ro_flags) & ~THIN_FEATURE_COMPAT_RO_SUPP;
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
