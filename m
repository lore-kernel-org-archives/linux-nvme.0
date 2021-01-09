Return-Path: <SRS0=oNOl=GM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65933C433E0
	for <linux-nvme@archiver.kernel.org>; Sat,  9 Jan 2021 10:45:37 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D72F823A1E
	for <linux-nvme@archiver.kernel.org>; Sat,  9 Jan 2021 10:45:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D72F823A1E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ad9kS4zh1cLXg/wghntNWFNOpri3ibDy++rlZww8Hcc=; b=Ei59ldv0cfzpcmOYvtY6wCez3
	7yAFHTRpN0v6IEGhbNj6FXEZ9gzcr0yw+bXg+GSCEYLLPiwO1xcCqz61Wnv+FlhILls6Hq1oRsbxo
	/WdmkRuHjwHLgD3j8DZcVBrH/yrMTo5uptXx5mw9QEp5lD3YVCft1q7/hq3WCVn05KO/TmJOnrHcl
	c1/CeapE7YHUo7N6UR5kt4yqhea7q7qonBh6HinbwvPgb2Y5zmDDZh7Mr7iSPwWoscpyHBTNIWo92
	sKDUc13nzHSRHK2RZ6Z/M9tiCd4pzrIPYqph1sGd4+6TIgaa01J0LfEq+xMNSEJs9704YKfgiQU+h
	218Uv1UTw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kyBkA-0003RT-6T; Sat, 09 Jan 2021 10:45:14 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kyBjb-0003Fg-Rw
 for linux-nvme@merlin.infradead.org; Sat, 09 Jan 2021 10:44:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=Hk3FmyWBTPX2vs5vD3kbYiMzUxQSn7PXGcIMyCilJYs=; b=vx4kZ2Zd0/TAPMgqgFUzXTdBJu
 8Ettnbv0lHuMqotAHekqBrRJQrFK6XLthgr5Aia5ExJb7Cf9M4yKY6CmqDUdMs3v3rwtt4iSQ5ksA
 eTQN83suluixP8bK/t+EsvdTsEAJfNq8gphVEGE+HC3MpD5ALUDSiE/Rrtu1kh7tLgZzEOakc6kk6
 LxF2qbDMSmyb++jacxheJ4fdqHazY1H7nyA3ZMkww/Z+mQeCQ1t1XXyT7Wjs+JAgzoAOYqGa9gFsK
 pk71iuyyRsP340YteVF4F3oMxbOi0eCqvjX/2fcXxtJEjXOXWR0VSfXDwn5yhsk6gV8hdU/P+uySa
 y01UtpLg==;
Received: from [2001:4bb8:19b:e528:4197:a20:99de:e7b0] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1kyBim-000SyX-HT; Sat, 09 Jan 2021 10:44:04 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/6] dm: use bdev_read_only to check if a device is read-only
Date: Sat,  9 Jan 2021 11:42:49 +0100
Message-Id: <20210109104254.1077093-2-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210109104254.1077093-1-hch@lst.de>
References: <20210109104254.1077093-1-hch@lst.de>
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
 Dongsheng Yang <dongsheng.yang@easystack.cn>, Ming Lei <ming.lei@redhat.com>,
 linux-block@vger.kernel.org, dm-devel@redhat.com,
 linux-nvme@lists.infradead.org,
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
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
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
