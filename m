Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94534D41C2E
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Nov 2024 10:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=J7gQhNSmtD6VtBqDj9ekJPknx/4FLi0GHXUfJk+SkYw=; b=qke5UK7RR5PH2wIr5v6i4hQJTa
	fEYSZGHWeqcqzvh4blNk3UIOAuitrTSjEETSFhdO5TQduH3LmG/CZJO1NT8nkZkR/qvJ4bHhLBcBy
	b6UipajqeB2G1OXIagX+TNWpfJ2bWPrC1CA2qDH+rUdaIRtkA9jKJGSAikMAG1ZDQ6AFVTI1awbtV
	L0bPaBwJ/U/GC9Gk5JwrbaUFWpaGFce06PSLCiMbuNO3URL6lfcconUeZ7iEIqL3f7dJglioWolYI
	FD2YX5aFwakbrW4RleWX9hKvh8JcPyviE8M0YMCf4c3v8A3ezvCXb1X/TXBd5uAfDHP1WlOSh8t5L
	hqwuRIog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBAf3-00000006S3n-1XN5;
	Wed, 13 Nov 2024 10:31:45 +0000
Received: from out30-97.freemail.mail.aliyun.com ([115.124.30.97])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBASY-00000006PrA-0l9k
	for linux-nvme@lists.infradead.org;
	Wed, 13 Nov 2024 10:18:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731493126; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=J7gQhNSmtD6VtBqDj9ekJPknx/4FLi0GHXUfJk+SkYw=;
	b=JU8kF0YpRL3OXsneOM6WBUqZCQWM6r4Zk22O1w3E1KZHWAhxGzIG0OomG1eFL50Ll2zZKdA1QUFoLDZgvZrqrmlYUmtE4HOTplV/vqt5nnb6YKrCNQWLLCALajuuM2Vsi7tth8oCzT3fyNa6taahXYf2h6HpzawKVbzZdeKT14Y=
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WJKj3pz_1731493119 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 13 Nov 2024 18:18:44 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH v5] nvmet: report ns's vwc not present
Date: Wed, 13 Nov 2024 18:18:39 +0800
Message-ID: <20241113101839.101320-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241113_021850_929140_C6A09C4B 
X-CRM114-Status: GOOD (  10.15  )
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

Currently, we report that controller has vwc even though the ns may
not have vwc. Report ns's vwc not present when not buffered_io or
backdev doesn't have vwc.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
Based on Keith's v4 patch,
Changes from v4 to v5:
- When the backend is file, report support vwc even though buffered_io is
  disable, and add an annotation to expain it.

 drivers/nvme/target/admin-cmd.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 0a9fdc533186..934b401fbc2f 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -934,6 +934,13 @@ static void nvmet_execute_id_cs_indep(struct nvmet_req *req)
 		id->nsattr |= NVME_NS_ATTR_RO;
 	if (req->ns->bdev && !bdev_nonrot(req->ns->bdev))
 		id->nsfeat |= NVME_NS_ROTATIONAL;
+	/*
+	 * We need flush command to flush the file's metadata,
+	 * so report supporting vwc if backend is file, even
+	 * though buffered_io is disable.
+	 */
+	if (req->ns->bdev && !bdev_write_cache(req->ns->bdev))
+		id->nsfeat |= NVME_NS_VWC_NOT_PRESENT;
 
 	status = nvmet_copy_to_sgl(req, 0, id, sizeof(*id));
 	kfree(id);
-- 
2.43.0


