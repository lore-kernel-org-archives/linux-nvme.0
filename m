Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71D88ECAAD2
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Aug 2022 07:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ShZ9RCmn3f9kz90o0jDhL8jf0hYJJDCa3dy49UOnJ0c=; b=H8lzmn8gmEZ6PAkRHbPLzroEsz
	cNfUpo0LpxrNjkhSw00O3kvxQe1E0/blTabZPmH7zordDyUkYA0RrT1UnzmH58RkAWnPUGONtwGwY
	licRu/K8juzGsqz6j83ti5HfgKuLtJgpixHOj219JJ78/yKjZaWgF1Odw7zF8NNssJJjPefAe6x+O
	V4gK6sAg9bETcQPxvis0QHQCUtD/+rbFMELiz8zDj7/U0wv6zBJ9p4j6tb2D5sq93FkSiB/6o6FOR
	fmaXXUyGcSsIUpJgA211G9fAaFiONbIgGF5Hjl2biQb1QcMWVWDD3JIpXKuIjiBDSTOy6hYE7OyFL
	yzQpZQ5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSZb6-005s4q-75; Mon, 29 Aug 2022 07:54:16 +0000
Received: from mail-wr1-f45.google.com ([209.85.221.45])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSZaz-005ry8-4a
	for linux-nvme@lists.infradead.org; Mon, 29 Aug 2022 07:54:12 +0000
Received: by mail-wr1-f45.google.com with SMTP id b5so9089303wrr.5
        for <linux-nvme@lists.infradead.org>; Mon, 29 Aug 2022 00:54:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=ShZ9RCmn3f9kz90o0jDhL8jf0hYJJDCa3dy49UOnJ0c=;
        b=SV/TtD6bmNbElyOFGXkgtLbM2LeNraqT+l+PvslsKlWXKYpmsNKBN7j6ugf0NL0IP/
         IeIeIqhBPmBoZO4lK7+cPEHILfMBoYG23ByhVhupHQnn75xqEgEhtfs8U4H/7zAFzlXr
         4zZZFKOeUYgrsAzTq+MWb4X3Tekdry0Xff/yQrWRl1lYUB0t0R+llOATtYwpUE67MbQW
         HKpg16ZcAcmwOuAX8BiknH1IYtzCSveHOyqNikdaJCqOeudErqF0aUisrxzgtY2a8WqO
         C/wDXrOYw0QNKaLku9sxXWuPjwE0njk+2SD5lRFp7hPIHTFE/Ejg051zCY1KQSVR9yyE
         A/CA==
X-Gm-Message-State: ACgBeo2/OHN81rPPZgh3nIGNcLzMzQhvMUTDm/kOd8lkgUNIUFA8rJ7U
	8e3Ti5OOJqGU24/8KIgySBj94mofDNQ=
X-Google-Smtp-Source: AA6agR6qbJAN0rlN50REUaB4wr68h/NDPjgtgEotNaa5UHtqbsabyDKvM4slVWLQXm5k2iqCD7RrPA==
X-Received: by 2002:a05:6000:887:b0:21e:24a0:f302 with SMTP id ca7-20020a056000088700b0021e24a0f302mr5364239wrb.466.1661759646285;
        Mon, 29 Aug 2022 00:54:06 -0700 (PDT)
Received: from localhost.localdomain (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id k35-20020a05600c1ca300b003a5f3de6fddsm8675544wms.25.2022.08.29.00.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 00:54:04 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	"Fabio M . De Francesco" <fmdefrancesco@gmail.com>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	James Smart <james.smart@broadcom.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Venkataramanan Anirudh <anirudh.venkataramanan@intel.com>
Subject: [PATCH] nvmet-tcp: Don't map pages which can't come from HIGHMEM
Date: Mon, 29 Aug 2022 10:54:01 +0300
Message-Id: <20220829075401.868981-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220829_005409_218601_288A3ED3 
X-CRM114-Status: GOOD (  19.77  )
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

From: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>

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
Cc: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>
Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
[sagi: added bio_vec plus minor naming changes]
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/target/tcp.c | 44 ++++++++++++---------------------------
 1 file changed, 13 insertions(+), 31 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index dc3b4dc8fe08..43594e0d609c 100644
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
+		nr_pages, cmd->pdu_len);
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
2.34.1


