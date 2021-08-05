Return-Path: <SRS0=eYGd=M4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 624C2C4338F
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Aug 2021 13:17:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2574E6103B
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Aug 2021 13:17:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2574E6103B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:References:MIME-Version:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ECgLlMhEZ0moxNhQCKXHhI7q0HUQQUe9IV6hv06tRW0=; b=ZUQbF5uZEKQddV
	rus1ydWBIdx1fy/rRSmtz4UhXFEQMPE9wKkqqdXqoeV3jcfnNezzmYEI1eBPtWjqo7pbNTx6mElMY
	+IqwbnjcvZ/dxgZ4nNw5gA/x9Rmwz0259B0pO95s4y6+kWi9KQOaQVyUNajbDJ4m17l1vUbg3XlQ3
	eQCcvbQ3+c7Lm/mlKRZwHcTbX+tMv5ThxtWmNJKV5sLrBCFrkrp+U0nQ7rFuHAPcQM31B2ItTYcHo
	gNaut8fLZc+Ltv5UFa+HpfQQQmeiWbFhEhvU28FbaHMt/ifynRweCXoNJARhw2t1A8zz0i0ee5a4E
	VVlaOwIlmAo4O1Ts3tqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mBdFN-009eCF-Gq; Thu, 05 Aug 2021 13:17:17 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mBdEQ-009dvV-RF
 for linux-nvme@lists.infradead.org; Thu, 05 Aug 2021 13:16:21 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20210805131616epoutp047d1bf3ff9334fad0f07adea9cf0586c4~Ya2wBlzov1803418034epoutp04Z
 for <linux-nvme@lists.infradead.org>; Thu,  5 Aug 2021 13:16:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20210805131616epoutp047d1bf3ff9334fad0f07adea9cf0586c4~Ya2wBlzov1803418034epoutp04Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1628169376;
 bh=Q+rT0yCB/2IZmMD9Tg4LavILsDGcYtWDoS4/AenPnDU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=K2cuikaSfmRQxfvswFSkT1sbvxyKyQ7hZP1Lj9GgYdMKLqXJxXPzpghAwYjsJ6sRz
 QhHEb1qkgU8xTrXaAtZ49Hxf4z6e9qitGUaoKOG8vTl2HrNbVFhLxlp7N5cfBqdws4
 IH1rMXmjy/436+cjKtigNTSp+VfDfTGXyRk0j0hw=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
 epcas5p4.samsung.com (KnoxPortal) with ESMTP id
 20210805131615epcas5p4d72ed90d3785b628fae9c2a01674afb3~Ya2vFKETC2580725807epcas5p4i;
 Thu,  5 Aug 2021 13:16:15 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.178]) by
 epsnrtp4.localdomain (Postfix) with ESMTP id 4GgTdP64Pjz4x9Pw; Thu,  5 Aug
 2021 13:16:09 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
 epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
 FE.EC.41701.994EB016; Thu,  5 Aug 2021 22:16:09 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
 20210805125934epcas5p4ff88e95d558ad9f65d77a888a4211b18~YaoKijKmz2461324613epcas5p4E;
 Thu,  5 Aug 2021 12:59:34 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20210805125934epsmtrp2bc558175f68e910f0801ae4b9096a0cf~YaoKh1QG_2066920669epsmtrp2-;
 Thu,  5 Aug 2021 12:59:34 +0000 (GMT)
X-AuditID: b6c32a4b-0c1ff7000001a2e5-b6-610be499a628
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
 8E.84.32548.6B0EB016; Thu,  5 Aug 2021 21:59:34 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20210805125932epsmtip1c7b2656578e60ba8d909a3cac01e02b4~YaoI9vMpg1080510805epsmtip1B;
 Thu,  5 Aug 2021 12:59:32 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 anuj20.g@samsung.com, javier.gonz@samsung.com, hare@suse.de, Kanchan Joshi
 <joshi.k@samsung.com>
Subject: [RFC PATCH 5/6] io_uring: add support for uring_cmd with fixed-buffer
Date: Thu,  5 Aug 2021 18:25:38 +0530
Message-Id: <20210805125539.66958-6-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210805125539.66958-1-joshi.k@samsung.com>
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMJsWRmVeSWpSXmKPExsWy7bCmhu7MJ9yJBj2ntCyaJvxltlh9t5/N
 Ys+iSUwWK1cfZbJ413qOxeLxnc/sFkf/v2WzmHToGqPF/GVP2S2uTFnE7MDlcflsqcemVZ1s
 HpuX1HvsvtnA5tG3ZRWjx+bT1R6fN8kFsEdl22SkJqakFimk5iXnp2TmpdsqeQfHO8ebmhkY
 6hpaWpgrKeQl5qbaKrn4BOi6ZeYAHaekUJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8usVVKLUjJ
 KTAp0CtOzC0uzUvXy0stsTI0MDAyBSpMyM64viqzYI9Exc81a1gbGK8LdzFycEgImEg0HLLq
 YuTiEBLYzShxcsICpi5GTiDnE6PEhV16EInPjBIHJixiB0mANFx4c5kNIrGLUWL34hOscFWn
 m38ygYxlE9CUuDC5FKRBRMBIYv+nk2A1zAKLGCW23v/NDFIjLBAgcbPdCaSGRUBV4uSVSWwg
 YV4BC4mL600hdslLzLz0HWwvp4ClxOdDe1lBbF4BQYmTM5+wgNjMQDXNW2czg4yXEOjlkHh8
 /CMTRLOLxPnX05ghbGGJV8e3QD0gJfH53V42CLtY4tedo1DNHYwS1xtmskAk7CUu7vkL9gsz
 0C/rd+lDhGUlpp5axwSxmE+i9/cTqF28EjvmwdiKEvcmPWWFsMUlHs5YAmV7SJy78pgJElY9
 jBJzn05gnMCoMAvJQ7OQPDQLYfUCRuZVjJKpBcW56anFpgXGeanl8ChOzs/dxAhOrVreOxgf
 Pfigd4iRiYPxEKMEB7OSCG/yYq5EId6UxMqq1KL8+KLSnNTiQ4ymwACfyCwlmpwPTO55JfGG
 JpYGJmZmZiaWxmaGSuK87PFfE4QE0hNLUrNTUwtSi2D6mDg4pRqYuFcXvn7bsFX7fanWqu/C
 1xO5BIwENiuEBj2eGb19m8vC595J/OW7g78+LRDYX3UlcmfEOcu53zf/eL7kqZ2ViOzr/7Wf
 D99MtGLgzc9/9ffRFl0L1fi4iC7+5OcbXth/yQ3bbuLtoiv+pkFjxaKt1wM2zN0Xr7WyzSMu
 4civf0/e3DTnretdZXKLT39C6/Glr2tajifsMQqq+2O25cv1wD8z3OtVgy033ZvOsivldu2d
 +lu3954unLBjbmpvdt614+odf7/sCMkrOB3YFrbwy9e0swdbzt+bXet+6aFXYvqyF+fb09Rc
 bxW3Py7bFpDfPKPLaNfaPXPvrJlsmVHdsej3ee5NmWIeovv2OH7aEqPEUpyRaKjFXFScCABM
 rxo3NgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFLMWRmVeSWpSXmKPExsWy7bCSnO62B9yJBlvvyVk0TfjLbLH6bj+b
 xZ5Fk5gsVq4+ymTxrvUci8XjO5/ZLY7+f8tmMenQNUaL+cuesltcmbKI2YHL4/LZUo9NqzrZ
 PDYvqffYfbOBzaNvyypGj82nqz0+b5ILYI/isklJzcksSy3St0vgyri+KrNgj0TFzzVrWBsY
 rwt3MXJySAiYSFx4c5mti5GLQ0hgB6PE/Ad3mSES4hLN136wQ9jCEiv/PWeHKPrIKPHu4WSg
 Ig4ONgFNiQuTS0FqRATMJJYeXsMCUsMssIJRYnffb0aQhLCAn8S0O+vZQGwWAVWJk1cmsYH0
 8gpYSFxcbwoxX15i5qXvYLs4BSwlPh/aywpSIgRUMnNrBEiYV0BQ4uTMJywgNjNQefPW2cwT
 GAVmIUnNQpJawMi0ilEytaA4Nz232LDAKC+1XK84Mbe4NC9dLzk/dxMjOPi1tHYw7ln1Qe8Q
 IxMH4yFGCQ5mJRHe5MVciUK8KYmVValF+fFFpTmpxYcYpTlYlMR5L3SdjBcSSE8sSc1OTS1I
 LYLJMnFwSjUwzeZruy3z4NLJBZ/C379kufVsY9PRKayPnm5em6AjY1GzN0rnZ/OZmBePntf8
 rjD+NXG74m5jg/nxcv+VilRrhLVLv18o+JH2n6v6Wm2MsVnBSrb/h/Ojdhhu26b4Q2pnxPmG
 oGr1p5dUBCZe9av926t1YRe/2tqXnb8E5Fc5977h+Z7olKv7Xlrr7o7FG3edt+P+VrMnSkNZ
 Yvv/+i2HIqoqzDh2Hr7z6QibmmX6ZNargRd4X3cntxvGzo2xyJyZPr9QqOWxSl4Jp+aDCVOV
 evUCLn/7OGN9bm9U1Uwnnck+Z+Z+cmJa8q7/uljjJFe5SJ/EJWmiwVpqczbb7FGzu62q+/7q
 ugKTGc86v75pU2Ipzkg01GIuKk4EAJ8VHu3tAgAA
X-CMS-MailID: 20210805125934epcas5p4ff88e95d558ad9f65d77a888a4211b18
X-Msg-Generator: CA
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210805125934epcas5p4ff88e95d558ad9f65d77a888a4211b18
References: <20210805125539.66958-1-joshi.k@samsung.com>
 <CGME20210805125934epcas5p4ff88e95d558ad9f65d77a888a4211b18@epcas5p4.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210805_061619_273077_17DFA122 
X-CRM114-Status: GOOD (  19.22  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Anuj Gupta <anuj20.g@samsung.com>

Add IORING_OP_URING_CMD_FIXED opcode that enables performing the
operation with previously registered buffers.

Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 fs/io_uring.c                 | 27 ++++++++++++++++++++++++++-
 include/uapi/linux/io_uring.h |  6 +++++-
 2 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 1f2263a78c8e..a80f4c98ea86 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -1060,6 +1060,10 @@ static const struct io_op_def io_op_defs[] = {
 		.needs_file		= 1,
 		.offsets		= 1,
 	},
+	[IORING_OP_URING_CMD_FIXED] = {
+		.needs_file		= 1,
+		.offsets		= 1,
+	},
 };
 
 static bool io_disarm_next(struct io_kiocb *req);
@@ -3602,7 +3606,12 @@ static int io_uring_cmd_prep(struct io_kiocb *req,
 	}
 
 	cmd->op = READ_ONCE(csqe->op);
-	cmd->len = READ_ONCE(csqe->len);
+	if (req->opcode == IORING_OP_URING_CMD_FIXED) {
+		req->imu = NULL;
+		io_req_set_rsrc_node(req);
+		req->buf_index = READ_ONCE(csqe->buf_index);
+	} else
+		cmd->len = READ_ONCE(csqe->len);
 
 	/*
 	 * The payload is the last 40 bytes of an io_uring_cmd_sqe, with the
@@ -3617,6 +3626,20 @@ static int io_uring_cmd(struct io_kiocb *req, unsigned int issue_flags)
 	struct file *file = req->file;
 	int ret;
 
+	if (req->opcode == IORING_OP_URING_CMD_FIXED) {
+		u32 index, buf_index = req->buf_index;
+		struct io_ring_ctx *ctx = req->ctx;
+		struct io_mapped_ubuf *imu = req->imu;
+
+		if (likely(!imu)) {
+			if (unlikely(buf_index >= ctx->nr_user_bufs))
+				return -EFAULT;
+			index = array_index_nospec(buf_index, ctx->nr_user_bufs);
+			imu = READ_ONCE(ctx->user_bufs[index]);
+			req->imu = imu;
+		}
+	}
+
 	ret = file->f_op->uring_cmd(&req->uring_cmd, issue_flags);
 	/* queued async, consumer will call io_uring_cmd_done() when complete */
 	if (ret == -EIOCBQUEUED)
@@ -6031,6 +6054,7 @@ static int io_req_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 	case IORING_OP_UNLINKAT:
 		return io_unlinkat_prep(req, sqe);
 	case IORING_OP_URING_CMD:
+	case IORING_OP_URING_CMD_FIXED:
 		return io_uring_cmd_prep(req, sqe);
 	}
 
@@ -6322,6 +6346,7 @@ static int io_issue_sqe(struct io_kiocb *req, unsigned int issue_flags)
 		ret = io_unlinkat(req, issue_flags);
 		break;
 	case IORING_OP_URING_CMD:
+	case IORING_OP_URING_CMD_FIXED:
 		ret = io_uring_cmd(req, issue_flags);
 		break;
 	default:
diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index 92565e17bfd9..1a10ebd4ca0a 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -75,7 +75,10 @@ struct io_uring_cmd_sqe {
 	__u64			user_data;
 	__u16			op;
 	__u16			personality;
-	__u32			len;
+	union {
+		__u32			len;
+		__u16			buf_index;
+	};
 	__u64			pdu[5];
 };
 
@@ -154,6 +157,7 @@ enum {
 	IORING_OP_RENAMEAT,
 	IORING_OP_UNLINKAT,
 	IORING_OP_URING_CMD,
+	IORING_OP_URING_CMD_FIXED,
 
 	/* this goes last, obviously */
 	IORING_OP_LAST,
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
