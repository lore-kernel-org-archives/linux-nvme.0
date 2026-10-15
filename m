Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADACDCC6B34
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Oct 2026 12:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VjuAVMRAOQhBucSDPBTXXjKhh3RkY/7DidXgYyu2ie8=; b=YW6IwgxzCJE2n+s1jEY/+zKpEd
	HDjVdwY+FuDLD73TzVOmtjTEHDG/CFwQLwyAU4hFR5Id82weE7PsT8uHy/MxKz9txanm/sStj460s
	WxEPqXU+F0smpYqweBAq8tlplyutqbk/MCxNy3Q8uuEuhZ5vkNc4/v6ei7UTDA0FUO6qZSyQ3woYo
	1AEswUf6qILSx/3Nig1oINBafxRYmOLb/HWzotea+ANhwhOC4OLdOgnf9XQxB9PdpUjgqNQIVhJ52
	MADfkQPjPhHmYtOJdWI0V24opVDIZ/VQ6Yx8mw/GEWa6k0+/OWBVU4+A0Dm25nnMuvchxkwg3SVTT
	0eO4CKCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHKt0-000000009k8-15Y3;
	Thu, 15 Oct 2026 12:48:42 +0000
Received: from vtj.irix.systems ([82.76.27.144])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHKsx-000000009i4-1MLA
	for linux-nvme@lists.infradead.org;
	Thu, 15 Oct 2026 12:48:40 +0000
Received: from MAILGW-BIG.big.vtj.corp.irix.systems (localhost [127.0.0.1])
	by vtj.irix.systems (Proxmox) with ESMTP id 4F7B411CE3;
	Thu, 15 Oct 2026 15:48:25 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=andrei-z.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=sig1; bh=VjuAVMRAOQhBucSDPBTX
	XjKhh3RkY/7DidXgYyu2ie8=; b=Uk7h+Xvwc3nfR8lo4C/GstlKJxtIUYfZ84iY
	dmUPQMBC4i0Fo9oYRTbPL60eVNQe2spGmc8FKcZMJLqDiBCQUadCa/KBnfLt5BQr
	b8eWdZ7XCRyzKmaGoxzV0i2tvt4MnA8cy93Dz1HAeT8d5Q/RC64d1yhE+prlLrN4
	2HbJg3bet5uN88M8HZRN9VbZLYrqxt1IgyI+bvjg7u4BZLpeVxRJ+l1/IOhH4YVy
	P7XNxNTv3eGJeIEjvSHtBlPccKo4VLsDV5x3h/tQtaFEBP3dnqqtt2jjPM6AyIUk
	sUe2ppp99pYKKkooB5KzdJM34waV0qiQPsrNWlzzXpgMidfang==
Received: from VTJ-MX.corp.irix.systems (unknown [IPv6:2a02:2f04:1:9c24::6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by vtj.irix.systems (Proxmox) with ESMTPS id 047EE11C71;
	Thu, 15 Oct 2026 15:48:24 +0300 (EEST)
Received: from [10.89.11.73] (10.57.8.14) by VTJ-MX.corp.irix.systems
 (2a02:2f04:1:9c24::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 15 Oct
 2026 15:48:23 +0300
From: Andrei-Alexandru Bleortu <me@andrei-z.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph
 Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	<linux-nvme@lists.infradead.org>
CC: Andrei-Alexandru Bleortu <me@andrei-z.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/1] nvme-rdma: post the command capsule inline when it fits
Date: Thu, 15 Oct 2026 15:48:23 +0300
Message-ID: <20261015124823.2962700-2-me@andrei-z.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261015124823.2962700-1-me@andrei-z.com>
References: <20261015124823.2962700-1-me@andrei-z.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.57.8.14]
X-ClientProxiedBy: VTJ-MX.corp.irix.systems (2a02:2f04:1:9c24::6) To
 VTJ-MX.corp.irix.systems (2a02:2f04:1:9c24::6)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261015_054839_610138_2E9EDA07 
X-CRM114-Status: GOOD (  23.99  )
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

nvme_rdma_post_send() posts the 64-byte command capsule by reference,
so the HCA has to DMA-read the capsule from host memory before it can
send the command. That read is on the latency path of every I/O.

Ask for sizeof(struct nvme_command) bytes of inline data when creating
the queue pair, and create it without inline data if the device refuses.
Post a capsule that has no in-capsule data with IB_SEND_INLINE when it
fits in the granted inline size. The CPU then copies the capsule into
the send WQE and the HCA no longer reads it.

Providers copy inline data from sg_list[].addr as a kernel virtual
address, but nvme-rdma keeps the capsule's DMA address there. On the
inline path the SGE therefore points at qe->data. The capsule stays
DMA-mapped for the by-reference path.

An earlier version of this patch was measured with fio doing 4 KiB
random reads at queue depth 1 against a null_blk namespace exported by
nvmet-rdma. Both host pairs ran a 6.8 kernel over RoCEv2 at 100 Gb/s.
The mean completion latency fell by 0.998 us (95% CI 0.943-1.049)
between two AMD EPYC 7452 hosts with ConnectX-5 Ex, and by 0.589 us
(0.558-0.618) between two Xeon Platinum 8360Y hosts with ConnectX-6 Dx.
IOPS rose by 3.3% on the EPYC pair. A run there that asked for inline
data but kept posting by reference showed no change. That version asked
for 220 bytes and had no fallback, but it inlined the same capsules.

Assisted-by: LLM
Signed-off-by: Andrei-Alexandru Bleortu <me@andrei-z.com>
---
 drivers/nvme/host/rdma.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 5b9b540693b5..517098ebffb1 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -106,6 +106,7 @@ struct nvme_rdma_queue {
 	bool			pi_support;
 	int			cq_size;
 	struct mutex		queue_lock;
+	u32			max_inline_data;
 };
 
 struct nvme_rdma_setup_ctx {
@@ -265,7 +266,7 @@ static int nvme_rdma_wait_for_cm(struct nvme_rdma_queue *queue)
 static int nvme_rdma_create_qp(struct nvme_rdma_queue *queue, const int factor)
 {
 	struct nvme_rdma_device *dev = queue->device;
-	struct ib_qp_init_attr init_attr;
+	struct ib_qp_init_attr init_attr, attr;
 	int ret;
 
 	memset(&init_attr, 0, sizeof(init_attr));
@@ -284,9 +285,21 @@ static int nvme_rdma_create_qp(struct nvme_rdma_queue *queue, const int factor)
 		init_attr.create_flags |= IB_QP_CREATE_INTEGRITY_EN;
 	init_attr.qp_context = queue;
 
-	ret = rdma_create_qp(queue->cm_id, dev->pd, &init_attr);
+	/*
+	 * Ask for enough inline data to carry the command capsule in the send
+	 * WQE (see nvme_rdma_post_send()).  If the device cannot provide it,
+	 * create the QP without inline data and post the capsule by reference.
+	 */
+	attr = init_attr;
+	attr.cap.max_inline_data = sizeof(struct nvme_command);
+	ret = rdma_create_qp(queue->cm_id, dev->pd, &attr);
+	if (ret) {
+		attr = init_attr;
+		ret = rdma_create_qp(queue->cm_id, dev->pd, &attr);
+	}
 
 	queue->qp = queue->cm_id->qp;
+	queue->max_inline_data = ret ? 0 : attr.cap.max_inline_data;
 	return ret;
 }
 
@@ -1641,6 +1654,17 @@ static int nvme_rdma_post_send(struct nvme_rdma_queue *queue,
 	wr.opcode     = IB_WR_SEND;
 	wr.send_flags = IB_SEND_SIGNALED;
 
+	/*
+	 * Post a capsule without in-capsule data inline if it fits in the
+	 * granted inline size, so the HCA does not have to DMA-read it from
+	 * host memory.  The CPU copies inline data from a kernel virtual
+	 * address, so point the SGE at qe->data.
+	 */
+	if (num_sge == 1 && sge->length <= queue->max_inline_data) {
+		sge->addr = (uintptr_t)qe->data;
+		wr.send_flags |= IB_SEND_INLINE;
+	}
+
 	if (first)
 		first->next = &wr;
 	else
-- 
2.56.0



