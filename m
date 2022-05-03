Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D37EC433F5
	for <linux-nvme@archiver.kernel.org>; Tue,  3 May 2022 20:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5f0pgRcloYg8KFHgDnDeeaMGHTCe3DJInszg4WJrPlo=; b=oV7P8I/qAdaOTJJhmCw+JcZAII
	9+1Fh7mhYSJzvBXjgrnbH8Tw4Yamkvp35m75VaJdiwLJAcoE7CroV4uLwQdf+iI/XeqM0CtQ3nIBm
	Qw2BFA3TSrx80aL2q3nNW/TEGxzIJen9QnjVG0K/BM1x0vyUzL5ix+OgHfbXZkH4ZGexAP/xdtElp
	krgXErDggyNssvjDpFM/D605Q1rZw0Lpukog35FPOXTk3ppnszAjZ8KOLcyR6cL1s1/enW3awYu5C
	36Ve2IMqVUGtBc+Jr7EVyAJHfW8njOKV6v9scie2mM6Ikczz0VDyTrnjXiJz7QEJAb8AeNXHGFcnj
	e5RQRJ1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nlzVN-007dpt-47; Tue, 03 May 2022 20:52:21 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nlzVI-007dj5-VI
 for linux-nvme@lists.infradead.org; Tue, 03 May 2022 20:52:19 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id EADE467373; Tue,  3 May 2022 22:52:02 +0200 (CEST)
Date: Tue, 3 May 2022 22:52:02 +0200
From: Christoph Hellwig <hch@lst.de>
To: Pankaj Raghav <p.raghav@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, io-uring@vger.kernel.org,
 linux-nvme@lists.infradead.org, asml.silence@gmail.com,
 ming.lei@redhat.com, mcgrof@kernel.org, shr@fb.com,
 joshiiitr@gmail.com, gost.dev@samsung.com,
 Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH v3 1/5] fs,io_uring: add infrastructure for uring-cmd
Message-ID: <20220503205202.GA9567@lst.de>
References: <20220503184831.78705-1-p.raghav@samsung.com>
 <CGME20220503184912eucas1p1bb0e3d36c06cfde8436df3a45e67bd32@eucas1p1.samsung.com>
 <20220503184831.78705-2-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220503184831.78705-2-p.raghav@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220503_135217_332629_01F74C35 
X-CRM114-Status: GOOD (  28.67  )
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

This mostly looks good, but a few comments an an (untested) patch
to fix these complaints below:

> +struct io_uring_cmd {
> +	struct file     *file;
> +	void            *cmd;
> +	/* for irq-completion - if driver requires doing stuff in task-context*/
> +	void (*driver_cb)(struct io_uring_cmd *cmd);

I'd rename this task_Work_cb or similar, as driver is not very
meaningful.

> +	u32             flags;
> +	u32             cmd_op;
> +	u32		unused;
> +	u8		pdu[28]; /* available inline for free use */

The unused field here is not only unused, but also messed up the
alignment so that any pointer in pdu will not be properly aligned
on 64-bit platforms and tjus might cause crashes on some platforms.

For now we can just remove it, but I really want to get rid of the pdu
thing that causes these problems, but I will not hold the series off for
that and plan to look into that later.

Also a lot of the fields here were using spaces instead of tabs for
indentation.

>  	union {
>  		__u64	addr;	/* pointer to buffer or iovecs */
>  		__u64	splice_off_in;
> +		__u16	cmd_len;
>  	};

This field isn't actually used and can be removed.

>  	__u32	len;		/* buffer size or number of iovecs */
>  	union {
> @@ -61,7 +63,10 @@ struct io_uring_sqe {
>  		__s32	splice_fd_in;
>  		__u32	file_index;
>  	};
> -	__u64	addr3;
> +	union {
> +		__u64	addr3;
> +		__u64	cmd;
> +	};
>  	__u64	__pad2[1];

The way how the tail of the structure is handled here is a mess.  I
think something like a union of two structs for the small and large
case would be much better, so that cmd can be the actual array for
the data that can be used directly and without the nasty cast (that
also casted away the constness):

diff --git a/fs/io_uring.c b/fs/io_uring.c
index b774e6eac5384..fe24d606ca306 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -4544,7 +4544,7 @@ static int io_getxattr_prep(struct io_kiocb *req,
 	if (ret)
 		return ret;
 
-	path = u64_to_user_ptr(READ_ONCE(sqe->addr3));
+	path = u64_to_user_ptr(READ_ONCE(sqe->small.addr3));
 
 	ix->filename = getname_flags(path, LOOKUP_FOLLOW, NULL);
 	if (IS_ERR(ix->filename)) {
@@ -4645,7 +4645,7 @@ static int io_setxattr_prep(struct io_kiocb *req,
 	if (ret)
 		return ret;
 
-	path = u64_to_user_ptr(READ_ONCE(sqe->addr3));
+	path = u64_to_user_ptr(READ_ONCE(sqe->small.addr3));
 
 	ix->filename = getname_flags(path, LOOKUP_FOLLOW, NULL);
 	if (IS_ERR(ix->filename)) {
@@ -4909,15 +4909,15 @@ static int io_linkat(struct io_kiocb *req, unsigned int issue_flags)
 
 static void io_uring_cmd_work(struct io_kiocb *req, bool *locked)
 {
-	req->uring_cmd.driver_cb(&req->uring_cmd);
+	req->uring_cmd.task_work_cb(&req->uring_cmd);
 }
 
 void io_uring_cmd_complete_in_task(struct io_uring_cmd *ioucmd,
-			void (*driver_cb)(struct io_uring_cmd *))
+			void (*task_work_cb)(struct io_uring_cmd *))
 {
 	struct io_kiocb *req = container_of(ioucmd, struct io_kiocb, uring_cmd);
 
-	req->uring_cmd.driver_cb = driver_cb;
+	req->uring_cmd.task_work_cb = task_work_cb;
 	req->io_task_work.func = io_uring_cmd_work;
 	io_req_task_work_add(req, !!(req->ctx->flags & IORING_SETUP_SQPOLL));
 }
@@ -4949,7 +4949,7 @@ static int io_uring_cmd_prep(struct io_kiocb *req,
 		return -EOPNOTSUPP;
 	if (!(req->ctx->flags & IORING_SETUP_CQE32))
 		return -EOPNOTSUPP;
-	ioucmd->cmd = (void *) &sqe->cmd;
+	ioucmd->cmd = sqe->big.cmd;
 	ioucmd->cmd_op = READ_ONCE(sqe->cmd_op);
 	ioucmd->flags = 0;
 	return 0;
@@ -12735,7 +12735,7 @@ static int __init io_uring_init(void)
 	BUILD_BUG_SQE_ELEM(42, __u16,  personality);
 	BUILD_BUG_SQE_ELEM(44, __s32,  splice_fd_in);
 	BUILD_BUG_SQE_ELEM(44, __u32,  file_index);
-	BUILD_BUG_SQE_ELEM(48, __u64,  addr3);
+	BUILD_BUG_SQE_ELEM(48, __u64,  small.addr3);
 
 	BUILD_BUG_ON(sizeof(struct io_uring_files_update) !=
 		     sizeof(struct io_uring_rsrc_update));
diff --git a/include/linux/io_uring.h b/include/linux/io_uring.h
index a4ff4696cbead..7274884859910 100644
--- a/include/linux/io_uring.h
+++ b/include/linux/io_uring.h
@@ -13,20 +13,19 @@ enum io_uring_cmd_flags {
 };
 
 struct io_uring_cmd {
-	struct file     *file;
-	void            *cmd;
-	/* for irq-completion - if driver requires doing stuff in task-context*/
-	void (*driver_cb)(struct io_uring_cmd *cmd);
-	u32             flags;
-	u32             cmd_op;
-	u32		unused;
+	struct file	*file;
+	const u8	*cmd;
+	/* callback to defer completions to task context */
+	void (*task_work_cb)(struct io_uring_cmd *cmd);
+	u32		flags;
+	u32		cmd_op;
 	u8		pdu[28]; /* available inline for free use */
 };
 
 #if defined(CONFIG_IO_URING)
 void io_uring_cmd_done(struct io_uring_cmd *cmd, ssize_t ret, ssize_t res2);
 void io_uring_cmd_complete_in_task(struct io_uring_cmd *ioucmd,
-			void (*driver_cb)(struct io_uring_cmd *));
+			void (*task_work_cb)(struct io_uring_cmd *));
 struct sock *io_uring_get_socket(struct file *file);
 void __io_uring_cancel(bool cancel_all);
 void __io_uring_free(struct task_struct *tsk);
@@ -56,7 +55,7 @@ static inline void io_uring_cmd_done(struct io_uring_cmd *cmd, ssize_t ret,
 {
 }
 static inline void io_uring_cmd_complete_in_task(struct io_uring_cmd *ioucmd,
-			void (*driver_cb)(struct io_uring_cmd *))
+			void (*task_work_cb)(struct io_uring_cmd *))
 {
 }
 static inline struct sock *io_uring_get_socket(struct file *file)
diff --git a/include/trace/events/io_uring.h b/include/trace/events/io_uring.h
index 630982b3c34c5..b1f64c2412935 100644
--- a/include/trace/events/io_uring.h
+++ b/include/trace/events/io_uring.h
@@ -539,8 +539,8 @@ TRACE_EVENT(io_uring_req_failed,
 		__entry->buf_index	= sqe->buf_index;
 		__entry->personality	= sqe->personality;
 		__entry->file_index	= sqe->file_index;
-		__entry->pad1		= sqe->__pad2[0];
-		__entry->addr3		= sqe->addr3;
+		__entry->addr3		= sqe->small.addr3;
+		__entry->pad1		= sqe->small.__pad2[0];
 		__entry->error		= error;
 	),
 
diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index c081511119bfa..bd4221184f594 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -27,7 +27,6 @@ struct io_uring_sqe {
 	union {
 		__u64	addr;	/* pointer to buffer or iovecs */
 		__u64	splice_off_in;
-		__u16	cmd_len;
 	};
 	__u32	len;		/* buffer size or number of iovecs */
 	union {
@@ -64,16 +63,19 @@ struct io_uring_sqe {
 		__u32	file_index;
 	};
 	union {
-		__u64	addr3;
-		__u64	cmd;
+		struct {
+			__u64	addr3;
+			__u64	__pad2[1];
+		} small;
+
+		/*
+		 * If the ring is initialized with IORING_SETUP_SQE128, then
+		 * this field is used for 80 bytes of arbitrary command data.
+		 */
+		struct {
+			__u8	cmd[0];
+		} big;
 	};
-	__u64	__pad2[1];
-
-	/*
-	 * If the ring is initialized with IORING_SETUP_SQE128, then this field
-	 * contains 64-bytes of padding, doubling the size of the SQE.
-	 */
-	__u64	__big_sqe_pad[0];
 };
 
 enum {

