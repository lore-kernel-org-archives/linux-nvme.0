Return-Path: <SRS0=qQKB=H2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86BD6C433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Feb 2021 12:53:15 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EB9C64F60
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Feb 2021 12:53:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EB9C64F60
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=40CLhggyUciHtd8aZgZljA8b83LQJxSxGJHloCvihc4=; b=qVygP19bVxDUCpPiJZKHAb0kH
	diaxfXGKe45d88PS5QIUKY5Wzm6rXbvVb9/ZDtBYD1ATev+qlO105gzgcuUbFGOBHGmsVdDHzPiAh
	brC61w8kzawE4vmh/lFJr4o6+bCFr3KEWq7WAO+v+N5aMmacFFhyNNVrMB/7V8rYczE3FzJOIUqkU
	cB16w4s/QnNlX42l8/DOd4vDgaDE7EBQgssvjIkLKg+ck8nQF5yyAiHS9LFPKGBRGFp36yM3rCYzw
	jtyhP5iv9eIrFIUY59zdPhMbGH0mumekMvSB1LYsNA4Zxr1itc9IuFBsmfAoap6MVB/5lIeZ1TqOR
	yxXUfuAKw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lEtfC-00030b-RD; Wed, 24 Feb 2021 12:53:10 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lEtf5-0002xK-Ny
 for linux-nvme@lists.infradead.org; Wed, 24 Feb 2021 12:53:04 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 47E1664F4F;
 Wed, 24 Feb 2021 12:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1614171183;
 bh=Nn44nehcv/5qjuuCj3kVrBIthep8ClIsT890wIcpkoI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=n55+DbNVCcENlQhXCLnYx7lVQ2EIiL65irp6M3r64N6JNM7QVgfFWsnrfdpzXmCMM
 wzmR/uhCPBj61FIZGANt7Q12r3s1Oun9ULRy+wy77CZHSizWzdE2KtEb/AVGgoIIgY
 KEKmWtdRfQQnmtab9tAV4R00m7O3fWe7lKL68geVa6i8BgEhkVhp/gpbbI7kDLXKrc
 3rLjtZqQB/UP3ogfp4TDdiNzcotJm8/dXjGTI0+Ih4HZrO3EytQhlOM9fI+b1HfQW5
 twU0ycTnPskuEKgCDW7VZC4ei8euU+uJkkBeyYr6Imb3wKy2CnnI8WZYxiJ4kCD/MV
 a1KpLqEOgGrEg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 38/56] nvme-tcp: add clean action for failed
 reconnection
Date: Wed, 24 Feb 2021 07:51:54 -0500
Message-Id: <20210224125212.482485-38-sashal@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210224125212.482485-1-sashal@kernel.org>
References: <20210224125212.482485-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210224_075303_940195_4FC05474 
X-CRM114-Status: GOOD (  13.83  )
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
Cc: Sasha Levin <sashal@kernel.org>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, Chao Leng <lengchao@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Chao Leng <lengchao@huawei.com>

[ Upstream commit 70a99574a79f1cd4dc7ad56ea37be40844bfb97b ]

If reconnect failed after start io queues, the queues will be unquiesced
and new requests continue to be delivered. Reconnection error handling
process directly free queues without cancel suspend requests. The
suppend request will time out, and then crash due to use the queue
after free.

Add sync queues and cancel suppend requests for reconnection error
handling.

Signed-off-by: Chao Leng <lengchao@huawei.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/tcp.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 6487b7897d1fb..739ac7deccd96 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1815,8 +1815,10 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
 
 out_wait_freeze_timed_out:
 	nvme_stop_queues(ctrl);
+	nvme_sync_io_queues(ctrl);
 	nvme_tcp_stop_io_queues(ctrl);
 out_cleanup_connect_q:
+	nvme_cancel_tagset(ctrl);
 	if (new)
 		blk_cleanup_queue(ctrl->connect_q);
 out_free_tag_set:
@@ -1878,12 +1880,16 @@ static int nvme_tcp_configure_admin_queue(struct nvme_ctrl *ctrl, bool new)
 
 	error = nvme_init_identify(ctrl);
 	if (error)
-		goto out_stop_queue;
+		goto out_quiesce_queue;
 
 	return 0;
 
+out_quiesce_queue:
+	blk_mq_quiesce_queue(ctrl->admin_q);
+	blk_sync_queue(ctrl->admin_q);
 out_stop_queue:
 	nvme_tcp_stop_queue(ctrl, 0);
+	nvme_cancel_admin_tagset(ctrl);
 out_cleanup_queue:
 	if (new)
 		blk_cleanup_queue(ctrl->admin_q);
@@ -2003,10 +2009,18 @@ static int nvme_tcp_setup_ctrl(struct nvme_ctrl *ctrl, bool new)
 	return 0;
 
 destroy_io:
-	if (ctrl->queue_count > 1)
+	if (ctrl->queue_count > 1) {
+		nvme_stop_queues(ctrl);
+		nvme_sync_io_queues(ctrl);
+		nvme_tcp_stop_io_queues(ctrl);
+		nvme_cancel_tagset(ctrl);
 		nvme_tcp_destroy_io_queues(ctrl, new);
+	}
 destroy_admin:
+	blk_mq_quiesce_queue(ctrl->admin_q);
+	blk_sync_queue(ctrl->admin_q);
 	nvme_tcp_stop_queue(ctrl, 0);
+	nvme_cancel_admin_tagset(ctrl);
 	nvme_tcp_destroy_admin_queue(ctrl, new);
 	return ret;
 }
-- 
2.27.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
