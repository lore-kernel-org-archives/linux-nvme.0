Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09B84C04A95
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Sep 2022 01:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=b7q+EJ/ra0nyTIMUjfA713y5fkLY0H/B8MGc0Xo6s/w=; b=iWysvCYMAKP3WqRgIKc+fj3b4x
	PyhGq/1XGkdaBdIfLZ0MITfDq8sC9R2pPjJv5aOp2l7keTbvFfvS/EgooTp9toO+KzglID3svC0wQ
	e5NX/UH+x48JdshXQcW+XvTJEBgduHvc52FsjGRySuftyN4u4UXaThTRganJ5Ncxk/NwReWk1Oz74
	1kMyjQlsUWSUVpFo1u647tGfKQEZsDx6JndAR/6+vMmwVIzji4xSx4Cwd7O8OSm/gLgklwtxIVbYV
	hVwuP+CH6sfPoJ3vUurnNjsCfz4C70Xzk9zh/+krYkuo3DVTaQ0Man+zmRJfSAhK4/rbgB0dRgJZz
	pqVnPs8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ocd0l-000l7X-5T; Mon, 26 Sep 2022 01:34:19 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ocd0i-000l6M-Fb
	for linux-nvme@lists.infradead.org; Mon, 26 Sep 2022 01:34:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1664156053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=b7q+EJ/ra0nyTIMUjfA713y5fkLY0H/B8MGc0Xo6s/w=;
	b=i8LosV7iERiCZkvaOLqXNVMvB0nD+Sxdwo0Zzy25ZaVANFbaVX4HgfjmoMwB5VDxri0w/O
	U1U0Uph5Ak42Bq6odGvRg65ehBm33iUb4mYs/+aHersdsOHNWqAFs/5Cwnwx/N0gvL67vp
	J1yIq+4S+sa2FDa6C7TNu3cZVKvt4no=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-153-g1PHuNGdPiGpm3Tt2AcCtg-1; Sun, 25 Sep 2022 21:34:09 -0400
X-MC-Unique: g1PHuNGdPiGpm3Tt2AcCtg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5B6D085A59D;
	Mon, 26 Sep 2022 01:34:09 +0000 (UTC)
Received: from localhost (ovpn-8-18.pek2.redhat.com [10.72.8.18])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1867118EB3;
	Mon, 26 Sep 2022 01:34:07 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>,
	linux-nvme@lists.infradead.org
Cc: Yi Zhang <yi.zhang@redhat.com>,
	Ming Lei <ming.lei@redhat.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chao Leng <lengchao@huawei.com>,
	Keith Busch <kbusch@kernel.org>
Subject: [PATCH V2] nvme: don't wait freeze during resetting
Date: Mon, 26 Sep 2022 09:34:04 +0800
Message-Id: <20220926013404.2217794-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220925_183416_611307_42EEF0CC 
X-CRM114-Status: GOOD (  12.52  )
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

First it isn't necessary to call nvme_wait_freeze during reset.
For nvme-pci, if tagset isn't allocated, there can't be any inflight
IOs; otherwise blk_mq_update_nr_hw_queues can freeze & wait queues.

Second, since commit bdd6316094e0 ("block: Allow unfreezing of a queue
while requests are in progress"), it is fine to unfreeze queue without
draining inflight IOs.

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Chao Leng <lengchao@huawei.com>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
V2:
	- remove the change in rdma/tcp which may make non-mpath reset
	time much longer, as pointed by Sagi

 drivers/nvme/host/apple.c | 1 -
 drivers/nvme/host/pci.c   | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index 5fc5ea196b40..9cd02b57fc85 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -1126,7 +1126,6 @@ static void apple_nvme_reset_work(struct work_struct *work)
 	anv->ctrl.queue_count = nr_io_queues + 1;
 
 	nvme_start_queues(&anv->ctrl);
-	nvme_wait_freeze(&anv->ctrl);
 	blk_mq_update_nr_hw_queues(&anv->tagset, 1);
 	nvme_unfreeze(&anv->ctrl);
 
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 98864b853eef..985b216907fc 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2910,7 +2910,6 @@ static void nvme_reset_work(struct work_struct *work)
 		nvme_free_tagset(dev);
 	} else {
 		nvme_start_queues(&dev->ctrl);
-		nvme_wait_freeze(&dev->ctrl);
 		if (!dev->ctrl.tagset)
 			nvme_pci_alloc_tag_set(dev);
 		else
-- 
2.31.1


