Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50467C7EE26
	for <linux-nvme@archiver.kernel.org>; Mon,  1 May 2023 12:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2WOGiov/m2pA1t59sXGUsmU4eYhd1snXKoF3h/t1OiE=; b=TQxpelghBcL725cLi7CGHuNvPy
	hVPw1axbAHOHpLSch+fiNeBcVeS4uJ8DsGxFnixj7o9BAbmFXrTprag33xr+SRf3GY0mcd0sB+txH
	6yZfzHB/4NyKL3PDXUoTMLkLgwfYMqPMr/Ts0ucbgY/cxdfbwD2nohvzCAkCWcSDkPK4Y7dXKWX3P
	fs0vapbX5reCV4c/M9oa/Vd+1Jy4B/oZJ3AWcdS5CwVv5Nnovc3L3Z99c9VZwOKPrcNjGOX8Lrnpb
	4Hbl7V36rUwQuNwR/fJsF+xk5+W07yfh84KcmiA/J7nfrcC0WsLrzphUSl6MULQhj4AmvOhwVbcru
	T8CInsKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ptSpt-00G0W9-2n;
	Mon, 01 May 2023 12:40:57 +0000
Received: from smtp-25.smtpout.orange.fr ([80.12.242.25] helo=smtp.smtpout.orange.fr)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ptSpn-00G0Rz-27
	for linux-nvme@lists.infradead.org;
	Mon, 01 May 2023 12:40:56 +0000
Received: from pop-os.home ([86.243.2.178])
	by smtp.orange.fr with ESMTPA
	id tSpZpM6hwpwRItSpmpInbR; Mon, 01 May 2023 14:40:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1682944850;
	bh=2WOGiov/m2pA1t59sXGUsmU4eYhd1snXKoF3h/t1OiE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aNBie3PYKeQ+8ngqAp7gsv76YqsQqflNrSky9N0LmN8gnXehQ+LPWDHAKmWUZUb5L
	 qsryuuTtFwuT+8QLeVPZK8Zx3uTwcqBcroYA4Svslx2AERgndJNOwav/rHzQmmr6Mt
	 WNqcz6/9GRlSmXpRvtD2wGpLxh8XBgbtjjlHMaaYJFvW15zdeSgBcyUSRlqzHENnkr
	 6VJeeolJ/3v39moz7s+K3sWA9Vj20SGC4IDN+L38BMKjEQyMKBiSP0hYYFefHTIAeg
	 MXlmJv5KKgsmvCmlX3f3iQr9pOzOI1JbmsjQdVqFz3sk2arnzQjmqdofkyNKX3kFQI
	 mWurVPEaMkiPw==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 01 May 2023 14:40:50 +0200
X-ME-IP: 86.243.2.178
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 5/5] nvmet: Reorder fields in 'struct nvmefc_fcp_req'
Date: Mon,  1 May 2023 14:40:29 +0200
Message-Id: <9433a896eae368a65f430f4eb7310c56da81d954.1682941568.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1682941568.git.christophe.jaillet@wanadoo.fr>
References: <cover.1682941568.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230501_054051_835132_5F4C262A 
X-CRM114-Status: GOOD (  17.04  )
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

Group some variables based on their sizes to reduce holes.
On x86_64, this shrinks the size of 'struct nvmefc_fcp_req' from
112 to 104 bytes.

This structure is embedded in some other structures (nvme_fc_fcp_op
which itself is embedded in nvme_fcp_op_w_sgl), so it helps reducing the
size of these structures too.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Using pahole

Before:
======
struct nvmefc_fcp_req {
	void *                     cmdaddr;              /*     0     8 */
	void *                     rspaddr;              /*     8     8 */
	dma_addr_t                 cmddma;               /*    16     8 */
	dma_addr_t                 rspdma;               /*    24     8 */
	u16                        cmdlen;               /*    32     2 */
	u16                        rsplen;               /*    34     2 */
	u32                        payload_length;       /*    36     4 */
	struct sg_table            sg_table;             /*    40    16 */
	struct scatterlist *       first_sgl;            /*    56     8 */
	/* --- cacheline 1 boundary (64 bytes) --- */
	int                        sg_cnt;               /*    64     4 */
	enum nvmefc_fcp_datadir    io_dir;               /*    68     4 */
	__le16                     sqid;                 /*    72     2 */

	/* XXX 6 bytes hole, try to pack */

	void                       (*done)(struct nvmefc_fcp_req *); /*    80     8 */
	void *                     private;              /*    88     8 */
	u32                        transferred_length;   /*    96     4 */
	u16                        rcv_rsplen;           /*   100     2 */

	/* XXX 2 bytes hole, try to pack */

	u32                        status;               /*   104     4 */

	/* size: 112, cachelines: 2, members: 17 */
	/* sum members: 100, holes: 2, sum holes: 8 */
	/* padding: 4 */
	/* last cacheline: 48 bytes */
} __attribute__((__aligned__(8)));


After:
=====
struct nvmefc_fcp_req {
	void *                     cmdaddr;              /*     0     8 */
	void *                     rspaddr;              /*     8     8 */
	dma_addr_t                 cmddma;               /*    16     8 */
	dma_addr_t                 rspdma;               /*    24     8 */
	u16                        cmdlen;               /*    32     2 */
	u16                        rsplen;               /*    34     2 */
	u32                        payload_length;       /*    36     4 */
	struct sg_table            sg_table;             /*    40    16 */
	struct scatterlist *       first_sgl;            /*    56     8 */
	/* --- cacheline 1 boundary (64 bytes) --- */
	int                        sg_cnt;               /*    64     4 */
	enum nvmefc_fcp_datadir    io_dir;               /*    68     4 */
	void                       (*done)(struct nvmefc_fcp_req *); /*    72     8 */
	void *                     private;              /*    80     8 */
	__le16                     sqid;                 /*    88     2 */
	u16                        rcv_rsplen;           /*    90     2 */
	u32                        transferred_length;   /*    92     4 */
	u32                        status;               /*    96     4 */

	/* size: 104, cachelines: 2, members: 17 */
	/* padding: 4 */
	/* last cacheline: 40 bytes */
} __attribute__((__aligned__(8)));
---
 include/linux/nvme-fc-driver.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/nvme-fc-driver.h b/include/linux/nvme-fc-driver.h
index fa092b9be2fd..4109f1bd6128 100644
--- a/include/linux/nvme-fc-driver.h
+++ b/include/linux/nvme-fc-driver.h
@@ -185,7 +185,6 @@ enum nvmefc_fcp_datadir {
  * @first_sgl: memory for 1st scatter/gather list segment for payload data
  * @sg_cnt:    number of elements in the scatter/gather list
  * @io_dir:    direction of the FCP request (see NVMEFC_FCP_xxx)
- * @sqid:      The nvme SQID the command is being issued on
  * @done:      The callback routine the LLDD is to invoke upon completion of
  *             the FCP operation. req argument is the pointer to the original
  *             FCP IO operation.
@@ -194,12 +193,13 @@ enum nvmefc_fcp_datadir {
  *             while processing the operation. The length of the buffer
  *             corresponds to the fcprqst_priv_sz value specified in the
  *             nvme_fc_port_template supplied by the LLDD.
+ * @sqid:      The nvme SQID the command is being issued on
  *
  * Values set by the LLDD indicating completion status of the FCP operation.
  * Must be set prior to calling the done() callback.
+ * @rcv_rsplen: length, in bytes, of the FCP RSP IU received.
  * @transferred_length: amount of payload data, in bytes, that were
  *             transferred. Should equal payload_length on success.
- * @rcv_rsplen: length, in bytes, of the FCP RSP IU received.
  * @status:    Completion status of the FCP operation. must be 0 upon success,
  *             negative errno value upon failure (ex: -EIO). Note: this is
  *             NOT a reflection of the NVME CQE completion status. Only the
@@ -219,14 +219,14 @@ struct nvmefc_fcp_req {
 	int			sg_cnt;
 	enum nvmefc_fcp_datadir	io_dir;
 
-	__le16			sqid;
-
 	void (*done)(struct nvmefc_fcp_req *req);
 
 	void			*private;
 
-	u32			transferred_length;
+	__le16			sqid;
+
 	u16			rcv_rsplen;
+	u32			transferred_length;
 	u32			status;
 } __aligned(sizeof(u64));	/* alignment for other things alloc'd with */
 
-- 
2.34.1


