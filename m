Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 128FCC3DA7F
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Aug 2024 20:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=d5bdg5cl46CVsPC2sCG5rD6JV6coGJmmGgFahMX7CaM=; b=yD+dHRDIL/YsO59hKfCaHORFRk
	h567l5dxpyJrKTKnGl+ZFWyDzapLc4aXU2bVQly+xuoMpKQhAheiO2oZaodwdTK0HkQr7l/Rc0HM4
	B2dFNiy5bN8ImPPNAmQYvAhrkKyQ4/uFdHjEUvwcN2jOMng5CWUUR0REnyIX526CZc0zoXV48Mtt1
	YHo8g5VCCwPuW1qE8jTMCEL6XBVdJIAiCCCnQqwEFzKPZhVCnbuA71WE3k40FbfLTnPdV26sJmybq
	NxdyRgnNqEV64OTTOgB3mFwwhxxWOvETo65gSI8KsqwVIuvpanSFi5vtjxUOotoZYl+kUfbRNoAxI
	8IhhlHfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1segoy-0000000AxU1-3zQy;
	Thu, 15 Aug 2024 20:11:44 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1segov-0000000AxTb-3foJ
	for linux-nvme@lists.infradead.org;
	Thu, 15 Aug 2024 20:11:43 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 47BF0CE1DC3;
	Thu, 15 Aug 2024 20:11:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 974AEC32786;
	Thu, 15 Aug 2024 20:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723752699;
	bh=fWucJfYeGMy5yIV7JXsim4S7WM/KtMpRRxYOLecfeek=;
	h=From:To:Cc:Subject:Date:From;
	b=jcawDEJtwF8vOKJ3dBHeAZDLNP9WHhstXkrpcyMWSM+BRX4dklKTSbSd7zXW/rdQy
	 U5mKApBXa32AZEYEHbhgKxon41A4Hp3LKBMjc9dJP/PAvjL+mGUXhrlyveoPLRbigN
	 FBvNBalDCD6MyCB2y3clJUTphJFuPwhtOvLnb9ZRGs1ntbbOwyxbZuw9RzxBkXpfqr
	 1+Y81vga6bRW1g+4VFSeELNiDx1+P4m2vhn9RqYEATXBZX785htWOoeuHlzqZp7wf4
	 0bn3rrCeZt4JXNThc+IyVB2x/HwdkjGhc9srf2c+9fh+LALe0oqtk3BuRXJfPySZeT
	 2LhuO4UfIjBpQ==
From: Niklas Cassel <cassel@kernel.org>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: kamaljit.singh1@wdc.com,
	dlemoal@kernel.org,
	Niklas Cassel <cassel@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH] nvme-rdma: send cntlid in the RDMA_CM_REQUEST Private Data
Date: Thu, 15 Aug 2024 22:11:31 +0200
Message-ID: <20240815201131.1439811-2-cassel@kernel.org>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2384; i=cassel@kernel.org; h=from:subject; bh=fWucJfYeGMy5yIV7JXsim4S7WM/KtMpRRxYOLecfeek=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNL2JXzex89vMYtna/KX1c9Pzpv2YtWj5jfn0r+9XXLnV X/ph3Kx4x2lLAxiXAyyYoosvj9c9hd3u085rnjHBmYOKxPIEAYuTgGYyNbzDP8TX8391BTLvyn9 zJqA1U/zDStM7Mz/bVpdW7eg47zwSu7ZjAw9NicvPfSMXXLuqIDqoytPKu6Z2zz7ciRm+Z4DQpo L7llzAQA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240815_131142_290212_10AF6331 
X-CRM114-Status: GOOD (  15.34  )
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

When sending a RDMA_CM_REQUEST, the NVMe RDMA Transport Specification
allows you to populate the cntlid field in the RDMA_CM_REQUEST Private
Data.

The cntlid is returned by the target on completion of the first
RDMA_CM_REQUEST command (which creates the admin queue).

The cntlid field can then be populated by the host when the I/O queues
are created (using additional RDMA_CM_REQUEST commands), such that the
target can perform extra validation for additional RDMA_CM_REQUEST
commands.

This additional error code and error message is also added, such that
nvme_rdma_cm_msg() will display the proper error message if the target
fails the RDMA_CM_REQUEST command because of this extra validation.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/nvme/host/rdma.c  | 2 ++
 include/linux/nvme-rdma.h | 6 +++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 2eb33842f971..e3520a91147b 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1876,6 +1876,8 @@ static int nvme_rdma_route_resolved(struct nvme_rdma_queue *queue)
 		 */
 		priv.hrqsize = cpu_to_le16(queue->queue_size);
 		priv.hsqsize = cpu_to_le16(queue->ctrl->ctrl.sqsize);
+		/* cntlid should only be set when creating an I/O queue */
+		priv.cntlid = cpu_to_le16(ctrl->ctrl.cntlid);
 	}
 
 	ret = rdma_connect_locked(queue->cm_id, &param);
diff --git a/include/linux/nvme-rdma.h b/include/linux/nvme-rdma.h
index eb2f04d636c8..97c5f00b9aa3 100644
--- a/include/linux/nvme-rdma.h
+++ b/include/linux/nvme-rdma.h
@@ -25,6 +25,7 @@ enum nvme_rdma_cm_status {
 	NVME_RDMA_CM_NO_RSC		= 0x06,
 	NVME_RDMA_CM_INVALID_IRD	= 0x07,
 	NVME_RDMA_CM_INVALID_ORD	= 0x08,
+	NVME_RDMA_CM_INVALID_CNTLID	= 0x09,
 };
 
 static inline const char *nvme_rdma_cm_msg(enum nvme_rdma_cm_status status)
@@ -46,6 +47,8 @@ static inline const char *nvme_rdma_cm_msg(enum nvme_rdma_cm_status status)
 		return "invalid IRD";
 	case NVME_RDMA_CM_INVALID_ORD:
 		return "Invalid ORD";
+	case NVME_RDMA_CM_INVALID_CNTLID:
+		return "invalid controller ID";
 	default:
 		return "unrecognized reason";
 	}
@@ -64,7 +67,8 @@ struct nvme_rdma_cm_req {
 	__le16		qid;
 	__le16		hrqsize;
 	__le16		hsqsize;
-	u8		rsvd[24];
+	__le16		cntlid;
+	u8		rsvd[22];
 };
 
 /**
-- 
2.46.0


