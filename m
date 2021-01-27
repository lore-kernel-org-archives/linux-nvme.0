Return-Path: <SRS0=3Lap=G6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7106BC433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Jan 2021 15:14:09 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CED9C20771
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Jan 2021 15:14:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CED9C20771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:MIME-Version:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=9ilwDVqt7vbNkBgsVeaTw4c0zL9N7sj6esyNPgMqRcU=; b=d0nZXfxsTQU+InKHJQKePjD2B
	MF4rYfhLwMauX48HcExFdDxinzawrfel36IejgbpxF8AsIDLjQrsnf1+ZSgQxByT1ix4VsEHJ6bZW
	zTkWWodXyRinZxNkzJaxBBoXFmT/5Y28Tb8Bbaf65GfhPU3QV6JHl2wkbv7g4DIwl0KDthWuTepV3
	aIoZH2cwlfwQpO0YrlYVQ1Lj+25d+oxC4o6ja8GqZgCqOZt0V9MC29icQVXBIa3EloC/zsojzBFnR
	pfFthQrac+ivRHiy5TtdWPKvQzjZP3MBiDxJfPiQeFgnKYwEc1DH7/M+pzuxdo/70xWgTVlAm9+ia
	ylMHpGRZw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l4mVb-0003hG-P1; Wed, 27 Jan 2021 15:13:27 +0000
Received: from casper.infradead.org ([90.155.50.34])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l4mVY-0003It-Bq
 for linux-nvme@merlin.infradead.org; Wed, 27 Jan 2021 15:13:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=References:Content-Type:
 Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
 :To:From:Sender:Reply-To:Content-ID:Content-Description;
 bh=0gfCy33qDEILaikTsVpNdHgQG//hPVXr1zKS9lJ2+lM=; b=e7NjPYQGE2nX+GvMJKW0QaKQ4t
 8O4yrNbt1c6w+0DKjP4UHE6SCUIQY1M1xtmp+BfeT0OsVimHLnms3dchuSQ0YKMPTYdEWC3tyS/Es
 ICWl2DcNx4uwrwIMjPCaB3QAgbVclw+a61vgkcRPYAz0WAmhPCAIouCloUd06INQ6fXO/5cpL1QkZ
 BNkd8ydIFaoA6uZ1/cf5WrWddrMWaNXO9rNv6IPaJMaxY49F7Rr7pZ8Ffftw9l9rN7wmOt5fZ0xcU
 TOcDBJS8ko5+UX03t1KFH9LkszrZ3GV5emBZFVGY8M0qYQbpx6YXM9cCf0LfvvmoxTOU4PiH1Ocvv
 1rBOTJ/w==;
Received: from mailout3.samsung.com ([203.254.224.33])
 by casper.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1l4mKZ-0079KB-Jl
 for linux-nvme@lists.infradead.org; Wed, 27 Jan 2021 15:02:25 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20210127150158epoutp0388aaa3d8359412e90f86850ca981a529~eHuyWsJM51776217762epoutp03g
 for <linux-nvme@lists.infradead.org>; Wed, 27 Jan 2021 15:01:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20210127150158epoutp0388aaa3d8359412e90f86850ca981a529~eHuyWsJM51776217762epoutp03g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1611759718;
 bh=0gfCy33qDEILaikTsVpNdHgQG//hPVXr1zKS9lJ2+lM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=mH3qrHltsUXxctt9TuMsM42UN+wXnA+9h/qL/yHikvzkhnL8V1kcqPIVDuj5dyP6A
 eBZWhJ9k+Zi337tyFFCAaUzoZImI8AdOWvPCjJfD0/csvbTNM7y5TWM0dOZFCep+hV
 bbyTrDaa++//c9unV1fThbvSRMamih5MLNBAPfig=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
 epcas5p1.samsung.com (KnoxPortal) with ESMTP id
 20210127150157epcas5p10c74d59d5147c8ae69cd52d0ca1af048~eHux-ULYP1681116811epcas5p1h;
 Wed, 27 Jan 2021 15:01:57 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
 epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 4A.33.15682.56081106; Thu, 28 Jan 2021 00:01:57 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
 20210127150156epcas5p26cdf368e4ff6bffb132fa1c7f9430653~eHuxC96l12309923099epcas5p2V;
 Wed, 27 Jan 2021 15:01:56 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20210127150156epsmtrp2b3e6a2ea496e87079ef8aae2d23b59fb~eHuxCMdYZ0982109821epsmtrp29;
 Wed, 27 Jan 2021 15:01:56 +0000 (GMT)
X-AuditID: b6c32a49-8bfff70000013d42-f3-60118065e8c6
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 A7.25.13470.46081106; Thu, 28 Jan 2021 00:01:56 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
 epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20210127150154epsmtip236c48b897466958e02c98eba663efa3d~eHuu2rr2J1918419184epsmtip25;
 Wed, 27 Jan 2021 15:01:54 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me
Subject: [RFC PATCH 4/4] io_uring: add async passthrough ioctl support
Date: Wed, 27 Jan 2021 20:30:29 +0530
Message-Id: <20210127150029.13766-5-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210127150029.13766-1-joshi.k@samsung.com>
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFKsWRmVeSWpSXmKPExsWy7bCmpm5qg2CCwaU2dYvf06ewWjRN+Mts
 sfpuP5vFytVHmSzetZ5jsXh85zO7xdH/b9ksJh26xmixZ+9JFovLu+awWcxf9pTdYtvv+cwW
 V6YsYrZY9/o9i8XrHyfZHPg9zt/byOJx+Wypx6ZVnWwem5fUe+y+2cDm0bdlFaPH501yAexR
 XDYpqTmZZalF+nYJXBlfZs9jKtisXrFw0T3mBsZD8l2MnBwSAiYSjb0n2LsYuTiEBHYzSkz7
 18wK4XxilPi3diczhPONUeLugutsMC2/n26HSuxllOjo64JyPjNKdF1Zw9TFyMHBJqApcWFy
 KUiDiICLxIXfB8B2MAtMZJL49qKXCSQhLOAmcX/ucrCpLAKqEofWX2YHsXkFLCROrG9hgtgm
 LzHz0newOKeApcSVbZtYIWoEJU7OfMICYjMD1TRvnQ12hITAFg6Jq4f+skM0u0ic/fwaapCw
 xKvjW6DiUhKf3+2FeqdY4tedo1DNHYwS1xtmskAk7CUu7vkL9g0z0Dfrd+lDLOOT6P39BCws
 IcAr0dEmBFGtKHFv0lNWCFtc4uGMJVC2h0TPu7XQAO4Bhum+nSwTGOVnIflhFpIfZiFsW8DI
 vIpRMrWgODc9tdi0wDAvtVyvODG3uDQvXS85P3cTIzh5aXnuYLz74IPeIUYmDsZDjBIczEoi
 vHYKgglCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeXcYPIgXEkhPLEnNTk0tSC2CyTJxcEo1MM3Y
 Pm250c5jq7SkPXIYWBdz9M5ilcjmkuTaYF7L/qOKV3+HXuycvPdznrVZ9Xly3Vr1bE4Z939l
 wcIrKy+cMX5Qtyay/PQu78VVix0c8kUXbti19lp8jKmhzgEVw/6UN6EpD95EntI3lW06W9Ej
 Wnl42tk9ls2S8hN5K5xMF4rXLnj9tahaJYmVN/XjvLnrf86sVk9W1tKMmcTu17dql3GdChs7
 d+WtTa+zHxw8esjsjJi+U3CN3CEdPa/M9HfhdXpyk+1UDFTkyxKt1s96eGl/6L//zLvOR7S9
 eDr9eFTrlHi5qnuWRpqzp83f+HFPsgjv27+3lYs2Gdz7YjGP9cfiOmvZyvkXF+f7rWpXVWIp
 zkg01GIuKk4EAJ8ENC3NAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKLMWRmVeSWpSXmKPExsWy7bCSvG5Kg2CCwfrPyha/p09htWia8JfZ
 YvXdfjaLlauPMlm8az3HYvH4zmd2i6P/37JZTDp0jdFiz96TLBaXd81hs5i/7Cm7xbbf85kt
 rkxZxGyx7vV7FovXP06yOfB7nL+3kcXj8tlSj02rOtk8Ni+p99h9s4HNo2/LKkaPz5vkAtij
 uGxSUnMyy1KL9O0SuDK+zJ7HVLBZvWLhonvMDYyH5LsYOTkkBEwkfj/dztzFyMUhJLCbUeJw
 zyVmiIS4RPO1H+wQtrDEyn/P2SGKPjJKTD12namLkYODTUBT4sLkUhBTRMBLYttSQ5ByZoHZ
 TBKNvyJBbGEBN4n7c5ezgdgsAqoSh9ZfBhvJK2AhcWJ9CxPEeHmJmZe+g8U5BSwlrmzbxApi
 CwHVvJ/wkA2iXlDi5MwnLBDz5SWat85mnsAoMAtJahaS1AJGplWMkqkFxbnpucWGBYZ5qeV6
 xYm5xaV56XrJ+bmbGMExo6W5g3H7qg96hxiZOBgPMUpwMCuJ8NopCCYI8aYkVlalFuXHF5Xm
 pBYfYpTmYFES573QdTJeSCA9sSQ1OzW1ILUIJsvEwSnVwHSCxffG2z1Jf54rb+GZ7DaHY62/
 sc/+n7y1815ZPzA7KjbBzUg8evLcehYZpdy52in3rSuPNF5bydN5imvDqb1Cb52eJFeFWTtV
 elw44iCx9gxn/pZXHmleDbK9N6f3X/vgwOb4fEvZyucdl00yROMKWe35Xjq8WcixTCfry1wJ
 gSnbmU7VeT+8cbIn5aFoxsVN6Z0tbzd/vyq+KGf3b5mfCyq2T46L2310dlTJc9c1yZzO8oK7
 fjkbVgbf2PvrmU/QpSe2HGcij69hmVZr0j5rt9esBU+vu95/01AUpaS77aZRU/391ugTO3m8
 5rE2vN75lENqblHHkdQNt3ekczQ+e8nr3nsg5dq1lgXOpj+UWIozEg21mIuKEwGBbgBiCAMA
 AA==
X-CMS-MailID: 20210127150156epcas5p26cdf368e4ff6bffb132fa1c7f9430653
X-Msg-Generator: CA
CMS-TYPE: 105P
X-CMS-RootMailID: 20210127150156epcas5p26cdf368e4ff6bffb132fa1c7f9430653
References: <20210127150029.13766-1-joshi.k@samsung.com>
 <CGME20210127150156epcas5p26cdf368e4ff6bffb132fa1c7f9430653@epcas5p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210127_150225_618589_A6457499 
X-CRM114-Status: GOOD (  21.94  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: selvakuma.s1@samsung.com, Kanchan Joshi <joshi.k@samsung.com>,
 Anuj Gupta <anuj20.g@samsung.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, io-uring@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, javier.gonz@samsung.com, nj.shetty@samsung.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Introduce IORING_OP_IOCTL_PT for async ioctl. It skips entering into
block-layer and reaches to underlying block-driver managing the
block-device. This is done by calling newly introduced "async_ioctl"
block-device operation.
The requested operation may be completed synchronously, and in that case
CQE is updated on the fly. For asynchronous update, lower-layer calls
the completion-callback supplied by io-uring.

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
---
 fs/io_uring.c                 | 77 +++++++++++++++++++++++++++++++++++
 include/uapi/linux/io_uring.h |  7 +++-
 2 files changed, 83 insertions(+), 1 deletion(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 985a9e3f976d..c15852dfb727 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -468,6 +468,19 @@ struct io_rw {
 	u64				len;
 };
 
+/*
+ * passthru ioctl skips block-layer and reaches to block device driver via
+ * async_ioctl() block-dev operation.
+ */
+struct io_pt_ioctl {
+	struct file			*file;
+	/* arg and cmd like regular ioctl */
+	u64				arg;
+	u32				cmd;
+	/* defined by block layer */
+	struct pt_ioctl_ctx		ioctx;
+};
+
 struct io_connect {
 	struct file			*file;
 	struct sockaddr __user		*addr;
@@ -699,6 +712,7 @@ struct io_kiocb {
 		struct io_shutdown	shutdown;
 		struct io_rename	rename;
 		struct io_unlink	unlink;
+		struct io_pt_ioctl	ptioctl;
 		/* use only after cleaning per-op data, see io_clean_op() */
 		struct io_completion	compl;
 	};
@@ -824,6 +838,10 @@ static const struct io_op_def io_op_defs[] = {
 		.needs_file		= 1,
 		.work_flags		= IO_WQ_WORK_BLKCG,
 	},
+	[IORING_OP_IOCTL_PT] = {
+		.needs_file		= 1,
+		.work_flags		= IO_WQ_WORK_MM,
+	},
 	[IORING_OP_READ_FIXED] = {
 		.needs_file		= 1,
 		.unbound_nonreg_file	= 1,
@@ -3704,6 +3722,60 @@ static int io_write(struct io_kiocb *req, bool force_nonblock,
 	return ret;
 }
 
+static int io_pt_ioctl_prep(struct io_kiocb *req,
+			    const struct io_uring_sqe *sqe)
+{
+	unsigned int cmd = READ_ONCE(sqe->ioctl_cmd);
+	unsigned long arg = READ_ONCE(sqe->ioctl_arg);
+	struct io_ring_ctx *ctx = req->ctx;
+	struct block_device *bdev = I_BDEV(req->file->f_mapping->host);
+	struct gendisk *disk = NULL;
+
+	disk = bdev->bd_disk;
+	if (!disk || !disk->fops || !disk->fops->async_ioctl)
+		return -EOPNOTSUPP;
+	/* for sqpoll, use sqo_task */
+	if (ctx->flags & IORING_SETUP_SQPOLL)
+		req->ptioctl.ioctx.task = ctx->sqo_task;
+	else
+		req->ptioctl.ioctx.task = current;
+
+	req->ptioctl.arg = arg;
+	req->ptioctl.cmd = cmd;
+	return 0;
+}
+
+void pt_complete(struct pt_ioctl_ctx *ptioc, long ret)
+{
+	struct io_kiocb *req = container_of(ptioc, struct io_kiocb, ptioctl.ioctx);
+
+	if (ret < 0)
+		req_set_fail_links(req);
+	io_req_complete(req, ret);
+}
+
+static int io_pt_ioctl(struct io_kiocb *req, bool force_nonblock)
+{
+	long ret = 0;
+	struct block_device *bdev = I_BDEV(req->file->f_mapping->host);
+	fmode_t mode = req->file->f_mode;
+	struct gendisk *disk = NULL;
+
+	disk = bdev->bd_disk;
+	/* set up callback for async */
+	req->ptioctl.ioctx.pt_complete = pt_complete;
+
+	ret = disk->fops->async_ioctl(bdev, mode, req->ptioctl.cmd,
+				req->ptioctl.arg, &req->ptioctl.ioctx);
+	if (ret == -EIOCBQUEUED) /*async completion */
+		return 0;
+	if (ret < 0)
+		req_set_fail_links(req);
+
+	io_req_complete(req, ret);
+	return 0;
+}
+
 static int io_renameat_prep(struct io_kiocb *req,
 			    const struct io_uring_sqe *sqe)
 {
@@ -6078,6 +6150,8 @@ static int io_req_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 		return io_renameat_prep(req, sqe);
 	case IORING_OP_UNLINKAT:
 		return io_unlinkat_prep(req, sqe);
+	case IORING_OP_IOCTL_PT:
+		return io_pt_ioctl_prep(req, sqe);
 	}
 
 	printk_once(KERN_WARNING "io_uring: unhandled opcode %d\n",
@@ -6337,6 +6411,9 @@ static int io_issue_sqe(struct io_kiocb *req, bool force_nonblock,
 	case IORING_OP_UNLINKAT:
 		ret = io_unlinkat(req, force_nonblock);
 		break;
+	case IORING_OP_IOCTL_PT:
+		ret = io_pt_ioctl(req, force_nonblock);
+		break;
 	default:
 		ret = -EINVAL;
 		break;
diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index d31a2a1e8ef9..60671e2b00ba 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -22,12 +22,16 @@ struct io_uring_sqe {
 	union {
 		__u64	off;	/* offset into file */
 		__u64	addr2;
+		__u64	ioctl_arg;
 	};
 	union {
 		__u64	addr;	/* pointer to buffer or iovecs */
 		__u64	splice_off_in;
 	};
-	__u32	len;		/* buffer size or number of iovecs */
+	union {
+		__u32	len;	/* buffer size or number of iovecs */
+		__u32	ioctl_cmd;
+	};
 	union {
 		__kernel_rwf_t	rw_flags;
 		__u32		fsync_flags;
@@ -137,6 +141,7 @@ enum {
 	IORING_OP_SHUTDOWN,
 	IORING_OP_RENAMEAT,
 	IORING_OP_UNLINKAT,
+	IORING_OP_IOCTL_PT,
 
 	/* this goes last, obviously */
 	IORING_OP_LAST,
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
