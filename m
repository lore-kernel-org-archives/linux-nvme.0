Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2A77CC6B34
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Oct 2026 15:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ays4SVba18pfRPB/Hpqu6QDaxGmpKJaoA/2lD097Khk=; b=e01P72qlVKkpb9/8l+BUlChx5g
	C26ciwgtIKvNBc2JiiiQW6h5PFPVHlkRmBFbsr1XG52GeVtJKIFTaZQNWju6DwAA6i8i6bHdrqdr9
	huq331OyjrlJG/kaufUnD6JoECSvg4uUkdg32dVJzsgjkv/J++1QWOCdy8RNQLasKBISCmIvEJBAl
	fBjOFAAhEuYULVGBxDlMl4j62VGCmebsWNTRTloqt0jH2H5mI8V69qEhsRhpKlAW5TqCClXbJ5yOX
	nfOqrLv+qwsG1QJP9pNDoTgFBP4hShwUh4hahYHMeL6hznxqM4Tc3KP22Q0izAvRndKqovmcEDMxX
	ukjX1nsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHMxx-00000000TcS-0AGs;
	Thu, 15 Oct 2026 15:01:57 +0000
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGjXG-0000000E3Nt-3wmo
	for linux-nvme@lists.infradead.org;
	Tue, 13 Oct 2026 20:55:48 +0000
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-48af27fe287so2974084f8f.0
        for <linux-nvme@lists.infradead.org>; Tue, 13 Oct 2026 13:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791924945; x=1792529745; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ays4SVba18pfRPB/Hpqu6QDaxGmpKJaoA/2lD097Khk=;
        b=rE3JOROvOZx15hb0N/EOPaVZKADc6k5muWdZ5isM1r/x56zmWkF9eMiSSdbOqJRNag
         yrJqGIxpZlFNe5SU4aW63qmsLYhT4sDKOIfjLFdgGfhqLxDVqfUA0jeVdOVL84Xp/2fN
         BIwXxkR92EJZdi7DbLkMJi8MHyGJ4Wp17RIMNTFdM14vEJiEqFFqv0h990zmslrMOBuU
         xoDxSivDDiBo8jC2BJk+iw8CcNVk5F7L7ObhpwxEe8Uhgp/QY+HjMsOPq77yH1nxfcc2
         HkN5HFeoATe5joZXTeDM1rE7kKZZ6+k0KflZdXc3J4WiegHP5+WJz/oc2+wSLpBTTMqV
         wRaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791924945; x=1792529745;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ays4SVba18pfRPB/Hpqu6QDaxGmpKJaoA/2lD097Khk=;
        b=HdRfmWsVyF2OBZYP6X54LjToqfk+4ONer6VkLggURWnWqUwKTVjaqYY0uq1+QwWQBU
         NyNQ6PyIS5WEHSALHTQZ5Y3uxf7TffsiTq/G6mfmFTo3G1Nk3lsSbBFXR38OE5yh5K4O
         m6652IxfbsGHOsXYh5rFcj7gul+XTUzilX++49U0J7LrbOUGkXen0j2+ApjF9OxA9UnM
         Rw4VyJQVWANqsv67E2cPW2bq8JQPkVJLnAA7CDfjNhohi2E1suKSyUdmwYVgFjqauCG2
         13bYR0+WrkubP4+c76nFhr/PbbMQYC+DyDSEOMa3IQ2FVtejUD6tRgzF9zk10vNFQPtC
         hh0g==
X-Forwarded-Encrypted: i=1; AKwUvBwH6fBBYL9JHwt3H+JYoL4CyRjJypWUdjw/ShCicqBcH8SivO5Xv6qb30GdF9B2O//5FvLWG14azsew@lists.infradead.org
X-Gm-Message-State: AFq9FYLQEAjRrEw51yUJWYkcodYh+RW6ryqvita61loYUHYDYo87XEhd
	GTZElvDt9NQFfgWGpJdFDjosY9ueVLT3WrYvb02xKwejqUOvjnEgZEnm
X-Gm-Gg: AYBFou03kohqyJ2BfgFxwqZJcTnvVQP1lvnHytAg1QguAQIGmK9XdQiolceACckjMOD
	DPsoCK4Ns9RiZeovGyANK2kwTVBUQ57Vl8XPMeKI/H3mdmmhWLasT7CUzfZjwHb5DL+ich5upeZ
	Z95+Pw7fDoxBnG9vCL/48+1iWJFiUHzzbrzsNTPsoTe9+3CUI/c1TljzxXZgIG7Ah7StsDTQCVB
	sG9JDNx4VEcrKSbjJZJMRnczF4lmgQuHGdalE+g9oSSdIzEcgD18AIZQ6DoXIRBE11tINhvE51s
	HTtztA8jDnTAyI7eNwQM2dB7AQiR+A7fOxX/1pSv0gTfUTjWtAvhsUOpOywd94nAkEYgeqcLba4
	Yj/hwjkJy8lnA5CAJ0iF9E2k9nRSoHbRldzvruRdMSh38BE5oGWnfByLr5xfq76JQQ7wcWrLa49
	0Q6L6PAE1seG/L1TWXcPKF4vbigVvUXFLoFCNitM+A/EKzaPhwO1gy12hrkK0DYrOkdy95BZL0O
	Zeqb8yQu4jvJYnOLNI2XDtxFvINtMVQXbevhW9cNfRZ67+9UcR8KfOy14a0hwNk50IBcvjT7kTp
	EZ9XvTNVTc0=
X-Received: by 2002:a05:6000:27c6:b0:487:27f9:82b with SMTP id ffacd0b85a97d-48dbaae34e3mr16754768f8f.32.1791924944821;
        Tue, 13 Oct 2026 13:55:44 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de7273a0esm2380730f8f.29.2026.10.13.13.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 13:55:42 -0700 (PDT)
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
	Matthew Brost <matthew.brost@intel.com>,
	Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Benjamin Marzinski <bmarzins@redhat.com>,
	dm-devel@lists.linux.dev
Subject: [PATCH v10 12/13] io_uring/rsrc: add regbuf import flags
Date: Tue, 13 Oct 2026 21:54:56 +0100
Message-ID: <4b7c13d9860640499460862c8cd4a13602ca174b.1791924581.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1791924581.git.asml.silence@gmail.com>
References: <cover.1791924581.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261013_135547_004897_B495E322 
X-CRM114-Status: GOOD (  13.65  )
X-Mailman-Approved-At: Thu, 15 Oct 2026 08:01:28 -0700
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
index 532866a1e9b9..f42d201738cd 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -1317,9 +1317,9 @@ inline struct io_rsrc_node *io_find_buf_node(struct io_kiocb *req,
 	return NULL;
 }
 
-int io_import_reg_buf(struct io_kiocb *req, struct iov_iter *iter,
+int __io_import_reg_buf(struct io_kiocb *req, struct iov_iter *iter,
 			u64 buf_addr, size_t len, int ddir,
-			unsigned issue_flags)
+			unsigned issue_flags, unsigned import_flags)
 {
 	struct io_rsrc_node *node;
 
@@ -1733,9 +1733,9 @@ static int io_kern_bvec_size(struct iovec *iov, unsigned nr_iovs,
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


