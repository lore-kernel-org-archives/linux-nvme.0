Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 521E7EB64DA
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Jun 2023 14:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bJGrZXTwtOsU4kZNzkQsFkVjDkz2Qxmf1lywo+B8LeY=; b=U/ETqphL+z5uWac3jI9UvKcgDh
	r0wGtBmSWSIgXWmIfiSzrKAzMG8U971eiJf+B7JliszIHyAm9oD1XX/mQn6HVrtY2rZeQJUEerPeI
	Ock3NXC6nbUyh35tSUA/DSDi9YwdglnBxQwDxiN7yWCudZwS6vr4Ne/JhpxHn8JWugZ5bokzxQvWD
	Z6fiD4ls4Ao/oHCsOqaNuuFFLEB5KSpYMlS7dqtN4/mpZx80XsXlViXTSdchxNMF/guwjqSAl1snk
	VuDFBFjWY5Auu8JnzjgrVQMci+FHoCGcRv0fa/IdR3jBQD7Y4TEI1H1nrukNdgLRlRi8K+2cIrqya
	HwzPbsfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q9o2p-00F9Gr-1x;
	Thu, 15 Jun 2023 14:33:51 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q9o2n-00F96j-1j
	for linux-nvme@lists.infradead.org;
	Thu, 15 Jun 2023 14:33:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1686839614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bJGrZXTwtOsU4kZNzkQsFkVjDkz2Qxmf1lywo+B8LeY=;
	b=DAoiKcWY6F5wrULNWg8oxxGXdDdZkns7eUQ4HGgMCnPHMDlrrV2yvgegJm6Qq5ISiMlkkv
	2zs5uEyK7V+2ItDSIIE8ulHeCj0gZ/xbckFQgGfiL2Ppmls2/wOU5T/J1mPluWjkaPU7jp
	Vzf350L7AL6TW19knYWpgbFxvJ9JWmI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-151-_VlH3dn7Pjmdn2mPw3qQYQ-1; Thu, 15 Jun 2023 10:33:29 -0400
X-MC-Unique: _VlH3dn7Pjmdn2mPw3qQYQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CD039858287;
	Thu, 15 Jun 2023 14:32:54 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0C431140E952;
	Thu, 15 Jun 2023 14:32:53 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org
Cc: Yi Zhang <yi.zhang@redhat.com>,
	linux-block@vger.kernel.org,
	Chunguang Xu <brookxu.cn@gmail.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 3/4] nvme: unfreeze queues before removing namespaces
Date: Thu, 15 Jun 2023 22:32:35 +0800
Message-Id: <20230615143236.297456-4-ming.lei@redhat.com>
In-Reply-To: <20230615143236.297456-1-ming.lei@redhat.com>
References: <20230615143236.297456-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230615_073349_651891_BD646016 
X-CRM114-Status: GOOD (  14.08  )
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

If removal is from breaking error recovery, queues may be frozen, and
there may be pending IOs in bio_queue_enter(), and the following
del_gendisk() may wait for these IOs, especially from writeback.

Similar IO hang exists in flushing scan work too if there are pending
IO in scan work context.

Fix the kind of issue by unfreezing queues before removing namespace,
so that all pending IOs can be handled.

Reported-by: Chunguang Xu <brookxu.cn@gmail.com>
https://lore.kernel.org/linux-nvme/cover.1685350577.git.chunguang.xu@shopee.com/
Reported-by: Yi Zhang <yi.zhang@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/nvme/host/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 96785913845b..ec7bd33b7e5f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4645,6 +4645,9 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
 	 */
 	nvme_mpath_clear_ctrl_paths(ctrl);
 
+	/* unfreeze queues which may be frozen from error recovery */
+	nvme_unfreeze_force(ctrl);
+
 	/* prevent racing with ns scanning */
 	flush_work(&ctrl->scan_work);
 
-- 
2.40.1


