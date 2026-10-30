Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57332606A329
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Oct 2026 01:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=L3Uw7PAP;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mvnADtkl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=ODvSAgyV/h/yeJCArNYdVO3F0icLZBSUlmTqdaSk0qI=; b=L3Uw7PAPMUa30h
	ZsC4Lyc0ya2eHY/p5tSUNKzWaN8bNeaiVhE3lxa0aQgE5kZRewnuRjC9/YIRMj6M6dXh32fRvhfO2
	yZ69GEWkCZ56OCITCcItf3t7WjWJpJJr7ZhFoJGRIqo+xh6QCC9eZS2tJHrjIaLfnBi+REBfuaCB8
	a63G0qdCulByCjTbgwjVTSBv74OORdsCMIR66vCBvl6fObuBmJrt08yHO4fMsSgw9Vup8io24bcSh
	gbZXPLe3DKH74ikF4hNBtAnppm0Z+ciZeLUUw38TRHv/cqeSu5vncbpzppY7Q+S6ucxZwFf3vDqC8
	/o/PIqEi6e2bkx5twrCQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMbgy-0000000Ad2k-3zDD;
	Fri, 30 Oct 2026 01:46:04 +0000
Received: from mail-dy1-x1335.google.com ([2607:f8b0:4864:20::1335])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMbgt-0000000Ad1D-382C
	for linux-nvme@lists.infradead.org;
	Fri, 30 Oct 2026 01:46:02 +0000
Received: by mail-dy1-x1335.google.com with SMTP id 5a478bee46e88-35c76e9614aso409580eec.0
        for <linux-nvme@lists.infradead.org>; Thu, 29 Oct 2026 18:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793324758; x=1793929558; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ODvSAgyV/h/yeJCArNYdVO3F0icLZBSUlmTqdaSk0qI=;
        b=mvnADtklSWCZ58nPZ/WleSKU2g2eMfUP61py05JHKkbNwyXOlHf2lFQeOeg7ywu6vF
         SAOe4FVtvozytOPQ+ay/ZdKV/kmeC8c/RHg71f6YlqXS8wKt2EZPALqlNO2y3p5n913M
         4CKdQG7mdKN8hsmfUBQD7l7AXCGiQ2+2ToqFy0mood3boRISDlebbd8Qlc+MO5G6pLgG
         nEf86Qj7ny3f4ruOGdhfu55qdlUt5y9w4YU3mnnVbJzP/UbWhAygzk8tpKc3DIFZWQcA
         XPJYLfU7mMyGlyGtnuQ+QWAiunzRd37VJgAzgYAa3aXOM0n9N7ndvgyoYTsHSbT86vmL
         4oXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793324758; x=1793929558;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ODvSAgyV/h/yeJCArNYdVO3F0icLZBSUlmTqdaSk0qI=;
        b=lBXpOo6z8cIcp4NJ4wLrsGSJAoRdpHSTUbtcM8ufLOoV6Vkp2zeSMchz1YruUuhMtD
         fNR4hWiq0NgYtzRLZh3zRR7niPl1nyhtDYpdeZe2f0ft9gzgZTN9W8UnwIf82uNMMbLh
         oyCflk096K6FM8+YkVZ68rV2Uq91O7Vf4XcXyeNOUcf/aqN5f7jb+E+nP41wYfWvccFH
         8YcvaCGv/zwbWbszGgr+KBow9gsEWO7G+TtLKYnjtcnXSBuyPSzIgjxKPjFVVovIn8hW
         eftTTMGGoYSJcnuiID9MUFv5RTWQYHNtHsHK4/gkwOTW6wejzuk+g5SOgHFjutnzA7oW
         vANA==
X-Forwarded-Encrypted: i=1; AKwUvBxrCMFmmQgnJAVzSCpxcdjYOxDCS4GOyDkFxPkIo3M83RfswrAZ63Hvyy8sw1t5FW36n2N9uTaovRYe@lists.infradead.org
X-Gm-Message-State: AFq9FYIbeXK2LVt6ZdtS6gfxF3LllYj5Sh9p1FKbQEY1msmA0ik1dB/D
	woyqnGhe6/BV3f8BduC2xyFh3YAa7tnoDBwhKbEEdfRMQVOVW2N0EUc=
X-Gm-Gg: AYBFou2JFg63Y6gYHGW5MovUiiFCl+IkXhus0zsF47R0aEmX63kW7n1bfNIi9F03nzk
	VislGem2oECorwgu4wsLuu1Ytp8X5UzbVL2AWgXBYk+fPeRp3unSTENNvCqQVRPs6fPXh9gBCyF
	2eDbnLB7iDrjyL4DHiZoMSogYiWuZF0E3FK6IFEmZsrml4tHZuhlSAOgz30b4tcg7suvs2Rd6dY
	7eJu8E1zz0qslZrglktyLuC1ZTOzcfqxtnhSadZNuGuKGoYINgmusSXFIePSlJRLjSvlYiIEpIt
	/6E3ZZ5b/1KmJrUcADJaxTnxPmkAZmi1VvBHNYmJxgdvdWDE03quP+aR9ejwTItfpehp0Ve7heX
	NIhubwMIINDraTFfz40Ss9m2WhSrWr5eRpV1Pk7D3XT1bcc/ySKr14p3N9h6hPQwIZTetG00YDE
	vaGBlxwROMB1TbzW30DYRbx0bZQuUuRQhWCXCXEoicbu0XpHg3PXsrZ5S/woQsn1u8gfvmyLJsx
	nkCplTb8QRTSW+dsY54GYLxcT6UZ8oB/A5PDKBSnTkvIfSJMmlxw12plHnuMPUfhRFCX3Y0g1l8
	6waiBfAUso5GvHJS63v/Xc6FBGnGK63YF4BsrrNOpMPjKFTnr1S8I6nZOMb37cEaSP/zQAjJvNv
	sM6MY5AW1PJ2rLs97
X-Received: by 2002:a05:693c:639c:10b0:36a:1f8:a56e with SMTP id 5a478bee46e88-36a423bb931mr1471206eec.23.1793324757946;
        Thu, 29 Oct 2026 18:45:57 -0700 (PDT)
Received: from anuj-MacBookPro.. ([2406:7400:63:75fd:f9a4:4062:7980:1324])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a428fa380sm2209020eec.12.2026.10.29.18.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 18:45:57 -0700 (PDT)
From: Anuj Gupta <anuj1072538@gmail.com>
To: axboe@kernel.dk,
	asml.silence@gmail.com,
	kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	James.Bottomley@HansenPartnership.com,
	mkp@kernel.org,
	bernd@bsbernd.com,
	joannelkoong@gmail.com,
	miklos@szeredi.hu
Cc: io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	fuse-devel@lists.linux.dev,
	joshi.k@samsung.com,
	anuj20.g@samsung.com
Subject: [PATCH v3 1/5] io_uring/rsrc: pass import flags to io_import_reg_buf()
Date: Fri, 30 Oct 2026 07:15:36 +0530
Message-ID: <20261030014540.3065403-2-anuj1072538@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261030014540.3065403-1-anuj1072538@gmail.com>
References: <20261030014540.3065403-1-anuj1072538@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261029_184559_794451_2C257209 
X-CRM114-Status: GOOD (  13.85  )
X-Spam-Score: -1.9 (-)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Anuj Gupta <anuj20.g@samsung.com>

Give io_import_reg_buf() the import flags argument and drop the
__io_import_reg_buf() variant, which only existed to pass them.

No functional change.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/net.c       |  6 +++---
 io_uring/rsrc.c      |  6 +++---
 io_uring/rsrc.h      | 13 +++----------
 io_uring/rw.c        |  5 +++--
 io_uring/uring_cmd.c |  2 +-
 5 files changed, 13 insertions(+), 19 deletions(-)

diff --git a/io_uring/net.c b/io_uring/net.c
index 533afd335627..5d0f7c0a1825 100644
--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -663,7 +663,7 @@ int io_send(struct io_kiocb *req, unsigned int issue_flags)
 	if (req->flags & REQ_F_IMPORT_BUFFER) {
 		ret = io_import_reg_buf(req, &kmsg->msg.msg_iter,
 					(u64)(uintptr_t)sr->buf, sr->len,
-					ITER_SOURCE, issue_flags);
+					ITER_SOURCE, issue_flags, 0);
 		if (unlikely(ret))
 			return ret;
 		req->flags &= ~REQ_F_IMPORT_BUFFER;
@@ -1242,7 +1242,7 @@ int io_recv(struct io_kiocb *req, unsigned int issue_flags)
 	if (req->flags & REQ_F_IMPORT_BUFFER) {
 		ret = io_import_reg_buf(req, &kmsg->msg.msg_iter,
 					(u64)(uintptr_t)sr->buf, sr->len,
-					ITER_DEST, issue_flags);
+					ITER_DEST, issue_flags, 0);
 		if (unlikely(ret)) {
 			kmsg->msg.msg_inq = -1;
 			sel.buf_list = NULL;
@@ -1536,7 +1536,7 @@ static int io_send_zc_import(struct io_kiocb *req,
 	if (!(sr->flags & IORING_SEND_VECTORIZED)) {
 		ret = io_import_reg_buf(notif, &kmsg->msg.msg_iter,
 					(u64)(uintptr_t)sr->buf, sr->len,
-					ITER_SOURCE, issue_flags);
+					ITER_SOURCE, issue_flags, 0);
 	} else {
 		unsigned uvec_segs = kmsg->msg.msg_iter.nr_segs;
 
diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index e0345c3e764e..e9e4221ef86f 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -1366,9 +1366,9 @@ inline struct io_rsrc_node *io_find_buf_node(struct io_kiocb *req,
 	return NULL;
 }
 
-int __io_import_reg_buf(struct io_kiocb *req, struct iov_iter *iter,
-			u64 buf_addr, size_t len, int ddir,
-			unsigned issue_flags, unsigned import_flags)
+int io_import_reg_buf(struct io_kiocb *req, struct iov_iter *iter,
+		      u64 buf_addr, size_t len, int ddir,
+		      unsigned issue_flags, unsigned import_flags)
 {
 	struct io_rsrc_node *node;
 
diff --git a/io_uring/rsrc.h b/io_uring/rsrc.h
index 418d236152ff..6226c7862d4e 100644
--- a/io_uring/rsrc.h
+++ b/io_uring/rsrc.h
@@ -66,21 +66,14 @@ int io_rsrc_data_alloc(struct io_rsrc_data *data, unsigned nr);
 
 struct io_rsrc_node *io_find_buf_node(struct io_kiocb *req,
 				      unsigned issue_flags);
-int __io_import_reg_buf(struct io_kiocb *req, struct iov_iter *iter,
-			u64 buf_addr, size_t len, int ddir,
-			unsigned issue_flags, unsigned import_flags);
+int io_import_reg_buf(struct io_kiocb *req, struct iov_iter *iter,
+		      u64 buf_addr, size_t len, int ddir,
+		      unsigned issue_flags, unsigned import_flags);
 int __io_import_reg_vec(int ddir, struct iov_iter *iter,
 			struct io_kiocb *req, struct iou_vec *vec,
 			unsigned nr_iovs, unsigned issue_flags,
 			unsigned import_flags);
 
-static inline int io_import_reg_buf(struct io_kiocb *req, struct iov_iter *iter,
-				    u64 buf_addr, size_t len, int ddir,
-				    unsigned issue_flags)
-{
-	return __io_import_reg_buf(req, iter, buf_addr, len, ddir, issue_flags, 0);
-}
-
 static inline int io_import_reg_vec(int ddir, struct iov_iter *iter,
 				    struct io_kiocb *req, struct iou_vec *vec,
 				    unsigned nr_iovs, unsigned issue_flags)
diff --git a/io_uring/rw.c b/io_uring/rw.c
index 3a8559ff4dc6..327215e0f8b2 100644
--- a/io_uring/rw.c
+++ b/io_uring/rw.c
@@ -360,8 +360,9 @@ static int io_init_rw_fixed(struct io_kiocb *req, unsigned int issue_flags,
 	int ret;
 
 	if (!io->bytes_done) {
-		ret = __io_import_reg_buf(req, &io->iter, rw->addr, rw->len, ddir,
-					  issue_flags, IO_REGBUF_IMPORT_ALLOW_DMABUF);
+		ret = io_import_reg_buf(req, &io->iter, rw->addr, rw->len, ddir,
+					issue_flags,
+					IO_REGBUF_IMPORT_ALLOW_DMABUF);
 		if (ret)
 			return ret;
 		iov_iter_save_state(&io->iter, &io->iter_state);
diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
index b5486b56ee0c..4dac3ba162ae 100644
--- a/io_uring/uring_cmd.c
+++ b/io_uring/uring_cmd.c
@@ -279,7 +279,7 @@ int io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
 	if (WARN_ON_ONCE(!(ioucmd->flags & IORING_URING_CMD_FIXED)))
 		return -EINVAL;
 
-	return io_import_reg_buf(req, iter, ubuf, len, rw, issue_flags);
+	return io_import_reg_buf(req, iter, ubuf, len, rw, issue_flags, 0);
 }
 EXPORT_SYMBOL_GPL(io_uring_cmd_import_fixed);
 
-- 
2.43.0


