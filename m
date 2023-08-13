Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 537A7C04E69
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Aug 2023 14:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nQ2cTXEltHCfVXnyLCfSTIsmKfECOAmh3JPWbPsMLMY=; b=TiOsm56qpgeXyRAF7ZXEedGVFy
	Q4nf2YHG8bnx1DZMQ1acbEH2kFvj1TS92HzEZRNyJhbrJrU5q3DrfOAOhb8tk7AO2mCj0yG5EB9BD
	BCI52jGoR6baDDfxbkvYnVlxSst9Ty1MndGprgYgKvrqQ5RFmsYMBPWx6TguC3b6N0dSPueOlti33
	vq2r5qqsIDFi7BzdQz6v8ORDSOW2zaNLGoMmR4iGKGpT9LDmlaEbxLpUeZxJaH2VgCzns63zeYO6k
	hsRZVzQ2aIV/Pu4JH0pOuNz34MqBBvmqdEYtwLh/GIditwNa1ies/v91aVLjRqE9F2VDa3ysDbmM+
	IqZPqzGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qVCLG-00FFv7-2C;
	Sun, 13 Aug 2023 14:45:18 +0000
Received: from mail-ej1-f47.google.com ([209.85.218.47])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qVCLE-00FFts-12
	for linux-nvme@lists.infradead.org;
	Sun, 13 Aug 2023 14:45:17 +0000
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-99bded9d93dso81026066b.1
        for <linux-nvme@lists.infradead.org>; Sun, 13 Aug 2023 07:45:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691937914; x=1692542714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nQ2cTXEltHCfVXnyLCfSTIsmKfECOAmh3JPWbPsMLMY=;
        b=gIxviwkQtiX7H+VNsuNHRNwGZzMQGs648HIxOljEs3d5CCevdhtmjlyahvAhLP3jRY
         6+qLF+1m10WNFxwS3KexjMMltQ3rSSyqFTtmtA8mfE6xd2BeeLvXFtUxQjeQx7achCEP
         Qp+tq4ft/DefZB69gT1bWgHWjQp6H21CmeJWIBr7MKqoUJEzYop9CFSoz1twbILgzibh
         TOZSFk03eOJrMVs7ZLkrUrx6AF4JA/asaXcdjyL3RnzfuFlUd4Y4S0Dz4uX157rYI6T5
         U+Ao5HpRd5AbQ57FJbEJsXn5AOCE7IyeRYMdXb01wXQ4AFviAb3/go8QFhy9k3GiIrcl
         t+lg==
X-Gm-Message-State: AOJu0Yy1a/I2eD6HUAOMhdFsMkNtZ3nz7jjCZyrwx3zSdwqmMm+ZeDCy
	11ekiyOcUQ23dOfFBxbOfFgA/T7Bwts=
X-Google-Smtp-Source: AGHT+IHitYqQ2RuY/X6YIxQYqp2OwJkrUNKE/oC4VN8cCqNDu1e/sOR7dWb5UEeuMIbbjfLCJPF/3w==
X-Received: by 2002:a17:906:10d2:b0:99b:4670:aca9 with SMTP id v18-20020a17090610d200b0099b4670aca9mr5579963ejv.1.1691937914286;
        Sun, 13 Aug 2023 07:45:14 -0700 (PDT)
Received: from localhost.localdomain (46-116-229-137.bb.netvision.net.il. [46.116.229.137])
        by smtp.gmail.com with ESMTPSA id g6-20020a170906348600b0099c157cba46sm4574699ejb.119.2023.08.13.07.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Aug 2023 07:45:13 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: <stable@vger.kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 5.15.y 5.10.y 5.4.y 2/2] nvme-rdma: fix potential unbalanced freeze & unfreeze
Date: Sun, 13 Aug 2023 17:45:10 +0300
Message-ID: <20230813144510.15401-2-sagi@grimberg.me>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813144510.15401-1-sagi@grimberg.me>
References: <20230813144510.15401-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230813_074516_361290_89884358 
X-CRM114-Status: GOOD (  12.98  )
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

From: Ming Lei <ming.lei@redhat.com>

Move start_freeze into nvme_rdma_configure_io_queues(), and there is
at least two benefits:

1) fix unbalanced freeze and unfreeze, since re-connection work may
fail or be broken by removal

2) IO during error recovery can be failfast quickly because nvme fabrics
unquiesces queues after teardown.

One side-effect is that !mpath request may timeout during connecting
because of queue topo change, but that looks not one big deal:

1) same problem exists with current code base

2) compared with !mpath, mpath use case is dominant

Fixes: 9f98772ba307 ("nvme-rdma: fix controller reset hang during traffic")
Cc: stable@vger.kernel.org
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Tested-by: Yi Zhang <yi.zhang@redhat.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/rdma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 2db9c166a1b7..b76e1d4adcc7 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -989,6 +989,7 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
 		goto out_cleanup_connect_q;
 
 	if (!new) {
+		nvme_start_freeze(&ctrl->ctrl);
 		nvme_start_queues(&ctrl->ctrl);
 		if (!nvme_wait_freeze_timeout(&ctrl->ctrl, NVME_IO_TIMEOUT)) {
 			/*
@@ -997,6 +998,7 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
 			 * to be safe.
 			 */
 			ret = -ENODEV;
+			nvme_unfreeze(&ctrl->ctrl);
 			goto out_wait_freeze_timed_out;
 		}
 		blk_mq_update_nr_hw_queues(ctrl->ctrl.tagset,
@@ -1038,7 +1040,6 @@ static void nvme_rdma_teardown_io_queues(struct nvme_rdma_ctrl *ctrl,
 		bool remove)
 {
 	if (ctrl->ctrl.queue_count > 1) {
-		nvme_start_freeze(&ctrl->ctrl);
 		nvme_stop_queues(&ctrl->ctrl);
 		nvme_sync_io_queues(&ctrl->ctrl);
 		nvme_rdma_stop_io_queues(ctrl);
-- 
2.41.0


