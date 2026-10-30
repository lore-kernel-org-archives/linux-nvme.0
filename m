Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C296E606A31A
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Oct 2026 01:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=4Or9q2LP;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0PhO5wQY
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=VA9n7u5udKY5o86NILqNHNelhcHr5Omn4I4tRtC62Fg=; b=4Or9q2LPJnbrI+
	OXr0g+8U9du+QO8tM7anmlRRZ2trucNv69opdnFs0wKu3CBAxTtIRTt5JdgsCCUJWuJO8Tp1BeIwu
	hTGtLSA+UPrSoPBv3YHBAFMWD7X1tVUgGIbX+vfDcVcJSt+BWEBOtiSq5GCqYxVMaB5+4cxFyryOs
	csxXFdG0MRA8dwO8QG3BMpdiH38IxyKcCr/r6umEdZeD5ymiRc4yCac0SXtKT9kExOcHvPusr1Bm9
	PG/6CnNVqXP6C/Gz9c0ow58FqiOGzeU9oSp9NAy3rKcHzYH0KRm2oVQKJmc9tiF6Z4ZukO7vOQ0i4
	ImmbZfpqWpfcntKNNHiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMbh2-0000000Ad4j-22jB;
	Fri, 30 Oct 2026 01:46:08 +0000
Received: from mail-dy1-x1335.google.com ([2607:f8b0:4864:20::1335])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMbgz-0000000Ad38-1J4a
	for linux-nvme@lists.infradead.org;
	Fri, 30 Oct 2026 01:46:06 +0000
Received: by mail-dy1-x1335.google.com with SMTP id 5a478bee46e88-36a18fc7a38so631504eec.1
        for <linux-nvme@lists.infradead.org>; Thu, 29 Oct 2026 18:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793324765; x=1793929565; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VA9n7u5udKY5o86NILqNHNelhcHr5Omn4I4tRtC62Fg=;
        b=0PhO5wQYm+4bKft0VrmUKtTbkcsEzHGa39lE1pih8b+tc4YXYUokgM+K0gO8rQ7Tib
         iEmzG9N8C+a375F48mhWCHbyp3t6VKKev9q7UbnOzaetvDh8oOrI14XnN3FK3YZGvmxT
         NYRtaRei56qXDge5gKwvV7FmkOijIqb9Cw+wcIjSHR18UvOX90HwiFtmUFOgpqdrm3Cv
         8N5v3P5UcsZW53QRcvd8CyBnGlRN2urzN4c2BFx4uHhvFkmXRN/8ekgUoEPCQlXngjFk
         pkg5+nb9qUpeFsz4/T0vyLYKap4Y5Nd7cWhUCgKWrtwx1ri5klZYrn7iNJ4JIQ6FELBL
         d9AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793324765; x=1793929565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VA9n7u5udKY5o86NILqNHNelhcHr5Omn4I4tRtC62Fg=;
        b=wV348wclq5eOXX/JG8eBRQZZNdAkQX05BYIfgn0BB9HWJjTp49O7cZJYBMBdbbutTW
         YkKTTIuryQI7jJeu1dWrdiJCaHki67z9PV3rJ9JaSfc2ypYdI4YHDQcRPzaix1ZoH1KU
         JNyFwpP5ihOzY+03BKZy/0X4aIEEJWNR/YGdt8iAdPFiGl6IxI1N41SEcObkgeEyX8EH
         DHUz3Pw9kJsPXlqnxVsJ1lNrzZGl3pVTSf+vD4GM8cLFQx2wFKyWm7sezw/bYq4xRilQ
         6h3/v+K5BZnbqsGDqcwn2DZ5jghcIdvDsdtr2OgT9ZStW0Rv91D7GevkQf8OQsAwFnGR
         4zKw==
X-Forwarded-Encrypted: i=1; AKwUvBy5eb+BiGvNV24gANRrNvc3eqodgnJL4/c6ozdk8oLtnzT6M0QmlpGuD1jOOtzSkcu+G7uRy0lNbIhP@lists.infradead.org
X-Gm-Message-State: AFq9FYIhNgQ/m/YM1TFnnKJ5k3Yr0mqlJSOnd07/nBa+lSZdmAEwyEw5
	35QnNg0YLDmd/UzB0oI0bYU/jA53OcUH8wtrYriXSad7Uu3jGaw+StY=
X-Gm-Gg: AYBFou0mWPmwKuibwV/sJZ9FCDPXC79zXwn5xzRcR8w063z6QHDtswzdEkz7Qlgbtgi
	VKb1PGZiHLNfqkqTxOml5IGlG3KzrCUuHeEM10thByENzwFkNf0mq2kPWsN3v5gW0QMMwzN4jpV
	ZEkTEfd590JVUEBNVEAO9iby82wncKnskcbp64VTQ7/z4N0W1WPWdu75tRZ6wzQUfs83TtXramr
	VvmO56c1xhe07Zp5rXMUGY6keNH7YxIAPJLEvcnvzt/8pEaElLM7/kBa97q3LSAVassAXBa5IIi
	nof5hX5EnLzDWoUh7R5yh6HIn1sEpsiA8fCWo7L6YGICVr5312HnMpknDJ4NE2jKawjb9+7ZTl/
	Rp3uEuKTAIYwC+BdDD65xEwOw/B2ckP4BhN1G9FiWxy0BuPDyTS0u73s125mXIOcxCJoD0SNkxd
	5yUYvKotvJ7p4HNdy4/XWjsgtsJq7FFJLk2zRqehcPnTh6iN5dGpzERkCBGsJ15JosP+IXtG93J
	T5ydpWpq8XesFaKk/UPgoMvYUyzsQW/8dqZBpMk9w9v8o+3sk583xQKpwN7j9gw99TFhkHGB/8T
	6gzRZ8+8aOLucyCn5EZ0Sy1eDNni/UuICPl6sfvGjToJdqUnhDSdMAFiAFSMId12PcSvYZsnn3g
	aPg/bK3t8vtAm4SC0
X-Received: by 2002:a05:7300:e918:b0:35c:de00:93d3 with SMTP id 5a478bee46e88-36a4247d812mr1334717eec.40.1793324764241;
        Thu, 29 Oct 2026 18:46:04 -0700 (PDT)
Received: from anuj-MacBookPro.. ([2406:7400:63:75fd:f9a4:4062:7980:1324])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a428fa380sm2209020eec.12.2026.10.29.18.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 18:46:03 -0700 (PDT)
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
Subject: [PATCH v3 2/5] io_uring/uring_cmd: add import flags to io_uring_cmd_import_fixed()
Date: Fri, 30 Oct 2026 07:15:37 +0530
Message-ID: <20261030014540.3065403-3-anuj1072538@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261030014540.3065403-1-anuj1072538@gmail.com>
References: <20261030014540.3065403-1-anuj1072538@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261029_184605_408599_6C6FD3AA 
X-CRM114-Status: GOOD (  13.58  )
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

Add an import flags argument to io_uring_cmd_import_fixed(), so callers
can opt in to buffer types they support. No flags are defined yet, and
all callers pass 0.

No functional change.

Suggested-by: Pavel Begunkov <asml.silence@gmail.com>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>
---
 drivers/nvme/host/ioctl.c    | 2 +-
 drivers/scsi/scsi_bsg.c      | 2 +-
 fs/fuse/dev_uring.c          | 2 +-
 include/linux/io_uring/cmd.h | 5 +++--
 io_uring/uring_cmd.c         | 5 ++++-
 5 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index a87c9ca9d06c..d342ccad067a 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -533,7 +533,7 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 					ddir, &iter, issue_flags);
 		else
 			ret = io_uring_cmd_import_fixed(d.addr, d.data_len,
-					ddir, &iter, ioucmd, issue_flags);
+					ddir, &iter, ioucmd, issue_flags, 0);
 		if (ret < 0)
 			return ret;
 
diff --git a/drivers/scsi/scsi_bsg.c b/drivers/scsi/scsi_bsg.c
index 5eec248a77a6..e53b417c27b9 100644
--- a/drivers/scsi/scsi_bsg.c
+++ b/drivers/scsi/scsi_bsg.c
@@ -87,7 +87,7 @@ static int scsi_bsg_map_user_buffer(struct request *req,
 	if (ioucmd->flags & IORING_URING_CMD_FIXED) {
 		ret = io_uring_cmd_import_fixed(buf_addr, buf_len,
 						is_write ? WRITE : READ,
-						&iter, ioucmd, issue_flags);
+						&iter, ioucmd, issue_flags, 0);
 		if (ret < 0)
 			return ret;
 		ret = blk_rq_map_user_iov(req->q, req, NULL, &iter, gfp_mask);
diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index c6dd420c4034..5cc206abccc0 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -727,7 +727,7 @@ static int fuse_uring_import_payload(struct fuse_ring_ent *ent, int dir,
 
 	if (bufpool_registered(ent->queue))
 		err = io_uring_cmd_import_fixed((u64)(uintptr_t)base, len, dir,
-						iter, ent->cmd, issue_flags);
+						iter, ent->cmd, issue_flags, 0);
 	else
 		err = import_ubuf(dir, base, len, iter);
 
diff --git a/include/linux/io_uring/cmd.h b/include/linux/io_uring/cmd.h
index e18d4af62e1a..23fb66a1e2c1 100644
--- a/include/linux/io_uring/cmd.h
+++ b/include/linux/io_uring/cmd.h
@@ -64,7 +64,8 @@ static inline void io_uring_cmd_set_res32(struct io_uring_cmd *cmd, s32 ret, u64
 int io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
 			      struct iov_iter *iter,
 			      struct io_uring_cmd *ioucmd,
-			      unsigned int issue_flags);
+			      unsigned int issue_flags,
+			      unsigned int import_flags);
 int io_uring_cmd_import_fixed_vec(struct io_uring_cmd *ioucmd,
 				  const struct iovec __user *uvec,
 				  size_t uvec_segs,
@@ -124,7 +125,7 @@ int io_buffer_unregister(struct io_uring_cmd *cmd, unsigned int index,
 static inline int
 io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
 			  struct iov_iter *iter, struct io_uring_cmd *ioucmd,
-			  unsigned int issue_flags)
+			  unsigned int issue_flags, unsigned int import_flags)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
index 4dac3ba162ae..d77a94d19cb5 100644
--- a/io_uring/uring_cmd.c
+++ b/io_uring/uring_cmd.c
@@ -272,12 +272,15 @@ int io_uring_cmd(struct io_kiocb *req, unsigned int issue_flags)
 int io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
 			      struct iov_iter *iter,
 			      struct io_uring_cmd *ioucmd,
-			      unsigned int issue_flags)
+			      unsigned int issue_flags,
+			      unsigned int import_flags)
 {
 	struct io_kiocb *req = cmd_to_io_kiocb(ioucmd);
 
 	if (WARN_ON_ONCE(!(ioucmd->flags & IORING_URING_CMD_FIXED)))
 		return -EINVAL;
+	if (WARN_ON_ONCE(import_flags))
+		return -EINVAL;
 
 	return io_import_reg_buf(req, iter, ubuf, len, rw, issue_flags, 0);
 }
-- 
2.43.0


