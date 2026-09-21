Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32030C98305
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Sep 2026 15:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/FMRvm1BaZ6kTlzIVu1IAGTERBBcZPL0byDe3SvrYcY=; b=tub9OWBN1R8an7WmK9uCrWmKh2
	y4lksgNXf5FvGYJqulJPCOc7pp5qIrQldiz4DEd7bhJv1X3VianmdffR623WeiwXXEJoMOzY6UFol
	CHpR/jP9JwGTuUX1NtWyHZMn7KVM1xzPqGV42Jyg4v1XgmQ1G7UuhKXtYJHkSrzlGc9GeYh1bQQMH
	Pk+5tpVIc2TIT72EXNb/QyzDUo/q94qLChwWu4AkxXW3eX9Iw+4lYhQmcswiUFS4nhPMuMEBP9xRa
	ZOe+Tb80Y9YTrI9hL93byEoiIUUn/nGyaIkAZIMKMQv0yKIeAAs7yZvDJEhX0ZKqQkd+/qMJ4hufG
	/QDeDvmg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8fWH-00000002Vl4-1Omm;
	Mon, 21 Sep 2026 15:01:25 +0000
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8eFX-00000002GdQ-2ydw
	for linux-nvme@lists.infradead.org;
	Mon, 21 Sep 2026 13:40:04 +0000
Received: by mail-wm2-x11.google.com with SMTP id 5b1f17b1804b1-49e71cdb22bso22408455e9.2
        for <linux-nvme@lists.infradead.org>; Mon, 21 Sep 2026 06:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789998002; x=1790602802; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/FMRvm1BaZ6kTlzIVu1IAGTERBBcZPL0byDe3SvrYcY=;
        b=BCi3AuQvv1Co9JWJC5FnhLWUjnVONZQGLtZ7r7IAF8KlkiAG4buQcMJfW1fT+RB0S4
         sLizKNyJsav4oj0kno3oIHpvVY8fAxfxU09Gv7p0gQAUY1/ljFjZzlUgMlXeidDFFLFk
         x1oXVRLOgU732G/8WEnjy2kMxjEB1fH+tl7mQGVst0zXG4VcyWaOijLo1RjQ54Fnp/wy
         eW1IncadsEy/S4q6JGyJLivGUxFIczAF/K6eFky7F4U80VVYUd3Sf/u0fSx32eTrlJx3
         MgUm6fAcI1p7bOuMvRFR4tw4ENVwI3zZSGLjk9OpqJdLauhKk8w64PizL+iiZXBeGHpT
         MhsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789998002; x=1790602802;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/FMRvm1BaZ6kTlzIVu1IAGTERBBcZPL0byDe3SvrYcY=;
        b=egRoIu31yDwVHtm4WPVL9FqqMPnqQHhwYhyt2E+bObOx+51hDk14LpHfSPs9BzsGGY
         nzQrj4C+dwztHfgGKTNMp3Ane+O43LxfS6yJS/aBGBDKmT7EakLqCT2yuDEmLnID/t3M
         rKEljjAq2Ce3uTK+TS3adZ32EDd6YKf2uvQ8MeqNmbHK1CrX9wDu9NVb4ickbyInOpl+
         fvhu+tpmH0VuTUz0BMc3kNBKyIN9wH8q4bwHDjjf1/DQ9V+rpcSvDo4594krpV+9g+Fu
         GkdXIaOZtDEchWpA67+6cFkb0SzPLcAdVeNOQVHmuglVPqxqsLUZhp06mVJgaftevBsT
         W42Q==
X-Forwarded-Encrypted: i=1; AKwUvBwV7MRmjTLRDizQ4nqcMIzZPPbh+NMP2CcNDQ5ETKZS8d+usTQ+V7Fy8MU1Defk9zlYjLbUXEyEzAWg@lists.infradead.org
X-Gm-Message-State: AFuF++kbXom7E99IfA12JSkhUbbiHj4EiZ0+uaemqsIgKbh4q1S3hTUS
	7yuavCXIKmG86A7HwSeDEJ52+//pcjZDQo42g0Ce7EuapunWLde1gC5W
X-Gm-Gg: AYBFou1/QxeGaPNCYIlzPTbK+IQEKWkQ9eI1+eQ/uem3STdmtrsCxChgr4oUXKha42G
	1OGx0k993HT0yZO5qwu7R8x8YPLsvXXj6G2n35+yfIMGcpPbuq1fa+IQxlU8cVUTt0JDxP06/GH
	L+2ASo6hTFqCF8BupGOZUcva2LeqjXwdvVb/9BuDIPq0bnGg3msjueC3z8HatFkuzVsjB2wF4jL
	6pqE5hmtoRTbuoJrHX8uGIYiRSd2aTFou7MH1Rtsiz5GaEQAxfL2vl4ie3wodv8qLVuErIRerp7
	VLDpKmVMd+7hAZiOvS+grpYv8WIalAms4jG0t6v1rAiAKfOmsWcRf3V/fwNJpuEtD9L93wGSAzP
	jNQTj4tHRK/K4HjwREVWfk8ve0JoV/hs9OYCLMzcnrZH3UxZm6NGNNvXeEDFAU6Ep3uHdUlHwNm
	9kLpHa37hGVjAxPLEBBLRnI9Sd3Ae9IZBkhBH3ai0+JPHX1uZ0bu878WblGoQTfjzfpeUWitf7j
	KUXVneTu+Jw7oqWpRWZQ5gBYxmEdLdbMzvKoRMW70s0oX796qsGDsKRItpq+gRnkUMpnf/YCPO+
	99at9CbtWXjFQOpt7XPmxhA2g6xkjw==
X-Received: by 2002:a05:600c:3107:b0:49c:ff9f:f6b6 with SMTP id 5b1f17b1804b1-49fc5669346mr153997265e9.6.1789998002057;
        Mon, 21 Sep 2026 06:40:02 -0700 (PDT)
Received: from 127.0.0.1localhost (82-132-213-26.dab.02.net. [82.132.213.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fc585920fsm617171605e9.4.2026.09.21.06.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 06:40:01 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: linux-block@vger.kernel.org
Cc: asml.silence@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Tushar Gohad <tushar.gohad@intel.com>,
	William Power <william.power@intel.com>,
	Phil Cayton <phil.cayton@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Benjamin Marzinski <bmarzins@redhat.com>,
	dm-devel@lists.linux.dev
Subject: [PATCH v6 12/13] io_uring/rsrc: add regbuf import flags
Date: Mon, 21 Sep 2026 14:38:56 +0100
Message-ID: <a7b154185897c7cd23de143f5bd834ef73cd7723.1789997898.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1789997898.git.asml.silence@gmail.com>
References: <cover.1789997898.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260921_064003_775811_1533CB0D 
X-CRM114-Status: GOOD (  13.90  )
X-Mailman-Approved-At: Mon, 21 Sep 2026 08:01:23 -0700
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

We'll have special registered buffer types that can't be used with all
opcodes and need special handling. Add separate flags to control
registered buffer import, which will be used to specify what kind of
buffers the caller can handle.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/rsrc.c |  8 ++++----
 io_uring/rsrc.h | 24 ++++++++++++++++++++----
 2 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index 0b526b094dc9..79e3c686ecc1 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -1298,9 +1298,9 @@ inline struct io_rsrc_node *io_find_buf_node(struct io_kiocb *req,
 	return NULL;
 }
 
-int io_import_reg_buf(struct io_kiocb *req, struct iov_iter *iter,
+int __io_import_reg_buf(struct io_kiocb *req, struct iov_iter *iter,
 			u64 buf_addr, size_t len, int ddir,
-			unsigned issue_flags)
+			unsigned issue_flags, unsigned import_flags)
 {
 	struct io_rsrc_node *node;
 
@@ -1709,9 +1709,9 @@ static int io_kern_bvec_size(struct iovec *iov, unsigned nr_iovs,
 	return 0;
 }
 
-int io_import_reg_vec(int ddir, struct iov_iter *iter,
+int __io_import_reg_vec(int ddir, struct iov_iter *iter,
 			struct io_kiocb *req, struct iou_vec *vec,
-			unsigned nr_iovs, unsigned issue_flags)
+			unsigned nr_iovs, unsigned issue_flags, unsigned import_flags)
 {
 	struct io_rsrc_node *node;
 	struct io_mapped_ubuf *imu;
diff --git a/io_uring/rsrc.h b/io_uring/rsrc.h
index 73d7b1ebf0b6..351995b61e68 100644
--- a/io_uring/rsrc.h
+++ b/io_uring/rsrc.h
@@ -62,12 +62,28 @@ int io_rsrc_data_alloc(struct io_rsrc_data *data, unsigned nr);
 
 struct io_rsrc_node *io_find_buf_node(struct io_kiocb *req,
 				      unsigned issue_flags);
-int io_import_reg_buf(struct io_kiocb *req, struct iov_iter *iter,
+int __io_import_reg_buf(struct io_kiocb *req, struct iov_iter *iter,
 			u64 buf_addr, size_t len, int ddir,
-			unsigned issue_flags);
-int io_import_reg_vec(int ddir, struct iov_iter *iter,
+			unsigned issue_flags, unsigned import_flags);
+int __io_import_reg_vec(int ddir, struct iov_iter *iter,
 			struct io_kiocb *req, struct iou_vec *vec,
-			unsigned nr_iovs, unsigned issue_flags);
+			unsigned nr_iovs, unsigned issue_flags,
+			unsigned import_flags);
+
+static inline int io_import_reg_buf(struct io_kiocb *req, struct iov_iter *iter,
+				    u64 buf_addr, size_t len, int ddir,
+				    unsigned issue_flags)
+{
+	return __io_import_reg_buf(req, iter, buf_addr, len, ddir, issue_flags, 0);
+}
+
+static inline int io_import_reg_vec(int ddir, struct iov_iter *iter,
+				    struct io_kiocb *req, struct iou_vec *vec,
+				    unsigned nr_iovs, unsigned issue_flags)
+{
+	return __io_import_reg_vec(ddir, iter, req, vec, nr_iovs, issue_flags, 0);
+}
+
 int io_prep_reg_iovec(struct io_kiocb *req, struct iou_vec *iv,
 			const struct iovec __user *uvec, size_t uvec_segs);
 
-- 
2.54.0


