Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C3B1C32771
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Aug 2022 18:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=xGU9QalusRdz0W9hKf9EB+6UjNuyQWtvR/GW+P/WHUw=; b=f2CP8irvVX2tNS5JGXUK2lp/Tm
	qfTB2N6Yv4w8KL7LX3csdf+Fqk7MEgXZ+5mmpteEGhik9f2XMYmqBs7+KLop3HMdhdXknRMQzjm8d
	l9E4Loyzbk8E3CBJ9ukR9rtOPZ4Cj1TQjHALMmO4PjxTfFpDfGmU4pmlpyGb885ZT3PhUZWN3kVuH
	OP0lHm7zZz0bD98iRMmZ0AqkbGI0o/3KMrGrkPjuWoSVlVFvvSe3Y3FsEZfwFsbwy8U3G/2V7an0n
	6sP+ZDjL82W03BKYpSKGm9rSuFn36o3CVFaQfXtsIh7lKd3aYJRMCCSX3qP1MRD/tgpWZGD0wnE6b
	+Rv39+ZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oOO2o-005Dzk-02; Wed, 17 Aug 2022 18:45:34 +0000
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oOO2k-005Ds1-OR
	for linux-nvme@lists.infradead.org; Wed, 17 Aug 2022 18:45:32 +0000
Received: by mail-ed1-x52a.google.com with SMTP id r4so18612044edi.8
        for <linux-nvme@lists.infradead.org>; Wed, 17 Aug 2022 11:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=xGU9QalusRdz0W9hKf9EB+6UjNuyQWtvR/GW+P/WHUw=;
        b=UFDIuYFY1k8+fk1hDuKvDWb2fyjxcvEPEJdw2+VK5IwzA3fGcWVBtydYoCc9Jz0qgH
         wf/Ivhl/hMejcR+6haJyBF+jAl6tORW7jX97VGmaOgVAAS9T8Q1WMNtwxVzlw+sqV0DM
         3xs1FkAt6tB3/0gNIn+5Y/rLSHozCz0Jjrn7kVlnI41wP0s7ZI+TAj9upAr55PRrerCU
         Qd3KGIL0mIv8uFQhhzwgSrp4W2hoUMt0H6QOm97b3yHxdWBxjYW14VTfKu1rgjUaLdYH
         AuRMDRShgIkhuNClu8q2lvnHHvl/tRsM1uEadix1ZSdGMyW4l0zFipkNPbSXOVKajq4k
         6ipA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=xGU9QalusRdz0W9hKf9EB+6UjNuyQWtvR/GW+P/WHUw=;
        b=mIMJoc2uVWKOqkqYPBwJMXbNWGuW1FMI2xuFdhQ7eGCEESf0mcCfxguSp5mCpy7WlL
         wIX+TBrVgb4NoAqHXYWr1f6/H5bdKwZGgP7SpO+Kyj2dhphGJJre+C1Lw2MP2kPrnj65
         PYCTuuq6fP+EeJ0bJuleM3yXVTOjUnPpB6CtwyA2hK1D9/tRDnV7gjRqSr5rT4oR3gxX
         sqvGQAkT0ds/N6Jj9pgwd0qYSbXABs+npWU9mJul4hHmXxwasPf1KLaHezghByBWz0J/
         QJCG3ujL3U5gTYHo7R1AM6k/gjI51CEWGFTBlyA3Gu0B7aODNwO072T4mzdZ33hNsjPq
         xsJg==
X-Gm-Message-State: ACgBeo3DD865yShtYPOTFhxG4PaFn/D9Rh7V72TQrKw73z+9RlhD9huO
	1+R29M0SKdz2pM2sRFbcb0I=
X-Google-Smtp-Source: AA6agR5zgDfueJg8rk7ZyXHB/d3TWt3aCmNp/ioebSxEicV6/TaYp4vTbgxI/8z/q1nGKBfvTKd5WQ==
X-Received: by 2002:a05:6402:3881:b0:445:f8bf:5a1c with SMTP id fd1-20020a056402388100b00445f8bf5a1cmr1127787edb.13.1660761926704;
        Wed, 17 Aug 2022 11:45:26 -0700 (PDT)
Received: from localhost.localdomain (host-87-17-106-94.retail.telecomitalia.it. [87.17.106.94])
        by smtp.gmail.com with ESMTPSA id fq15-20020a1709069d8f00b007306a4ecc9dsm7211975ejc.18.2022.08.17.11.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 11:45:24 -0700 (PDT)
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
Subject: [PATCH v2] nvmet-tcp: Don't kmap() pages which can't come from HIGHMEM
Date: Wed, 17 Aug 2022 20:45:19 +0200
Message-Id: <20220817184519.25141-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220817_114530_887561_8C2BA4EB 
X-CRM114-Status: GOOD (  17.97  )
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

[1] "[PATCH] checkpatch: Add kmap and kmap_atomic to the deprecated
list" https://lore.kernel.org/all/20220813220034.806698-1-ira.weiny@intel.com/

Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Keith Busch <kbusch@kernel.org>
Cc: Sagi Grimberg <sagi@grimberg.me>
Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

v1->v2: Use a local variable as argument of iov_iter_kvec() instead of
the removed "nr_mapped" field from struct "nvmet_tcp_cmd". Thanks to
Sagi and Keith who noticed my mistake.

Many thanks to Chaitanya, Keith, Sagi, for the answers and the comments on
the RFC which led to this patch. The RFC is at:
https://lore.kernel.org/all/20220816091808.23236-1-fmdefrancesco@gmail.com/

 drivers/nvme/target/tcp.c | 28 ++++------------------------
 1 file changed, 4 insertions(+), 24 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index dc3b4dc8fe08..5b839f842623 100644
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
@@ -338,7 +322,7 @@ static void nvmet_tcp_map_pdu_iovec(struct nvmet_tcp_cmd *cmd)
 	while (length) {
 		u32 iov_len = min_t(u32, length, sg->length - sg_offset);
 
-		iov->iov_base = kmap(sg_page(sg)) + sg->offset + sg_offset;
+		iov->iov_base = page_address(sg_page(sg)) + sg->offset + sg_offset;
 		iov->iov_len = iov_len;
 
 		length -= iov_len;
@@ -347,8 +331,7 @@ static void nvmet_tcp_map_pdu_iovec(struct nvmet_tcp_cmd *cmd)
 		sg_offset = 0;
 	}
 
-	iov_iter_kvec(&cmd->recv_msg.msg_iter, READ, cmd->iov,
-		cmd->nr_mapped, cmd->pdu_len);
+	iov_iter_kvec(&cmd->recv_msg.msg_iter, READ, cmd->iov, nr_mapped, cmd->pdu_len);
 }
 
 static void nvmet_tcp_fatal_error(struct nvmet_tcp_queue *queue)
@@ -1141,7 +1124,6 @@ static int nvmet_tcp_try_recv_data(struct nvmet_tcp_queue *queue)
 		cmd->rbytes_done += ret;
 	}
 
-	nvmet_tcp_unmap_pdu_iovec(cmd);
 	if (queue->data_digest) {
 		nvmet_tcp_prep_recv_ddgst(cmd);
 		return 0;
@@ -1411,7 +1393,6 @@ static void nvmet_tcp_restore_socket_callbacks(struct nvmet_tcp_queue *queue)
 static void nvmet_tcp_finish_cmd(struct nvmet_tcp_cmd *cmd)
 {
 	nvmet_req_uninit(&cmd->req);
-	nvmet_tcp_unmap_pdu_iovec(cmd);
 	nvmet_tcp_free_cmd_buffers(cmd);
 }
 
@@ -1424,7 +1405,6 @@ static void nvmet_tcp_uninit_data_in_cmds(struct nvmet_tcp_queue *queue)
 		if (nvmet_tcp_need_data_in(cmd))
 			nvmet_req_uninit(&cmd->req);
 
-		nvmet_tcp_unmap_pdu_iovec(cmd);
 		nvmet_tcp_free_cmd_buffers(cmd);
 	}
 
-- 
2.37.1


