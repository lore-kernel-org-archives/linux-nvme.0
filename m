Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10810E7E656
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Sep 2023 17:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=eK09SY9XnKtYYEeKZnb21txziNbHU1j+5dHVgQL9+WE=; b=HQBBSSZpFnG+QajILDzG4hwUMY
	+CF/2UqzX1/jcKmDvC9/QcjxzUjWyqm1FFQAfXu3p11yf43/8sO2qUpHQpBQzXuHYyLphwCJXj+1J
	iuLMDXZ1N77GRumzF3Ib32wiVCM4MiPQQJpPWeiF8xY0w0HXdgdEqPTTwHqguX5YYT9rOe8kUkHff
	H/DfcFqJAeR4L+4OgDSQfzEGD78GPpzWOUkRu6u6ZD0Q4/LGtZocCSqe35x6CYXCAv5amW2OSrLUJ
	VhgymeY8rh/gnueh0lx63f4Z2J5zOwpv0wlH9dsgmuKDyoUBeFvRdUl3s7QIl+U2Xs7HdXgRlvH3R
	BQ3DR+kQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qlBlj-00GmEf-30;
	Tue, 26 Sep 2023 17:22:43 +0000
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qlBlf-00GmE8-1X
	for linux-nvme@lists.infradead.org;
	Tue, 26 Sep 2023 17:22:40 +0000
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-578e33b6fb7so6088999a12.3
        for <linux-nvme@lists.infradead.org>; Tue, 26 Sep 2023 10:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695748956; x=1696353756; darn=lists.infradead.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eK09SY9XnKtYYEeKZnb21txziNbHU1j+5dHVgQL9+WE=;
        b=HRz7hhhHJznuSAzBq30j7aWMfvuGZE3pH4/2D6AY06mhqoCV810Vucc02JcTjcgJNJ
         e6mFCvnhm6KzGEdmeQgf1HyCsOP7bMlVd2vH11bvyhvuKV/v2rzHIOxVGSIhlU/sfaOs
         62IO9L8RxE7SxMgRMDtfWdas+uEVPX9lQA+67iOfcBvhRSoooZMUVO5KqRqwqpjWyIbe
         vZvD324B3dpZYA9bfnQAaiLRJn+E21HdfHhs55bmaV4GGnSjRZL/Sc8uet7sRpg0+Gig
         kfdoD0z210pO92eYypydaGW3HeoPHCk0b9MV+gB0+LJhyAkSsv6gUW83oBE1OJsKmqWx
         alzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695748956; x=1696353756;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eK09SY9XnKtYYEeKZnb21txziNbHU1j+5dHVgQL9+WE=;
        b=qS1w/OKgCbJDYTrrgiJAKmGfhIXFK4AtDEC3Z1e3MGz5zjA830o6Vbfg3SddhNE+Fk
         L0FPqHXZI66NWLpAFvTpN7eQv9e/KFofTCSMr+07u1gmuqCPkjptXk1Sg5pmbyrNFy2r
         aRpiaa5RmXJWg0iEDmBtS3eziGDDy+iU7Er+Vd6gLUAPHSsShm08y3KhFq2hM13t9Tbs
         uthDFXKZOPwyDCNnn+0EM4vxeJJou198e8Lw7/UCTzKEcA5M3cf5nmOrKciCPMcv2dwo
         F58G6SuAyi3fHVoYtALf0FZ9X+yzfbb7gnEFIAGz4zxOZRTtHupfW56OabKXIFGVn8Sz
         5ydQ==
X-Gm-Message-State: AOJu0YwRYVo8HUGR/G0ABFcr9qWXYt+y/bEUYZZyf/ZRUzx/aF907DEP
	5OPvgHHZ6zRwLPnSeIvL9vU=
X-Google-Smtp-Source: AGHT+IEyc2uv0p8+Qf+SIjOHIOliLqbPagqqIfNSHAsdtOegXTnGbScLJOuA2pDRhbgeHoPJH3rflA==
X-Received: by 2002:a05:6a20:139a:b0:154:e7e6:85bd with SMTP id hn26-20020a056a20139a00b00154e7e685bdmr7271605pzc.20.1695748956241;
        Tue, 26 Sep 2023 10:22:36 -0700 (PDT)
Received: from 377044c6c369.cse.ust.hk (191host097.mobilenet.cse.ust.hk. [143.89.191.97])
        by smtp.gmail.com with ESMTPSA id i15-20020aa7908f000000b006661562429fsm10510857pfa.97.2023.09.26.10.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 10:22:35 -0700 (PDT)
From: Chengfeng Ye <dg573847474@gmail.com>
To: hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <dg573847474@gmail.com>
Subject: [PATCH] nvmet-rdma: use spin_lock_bh() on rsp_wr_wait_lock
Date: Tue, 26 Sep 2023 17:22:08 +0000
Message-Id: <20230926172208.55478-1-dg573847474@gmail.com>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230926_102239_515831_8C3F0201 
X-CRM114-Status: GOOD (  12.93  )
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

It seems to me that read_cqe.done could be executed under softirq
context, as done callbacks always do, and it acquires rsp_wr_wait_lock
along the following call chain.

   nvmet_rdma_read_data_done()
   --> nvmet_rdma_release_rsp()
   --> spin_lock(&queue->rsp_wr_wait_lock)

So it seems more reasonable to use spin_lock_bh() on it, otherwise
there could be following potential deadlocks.

nvmet_rdma_queue_response()
--> nvmet_rdma_release_rsp()
--> spin_lock(&queue->rsp_wr_wait_lock)
<interrupt>
   --> nvmet_rdma_read_data_done()
   --> nvmet_rdma_release_rsp()
   --> spin_lock(&queue->rsp_wr_wait_lock)

nvmet_rdma_cm_handler()
--> nvmet_rdma_handle_command()
--> spin_lock(&queue->rsp_wr_wait_lock)
<interrupt>
   --> nvmet_rdma_read_data_done()
   --> nvmet_rdma_release_rsp()
   --> spin_lock(&queue->rsp_wr_wait_lock)

Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
---
 drivers/nvme/target/rdma.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 4597bca43a6d..a01ed29fbd8a 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -520,7 +520,7 @@ static int nvmet_rdma_post_recv(struct nvmet_rdma_device *ndev,
 
 static void nvmet_rdma_process_wr_wait_list(struct nvmet_rdma_queue *queue)
 {
-	spin_lock(&queue->rsp_wr_wait_lock);
+	spin_lock_bh(&queue->rsp_wr_wait_lock);
 	while (!list_empty(&queue->rsp_wr_wait_list)) {
 		struct nvmet_rdma_rsp *rsp;
 		bool ret;
@@ -529,16 +529,16 @@ static void nvmet_rdma_process_wr_wait_list(struct nvmet_rdma_queue *queue)
 				struct nvmet_rdma_rsp, wait_list);
 		list_del(&rsp->wait_list);
 
-		spin_unlock(&queue->rsp_wr_wait_lock);
+		spin_unlock_bh(&queue->rsp_wr_wait_lock);
 		ret = nvmet_rdma_execute_command(rsp);
-		spin_lock(&queue->rsp_wr_wait_lock);
+		spin_lock_bh(&queue->rsp_wr_wait_lock);
 
 		if (!ret) {
 			list_add(&rsp->wait_list, &queue->rsp_wr_wait_list);
 			break;
 		}
 	}
-	spin_unlock(&queue->rsp_wr_wait_lock);
+	spin_unlock_bh(&queue->rsp_wr_wait_lock);
 }
 
 static u16 nvmet_rdma_check_pi_status(struct ib_mr *sig_mr)
@@ -994,9 +994,9 @@ static void nvmet_rdma_handle_command(struct nvmet_rdma_queue *queue,
 		goto out_err;
 
 	if (unlikely(!nvmet_rdma_execute_command(cmd))) {
-		spin_lock(&queue->rsp_wr_wait_lock);
+		spin_lock_bh(&queue->rsp_wr_wait_lock);
 		list_add_tail(&cmd->wait_list, &queue->rsp_wr_wait_list);
-		spin_unlock(&queue->rsp_wr_wait_lock);
+		spin_unlock_bh(&queue->rsp_wr_wait_lock);
 	}
 
 	return;
-- 
2.17.1


