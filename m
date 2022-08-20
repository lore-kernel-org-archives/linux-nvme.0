Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06AB4C28D13
	for <linux-nvme@archiver.kernel.org>; Sat, 20 Aug 2022 03:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jbua48Q58XlA+8adVklDtQ//CCw/sQv/vde37Fg5XWU=; b=TmprqWdrHgAlt7DNvJX9hdfPmi
	0g4toJA0K4Tbk4kjKM3Z0D4DmkMJ5eM+fPBBExQcC3Qmsa6bYT76BQqnuwPnSFBowjtWPP7YOJL9w
	k9QLlRNssuhupP1/LPi1gRGLTAGNBiyjfivgceGHfbe+rL2l4COvfZMLHjdSeAHQpkFzgwii4V7Dt
	YuPSBC5ZElfq9ug63Q3x2RdrBvhDI0pdFd/D0Uy54ndXZlcE2FyXTzIKHguxrTg2RL8J5Y0O4z6nq
	2dRQW1o6lTCS7hFtKW/1TA52IEonD612caR1m1j9azfrv2osF5+cYpZ6N0fTnyKi+BdapD+melQ2X
	S/NzRIRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oPEzP-00Fv2V-Ep; Sat, 20 Aug 2022 03:17:35 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oPEz7-00Fuo3-Ml
	for linux-nvme@lists.infradead.org; Sat, 20 Aug 2022 03:17:19 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220820031711epoutp0185e9e99b000fd0235b85eb4a673cb808~M70Jk5bxj0777707777epoutp01N
	for <linux-nvme@lists.infradead.org>; Sat, 20 Aug 2022 03:17:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220820031711epoutp0185e9e99b000fd0235b85eb4a673cb808~M70Jk5bxj0777707777epoutp01N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1660965431;
	bh=jbua48Q58XlA+8adVklDtQ//CCw/sQv/vde37Fg5XWU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t2/W38xSDsP9bmY01cmZrCnqsSJyoDbkUl7skAy6izMT1/9w+e9t9ZZCjROD/gM2G
	 TV8Kfft+AcPBQ7wDRyH1YXDIGWHxfNWTNCv8UfbUv712w1gy3/R5pbS4gI881SzRtq
	 iXLq/8VzkOw9UgjMjsCuvINHZgM0LG1VxqXciLK4=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20220820031710epcas5p2b87a0fae979156f5f73060e20adce614~M70I0qhlh1302613026epcas5p2E;
	Sat, 20 Aug 2022 03:17:10 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.181]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4M8kLq6XHmz4x9Pp; Sat, 20 Aug
	2022 03:17:07 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	34.E8.49477.33250036; Sat, 20 Aug 2022 12:17:07 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20220820031707epcas5p23d980aff14b0d3bd258b9fb8735b4a40~M70GQPKP22786427864epcas5p2F;
	Sat, 20 Aug 2022 03:17:07 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20220820031707epsmtrp10ff416e670fc72110cc7aa5ae87bea41~M70GPdbrL2284922849epsmtrp1p;
	Sat, 20 Aug 2022 03:17:07 +0000 (GMT)
X-AuditID: b6c32a49-843ff7000000c145-e4-6300523305a4
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	97.39.08905.33250036; Sat, 20 Aug 2022 12:17:07 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20220820031705epsmtip1cdb60272d88c3020f4c040371d8b7011~M70E0wkOC1516815168epsmtip1V;
	Sat, 20 Aug 2022 03:17:05 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, ming.lei@redhat.com, gost.dev@samsung.com, Anuj
	Gupta <anuj20.g@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>
Subject: [PATCH for-next v2 2/4] io_uring: introduce fixed buffer support
 for io_uring_cmd
Date: Sat, 20 Aug 2022 08:36:18 +0530
Message-Id: <20220820030620.59003-3-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220820030620.59003-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOJsWRmVeSWpSXmKPExsWy7bCmhq5xEEOywfcWU4umCX+ZLVbf7Wez
	uHlgJ5PFytVHmSzetZ5jsTj6/y2bxaRD1xgt9t7Stpi/7Cm7xaHJzUwOXB6Xz5Z6bFrVyeax
	eUm9x+6bDWwe7/ddZfPo27KK0ePzJrkA9qhsm4zUxJTUIoXUvOT8lMy8dFsl7+B453hTMwND
	XUNLC3MlhbzE3FRbJRefAF23zByg45QUyhJzSoFCAYnFxUr6djZF+aUlqQoZ+cUltkqpBSk5
	BSYFesWJucWleel6eaklVoYGBkamQIUJ2RnfTnWxFJxSr/j/sIe5gfGwQhcjJ4eEgIlEz9Ob
	rCC2kMBuRomTj4HiXED2J0aJvpnTWCGcb4wSG7/9ZoHpeLuzjQ0isZdR4tmBn+wQ7Z8ZJXbP
	Fuli5OBgE9CUuDC5FCQsImAksf/TSbBBzAIXgDY0fWUGSQgLxEjMWAFic3CwCKhK3HouAhLm
	FbCQOPT3PRvELnmJmZe+g43nFLCUaFr+mxGiRlDi5MwnYPcwA9U0b53NDDJfQqCTQ2LuxWNQ
	zS4Sr2YvYoSwhSVeHd/CDmFLSbzsb4OykyUuzTzHBGGXSDzecxDKtpdoPdUPdhsz0C/rd+lD
	7OKT6P39hAkkLCHAK9HRJgRRrShxb9JTVghbXOLhjCVQtofEz9YLjJCg6mGUuLG9l2UCo/ws
	JC/MQvLCLIRtCxiZVzFKphYU56anFpsWGOallsOjNTk/dxMjOIVqee5gvPvgg94hRiYOxkOM
	EhzMSiK8N+78SRLiTUmsrEotyo8vKs1JLT7EaAoM4onMUqLJ+cAknlcSb2hiaWBiZmZmYmls
	Zqgkzut1dVOSkEB6YklqdmpqQWoRTB8TB6dUAxO/b+BiSfMfEjo89zwF+dcnBSjsWXD7Ttb5
	Ha9vXWJXq7NU/jiXaVqt0JISE4WNmqarT72LkNq11Xp2Xb/qFAm7M9eN77Ty6sUo6K8NnrTk
	kYdYb3Bi02yPmbMabQJvnfIt8dm4d/2Uax+zt09cxnfKQXt219esy3rbuhtPNybsTN/wP0ZP
	+kRH2wUP9odaFY801n6UnVaznMs/88J/p/zw949nLcwN/tH6MHNp/YQV6mUxX/6EPdYt63ig
	qCB3jKN0Z1/XlqSIxo0LK559vHluudnivsZYD+HAnr+ZFm1zHH5vXmEwwdX34W/54J97Ba3q
	qvJOyLb+fSKtLiG9bVe1+/+UtzvM178301lpfkyJpTgj0VCLuag4EQB7PphwKgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNLMWRmVeSWpSXmKPExsWy7bCSnK5xEEOywcGH4hZNE/4yW6y+289m
	cfPATiaLlauPMlm8az3HYnH0/1s2i0mHrjFa7L2lbTF/2VN2i0OTm5kcuDwuny312LSqk81j
	85J6j903G9g83u+7yubRt2UVo8fnTXIB7FFcNimpOZllqUX6dglcGd9OdbEUnFKv+P+wh7mB
	8bBCFyMnh4SAicTbnW1sXYxcHEICuxklZrddYYVIiEs0X/vBDmELS6z895wdougjo0Tjsl9A
	RRwcbAKaEhcml4LUiAiYSSw9vIYFxGYWuMEosW1CPogtLBAlseLILhaQchYBVYlbz0VAwrwC
	FhKH/r5ngxgvLzHz0newVZwClhJNy38zgthCQDXPZ79gg6gXlDg58wnUeHmJ5q2zmScwCsxC
	kpqFJLWAkWkVo2RqQXFuem6xYYFhXmq5XnFibnFpXrpecn7uJkZw+Gtp7mDcvuqD3iFGJg7G
	Q4wSHMxKIrw37vxJEuJNSaysSi3Kjy8qzUktPsQozcGiJM57oetkvJBAemJJanZqakFqEUyW
	iYNTqoEpI3o6s9zDFzvdUmpjS2e58r3PVQ5Kc/wwOc2g6k6xXuVjvof7w9bsFuZgvdf/5Irh
	wZtb/r2tv3ojI+T7mdz2hfekv7xonOvZ/DfrxoOFzPqcbdoh82+2K/ycdCpgbmPmlUsfba+k
	85x0Eilu/3Lc75mqeDlvguNTvTlmG/wNJRPE9mVM3x28cUMGk94Rt/ylvVNuHpD+pS7B1qX/
	/9KhrNernk38235a99rC7ZNO5+08u2ZKg3reeb7Puy8yvQ+P1dg5h+ulqkRml4i7h7TRQX0P
	s8faP3N1mfl8gw+z7ZN7GXl8TeW1crHjGzt8jQ+tDwpWcExQL3+TNy9nTs7FZb43jpux+gq0
	TnKKXv1UiaU4I9FQi7moOBEASOVSre4CAAA=
X-CMS-MailID: 20220820031707epcas5p23d980aff14b0d3bd258b9fb8735b4a40
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220820031707epcas5p23d980aff14b0d3bd258b9fb8735b4a40
References: <20220820030620.59003-1-joshi.k@samsung.com>
	<CGME20220820031707epcas5p23d980aff14b0d3bd258b9fb8735b4a40@epcas5p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220819_201718_097523_3BAABD97 
X-CRM114-Status: GOOD (  22.34  )
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

From: Anuj Gupta <anuj20.g@samsung.com>

Add IORING_OP_URING_CMD_FIXED opcode that enables sending io_uring
command with previously registered buffers. User-space passes the buffer
index in sqe->buf_index, same as done in read/write variants that uses
fixed buffers.

Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 include/linux/io_uring.h      |  5 ++++-
 include/uapi/linux/io_uring.h |  1 +
 io_uring/opdef.c              | 10 ++++++++++
 io_uring/rw.c                 |  3 ++-
 io_uring/uring_cmd.c          | 18 +++++++++++++++++-
 5 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/include/linux/io_uring.h b/include/linux/io_uring.h
index 60aba10468fc..40961d7c3827 100644
--- a/include/linux/io_uring.h
+++ b/include/linux/io_uring.h
@@ -5,6 +5,8 @@
 #include <linux/sched.h>
 #include <linux/xarray.h>
 
+#include<uapi/linux/io_uring.h>
+
 enum io_uring_cmd_flags {
 	IO_URING_F_COMPLETE_DEFER	= 1,
 	IO_URING_F_UNLOCKED		= 2,
@@ -15,6 +17,7 @@ enum io_uring_cmd_flags {
 	IO_URING_F_SQE128		= 4,
 	IO_URING_F_CQE32		= 8,
 	IO_URING_F_IOPOLL		= 16,
+	IO_URING_F_FIXEDBUFS		= 32,
 };
 
 struct io_uring_cmd {
@@ -33,7 +36,7 @@ struct io_uring_cmd {
 
 #if defined(CONFIG_IO_URING)
 int io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
-		struct iov_iter *iter, void *ioucmd)
+		struct iov_iter *iter, void *ioucmd);
 void io_uring_cmd_done(struct io_uring_cmd *cmd, ssize_t ret, ssize_t res2);
 void io_uring_cmd_complete_in_task(struct io_uring_cmd *ioucmd,
 			void (*task_work_cb)(struct io_uring_cmd *));
diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index 1463cfecb56b..80ea35d1ed5c 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -203,6 +203,7 @@ enum io_uring_op {
 	IORING_OP_SOCKET,
 	IORING_OP_URING_CMD,
 	IORING_OP_SENDZC_NOTIF,
+	IORING_OP_URING_CMD_FIXED,
 
 	/* this goes last, obviously */
 	IORING_OP_LAST,
diff --git a/io_uring/opdef.c b/io_uring/opdef.c
index 9a0df19306fe..7d5731b84c92 100644
--- a/io_uring/opdef.c
+++ b/io_uring/opdef.c
@@ -472,6 +472,16 @@ const struct io_op_def io_op_defs[] = {
 		.issue			= io_uring_cmd,
 		.prep_async		= io_uring_cmd_prep_async,
 	},
+	[IORING_OP_URING_CMD_FIXED] = {
+		.needs_file		= 1,
+		.plug			= 1,
+		.name			= "URING_CMD_FIXED",
+		.iopoll			= 1,
+		.async_size		= uring_cmd_pdu_size(1),
+		.prep			= io_uring_cmd_prep,
+		.issue			= io_uring_cmd,
+		.prep_async		= io_uring_cmd_prep_async,
+	},
 	[IORING_OP_SENDZC_NOTIF] = {
 		.name			= "SENDZC_NOTIF",
 		.needs_file		= 1,
diff --git a/io_uring/rw.c b/io_uring/rw.c
index 1a4fb8a44b9a..3c7b94bffa62 100644
--- a/io_uring/rw.c
+++ b/io_uring/rw.c
@@ -1005,7 +1005,8 @@ int io_do_iopoll(struct io_ring_ctx *ctx, bool force_nonspin)
 		if (READ_ONCE(req->iopoll_completed))
 			break;
 
-		if (req->opcode == IORING_OP_URING_CMD) {
+		if (req->opcode == IORING_OP_URING_CMD ||
+				req->opcode == IORING_OP_URING_CMD_FIXED) {
 			struct io_uring_cmd *ioucmd = (struct io_uring_cmd *)rw;
 
 			ret = req->file->f_op->uring_cmd_iopoll(ioucmd);
diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
index ff65cc8ab6cc..9383150b2949 100644
--- a/io_uring/uring_cmd.c
+++ b/io_uring/uring_cmd.c
@@ -3,11 +3,13 @@
 #include <linux/errno.h>
 #include <linux/file.h>
 #include <linux/io_uring.h>
+#include <linux/nospec.h>
 
 #include <uapi/linux/io_uring.h>
 
 #include "io_uring.h"
 #include "uring_cmd.h"
+#include "rsrc.h"
 
 static void io_uring_cmd_work(struct io_kiocb *req, bool *locked)
 {
@@ -74,6 +76,18 @@ int io_uring_cmd_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 
 	if (sqe->rw_flags || sqe->__pad1)
 		return -EINVAL;
+
+	req->buf_index = READ_ONCE(sqe->buf_index);
+	if (req->opcode == IORING_OP_URING_CMD_FIXED) {
+		struct io_ring_ctx *ctx = req->ctx;
+		u16 index;
+
+		if (unlikely(req->buf_index >= ctx->nr_user_bufs))
+			return -EFAULT;
+		index = array_index_nospec(req->buf_index, ctx->nr_user_bufs);
+		req->imu = ctx->user_bufs[index];
+		io_req_set_rsrc_node(req, ctx, 0);
+	}
 	ioucmd->cmd = sqe->cmd;
 	ioucmd->cmd_op = READ_ONCE(sqe->cmd_op);
 	return 0;
@@ -98,6 +112,8 @@ int io_uring_cmd(struct io_kiocb *req, unsigned int issue_flags)
 		req->iopoll_completed = 0;
 		WRITE_ONCE(ioucmd->cookie, NULL);
 	}
+	if (req->opcode == IORING_OP_URING_CMD_FIXED)
+		issue_flags |= IO_URING_F_FIXEDBUFS;
 
 	if (req_has_async_data(req))
 		ioucmd->cmd = req->async_data;
@@ -125,7 +141,7 @@ int io_uring_cmd(struct io_kiocb *req, unsigned int issue_flags)
 int io_uring_cmd_import_fixed(u64 ubuf, unsigned long len,
 		int rw, struct iov_iter *iter, void *ioucmd)
 {
-	struct io_kiocb *req = container_of(ioucmd, struct io_kiocb, uring_cmd);
+	struct io_kiocb *req = cmd_to_io_kiocb(ioucmd);
 	struct io_mapped_ubuf *imu = req->imu;
 
 	return io_import_fixed(rw, iter, imu, ubuf, len);
-- 
2.25.1


