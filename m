Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DA11C25B08
	for <linux-nvme@archiver.kernel.org>; Sun,  7 Aug 2022 18:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZYYFfaS0RNTkCcJc/ZH77FA4ETZSamAKY1PfxlySMeM=; b=ffCN/3X5q9wAyXuZkrsk7cg73p
	uxf8/d6NWEA0ojMRxL9WvCnjrEEUY4ebOnyTbIaaQLIImsIBmLUpEB0+vxp6Y6CqU0b9mknlKt4CV
	P90pwUHgyPLVoWCEkhwHJCSzNRugPfnamxlqFnAVpr6I0IdkWsIEd+/ZlG0tBL5kpizdb3qubrL1x
	rAQEwHE59MRqdQa1AIkrPgn1EfdD3lBClrbh1kDMTRQZyfBGGB/Zd2vw94tw5Wi3Rge5Aw/p8aHZL
	NBB9mTQ/hcDgCcrt0uoFnhQ1DDaYu1uy+vb7wXBZNAqcqeUTdXTeS+5KL91cyyLAr+ICCaAlA1lJY
	PtJWuiZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oKlI7-001ROG-DO; Sun, 07 Aug 2022 18:46:23 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oKlHo-001RCR-Pf
	for linux-nvme@lists.infradead.org; Sun, 07 Aug 2022 18:46:06 +0000
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220807184558epoutp016f14bbeac631b1072b7259563e54e4bd~JJGYPTLSK0226902269epoutp01n
	for <linux-nvme@lists.infradead.org>; Sun,  7 Aug 2022 18:45:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220807184558epoutp016f14bbeac631b1072b7259563e54e4bd~JJGYPTLSK0226902269epoutp01n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1659897958;
	bh=ZYYFfaS0RNTkCcJc/ZH77FA4ETZSamAKY1PfxlySMeM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O/W2ioYF427vlSxF0K4QiYbuCriVeHQC0bhmOhrk8Ah2TBEGv6LAqCEYWUAICTP7M
	 kp2hYskMaUBcOoYycxozTZveWrsMFxvn41/dEJdusZGzZwBDA+qUfJMTUBn4klXAsK
	 dzExGU9e289Zks18oYOCKt9fcKkgJGO7SldM1hC0=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20220807184557epcas5p3d4342cd5e8cebb3c2446b2ae77628a24~JJGX0KLpg2250522505epcas5p3D;
	Sun,  7 Aug 2022 18:45:57 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.180]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4M17ZW4tdVz4x9Pt; Sun,  7 Aug
	2022 18:45:55 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	C2.EA.09639.36800F26; Mon,  8 Aug 2022 03:45:55 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20220807184555epcas5p4b7f5018c52d150150c32458fe3c21986~JJGVYxlpT2500925009epcas5p4G;
	Sun,  7 Aug 2022 18:45:55 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20220807184555epsmtrp1cb8e4d7b205ea346f05472292172790a~JJGVXsl273253032530epsmtrp1M;
	Sun,  7 Aug 2022 18:45:55 +0000 (GMT)
X-AuditID: b6c32a4b-e83ff700000025a7-84-62f00863e574
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	E3.35.08905.36800F26; Mon,  8 Aug 2022 03:45:55 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20220807184553epsmtip21359e35c8d27aac4c0e3d33d6b2b9644~JJGT-5q6L2084620846epsmtip2i;
	Sun,  7 Aug 2022 18:45:53 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: axboe@kernel.dk, hch@lst.de
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, ming.lei@redhat.com, gost.dev@samsung.com,
	Kanchan Joshi <joshi.k@samsung.com>, Anuj Gupta <anuj20.g@samsung.com>
Subject: [PATCH for-next v2 4/4] nvme: wire up async polling for io
 passthrough commands
Date: Mon,  8 Aug 2022 00:06:07 +0530
Message-Id: <20220807183607.352351-5-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220807183607.352351-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphk+LIzCtJLcpLzFFi42LZdlhTQzeZ40OSQdMJZYumCX+ZLVbf7Wez
	uHlgJ5PFytVHmSzetZ5jsTj6/y2bxd5b2hbzlz1ltzg0uZnJgdPj8tlSj81L6j1232xg83i/
	7yqbR9+WVYwenzfJBbBFZdtkpCampBYppOYl56dk5qXbKnkHxzvHm5oZGOoaWlqYKynkJeam
	2iq5+AToumXmAJ2kpFCWmFMKFApILC5W0rezKcovLUlVyMgvLrFVSi1IySkwKdArTswtLs1L
	18tLLbEyNDAwMgUqTMjOOLT6HFPBdJOKufuusjQwntbuYuTgkBAwkfhzm7OLkYtDSGA3o8SB
	X1dYIZxPjBI/ph1khnC+MUq0nekBynCCdWx71wpVtZdRYsPLtSwQzmdGiV37DrKAzGUT0JS4
	MLkUpEFEQF7iy22IGmaBC4wS93beBKsRFoiSOLkiEKSGRUBV4uKtbUwgNq+ApcTWCatZIJbJ
	S8y89J0dpJxTwEqia4syRImgxMmZT8BKmIFKmrfOBjtUQuAvu8Tvl4uhDnWRaP59jBnCFpZ4
	dXwLO4QtJfGyvw3KTpa4NPMcE4RdIvF4z0Eo216i9VQ/M8heZqBX1u/Sh9jFJ9H7+wkTJOR4
	JTrahCCqFSXuTXoKtVVc4uGMJawQJR4S9+7XQAKnl1Hi0L1O1gmM8rOQfDALyQezEJYtYGRe
	xSiZWlCcm55abFpgnJdaDo/V5PzcTYzgZKnlvYPx0YMPeocYmTgYDzFKcDArifAeWfs+SYg3
	JbGyKrUoP76oNCe1+BCjKTCEJzJLiSbnA9N1Xkm8oYmlgYmZmZmJpbGZoZI4r9fVTUlCAumJ
	JanZqakFqUUwfUwcnFINTPePHXqlLedjXvr0osKHc39+VPIIWR42Y7vqEhQns8fIbf3VW/rn
	SkvzNVXsL87+LGe/dEX14qX3U4t+M7y78OAa87n5wWH55x7GpWq9eSFwI+DA1SXfs7ZJxgWr
	6VSelRaq/Vt2Lcdx2j0h/ohoN6O8kuwuJZ1LqstyLjy3bI1ptuPft9C6dMFzdr6JlfnC/7qt
	k/ivOQofaSma+Ohmt06nuaNJhOhLybqihYanuSKbN01R1rwaarvaWHTj/H69PzdYitdwXn9p
	31FW3S6ydNbsiCN3/uQrmC3uVpn7a07TxNp/rKlbzifqfHO+p/FzvZfmrltqi6WNxTqFHpne
	7eha9nR7kbn9nJ+lD5NblFiKMxINtZiLihMBX+3JpR8EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrILMWRmVeSWpSXmKPExsWy7bCSvG4yx4ckg/WX+CyaJvxltlh9t5/N
	4uaBnUwWK1cfZbJ413qOxeLo/7dsFntvaVvMX/aU3eLQ5GYmB06Py2dLPTYvqffYfbOBzeP9
	vqtsHn1bVjF6fN4kF8AWxWWTkpqTWZZapG+XwJVxaPU5poLpJhVz911laWA8rd3FyMkhIWAi
	se1dK2sXIxeHkMBuRokz7zezQSTEJZqv/WCHsIUlVv57DmYLCXxklHi+SL2LkYODTUBT4sLk
	UpCwiICixMaPTYwgc5gFbjBK7OudwgSSEBaIkDi5YwsriM0ioCpx8dY2sDivgKXE1gmrWSDm
	y0vMvPSdHWQmp4CVRNcWZYhVlhJnL7QwQ5QLSpyc+QSsnBmovHnrbOYJjAKzkKRmIUktYGRa
	xSiZWlCcm55bbFhgmJdarlecmFtcmpeul5yfu4kRHOpamjsYt6/6oHeIkYmD8RCjBAezkgjv
	kbXvk4R4UxIrq1KL8uOLSnNSiw8xSnOwKInzXug6GS8kkJ5YkpqdmlqQWgSTZeLglGpgKmyp
	K3OQlmPafijugnlJKZNMy/azTDcPmR8Q/mUteo5lyvUVP7U0NjHfXsq9bm/K5eq1bfypvP9l
	dN5oOa3Yam35+LfVvPSylfLCKyTWPrpzQnSb6oWmrJ15c95qh30NKf9/uyWuaMYc5svac39n
	yN02uM+k2HBtyfRTta5vfz1g5zc9sGNZaOrFi7/d9zEeW8a4/NiRf+wtk5TSH4XPyjs3Ly6K
	+VBECc90jskJ0xV3lV0IPPVNT1Zs/oV/frMsGk9UvC+a9fjfxpTXrcaL/tdrijjEphSIJJ+/
	WM7W91usimWBuNVq39PHP3O1nkpU+v+15N1uhxOTZ+8qcFxnpKBYxnvKMNR0j64fh+3uHCWW
	4oxEQy3mouJEAB/EOp/kAgAA
X-CMS-MailID: 20220807184555epcas5p4b7f5018c52d150150c32458fe3c21986
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220807184555epcas5p4b7f5018c52d150150c32458fe3c21986
References: <20220807183607.352351-1-joshi.k@samsung.com>
	<CGME20220807184555epcas5p4b7f5018c52d150150c32458fe3c21986@epcas5p4.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220807_114605_196339_0F1F6D42 
X-CRM114-Status: GOOD (  26.41  )
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

Store a cookie during submission, and use that to implement
completion-polling inside the ->uring_cmd_iopoll handler.
This handler makes use of existing bio poll facility.

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
---
 drivers/nvme/host/core.c      |  1 +
 drivers/nvme/host/ioctl.c     | 73 ++++++++++++++++++++++++++++++++---
 drivers/nvme/host/multipath.c |  1 +
 drivers/nvme/host/nvme.h      |  2 +
 4 files changed, 72 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 2429b11eb9a8..77b6c2882afd 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3976,6 +3976,7 @@ static const struct file_operations nvme_ns_chr_fops = {
 	.unlocked_ioctl	= nvme_ns_chr_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
 	.uring_cmd	= nvme_ns_chr_uring_cmd,
+	.uring_cmd_iopoll = nvme_ns_chr_uring_cmd_iopoll,
 };
 
 static int nvme_add_ns_cdev(struct nvme_ns *ns)
diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 27614bee7380..7756b439a688 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -391,11 +391,19 @@ static void nvme_uring_cmd_end_io(struct request *req, blk_status_t err)
 	struct nvme_uring_cmd_pdu *pdu = nvme_uring_cmd_pdu(ioucmd);
 	/* extract bio before reusing the same field for request */
 	struct bio *bio = pdu->bio;
+	void *cookie = READ_ONCE(ioucmd->cookie);
 
 	pdu->req = req;
 	req->bio = bio;
-	/* this takes care of moving rest of completion-work to task context */
-	io_uring_cmd_complete_in_task(ioucmd, nvme_uring_task_cb);
+
+	/*
+	 * For iopoll, complete it directly.
+	 * Otherwise, move the completion to task work.
+	 */
+	if (cookie != NULL && blk_rq_is_poll(req))
+		nvme_uring_task_cb(ioucmd);
+	else
+		io_uring_cmd_complete_in_task(ioucmd, nvme_uring_task_cb);
 }
 
 static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
@@ -445,7 +453,10 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 		rq_flags = REQ_NOWAIT;
 		blk_flags = BLK_MQ_REQ_NOWAIT;
 	}
+	if (issue_flags & IO_URING_F_IOPOLL)
+		rq_flags |= REQ_POLLED;
 
+retry:
 	req = nvme_alloc_user_request(q, &c, nvme_to_user_ptr(d.addr),
 			d.data_len, nvme_to_user_ptr(d.metadata),
 			d.metadata_len, 0, &meta, d.timeout_ms ?
@@ -456,6 +467,17 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	req->end_io = nvme_uring_cmd_end_io;
 	req->end_io_data = ioucmd;
 
+	if (issue_flags & IO_URING_F_IOPOLL && rq_flags & REQ_POLLED) {
+		if (unlikely(!req->bio)) {
+			/* we can't poll this, so alloc regular req instead */
+			blk_mq_free_request(req);
+			rq_flags &= ~REQ_POLLED;
+			goto retry;
+		} else {
+			WRITE_ONCE(ioucmd->cookie, req->bio);
+			req->bio->bi_opf |= REQ_POLLED;
+		}
+	}
 	/* to free bio on completion, as req->bio will be null at that time */
 	pdu->bio = req->bio;
 	pdu->meta = meta;
@@ -559,9 +581,6 @@ long nvme_ns_chr_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 
 static int nvme_uring_cmd_checks(unsigned int issue_flags)
 {
-	/* IOPOLL not supported yet */
-	if (issue_flags & IO_URING_F_IOPOLL)
-		return -EOPNOTSUPP;
 
 	/* NVMe passthrough requires big SQE/CQE support */
 	if ((issue_flags & (IO_URING_F_SQE128|IO_URING_F_CQE32)) !=
@@ -604,6 +623,23 @@ int nvme_ns_chr_uring_cmd(struct io_uring_cmd *ioucmd, unsigned int issue_flags)
 	return nvme_ns_uring_cmd(ns, ioucmd, issue_flags);
 }
 
+int nvme_ns_chr_uring_cmd_iopoll(struct io_uring_cmd *ioucmd)
+{
+	struct bio *bio;
+	int ret = 0;
+	struct nvme_ns *ns;
+	struct request_queue *q;
+
+	rcu_read_lock();
+	bio = READ_ONCE(ioucmd->cookie);
+	ns = container_of(file_inode(ioucmd->file)->i_cdev,
+			struct nvme_ns, cdev);
+	q = ns->queue;
+	if (test_bit(QUEUE_FLAG_POLL, &q->queue_flags) && bio && bio->bi_bdev)
+		ret = bio_poll(bio, NULL, 0);
+	rcu_read_unlock();
+	return ret;
+}
 #ifdef CONFIG_NVME_MULTIPATH
 static int nvme_ns_head_ctrl_ioctl(struct nvme_ns *ns, unsigned int cmd,
 		void __user *argp, struct nvme_ns_head *head, int srcu_idx)
@@ -685,6 +721,29 @@ int nvme_ns_head_chr_uring_cmd(struct io_uring_cmd *ioucmd,
 	srcu_read_unlock(&head->srcu, srcu_idx);
 	return ret;
 }
+
+int nvme_ns_head_chr_uring_cmd_iopoll(struct io_uring_cmd *ioucmd)
+{
+	struct cdev *cdev = file_inode(ioucmd->file)->i_cdev;
+	struct nvme_ns_head *head = container_of(cdev, struct nvme_ns_head, cdev);
+	int srcu_idx = srcu_read_lock(&head->srcu);
+	struct nvme_ns *ns = nvme_find_path(head);
+	struct bio *bio;
+	int ret = 0;
+	struct request_queue *q;
+
+	if (ns) {
+		rcu_read_lock();
+		bio = READ_ONCE(ioucmd->cookie);
+		q = ns->queue;
+		if (test_bit(QUEUE_FLAG_POLL, &q->queue_flags) && bio
+				&& bio->bi_bdev)
+			ret = bio_poll(bio, NULL, 0);
+		rcu_read_unlock();
+	}
+	srcu_read_unlock(&head->srcu, srcu_idx);
+	return ret;
+}
 #endif /* CONFIG_NVME_MULTIPATH */
 
 int nvme_dev_uring_cmd(struct io_uring_cmd *ioucmd, unsigned int issue_flags)
@@ -692,6 +751,10 @@ int nvme_dev_uring_cmd(struct io_uring_cmd *ioucmd, unsigned int issue_flags)
 	struct nvme_ctrl *ctrl = ioucmd->file->private_data;
 	int ret;
 
+	/* IOPOLL not supported yet */
+	if (issue_flags & IO_URING_F_IOPOLL)
+		return -EOPNOTSUPP;
+
 	ret = nvme_uring_cmd_checks(issue_flags);
 	if (ret)
 		return ret;
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 6ef497c75a16..00f2f81e20fa 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -439,6 +439,7 @@ static const struct file_operations nvme_ns_head_chr_fops = {
 	.unlocked_ioctl	= nvme_ns_head_chr_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
 	.uring_cmd	= nvme_ns_head_chr_uring_cmd,
+	.uring_cmd_iopoll = nvme_ns_head_chr_uring_cmd_iopoll,
 };
 
 static int nvme_add_ns_head_cdev(struct nvme_ns_head *head)
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index bdc0ff7ed9ab..3f2d3dda6e6c 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -821,6 +821,8 @@ long nvme_ns_head_chr_ioctl(struct file *file, unsigned int cmd,
 		unsigned long arg);
 long nvme_dev_ioctl(struct file *file, unsigned int cmd,
 		unsigned long arg);
+int nvme_ns_chr_uring_cmd_iopoll(struct io_uring_cmd *ioucmd);
+int nvme_ns_head_chr_uring_cmd_iopoll(struct io_uring_cmd *ioucmd);
 int nvme_ns_chr_uring_cmd(struct io_uring_cmd *ioucmd,
 		unsigned int issue_flags);
 int nvme_ns_head_chr_uring_cmd(struct io_uring_cmd *ioucmd,
-- 
2.25.1


