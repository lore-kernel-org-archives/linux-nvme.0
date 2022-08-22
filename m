Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59449C32774
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Aug 2022 14:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UqdwmA13nyBstb3LLHqV9cDnbeU1qajuXcxfCTpGT0U=; b=uxbI2Eh0xaet2fgZHeowwLF4xo
	yWsf0EGdC+jsbawMKPBLPTWBZ9/dMKFY3XQ5qTq2xrmMJRqfX5DvLjpcUuPOhlLp2RR852oeNIXgX
	r8myLkBIIgclWx4zzVB77giTBj0V0fvWBjtL45RABbPq5BVZxpYt9VAo2wTm0elZjlFLZ7qHQxnaa
	o+crMXY16kcJbOyNIgob8cSKJ68GW97UOgzPJv6RJWF/wFR+HEflvoA8MS8o+GUadUgv/gUkmaFCV
	gq49FY/P6Vrt/mjKvatUiSowsvuKU8YWjEe2xwNfl6t4Gmw0wxz+x9MhozIIYR1ykSsucUBCqhkJ9
	EHYrKteQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oQ8MQ-00B635-Hf; Mon, 22 Aug 2022 14:25:02 +0000
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oQ8MI-00B5ig-VR
	for linux-nvme@lists.infradead.org; Mon, 22 Aug 2022 14:24:56 +0000
Received: by mail-ej1-x636.google.com with SMTP id n7so3402590ejh.2
        for <linux-nvme@lists.infradead.org>; Mon, 22 Aug 2022 07:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=UqdwmA13nyBstb3LLHqV9cDnbeU1qajuXcxfCTpGT0U=;
        b=Rt/5FX0mvQ+cMkyy5Jj6jYpCapyl2esoEAIsyUXJIoJokJfwF6rolyOBCRPiOTdFK/
         kr2v3SaXXMG4NYskxUPtAzy/bdASHponLcF9h1VaEjV48GkzSYyvlqztGiPLmgDwvYaA
         evStkYIty6U8+b+ilmVO9pCUsRx5JcZAalEdKvmIufgb/hlzQD1V2WNKb6yR07S+tyYC
         VM61J4Q2PHmrJtqUUI55KGTNrymqF87fAeG3+9Ag51W/dpDW2TsgKk0mnhuj1NnP3ua6
         3a2yTS2CuV0gDtqXQoMS7p7p89PzuvUr0Y+jBQ75L99bvaHYt2f1yszRdIHSteQU5tCs
         H4RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=UqdwmA13nyBstb3LLHqV9cDnbeU1qajuXcxfCTpGT0U=;
        b=yVL3/wbSu6prPIfC5D/vWRRoqRdGoBwf4Hr98aVgGL04dLfIcAJapun6Is5T39zmdm
         naSXlw90gHYYFXFusyweoUG6KOVxTaCQBiwne3IB0L71eEc1zOCCii9QN37ng1R82J6D
         sNDt8FAZeYiF3grk4g8f4hdLRRKC+XLoRfOjeJgz7n5IrCK/Ap6HPOFYRNJ8GTuP/21E
         BD0KxnEqNczfWotPfp+TIGN9Q5LcdPvcGGykGS/uWtA6HMy/cwKP8a4jBrWyFHUsmYjo
         UIwkMqvLx9E4W5T/rMKjcMb/4TWYvD+1Dlb9q2aMxKRvAxNa0nEbueEXr+QhRxUImhhi
         xkuw==
X-Gm-Message-State: ACgBeo0GJjI1NwPyhiINDnu46WM4e7wKx2k0a+CT9KsyyBB/qkX0VYDl
	mSNBRQ2Ywklaies7sO4xqVE=
X-Google-Smtp-Source: AA6agR4m2NrHXm24VJGTtiRTJFIWJpt0bKcmR0lG6LI+zTpSqNmwDv5doKvm3NI1wWuB4R6HCJG4pQ==
X-Received: by 2002:a17:907:7d91:b0:731:7ecb:1e5b with SMTP id oz17-20020a1709077d9100b007317ecb1e5bmr12910146ejc.78.1661178290533;
        Mon, 22 Aug 2022 07:24:50 -0700 (PDT)
Received: from localhost.localdomain (host-87-17-106-94.retail.telecomitalia.it. [87.17.106.94])
        by smtp.gmail.com with ESMTPSA id h4-20020a170906398400b0073151ce7726sm6286083eje.100.2022.08.22.07.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 07:24:48 -0700 (PDT)
From: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	James Smart <james.smart@broadcom.com>,
	Ira Weiny <ira.weiny@intel.com>,
	"Venkataramanan, Anirudh" <anirudh.venkataramanan@intel.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Keith Busch <kbusch@kernel.org>
Subject: [PATCH v3 1/1] nvmet-tcp: Don't kmap() pages which can't come from HIGHMEM
Date: Mon, 22 Aug 2022 16:24:38 +0200
Message-Id: <20220822142438.5954-2-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220822142438.5954-1-fmdefrancesco@gmail.com>
References: <20220822142438.5954-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220822_072455_074348_D77C68F2 
X-CRM114-Status: GOOD (  19.04  )
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
delete the "nr_mapped" field from "nvmet_tcp_cmd" and instead pass a
local variable to iov_iter_kvec() from the call site in
nvmet_tcp_map_pdu_iovec().

Test with blktests on a QEMU/KVM x86_32 VM, 6GB RAM, booting a kernel with
HIGHMEM64GB enabled.

[1] "[PATCH] checkpatch: Add kmap and kmap_atomic to the deprecated
list" https://lore.kernel.org/all/20220813220034.806698-1-ira.weiny@intel.com/

Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>
Cc: Sagi Grimberg <sagi@grimberg.me>
Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/nvme/target/tcp.c | 28 +++++-----------------------
 1 file changed, 5 insertions(+), 23 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index dc3b4dc8fe08..2e2a7367b77e 100644
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
 static void nvmet_tcp_map_pdu_iovec(struct nvmet_tcp_cmd *cmd)
 {
 	struct kvec *iov = cmd->iov;
 	struct scatterlist *sg;
 	u32 length, offset, sg_offset;
+	int nr_mapped;
 
 	length = cmd->pdu_len;
-	cmd->nr_mapped = DIV_ROUND_UP(length, PAGE_SIZE);
+	nr_mapped = DIV_ROUND_UP(length, PAGE_SIZE);
 	offset = cmd->rbytes_done;
 	cmd->sg_idx = offset / PAGE_SIZE;
 	sg_offset = offset % PAGE_SIZE;
@@ -338,7 +322,8 @@ static void nvmet_tcp_map_pdu_iovec(struct nvmet_tcp_cmd *cmd)
 	while (length) {
 		u32 iov_len = min_t(u32, length, sg->length - sg_offset);
 
-		iov->iov_base = kmap(sg_page(sg)) + sg->offset + sg_offset;
+		iov->iov_base = page_address(sg_page(sg)) +
+				sg->offset + sg_offset;
 		iov->iov_len = iov_len;
 
 		length -= iov_len;
@@ -348,7 +333,7 @@ static void nvmet_tcp_map_pdu_iovec(struct nvmet_tcp_cmd *cmd)
 	}
 
 	iov_iter_kvec(&cmd->recv_msg.msg_iter, READ, cmd->iov,
-		cmd->nr_mapped, cmd->pdu_len);
+		      nr_mapped, cmd->pdu_len);
 }
 
 static void nvmet_tcp_fatal_error(struct nvmet_tcp_queue *queue)
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


