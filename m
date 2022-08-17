Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92A08C28B2B
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Aug 2022 17:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=iKUCUDi2SfnduC7piObEFyzun59ij4PD/TgFI7EIPmE=; b=4GflfsJ8yg5Knf4jkFoJOuGAI8
	JBfhB4F9zgAr6uXOlExPVJ+duiB4qsjmEA1KhRrHqR8LffhxegbVEWYvQIDK/iXwFY7a7pBAV1LFR
	OMcg1W/ycHSqp3rAT43VoZ1O2V8+FmbmZ+v21/mAFVavSJiqdcUoqCuHdkxtuS6WLi8k+ptbGk3/A
	a1IcRntdQ7NWBTdrYAvvJPCST+BNL/C2P/TtDiGjl0hrKc6LC5Zz1U1RVHLSqCt7BOqTgLv38biL1
	wlGMpuchoX9gXxmI+5+8QqikLaRYwRm1NpdBCAAcJ6L/T1fLqop5NS5ALu4nbibVMPtDPc5NpQZ2R
	Wdd6wARA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oOMT8-0048aW-Be; Wed, 17 Aug 2022 17:04:38 +0000
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oOMT4-0048Xv-V7
	for linux-nvme@lists.infradead.org; Wed, 17 Aug 2022 17:04:36 +0000
Received: by mail-ed1-x533.google.com with SMTP id z20so18281352edb.9
        for <linux-nvme@lists.infradead.org>; Wed, 17 Aug 2022 10:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=iKUCUDi2SfnduC7piObEFyzun59ij4PD/TgFI7EIPmE=;
        b=GVobNuPoIQk4FYGcP5+3o2DPEfAa9CaGLRS4Y0kS6qBp1dkyPuJqdY9Uyv6LTVRQr4
         BtsQZvO4xsLmkXoIvBhY4oQLm4spLxNNfnyJCl92Mj+pr9gIrzde5LPF1HxbFwvPkb3A
         AO4jkbGr272w1Oyhs6nH9ub0c71YdATQLtlk84mfIWaliHof5629cV4bQh74Z6ImNGAh
         3EragBVnAQS7KyKu8Oh51dka1ZgYquBLpIAuUq8ZO0Jo0DTKGpT4Q2xFYfqI556zWgzq
         vlcOdQXZ6iWulSa/HQ7z5IOlxxLKUqZZXvcccgnou4hvuznlN+/pYlhvStiFbddbC8OU
         fMRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=iKUCUDi2SfnduC7piObEFyzun59ij4PD/TgFI7EIPmE=;
        b=RYidZV98PYjKZiRTsWkF5ysSBHzgSThIOHoV9JTRpypr2TzHQfOjpkzhWf7cZPH6/+
         xh+Sb2SHodFfx07D2u6j8KszNsgC46CFxYaV/kWpW6mahgw4TuH05ARjiac1tWg9JzFr
         66AHSRHwxbFIRYuclC5UlA2AJ4WJ5WKdb6Nsz4FR2Pwn6uTlwJ/1XXMn2lODQIq8mUSC
         KbdSWcPe/CXSI9by+W8kgDd0if3f7O14s5Md5j1/n9iTJBW55tt4wS5XIfzY7ee/OgvI
         +AM+YOAdKuF6FHKW2Sd2hx3cKnlKGtsFPazhngFQRooAE4kR7AYOJhaGNC+OjzM6e7Er
         e2XA==
X-Gm-Message-State: ACgBeo0uRn2vRVRfxdFsPHpzlwCHfPjFGQxPJz+D3m3uoQZ/JnUkNywI
	eiFIf7yoeJUL0b9+BFROOSo=
X-Google-Smtp-Source: AA6agR5pYx0/TsNQJIeMVJc58mUylsDroBV3h72JoICmf0cjWMdAtAjbSGIc0HxQ+ssspQkYIJdBew==
X-Received: by 2002:a05:6402:7c8:b0:445:ce63:7ab0 with SMTP id u8-20020a05640207c800b00445ce637ab0mr4577377edy.8.1660755872875;
        Wed, 17 Aug 2022 10:04:32 -0700 (PDT)
Received: from localhost.localdomain (host-87-17-106-94.retail.telecomitalia.it. [87.17.106.94])
        by smtp.gmail.com with ESMTPSA id kx18-20020a170907775200b007341663d7ddsm6962978ejc.96.2022.08.17.10.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 10:04:31 -0700 (PDT)
From: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH] nvmet-tcp: Don't kmap() pages which can't come from HIGHMEM
Date: Wed, 17 Aug 2022 19:04:27 +0200
Message-Id: <20220817170427.15682-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220817_100435_061060_5D72E1DD 
X-CRM114-Status: GOOD (  17.05  )
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

kmap() is being deprecated in favor of kmap_local_page().[1]

There are two main problems with kmap(): (1) It comes with an overhead as
mapping space is restricted and protected by a global lock for
synchronization and (2) it also requires global TLB invalidation when the
kmap’s pool wraps and it might block when the mapping space is fully
utilized until a slot becomes available.

The pages which will be mapped are allocated in nvmet_tcp_map_data(),
using the GFP_KERNEL flag. This assures that they cannot come from
HIGHMEM. This imply that a straight page_address() can replace the kmap()
of sg_page(sg) in nvmet_tcp_map_pdu_iovec(). As a side effect, we might
also delete the field "nr_mapped" from struct "nvmet_tcp_cmd" because,
after removing the kmap() calls, there would be no longer any need of it.

Therefore, replace the kmap() of sg_page(sg) with a page_address() and
delete the "nr_mapped" field from "nvmet_tcp_cmd".

[1] "[PATCH] checkpatch: Add kmap and kmap_atomic to the deprecated
list" https://lore.kernel.org/all/20220813220034.806698-1-ira.weiny@intel.com/

Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Keith Busch <kbusch@kernel.org>
Cc: Sagi Grimberg <sagi@grimberg.me>
Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

Thanks so much to Chaitanya, Keith, Sagi, for the answers and the comments
on the RFC which gave birth to this patch. The RFC is at:
https://lore.kernel.org/all/20220816091808.23236-1-fmdefrancesco@gmail.com/

 drivers/nvme/target/tcp.c | 26 ++------------------------
 1 file changed, 2 insertions(+), 24 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index dc3b4dc8fe08..6ed44531de55 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -77,7 +77,6 @@ struct nvmet_tcp_cmd {
 	u32				pdu_len;
 	u32				pdu_recv;
 	int				sg_idx;
-	int				nr_mapped;
 	struct msghdr			recv_msg;
 	struct kvec			*iov;
 	u32				flags;
@@ -167,7 +166,6 @@ static const struct nvmet_fabrics_ops nvmet_tcp_ops;
 static void nvmet_tcp_free_cmd(struct nvmet_tcp_cmd *c);
 static void nvmet_tcp_finish_cmd(struct nvmet_tcp_cmd *cmd);
 static void nvmet_tcp_free_cmd_buffers(struct nvmet_tcp_cmd *cmd);
-static void nvmet_tcp_unmap_pdu_iovec(struct nvmet_tcp_cmd *cmd);
 
 static inline u16 nvmet_tcp_cmd_tag(struct nvmet_tcp_queue *queue,
 		struct nvmet_tcp_cmd *cmd)
@@ -301,27 +299,12 @@ static int nvmet_tcp_check_ddgst(struct nvmet_tcp_queue *queue, void *pdu)
 
 static void nvmet_tcp_free_cmd_buffers(struct nvmet_tcp_cmd *cmd)
 {
-	WARN_ON(unlikely(cmd->nr_mapped > 0));
-
 	kfree(cmd->iov);
 	sgl_free(cmd->req.sg);
 	cmd->iov = NULL;
 	cmd->req.sg = NULL;
 }
 
-static void nvmet_tcp_unmap_pdu_iovec(struct nvmet_tcp_cmd *cmd)
-{
-	struct scatterlist *sg;
-	int i;
-
-	sg = &cmd->req.sg[cmd->sg_idx];
-
-	for (i = 0; i < cmd->nr_mapped; i++)
-		kunmap(sg_page(&sg[i]));
-
-	cmd->nr_mapped = 0;
-}
-
 static void nvmet_tcp_map_pdu_iovec(struct nvmet_tcp_cmd *cmd)
 {
 	struct kvec *iov = cmd->iov;
@@ -329,7 +312,6 @@ static void nvmet_tcp_map_pdu_iovec(struct nvmet_tcp_cmd *cmd)
 	u32 length, offset, sg_offset;
 
 	length = cmd->pdu_len;
-	cmd->nr_mapped = DIV_ROUND_UP(length, PAGE_SIZE);
 	offset = cmd->rbytes_done;
 	cmd->sg_idx = offset / PAGE_SIZE;
 	sg_offset = offset % PAGE_SIZE;
@@ -338,7 +320,7 @@ static void nvmet_tcp_map_pdu_iovec(struct nvmet_tcp_cmd *cmd)
 	while (length) {
 		u32 iov_len = min_t(u32, length, sg->length - sg_offset);
 
-		iov->iov_base = kmap(sg_page(sg)) + sg->offset + sg_offset;
+		iov->iov_base = page_address(sg_page(sg)) + sg->offset + sg_offset;
 		iov->iov_len = iov_len;
 
 		length -= iov_len;
@@ -347,8 +329,7 @@ static void nvmet_tcp_map_pdu_iovec(struct nvmet_tcp_cmd *cmd)
 		sg_offset = 0;
 	}
 
-	iov_iter_kvec(&cmd->recv_msg.msg_iter, READ, cmd->iov,
-		cmd->nr_mapped, cmd->pdu_len);
+	iov_iter_kvec(&cmd->recv_msg.msg_iter, READ, cmd->iov, 0, cmd->pdu_len);
 }
 
 static void nvmet_tcp_fatal_error(struct nvmet_tcp_queue *queue)
@@ -1141,7 +1122,6 @@ static int nvmet_tcp_try_recv_data(struct nvmet_tcp_queue *queue)
 		cmd->rbytes_done += ret;
 	}
 
-	nvmet_tcp_unmap_pdu_iovec(cmd);
 	if (queue->data_digest) {
 		nvmet_tcp_prep_recv_ddgst(cmd);
 		return 0;
@@ -1411,7 +1391,6 @@ static void nvmet_tcp_restore_socket_callbacks(struct nvmet_tcp_queue *queue)
 static void nvmet_tcp_finish_cmd(struct nvmet_tcp_cmd *cmd)
 {
 	nvmet_req_uninit(&cmd->req);
-	nvmet_tcp_unmap_pdu_iovec(cmd);
 	nvmet_tcp_free_cmd_buffers(cmd);
 }
 
@@ -1424,7 +1403,6 @@ static void nvmet_tcp_uninit_data_in_cmds(struct nvmet_tcp_queue *queue)
 		if (nvmet_tcp_need_data_in(cmd))
 			nvmet_req_uninit(&cmd->req);
 
-		nvmet_tcp_unmap_pdu_iovec(cmd);
 		nvmet_tcp_free_cmd_buffers(cmd);
 	}
 
-- 
2.37.1


