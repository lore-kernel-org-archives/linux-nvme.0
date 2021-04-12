Return-Path: <SRS0=ND0+=JJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06492C433B4
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Apr 2021 12:24:11 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A5676128A
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Apr 2021 12:24:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A5676128A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=zfh33YZnLrR8TKWCq+dqPlHnfZ1h/nqWD7yyQAkBGKE=; b=Gvf9aEYg+0d8FtIDgSHrb1P92m
	u5H7n9sNrhoTA5AWMWcqpVJ8klV4nM2rboN1AvAjKGxSTBcvsrjEI2hgcjcpSBKmSo7poSZyX5tsa
	EPGPOqSnloU/onBbb+ZDgrCxFxzwRdN7Zj+ml4+aG7ureNZBaoLTbUxD2Nm8Oaeulba904QtiIETC
	byzGSF495Pe8pZCNO1Ca0WH6zTYvc+gO0lyV1Xmx/GdJUEI1GnECjUDyArmC2Dcv3sr6RqZlU8zm5
	2ZpsEsd790b5zmYs0ZrtDS22LdrYunOqoo2uZBKlV2+bsUhw4jkTxizmkbPiEVTo6bn7YErySsGl7
	yqOWbdcw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lVvbb-006fvJ-6D; Mon, 12 Apr 2021 12:23:51 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lVvbW-006fuC-32
 for linux-nvme@desiato.infradead.org; Mon, 12 Apr 2021 12:23:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=m/Wuv6f5G8svun+qjdTH6/J+JLxrkRvirnYw5qXLtPM=; b=Qv0uzYxyDR6qmxln5MviUOKDOI
 rzl/laBDlFFvlkJ+6ngEqnE96IG12CcKAyZKmmucvlsILLQEZxnUGQdh23dgEqm/csp2ljgNXDrWQ
 6ltHPyihAc8135pyBaYV3yyEtK4J+V65XvPbftm96WF8FRYSNyOMzlX8gEJxfOl0ZgYERz0ImHQOb
 0H7hjIc3TcjIK/QgcpK/pNnWEJw2SCXlI9ISnIWJbZuUtFcJSqvw4IwBo/gi5jw+5dGNMWVZH7QB6
 JwnVbhLC2lBLtm6BHCJ7UdFVWa2EpTCvLrldJ2ijZY7sF+pVmfgXU7TNztZsVTo9M1nnL4kYlPyho
 u/8n5jhQ==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lVvbT-006DTn-3h
 for linux-nvme@lists.infradead.org; Mon, 12 Apr 2021 12:23:44 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id BF645AE5C;
 Mon, 12 Apr 2021 12:23:39 +0000 (UTC)
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Steve Wise <swise@opengridcomputing.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Potnuri Bharat Teja <bharat@chelsio.com>, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH] nvme: Drop WQ_MEM_RECLAIM flag from core workqueues
Date: Mon, 12 Apr 2021 14:23:30 +0200
Message-Id: <20210412122330.5166-1-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210412_052343_461459_00D65B1B 
X-CRM114-Status: GOOD (  16.41  )
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

Drop the WQ_MEM_RECLAIM flag as it is not needed and introduces
warnings.

The documentation says "all wq which might be used in the memory
reclaim paths MUST have this flag set. The wq is guaranteed to have at
least one execution context regardless of memory pressure."

By setting WQ_MEM_RECLAIM the threads are ready be running during
early init. The claim it guarantees at least one execution context
regardless of memory pressure is not supported by the implementation.

As the nvme core does not depend on early init we can remove the
WQ_MEM_RECLAIM flag. This resolves a warning in the rdma path:

  WQ_MEM_RECLAIM nvme-wq:nvme_rdma_reconnect_ctrl_work [nvme_rdma]
  is flushing !WQ_MEM_RECLAIM ib_addr:process_one_req [ib_core]

There were several attempts to address these kind of warnings and but
it still persist:

  39baf10310e6 ("IB/core: Fix use workqueue without WQ_MEM_RECLAIM")
  cb93e597779e ("cm: Don't allocate ib_cm workqueue with WQ_MEM_RECLAIM")
  c669ccdc50c2 ("nvme: queue ns scanning and async request from nvme_wq")

Also a review of the nvme jobs shows nvme_wq and nvme_reset_wq gets
jobs posted which do memory allocation:

 - nvme_wq

   nvme_scan_work()
     nvme_scan_ns_list()
       ns_list = kzalloc(..., GFP_KERNEL);
   [...]

 - nvme_reset_wq

   nvme_reset_work()
     nvme_pci_configure_admin_queue()
       nvme_alloc_queue()
         dma_alloc_coherent(..., GFP_KERNEL)

   nvme_rdma_reset_ctrl_work()
     nvme_rdma_setup_ctrl()
       (see above)

   nvme_reset_ctrl_work()
     nvme_tcp_setup_ctrl()
       nvme_tcp_configure_admin_queue()
         nvme_tcp_alloc_queue()
           sock_create()
   [...]

nvme_delete_wq doesn't run any job which allocates memory, the system
still depends on nvme_wq/nvme_reset_wq making progress.

 - nvme_delete_wq

   nvme_fc_ctrl_connectivity_loss()
     nvme_delete_ctrl()
   nvme_fc_unregister_remoteport
     nvme_delete_ctrl()
   nvme_fc_reconnect_or_delete()
     nvme_delete_ctrl()
   nvme_rdma_reconnect_or_remove()
     nvme_delete_ctrl()
   nvme_tcp_reconnect_or_remove()
     nvme_delete_ctrl()

   nvme_delete_ctrl_work()
     flush_work(&ctrl->reset_work)
     flush_work(&ctrl->async_event_work)
     cancel_work_sync(&ctrl->fw_act_work)
     ...

That means we either have WQ_MEM_RECLAIM set on all wq or non.

Link: https://patchwork.kernel.org/project/linux-rdma/patch/5f5a1e4e90f3625cea57ffa79fc0e5bcb7efe09d.1548963371.git.swise@opengridcomputing.com/

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/host/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 11fca6459812..ab0d00ddf03f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4810,17 +4810,17 @@ static int __init nvme_core_init(void)
 	_nvme_check_size();
 
 	nvme_wq = alloc_workqueue("nvme-wq",
-			WQ_UNBOUND | WQ_MEM_RECLAIM | WQ_SYSFS, 0);
+			WQ_UNBOUND | WQ_SYSFS, 0);
 	if (!nvme_wq)
 		goto out;
 
 	nvme_reset_wq = alloc_workqueue("nvme-reset-wq",
-			WQ_UNBOUND | WQ_MEM_RECLAIM | WQ_SYSFS, 0);
+			WQ_UNBOUND | WQ_SYSFS, 0);
 	if (!nvme_reset_wq)
 		goto destroy_wq;
 
 	nvme_delete_wq = alloc_workqueue("nvme-delete-wq",
-			WQ_UNBOUND | WQ_MEM_RECLAIM | WQ_SYSFS, 0);
+			WQ_UNBOUND | WQ_SYSFS, 0);
 	if (!nvme_delete_wq)
 		goto destroy_reset_wq;
 
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
