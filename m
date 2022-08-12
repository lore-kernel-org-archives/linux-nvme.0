Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB64FC00140
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Aug 2022 21:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=7p6Y8/i9Zud4dD3OXaD9CJ5omkHnOmb9qmsVs/S95A0=; b=v3evyXo68g9Xiy98agUrrnVNuy
	hsekB+yP/ASHmjvE4zQr2j5OwlTqIWM8SAjBBJJUn8IIsI3hXoIYnJsrEWgf18/2bK6/fNpQPnu1F
	IdrLuU/J5v9dhghoGhYouisnB11goUL0KKq6x4qUyal6vm+cnDvUlj56t/RGcsN2D/AoVilHHQaWB
	ICt3VstwYlftlWagkYzQGsb0awD1dokXh397/s2vBF7IcJ/OCQn6Vy+xLBNv3IRHVceJjFaLDPrnQ
	esMJ+M9WqZe0SZmvSNo6v+3QvW+vPm0lG/L4fGSV+pC4yD2e4I5tkNuTGPHq57+uFePv3QVr/3CIR
	aX2PaRIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oMboZ-00DKS3-Av; Fri, 12 Aug 2022 21:03:31 +0000
Received: from mail-pf1-f169.google.com ([209.85.210.169])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oMboX-00DKPq-2d
	for linux-nvme@lists.infradead.org; Fri, 12 Aug 2022 21:03:30 +0000
Received: by mail-pf1-f169.google.com with SMTP id q19so1926804pfg.8
        for <linux-nvme@lists.infradead.org>; Fri, 12 Aug 2022 14:03:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=7p6Y8/i9Zud4dD3OXaD9CJ5omkHnOmb9qmsVs/S95A0=;
        b=hWykQo4fatFOjhyrcHchX9XqqQCygkSqBK7HkLSchSCfGgcDTup2u8j/ltuhEkyh0s
         nX7WrpYp3BEXp/XgQgYa1BEX1uKcLLMi/rXjCju1Owbr9jZB6G3cx2mZQsCEexe/9d7m
         VXIdLxyf/cYF4DpMmis49XVexTtHwFgWkZz6ckFST4Xv6zeAOmHB8gyDfraXgxnazyzR
         XA5SR7CrDpA/0dq5tzWJTmDcpYGhvT0kBWZmNRwYDMI+GFJ+V7ElcJbz+yi0qVA6PC8s
         B5mMOSCzsSI0LBSBfuLqM8i2nMoh+9zSnI2ajy3XmVZGF5JHRdMJZ0aE1HYfhelqNFma
         2xxA==
X-Gm-Message-State: ACgBeo32m+QAil97ELbFTsDyq9v6u53drNzjbP9WNyw9mEuToKp/tIcM
	6KSt/+OFxuRaKyKViOh8mbk=
X-Google-Smtp-Source: AA6agR4b5Ebg4rl6xrMSIlbgQQL0EZIjjsnB9+lkTLwQZYDbUX76R/E8Vsv737QCf36Da0U4cXUdbg==
X-Received: by 2002:a05:6a00:2185:b0:520:7276:6570 with SMTP id h5-20020a056a00218500b0052072766570mr5644987pfi.84.1660338205210;
        Fri, 12 Aug 2022 14:03:25 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:2414:9f13:41de:d21d])
        by smtp.gmail.com with ESMTPSA id c13-20020a170903234d00b0016c1a1c1405sm2218519plh.222.2022.08.12.14.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 14:03:24 -0700 (PDT)
From: Bart Van Assche <bvanassche@acm.org>
To: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>,
	linux-nvme@lists.infradead.org,
	Bart Van Assche <bvanassche@acm.org>,
	stable@vger.kernel.org
Subject: [PATCH] nvmet: Fix a use-after-free
Date: Fri, 12 Aug 2022 14:03:17 -0700
Message-Id: <20220812210317.2252051-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220812_140329_136838_D6DD8CC7 
X-CRM114-Status: GOOD (  12.74  )
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

Fix the following use-after-free complaint triggered by blktests nvme/004:

BUG: KASAN: user-memory-access in blk_mq_complete_request_remote+0xac/0x350
Read of size 4 at addr 0000607bd1835943 by task kworker/13:1/460
Workqueue: nvmet-wq nvme_loop_execute_work [nvme_loop]
Call Trace:
 show_stack+0x52/0x58
 dump_stack_lvl+0x49/0x5e
 print_report.cold+0x36/0x1e2
 kasan_report+0xb9/0xf0
 __asan_load4+0x6b/0x80
 blk_mq_complete_request_remote+0xac/0x350
 nvme_loop_queue_response+0x1df/0x275 [nvme_loop]
 __nvmet_req_complete+0x132/0x4f0 [nvmet]
 nvmet_req_complete+0x15/0x40 [nvmet]
 nvmet_execute_io_connect+0x18a/0x1f0 [nvmet]
 nvme_loop_execute_work+0x20/0x30 [nvme_loop]
 process_one_work+0x56e/0xa70
 worker_thread+0x2d1/0x640
 kthread+0x183/0x1c0
 ret_from_fork+0x1f/0x30

Cc: stable@vger.kernel.org
Fixes: a07b4970f464 ("nvmet: add a generic NVMe target")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/nvme/target/core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index a1345790005f..7f4083cf953a 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -735,6 +735,8 @@ static void nvmet_set_error(struct nvmet_req *req, u16 status)
 
 static void __nvmet_req_complete(struct nvmet_req *req, u16 status)
 {
+	struct nvmet_ns *ns = req->ns;
+
 	if (!req->sq->sqhd_disabled)
 		nvmet_update_sq_head(req);
 	req->cqe->sq_id = cpu_to_le16(req->sq->qid);
@@ -745,9 +747,9 @@ static void __nvmet_req_complete(struct nvmet_req *req, u16 status)
 
 	trace_nvmet_req_complete(req);
 
-	if (req->ns)
-		nvmet_put_namespace(req->ns);
 	req->ops->queue_response(req);
+	if (ns)
+		nvmet_put_namespace(ns);
 }
 
 void nvmet_req_complete(struct nvmet_req *req, u16 status)

