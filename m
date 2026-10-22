Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A509606A31E
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Oct 2026 14:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=UNCih01I;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NggCsbYF
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=zxlzuK4b3EjXwKJngq0cBhTK9G6JWxv2Wu97XDb3XjU=; b=UNCih01IMiGxz/
	hBgZPnJtbphQsXSSBF7FXiwcTMG2Z6MdDKU1dAGFM36m2YCAi1uCmjG0qqLiXGLW8REGlJqNpI9ih
	AJhMPV6VsIEGKgk6G5ha4lFtHuKAhQkfo0xXLoRltkoxxcci6ra/kWh4uHdjZuQZnWzZ8eLzcQ0pd
	xmaNG+v1sP5b1wiiQJFhGtrJlIAiWDecJulT55/IecAQrSzWb6TqpwQwD7T8y46MIJnVILIiEq6Wq
	m/hi/8gVDaNF/WwZ628N8kezanPsFLJfdrMaEn9rfbLZwlp2vlPDojmeElqueFHV5crVKD6XthHuk
	y6iu4HtubS0oH6ViWFlw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xJu3L-0000000EKiF-0GGS;
	Thu, 22 Oct 2026 14:45:59 +0000
Received: from mail-dy1-x132d.google.com ([2607:f8b0:4864:20::132d])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xJu3I-0000000EKgq-2bsq
	for linux-nvme@lists.infradead.org;
	Thu, 22 Oct 2026 14:45:57 +0000
Received: by mail-dy1-x132d.google.com with SMTP id 5a478bee46e88-35829219da8so1123420eec.0
        for <linux-nvme@lists.infradead.org>; Thu, 22 Oct 2026 07:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792680356; x=1793285156; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zxlzuK4b3EjXwKJngq0cBhTK9G6JWxv2Wu97XDb3XjU=;
        b=NggCsbYFtElib6nHiJw8y3G7JAShS9MIyubC8VK5Ol3/b1O66COF5r3Kr7rax4YGjI
         PWf6ZXld1EWvfvFw7/YsjG13u3KeJaBxT9n2jqMfUq1YI1Y50wE3xnCSE+AgOtN5D48W
         JAB+humJPQ2dJOIgq8MzzZ/b76QKOJ7LsXP6Ys+uM6SN80bTra4UXWARXfgjEL67OyVE
         WqU5fs11X4/sv6lUS7uvZ69ukOAtBvacknjchBsKbhbOM+6bzx6oSDY5wMOGZsdIuQdO
         x4GfGn7A6ugyxfC+nn300ZMsTspKMiTkBhryuFH2qyuTvoN5y6KVjX5kDkagXXJIYeku
         VYKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792680356; x=1793285156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zxlzuK4b3EjXwKJngq0cBhTK9G6JWxv2Wu97XDb3XjU=;
        b=2rbW7gg5j5KeGn1xoMQWsOIujKQZK1eSzA5cFojuYjOy+PXKqPrrD9IyPKFj192aNe
         5Za518IP8tGVDFj3PLQKPM37ALFNw+csnrhyPlDMyYToMdndm/t4+mIIGqUg4P5VmYjM
         NulOYBswoz0Liab7gOAdYSwPSZN5mwDWm6WQFHwfEtIBZr9HGSf6h+m2eUWeSYkxQWeK
         emyZC65NXPxxKxAlqHkuYMZpVwoTM722AiqQFCa/T2xajTZYjPI0sm6IaV67v/CBmoVq
         HSr3QLLpm5UwQuaw4qYyfX9SpLdOrGyeXavy3Zc6Ax047IPqHhpwXyv1V3F4kcEIHWdf
         YipQ==
X-Forwarded-Encrypted: i=1; AKwUvBzj0p4FShNWS0s5HUa+1udG/xcVqVPASID/gQj/tH4CjQP1mqFLA79UW1L+PnsIBecLxZPkGzzsfZDY@lists.infradead.org
X-Gm-Message-State: AFq9FYI/0dGM3c1qMQfqFsMi6tAS1uYyKEBQvNxZUCD0KRyyEczELZ4C
	b1MjcleZKN7D9doD7CN1tTZhxAlp7vUfAwfxdr4Y/pzDDq5VgAXXNZ8=
X-Gm-Gg: AYBFou18B8x0ZURtx0Xu5gd+S2aCSvIffOthx55DKPZwljxAYMWQc6jVrkkvKyevMRN
	v2ao/pqUrMJ67idCf+d7T/WrjjCSz3c8CT1Ou4BrgPOMAaYvNIH+rULQetjpow7B3NnyYA5H91C
	Q4NkxeKZswm784f+LCqC7A7qiai9o91aPzvikHZslPqf/SkvaFuwqZtvQO5Lfy1pSQYCkko0lmN
	W6j+fcl1mXk1qBLvE2MxOT2Qu0f7WUDhaHwsTbZxW8egsgvHPOyR7Y8eievRluuhSNSLG+mPgbJ
	XxFxgcg9cT4hBY0pI/q56M6xL9Nqj9JmNEvuh68IMm6SHQvEHJvl95fwhL8aEZxczSoHz91J3r9
	fLsAwXVQcPrdQNfV7rcfCrm56dJglUEru4Jp0K4tFGm2pP84oaFWj/uu1ck9Hpr2VsBertznjZE
	f5SIH51+l3dYoVlYNuGSIN5FkF8l3hvdr+8/l7G/iMSEVrRAY3uqewDRD/VEfm8mskLtc3ba4IO
	f23o9maWaaI6j0o8F0MFr3hL/Csgl37KuaqM/qs4hkzm5ZRjrepSgHKv3OmZtrAvvNsqVTELoeh
	xKtnaZaCpMbVkIElHtZMRLt3N0e7SvQpt36831J1d7M=
X-Received: by 2002:a05:701b:4241:20b0:15d:d7a2:3a88 with SMTP id a92af1059eb24-192f03cb835mr3210408c88.18.1792680355569;
        Thu, 22 Oct 2026 07:45:55 -0700 (PDT)
Received: from anuj-MacBookPro.. ([2406:7400:63:e55a:5016:92c7:7a35:f3ff])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1903a275026sm23625880c88.5.2026.10.22.07.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 07:45:54 -0700 (PDT)
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
Subject: [PATCH v2 2/5] io_uring/uring_cmd: add import flags to io_uring_cmd_import_fixed()
Date: Thu, 22 Oct 2026 20:14:53 +0530
Message-ID: <20261022144501.2478417-3-anuj1072538@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261022144501.2478417-1-anuj1072538@gmail.com>
References: <20261022144501.2478417-1-anuj1072538@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261022_074556_673768_2A1DD590 
X-CRM114-Status: GOOD (  13.99  )
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
---
 drivers/nvme/host/ioctl.c    | 2 +-
 drivers/scsi/scsi_bsg.c      | 2 +-
 fs/fuse/dev_uring.c          | 2 +-
 include/linux/io_uring/cmd.h | 5 +++--
 io_uring/uring_cmd.c         | 5 ++++-
 5 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 3aa5d2f2dfbb..612d3009dd29 100644
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
index 45c9c845f5d0..c2bc9dd242ec 100644
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


