Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07C2CC19F4E
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Apr 2024 18:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FdFq2FZdO8v/8D9b+1sjDkJ0PD17j8j/mUpt7Sw3h80=; b=VJVE2vzUp721RqkVZcegZo76Rn
	iS1+R/rZ+Q/GDSaAmvwd3GNzsbJ1RlVf5cS786NUrYrU7X/C8FN5K5ZveqGNxltfxxrXoiQ3K3tRQ
	EW/i6qZHKg/T5WN3SADhtpqzt+5fKbmojM0F4hWqBIOAym40NNBCUMOL7+k78qwsO5ax+/Bfv7Mik
	GDW6gw2QrBk7qboepYKyJrBq24RYGvUALYM0+IYSB/h53N242+S3XlsyYIbc2jKQRh6B8TMTJk45R
	Lv0MIlOPbSDcHy0eNnhftnHIccCWdQdSOL5gE3nQzMDHucAj5X5XXV5nXZadrTgfN5BsQlYKaIoCF
	W1L4oi2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s047u-00000009lxD-24oA;
	Thu, 25 Apr 2024 18:47:22 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s047i-00000009lnn-2J9o
	for linux-nvme@lists.infradead.org;
	Thu, 25 Apr 2024 18:47:14 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240425184708epoutp011d6240a169a8a09e98ae9584b4d646bf~JmlZRb_5g0066600666epoutp012
	for <linux-nvme@lists.infradead.org>; Thu, 25 Apr 2024 18:47:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240425184708epoutp011d6240a169a8a09e98ae9584b4d646bf~JmlZRb_5g0066600666epoutp012
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1714070828;
	bh=FdFq2FZdO8v/8D9b+1sjDkJ0PD17j8j/mUpt7Sw3h80=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C7FkOrSnlqY3mL7x6q1Ge7jVQgT8G5R/2W+k2nwrZpVBYqr2aZD44IGGNMicXTy6E
	 Ggonq3z/ME8LAlOrA74RU8lJn1jrqScbyv4+jiGMKNREqTAN1NFXEHMJ/Cre+epWK3
	 E01ddTEjLZ8GnFaOCVXXimDODPG1vNsUblYfZ+tY=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20240425184708epcas5p4b2815f78f0a5b00b5a33b6eeaa520135~JmlY0K4761482414824epcas5p4r;
	Thu, 25 Apr 2024 18:47:08 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.174]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4VQPwW0R34z4x9Pq; Thu, 25 Apr
	2024 18:47:07 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	8C.E6.19431.A25AA266; Fri, 26 Apr 2024 03:47:06 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20240425184706epcas5p1d75c19d1d1458c52fc4009f150c7dc7d~JmlXGq_w_2685426854epcas5p1P;
	Thu, 25 Apr 2024 18:47:06 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240425184706epsmtrp14c11a1eedd113ed87970fdfb484fa2cb~JmlXF2xdh0085000850epsmtrp1g;
	Thu, 25 Apr 2024 18:47:06 +0000 (GMT)
X-AuditID: b6c32a50-f57ff70000004be7-d3-662aa52a99e6
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	70.E7.08924.A25AA266; Fri, 26 Apr 2024 03:47:06 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240425184704epsmtip1f173edc993d14c8e8955b5c8f8ab8888~JmlVEU6nb3082730827epsmtip1c;
	Thu, 25 Apr 2024 18:47:04 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: axboe@kernel.dk, martin.petersen@oracle.com, kbusch@kernel.org,
	hch@lst.de, brauner@kernel.org
Cc: asml.silence@gmail.com, dw@davidwei.uk, io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, Anuj Gupta <anuj20.g@samsung.com>, Kanchan Joshi
	<joshi.k@samsung.com>, Nitesh Shetty <nj.shetty@samsung.com>
Subject: [PATCH 08/10] io_uring/rw: add support to send meta along with
 read/write
Date: Fri, 26 Apr 2024 00:09:41 +0530
Message-Id: <20240425183943.6319-9-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240425183943.6319-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOJsWRmVeSWpSXmKPExsWy7bCmhq7WUq00gzuHrS2aJvxltpizahuj
	xeq7/WwWrw9/YrR4NWMtm8XNAzuZLFauPspk8a71HIvF0f9v2SwmHbrGaLH3lrbF/GVP2S2W
	H//HZLHt93xmBz6PazMmsnjsnHWX3ePy2VKPTas62Tw2L6n32H2zgc3j49NbLB59W1Yxenze
	JBfAGZVtk5GamJJapJCal5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQN0
	upJCWWJOKVAoILG4WEnfzqYov7QkVSEjv7jEVim1ICWnwKRArzgxt7g0L10vL7XEytDAwMgU
	qDAhO+P5z/MsBXPCKnbfO8jYwHjKtYuRk0NCwETi3LP7zF2MXBxCAnsYJS5O3cAK4XxilDg2
	7xxU5hujxPR/G1m6GDnAWnq+aEDE9zJKnPl9BqrjM6PEikm9rCBFbAKaEhcml4KsEBFIkXi1
	7jUjSA2zQA+TxNSvN1hAEsICIRK7lvxnBKlnEVCV6L0pDRLmFTCXOLzsDBvEefISMy99Zwex
	OQUsJCZfPM0OUSMocXLmE7AxzEA1zVtngx0qIbCDQ2LdlEYmiGYXieeTN0PZwhKvjm9hh7Cl
	JF72t0HZyRKXZp6DqimReLznIJRtL9F6qp8Z5DZmoF/W79KH2MUn0fv7CRMkHHglOtqEIKoV
	Je5NesoKYYtLPJyxBMr2kLhzaRI0DLsZJV4u3skygVF+FpIXZiF5YRbCtgWMzKsYpVILinPT
	U5NNCwx181LL4RGbnJ+7iRGcgrUCdjCu3vBX7xAjEwfjIUYJDmYlEd6bHzXShHhTEiurUovy
	44tKc1KLDzGaAsN4IrOUaHI+MAvklcQbmlgamJiZmZlYGpsZKonzvm6dmyIkkJ5YkpqdmlqQ
	WgTTx8TBKdXAFN2VmCc0sd6Wt++Uc/B3mZppsQsVJMIki8qktx6cckL9uaZevZfVBMvaUMOT
	9zuzTTkzD7OcXHLjh9/7E8c/Hlkzp4773+KTP3OYqu54byzdovTtzuvzCe9YZn7xaWiqZezg
	2vn+gtUyedkFItPebdaTEK4wWRM3J+jATt9Lc1+x7tn/XGXu0bvKItPa+g0q/7xafaqF5QOr
	S+Vxj4eHVZ7MODWV02j9TIbw9R5JBzouLz73vvi1ncXSmqnrOwqPHrlwVmNSkwtXsNXS/dnK
	bv7rKiJsJtkkxv465/Lz2DcF7p/HEzyYbjy74Hff8DBPot/Ut2vZF5mnn31q0pDgun8Tw+eH
	nR02c84YirbK/lJiKc5INNRiLipOBABxTg5BSgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJLMWRmVeSWpSXmKPExsWy7bCSnK7WUq00g3XNghZNE/4yW8xZtY3R
	YvXdfjaL14c/MVq8mrGWzeLmgZ1MFitXH2WyeNd6jsXi6P+3bBaTDl1jtNh7S9ti/rKn7BbL
	j/9jstj2ez6zA5/HtRkTWTx2zrrL7nH5bKnHplWdbB6bl9R77L7ZwObx8ektFo++LasYPT5v
	kgvgjOKySUnNySxLLdK3S+DKeP7zPEvBnLCK3fcOMjYwnnLtYuTgkBAwkej5otHFyMUhJLCb
	UWLlzi62LkZOoLi4RPO1H+wQtrDEyn/P2SGKPjJKfDhwnBmkmU1AU+LC5FKQGhGBLIm9/VfA
	apgFpjFJbP3/CWyQsECQxIWntxlB6lkEVCV6b0qDhHkFzCUOLzsDtUteYual72C7OAUsJCZf
	PA1mCwHVTF2ziBGiXlDi5MwnLCA2M1B989bZzBMYBWYhSc1CklrAyLSKUTK1oDg3PbfYsMAw
	L7Vcrzgxt7g0L10vOT93EyM4drQ0dzBuX/VB7xAjEwfjIUYJDmYlEd6bHzXShHhTEiurUovy
	44tKc1KLDzFKc7AoifOKv+hNERJITyxJzU5NLUgtgskycXBKNTAdYDzod/zwB6fgVlP5BQpL
	7ofd1gq72ihU8/dOiDBzzd3Uw2qMbcrXt/k/yvZe0rxOVaskskb3af/9U65xvW/q1xp2Npyf
	u0948xVr7ilKkxwuT1Ceyrd/5/NLH51X1Fim78n4mbnec8P1M21KzgXXf6fwXN1vOqXQ2LNU
	79nh5xesd24q9PuS+O9Z6ZLnjZHxkeqzV+vpSKyOXuol8XW98Xe289Z3ZitmOZ7n2fk9w3rF
	ibuPvH9e/+1f9X/Pl8mGj+5/3XDjY+c/583Hfhz5OPf20+1FT5MVeT70Jvu+UvX6cPFX3uHe
	JpbGiqU3vQsZC727jEwZTe9v2N5n9+j8+o2vW9kMuthYdy3bp6TgrsRSnJFoqMVcVJwIAAQY
	/j8MAwAA
X-CMS-MailID: 20240425184706epcas5p1d75c19d1d1458c52fc4009f150c7dc7d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240425184706epcas5p1d75c19d1d1458c52fc4009f150c7dc7d
References: <20240425183943.6319-1-joshi.k@samsung.com>
	<CGME20240425184706epcas5p1d75c19d1d1458c52fc4009f150c7dc7d@epcas5p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240425_114710_941772_BBAA1F28 
X-CRM114-Status: GOOD (  29.80  )
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

This patch introduces IORING_OP_READ_META and IORING_OP_WRITE_META
opcodes which allow sending a meta buffer along with read/write. The
meta buffer, its length, apptag and integrity check flags can be specified
by the application in the newly introduced meta_buf, meta_len, apptag and
meta_flags fields of SQE.

Use the user-passed information to prepare uio_meta descriptor, and
pass it down using kiocb->private.

Meta exchange is supported only for direct IO.

Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
---
 include/linux/fs.h            |  1 +
 include/uapi/linux/io_uring.h | 15 +++++++
 io_uring/io_uring.c           |  4 ++
 io_uring/opdef.c              | 30 ++++++++++++++
 io_uring/rw.c                 | 76 +++++++++++++++++++++++++++++++++--
 io_uring/rw.h                 | 11 ++++-
 6 files changed, 132 insertions(+), 5 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 8dfd53b52744..8868d17ae8f9 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -329,6 +329,7 @@ struct readahead_control;
 #define IOCB_NOIO		(1 << 20)
 /* can use bio alloc cache */
 #define IOCB_ALLOC_CACHE	(1 << 21)
+#define IOCB_USE_META		(1 << 22)
 /*
  * IOCB_DIO_CALLER_COMP can be set by the iocb owner, to indicate that the
  * iocb completion can be passed back to the owner for execution from a safe
diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index a7f847543a7f..d4653b52fdd6 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -97,6 +97,12 @@ struct io_uring_sqe {
 			__u64	addr3;
 			__u64	__pad2[1];
 		};
+		struct {
+			__u64	meta_addr;
+			__u32	meta_len;
+			__u16	meta_flags;
+			__u16	apptag;
+		};
 		__u64	optval;
 		/*
 		 * If the ring is initialized with IORING_SETUP_SQE128, then
@@ -106,6 +112,13 @@ struct io_uring_sqe {
 	};
 };
 
+/*
+ * meta io flags
+ */
+#define META_CHK_GUARD	(1U << 0)	/* guard is valid */
+#define META_CHK_APPTAG	(1U << 1)	/* app tag is valid */
+#define META_CHK_REFTAG	(1U << 2)	/* ref tag is valid */
+
 /*
  * If sqe->file_index is set to this for opcodes that instantiate a new
  * direct descriptor (like openat/openat2/accept), then io_uring will allocate
@@ -256,6 +269,8 @@ enum io_uring_op {
 	IORING_OP_FUTEX_WAITV,
 	IORING_OP_FIXED_FD_INSTALL,
 	IORING_OP_FTRUNCATE,
+	IORING_OP_READ_META,
+	IORING_OP_WRITE_META,
 
 	/* this goes last, obviously */
 	IORING_OP_LAST,
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 3c9087f37c43..af95fc8d988c 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -3723,7 +3723,11 @@ static int __init io_uring_init(void)
 	BUILD_BUG_SQE_ELEM(44, __u16,  addr_len);
 	BUILD_BUG_SQE_ELEM(46, __u16,  __pad3[0]);
 	BUILD_BUG_SQE_ELEM(48, __u64,  addr3);
+	BUILD_BUG_SQE_ELEM(48, __u64,  meta_addr);
 	BUILD_BUG_SQE_ELEM_SIZE(48, 0, cmd);
+	BUILD_BUG_SQE_ELEM(56, __u32,  meta_len);
+	BUILD_BUG_SQE_ELEM(60, __u16,  meta_flags);
+	BUILD_BUG_SQE_ELEM(62, __u16,  apptag);
 	BUILD_BUG_SQE_ELEM(56, __u64,  __pad2);
 
 	BUILD_BUG_ON(sizeof(struct io_uring_files_update) !=
diff --git a/io_uring/opdef.c b/io_uring/opdef.c
index a16f73938ebb..8b8fdcfb7f30 100644
--- a/io_uring/opdef.c
+++ b/io_uring/opdef.c
@@ -444,6 +444,28 @@ const struct io_issue_def io_issue_defs[] = {
 		.prep			= io_eopnotsupp_prep,
 #endif
 	},
+	[IORING_OP_READ_META] = {
+		.needs_file		= 1,
+		.plug			= 1,
+		.audit_skip		= 1,
+		.ioprio			= 1,
+		.iopoll			= 1,
+		.iopoll_queue		= 1,
+		.async_size		= sizeof(struct io_async_rw),
+		.prep			= io_prep_read_meta,
+		.issue			= io_rw_meta,
+	},
+	[IORING_OP_WRITE_META] = {
+		.needs_file		= 1,
+		.plug			= 1,
+		.audit_skip		= 1,
+		.ioprio			= 1,
+		.iopoll			= 1,
+		.iopoll_queue		= 1,
+		.async_size		= sizeof(struct io_async_rw),
+		.prep			= io_prep_write_meta,
+		.issue			= io_rw_meta,
+	},
 	[IORING_OP_READ_MULTISHOT] = {
 		.needs_file		= 1,
 		.unbound_nonreg_file	= 1,
@@ -510,6 +532,14 @@ const struct io_cold_def io_cold_defs[] = {
 		.cleanup		= io_readv_writev_cleanup,
 		.fail			= io_rw_fail,
 	},
+	[IORING_OP_READ_META] = {
+		.name			= "READ_META",
+		.fail			= io_rw_fail,
+	},
+	[IORING_OP_WRITE_META] = {
+		.name			= "WRITE_META",
+		.fail			= io_rw_fail,
+	},
 	[IORING_OP_FSYNC] = {
 		.name			= "FSYNC",
 	},
diff --git a/io_uring/rw.c b/io_uring/rw.c
index 3134a6ece1be..b2c9ac91d5e5 100644
--- a/io_uring/rw.c
+++ b/io_uring/rw.c
@@ -269,6 +269,7 @@ static int io_prep_rw(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 		rw->kiocb.ki_ioprio = get_current_ioprio();
 	}
 	rw->kiocb.dio_complete = NULL;
+	rw->kiocb.ki_flags = 0;
 
 	rw->addr = READ_ONCE(sqe->addr);
 	rw->len = READ_ONCE(sqe->len);
@@ -286,6 +287,41 @@ int io_prep_write(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 	return io_prep_rw(req, sqe, ITER_SOURCE, true);
 }
 
+static int io_prep_rw_meta(struct io_kiocb *req, const struct io_uring_sqe *sqe,
+		    int ddir, bool import)
+{
+	struct io_rw *rw = io_kiocb_to_cmd(req, struct io_rw);
+	struct io_async_rw *io;
+	struct kiocb *kiocb = &rw->kiocb;
+	int ret;
+
+	ret = io_prep_rw(req, sqe, ddir, import);
+	if (unlikely(ret))
+		return ret;
+
+	io = req->async_data;
+	kiocb->ki_flags |= IOCB_USE_META;
+	io->meta.flags = READ_ONCE(sqe->meta_flags);
+	io->meta.apptag = READ_ONCE(sqe->apptag);
+	ret = import_ubuf(ddir, u64_to_user_ptr(READ_ONCE(sqe->meta_addr)),
+			     READ_ONCE(sqe->meta_len), &io->meta.iter);
+	if (unlikely(ret < 0))
+		return ret;
+
+	iov_iter_save_state(&io->meta.iter, &io->iter_meta_state);
+	return 0;
+}
+
+int io_prep_read_meta(struct io_kiocb *req, const struct io_uring_sqe *sqe)
+{
+	return io_prep_rw_meta(req, sqe, ITER_DEST, true);
+}
+
+int io_prep_write_meta(struct io_kiocb *req, const struct io_uring_sqe *sqe)
+{
+	return io_prep_rw_meta(req, sqe, ITER_SOURCE, true);
+}
+
 static int io_prep_rwv(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 		       int ddir)
 {
@@ -587,6 +623,8 @@ static int kiocb_done(struct io_kiocb *req, ssize_t ret,
 
 		req->flags &= ~REQ_F_REISSUE;
 		iov_iter_restore(&io->iter, &io->iter_state);
+		if (unlikely(rw->kiocb.ki_flags & IOCB_USE_META))
+			iov_iter_restore(&io->meta.iter, &io->iter_meta_state);
 		return -EAGAIN;
 	}
 	return IOU_ISSUE_SKIP_COMPLETE;
@@ -768,7 +806,7 @@ static int io_rw_init_file(struct io_kiocb *req, fmode_t mode)
 	if (!(req->flags & REQ_F_FIXED_FILE))
 		req->flags |= io_file_get_flags(file);
 
-	kiocb->ki_flags = file->f_iocb_flags;
+	kiocb->ki_flags |= file->f_iocb_flags;
 	ret = kiocb_set_rw_flags(kiocb, rw->flags);
 	if (unlikely(ret))
 		return ret;
@@ -787,7 +825,8 @@ static int io_rw_init_file(struct io_kiocb *req, fmode_t mode)
 		if (!(kiocb->ki_flags & IOCB_DIRECT) || !file->f_op->iopoll)
 			return -EOPNOTSUPP;
 
-		kiocb->private = NULL;
+		if (likely(!(kiocb->ki_flags & IOCB_USE_META)))
+			kiocb->private = NULL;
 		kiocb->ki_flags |= IOCB_HIPRI;
 		kiocb->ki_complete = io_complete_rw_iopoll;
 		req->iopoll_completed = 0;
@@ -853,7 +892,8 @@ static int __io_read(struct io_kiocb *req, unsigned int issue_flags)
 	} else if (ret == -EIOCBQUEUED) {
 		return IOU_ISSUE_SKIP_COMPLETE;
 	} else if (ret == req->cqe.res || ret <= 0 || !force_nonblock ||
-		   (req->flags & REQ_F_NOWAIT) || !need_complete_io(req)) {
+		   (req->flags & REQ_F_NOWAIT) || !need_complete_io(req) ||
+		   (kiocb->ki_flags & IOCB_USE_META)) {
 		/* read all, failed, already did sync or don't want to retry */
 		goto done;
 	}
@@ -864,6 +904,12 @@ static int __io_read(struct io_kiocb *req, unsigned int issue_flags)
 	 * manually if we need to.
 	 */
 	iov_iter_restore(&io->iter, &io->iter_state);
+	if (unlikely(kiocb->ki_flags & IOCB_USE_META)) {
+		/* don't handle partial completion for read + meta */
+		if (ret > 0)
+			goto done;
+		iov_iter_restore(&io->meta.iter, &io->iter_meta_state);
+	}
 
 	do {
 		/*
@@ -1053,7 +1099,8 @@ int io_write(struct io_kiocb *req, unsigned int issue_flags)
 		if (ret2 == -EAGAIN && (req->ctx->flags & IORING_SETUP_IOPOLL))
 			goto ret_eagain;
 
-		if (ret2 != req->cqe.res && ret2 >= 0 && need_complete_io(req)) {
+		if (ret2 != req->cqe.res && ret2 >= 0 && need_complete_io(req)
+				&& !(kiocb->ki_flags & IOCB_USE_META)) {
 			trace_io_uring_short_write(req->ctx, kiocb->ki_pos - ret2,
 						req->cqe.res, ret2);
 
@@ -1074,12 +1121,33 @@ int io_write(struct io_kiocb *req, unsigned int issue_flags)
 	} else {
 ret_eagain:
 		iov_iter_restore(&io->iter, &io->iter_state);
+		if (unlikely(kiocb->ki_flags & IOCB_USE_META))
+			iov_iter_restore(&io->meta.iter, &io->iter_meta_state);
 		if (kiocb->ki_flags & IOCB_WRITE)
 			io_req_end_write(req);
 		return -EAGAIN;
 	}
 }
 
+int io_rw_meta(struct io_kiocb *req, unsigned int issue_flags)
+{
+	struct io_rw *rw = io_kiocb_to_cmd(req, struct io_rw);
+	struct io_async_rw *io = req->async_data;
+	struct kiocb *kiocb = &rw->kiocb;
+	int ret;
+
+	if (!(req->file->f_flags & O_DIRECT))
+		return -EOPNOTSUPP;
+
+	kiocb->private = &io->meta;
+	if (req->opcode == IORING_OP_READ_META)
+		ret = io_read(req, issue_flags);
+	else
+		ret = io_write(req, issue_flags);
+
+	return ret;
+}
+
 void io_rw_fail(struct io_kiocb *req)
 {
 	int res;
diff --git a/io_uring/rw.h b/io_uring/rw.h
index 3f432dc75441..a640071064e3 100644
--- a/io_uring/rw.h
+++ b/io_uring/rw.h
@@ -9,7 +9,13 @@ struct io_async_rw {
 	struct iovec			fast_iov;
 	struct iovec			*free_iovec;
 	int				free_iov_nr;
-	struct wait_page_queue		wpq;
+	union {
+		struct wait_page_queue		wpq;
+		struct {
+			struct uio_meta			meta;
+			struct iov_iter_state		iter_meta_state;
+		};
+	};
 };
 
 int io_prep_read_fixed(struct io_kiocb *req, const struct io_uring_sqe *sqe);
@@ -17,9 +23,12 @@ int io_prep_write_fixed(struct io_kiocb *req, const struct io_uring_sqe *sqe);
 int io_prep_readv(struct io_kiocb *req, const struct io_uring_sqe *sqe);
 int io_prep_writev(struct io_kiocb *req, const struct io_uring_sqe *sqe);
 int io_prep_read(struct io_kiocb *req, const struct io_uring_sqe *sqe);
+int io_prep_read_meta(struct io_kiocb *req, const struct io_uring_sqe *sqe);
 int io_prep_write(struct io_kiocb *req, const struct io_uring_sqe *sqe);
+int io_prep_write_meta(struct io_kiocb *req, const struct io_uring_sqe *sqe);
 int io_read(struct io_kiocb *req, unsigned int issue_flags);
 int io_write(struct io_kiocb *req, unsigned int issue_flags);
+int io_rw_meta(struct io_kiocb *req, unsigned int issue_flags);
 void io_readv_writev_cleanup(struct io_kiocb *req);
 void io_rw_fail(struct io_kiocb *req);
 void io_req_rw_complete(struct io_kiocb *req, struct io_tw_state *ts);
-- 
2.25.1


