Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 952E0ECAAD4
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Aug 2022 22:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=T+aV8rwEpdWn3HT0IPelsU7ZeHDx/XPnYVHdz9wbMJc=; b=Qii73bufsgEy5RARUrLT4Uyjuu
	+S6cKCQvRRJtodMeOL4FtvNLJySd/9Gn0nNdyBfELLY3QqTWSiYnaja/Omh/lrpZGWSl4k2eCwMMy
	HXrxQ6Ou+8s7WK43nehfIWh7du3XuoBsrTlX2oeWeuKoa0FkDZHlMV83lB86zZzrbVt/52rlzefmc
	6TpCBPu2u3pmm6U+e1ZG5SzyQY6pHEytBCUS76WHD1UyWT+1YnsgVL1v3ePAxh6zdSqHmNzK4Tlwq
	w5e7p/sNPRrA1vNfX7ZPOM2EXM69xpBKqd1Yko8zjeD680SZZGzWckY9CCoXnzmtgRUGGLLq01Myu
	t1B6CV5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oT9Ms-002CTS-UZ; Tue, 30 Aug 2022 22:05:58 +0000
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oT9Mp-002CO9-Ll
	for linux-nvme@lists.infradead.org; Tue, 30 Aug 2022 22:05:57 +0000
Received: by mail-ej1-x629.google.com with SMTP id p16so21768859ejb.9
        for <linux-nvme@lists.infradead.org>; Tue, 30 Aug 2022 15:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=T+aV8rwEpdWn3HT0IPelsU7ZeHDx/XPnYVHdz9wbMJc=;
        b=pX6C2Kl+GzBoys5LpEJbm4cO5DxOpFQjRh3apDeihRh/MnHL+rOMClP1kGCyOFqPbj
         ElR1ucFf94CQSGB5in85p/hsjheLU3boCfw46vsswAmkUM7KUOUN+co/qsEKVigUMYwH
         yRNeOK1OQ67cump3ndzd5KBOqB9/7EXcF5My+1PzO4gdonHqiIMwJFgN6pBsTEZGTkHq
         s7B1iIqYgwEt4qRawbiDMi4AaikXvabcii1yWmRwRQGEjFrz53oIa5ALHi5KAfF72Nc4
         dl6RMGqvJdBQ+mc6oEpWlWCRA9R3HMDm469z+fekAkNzh8buJ/adVh2Q/jUw7tUP0Ng3
         2DmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=T+aV8rwEpdWn3HT0IPelsU7ZeHDx/XPnYVHdz9wbMJc=;
        b=q+8trvPXEyuHFCMCYYf72jN0dnTj3mOEb4jaauh17M8kGMtvlIzTiJwB+ARImmD/b6
         UvCI7Pskj/c6l17cl8aLbUOzQHHP7nDWn/GbVEiY9VWCxe+63Lqnn/9lpYYW8ud6+ATh
         8ZFc6DikNIKSUGnsnTev7O6Mv5eJquFF/MDmJBAzObQp+fSO+SxPoSZqBTE9uaglzrN9
         Q2n0vTK0VZ/mtfJnc23/LdSMgDnVua6/Ovz3d1+gis4Geq/iMJy7H+ZMyHAmexZcMy9J
         b7gjvMPtb1yTSYq+f3kT1/Y8PcRjMAAKZPHQqkJWw2j05paCu87bLQDFpLKELbhVtU+l
         1h1w==
X-Gm-Message-State: ACgBeo3cB5lpQCJhHuxjdmnIQGSG4p8NRrsuvV5p+KKGHqRRDKUwPjd4
	RTH4Teh2R+0a37uLxUD7zJAfedwLtNw=
X-Google-Smtp-Source: AA6agR633KBuNCyZ9wnO9l0sThXdJEHGIDWwVRZSt7wAlqu51jh93Ifq7VeahirIQv+Q1dFN0gakBw==
X-Received: by 2002:a17:907:968d:b0:741:5d55:e501 with SMTP id hd13-20020a170907968d00b007415d55e501mr10940111ejc.449.1661897151370;
        Tue, 30 Aug 2022 15:05:51 -0700 (PDT)
Received: from localhost.localdomain (host-87-1-103-238.retail.telecomitalia.it. [87.1.103.238])
        by smtp.gmail.com with ESMTPSA id qc21-20020a170906d8b500b0072f4f4dc038sm6233325ejb.42.2022.08.30.15.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 15:05:49 -0700 (PDT)
From: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To: linux-nvme@lists.infradead.org,
	Sagi Grimberg <sagi@grimberg.me>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	James Smart <james.smart@broadcom.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Venkataramanan Anirudh <anirudh.venkataramanan@intel.com>,
	linux-kernel@vger.kernel.org
Cc: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH v2] nvmet-tcp: Don't map pages which can't come from HIGHMEM
Date: Wed, 31 Aug 2022 00:05:33 +0200
Message-Id: <20220830220533.17777-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220830_150555_751726_B06498C2 
X-CRM114-Status: GOOD (  20.32  )
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

In addition, there is no reason to use a kvec for the command receive
data buffers iovec, use a bio_vec instead and let iov_iter handle the
buffer mapping and data copy.

Test with blktests on a QEMU/KVM x86_32 VM, 6GB RAM, booting a kernel with
HIGHMEM64GB enabled.

[1] "[PATCH] checkpatch: Add kmap and kmap_atomic to the deprecated
list" https://lore.kernel.org/all/20220813220034.806698-1-ira.weiny@intel.com/

Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Keith Busch <kbusch@kernel.org>
Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
Suggested-by: Christoph Hellwig <hch@lst.de>
Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
[sagi: added bio_vec plus minor naming changes]
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---

v1->v2: Add the "Suggested-by" tags from Al and Christoph, because they
advised to use BVEC instead of KVEC. Fix a minor alignment issue reported
by checkpatch.

 drivers/nvme/target/tcp.c | 44 ++++++++++++---------------------------
 1 file changed, 13 insertions(+), 31 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index dc3b4dc8fe08..c07de4f4f719 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -77,9 +77,8 @@ struct nvmet_tcp_cmd {
 	u32				pdu_len;
 	u32				pdu_recv;
 	int				sg_idx;
-	int				nr_mapped;
 	struct msghdr			recv_msg;
-	struct kvec			*iov;
+	struct bio_vec			*iov;
 	u32				flags;
 
 	struct list_head		entry;
@@ -167,7 +166,6 @@ static const struct nvmet_fabrics_ops nvmet_tcp_ops;
 static void nvmet_tcp_free_cmd(struct nvmet_tcp_cmd *c);
 static void nvmet_tcp_finish_cmd(struct nvmet_tcp_cmd *cmd);
 static void nvmet_tcp_free_cmd_buffers(struct nvmet_tcp_cmd *cmd);
-static void nvmet_tcp_unmap_pdu_iovec(struct nvmet_tcp_cmd *cmd);
 
 static inline u16 nvmet_tcp_cmd_tag(struct nvmet_tcp_queue *queue,
 		struct nvmet_tcp_cmd *cmd)
@@ -301,35 +299,21 @@ static int nvmet_tcp_check_ddgst(struct nvmet_tcp_queue *queue, void *pdu)
 
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
-static void nvmet_tcp_map_pdu_iovec(struct nvmet_tcp_cmd *cmd)
+static void nvmet_tcp_build_pdu_iovec(struct nvmet_tcp_cmd *cmd)
 {
-	struct kvec *iov = cmd->iov;
+	struct bio_vec *iov = cmd->iov;
 	struct scatterlist *sg;
 	u32 length, offset, sg_offset;
+	int nr_pages;
 
 	length = cmd->pdu_len;
-	cmd->nr_mapped = DIV_ROUND_UP(length, PAGE_SIZE);
+	nr_pages = DIV_ROUND_UP(length, PAGE_SIZE);
 	offset = cmd->rbytes_done;
 	cmd->sg_idx = offset / PAGE_SIZE;
 	sg_offset = offset % PAGE_SIZE;
@@ -338,8 +322,9 @@ static void nvmet_tcp_map_pdu_iovec(struct nvmet_tcp_cmd *cmd)
 	while (length) {
 		u32 iov_len = min_t(u32, length, sg->length - sg_offset);
 
-		iov->iov_base = kmap(sg_page(sg)) + sg->offset + sg_offset;
-		iov->iov_len = iov_len;
+		iov->bv_page = sg_page(sg);
+		iov->bv_len = sg->length;
+		iov->bv_offset = sg->offset + sg_offset;
 
 		length -= iov_len;
 		sg = sg_next(sg);
@@ -347,8 +332,8 @@ static void nvmet_tcp_map_pdu_iovec(struct nvmet_tcp_cmd *cmd)
 		sg_offset = 0;
 	}
 
-	iov_iter_kvec(&cmd->recv_msg.msg_iter, READ, cmd->iov,
-		cmd->nr_mapped, cmd->pdu_len);
+	iov_iter_bvec(&cmd->recv_msg.msg_iter, READ, cmd->iov,
+		      nr_pages, cmd->pdu_len);
 }
 
 static void nvmet_tcp_fatal_error(struct nvmet_tcp_queue *queue)
@@ -926,7 +911,7 @@ static void nvmet_tcp_handle_req_failure(struct nvmet_tcp_queue *queue,
 	}
 
 	queue->rcv_state = NVMET_TCP_RECV_DATA;
-	nvmet_tcp_map_pdu_iovec(cmd);
+	nvmet_tcp_build_pdu_iovec(cmd);
 	cmd->flags |= NVMET_TCP_F_INIT_FAILED;
 }
 
@@ -952,7 +937,7 @@ static int nvmet_tcp_handle_h2c_data_pdu(struct nvmet_tcp_queue *queue)
 
 	cmd->pdu_len = le32_to_cpu(data->data_length);
 	cmd->pdu_recv = 0;
-	nvmet_tcp_map_pdu_iovec(cmd);
+	nvmet_tcp_build_pdu_iovec(cmd);
 	queue->cmd = cmd;
 	queue->rcv_state = NVMET_TCP_RECV_DATA;
 
@@ -1021,7 +1006,7 @@ static int nvmet_tcp_done_recv_pdu(struct nvmet_tcp_queue *queue)
 	if (nvmet_tcp_need_data_in(queue->cmd)) {
 		if (nvmet_tcp_has_inline_data(queue->cmd)) {
 			queue->rcv_state = NVMET_TCP_RECV_DATA;
-			nvmet_tcp_map_pdu_iovec(queue->cmd);
+			nvmet_tcp_build_pdu_iovec(queue->cmd);
 			return 0;
 		}
 		/* send back R2T */
@@ -1141,7 +1126,6 @@ static int nvmet_tcp_try_recv_data(struct nvmet_tcp_queue *queue)
 		cmd->rbytes_done += ret;
 	}
 
-	nvmet_tcp_unmap_pdu_iovec(cmd);
 	if (queue->data_digest) {
 		nvmet_tcp_prep_recv_ddgst(cmd);
 		return 0;
@@ -1411,7 +1395,6 @@ static void nvmet_tcp_restore_socket_callbacks(struct nvmet_tcp_queue *queue)
 static void nvmet_tcp_finish_cmd(struct nvmet_tcp_cmd *cmd)
 {
 	nvmet_req_uninit(&cmd->req);
-	nvmet_tcp_unmap_pdu_iovec(cmd);
 	nvmet_tcp_free_cmd_buffers(cmd);
 }
 
@@ -1424,7 +1407,6 @@ static void nvmet_tcp_uninit_data_in_cmds(struct nvmet_tcp_queue *queue)
 		if (nvmet_tcp_need_data_in(cmd))
 			nvmet_req_uninit(&cmd->req);
 
-		nvmet_tcp_unmap_pdu_iovec(cmd);
 		nvmet_tcp_free_cmd_buffers(cmd);
 	}
 
-- 
2.37.2


