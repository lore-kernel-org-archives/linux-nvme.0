Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F060606A31A
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Oct 2026 01:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=45gN+6uK;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=h0ig72qY
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=SF9HmYpsqJyt4I9c/G5LCdmVYCdb7Ms79eOZlmLUUW8=; b=45gN+6uK9Ryhqw
	aesu5Xu041UU7cutLHj1S+UNzjF40o3S0Ab4RqytSxF+T1hPiM0usDws7zmUEA1Q6Eu1no0m6VrOe
	5jsguGGDpWZm+twjJh88bRF1AIEUqm1w/TSXq2rhwG+07/V2iIZMoIwimbVbxi1U5E7efQUPHQ9q4
	whklG4A8gw0+73Xq+K/QZAe9+aVnW5RvzZEQmaYXbHwHMZxKBKPSxrCXJn1nWs54GbFntxa/VI5mG
	JByqQYCQJ4WgGgmV2AU2zcoBlkIKh6SJCR+cVbDkFZBM2QveKS3TSee2aEijBhSmxX/d/OEPs74+1
	EpoLD3fjIEeii7igqOuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMbhL-0000000AdFj-3qrg;
	Fri, 30 Oct 2026 01:46:28 +0000
Received: from mail-dy1-x1334.google.com ([2607:f8b0:4864:20::1334])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMbhI-0000000AdDu-2whK
	for linux-nvme@lists.infradead.org;
	Fri, 30 Oct 2026 01:46:26 +0000
Received: by mail-dy1-x1334.google.com with SMTP id 5a478bee46e88-35c76e9614aso410072eec.0
        for <linux-nvme@lists.infradead.org>; Thu, 29 Oct 2026 18:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793324783; x=1793929583; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SF9HmYpsqJyt4I9c/G5LCdmVYCdb7Ms79eOZlmLUUW8=;
        b=h0ig72qY23P3w/9/htdG4Tpvii0nUly4SODWnwAUg9z1AOAUW7dQIXm6na2JczTnNS
         GZL9pSRfW9yEGAFPn/5gBds1PnHCVhK/HqsjExkHYryH/xPX5uzUEjNUz6Ly01ovMceS
         qDrc9U4tW187ZwSxw2Zz98fxINjTnbwO8uhdlMsBtDz4sfXiL+wF/reWuXPbltzd4Rfq
         lP15aNyUnthWWjZcS6J9hwTzK7ZIH/bJW7oCWcQAeISYZgo+Pa6NemzWWCHoSjuVePo9
         dilUwAV079Un2Gwm0dEmdPk9qTSihA+FftPr+buV5hQ4uls1ybCcf8zjcNYVXRo87xy4
         excw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793324783; x=1793929583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SF9HmYpsqJyt4I9c/G5LCdmVYCdb7Ms79eOZlmLUUW8=;
        b=f/AU1qdNqjH00VEtAxV6otzGPpNGwrItlhxboIxeba+0tK28WcYFuAFKxh2ZF8kfNF
         2GoCuIsKjK8VBe9xFckE6Lt+o91tM5DJvPb66qfLVLJTKPOZJb0BupEOE6TtqHeGqDei
         ekaEgodQ99PESAzUoqBnDQvF2uh3iHWhBXJ4l33ln8FyoLweastBA6cAClhdDKqRPJgR
         bjWPDMB6zsYPhEd2E2v7pCjq/pfCr/MqSCcQbsyiEnKqauldB4mFN2n7fH26hSaDRS2S
         wI7XkFzsj+9cETa1Y1+QNNRQxs9+A3fMvAHPpoS24sKSkBVgDhejVfKt0G8SEXLChuy0
         wKvA==
X-Forwarded-Encrypted: i=1; AKwUvBykfFqZEF68rj279Rboqs7gyy423nWs0E3NoiyR1VKZkkA2BvjxfSfxfKbcGuFOUJ8d1lZ+lg+T003/@lists.infradead.org
X-Gm-Message-State: AFq9FYJDFvUS76Jjt70P0yQZUEWG3TNS28pbfFXFHfIPQ+Mg3EifCiC/
	MXfDmUzmqcnjvyoYOuGrr1CDsl7TQ+vlHUmb0z2xHI7kPjfQtzhM/tE=
X-Gm-Gg: AYBFou3kZX9EIRSGa8eKCyTYAbnw/MQ2qmxkp6v8BE4mFxdbxmtOsDgk/prG/OSs8Lg
	KkHKHe4ReXcgMv1ZqzLfcP0fYkEOILG1edNb1sOQBpKUD2rSnlGS5iHHhHkEDpXKfjL12QIRWjE
	F3Fcyf3lJYieHSLr+xpPy4FZznkA1nLAenaFSL6UxyjF7SYyU4VLKh3HpUiRCCCgfMLFmfuYAgb
	mkrvA08Fd/h45v7AKUr8dzvG2iWjxLhRFFKmPxKNjc1sIJoEhB2ZBfTz0qyAkTp/+Ety34NVBJF
	Rqvlv30XEcHY8BeYJu04tAhXvhjkrgaz8z0O5Homst4n9k4N4YtWBRlKZ96x5Psmc1vba1y0Oux
	k38KMZcptc8UD40tOgTLJKYDLhYrpP7abNjwnyqfYAuZ0vEn3PnnNeq3nzixenjoX7hsy0CJ9oN
	vVKz+LmS4jz5JvrVxNtUMONLAn+YGpoSuW/jutk36VEvhm4YItqFhvS2CB27HeG/i2Vu/Mihk/5
	ViHPjvqIdMGSrxCoTFZROk5FLXVBngvfJLLAd7HHWAXdLUnb18XTkRjoLnuE94w++w7O1VJx9Wk
	BcC4v1qCSqzj2rBLveu/5ZkmQ+M6sPKVxiica7etX2uM1pF5qYd7luBO0R6zZrRCh+ZkVXaa8kc
	cwMLNYp81nmJxquEN
X-Received: by 2002:a05:693c:69d2:b0:368:9553:f2da with SMTP id 5a478bee46e88-36a423f5c39mr1635691eec.31.1793324783143;
        Thu, 29 Oct 2026 18:46:23 -0700 (PDT)
Received: from anuj-MacBookPro.. ([2406:7400:63:75fd:f9a4:4062:7980:1324])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a428fa380sm2209020eec.12.2026.10.29.18.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 18:46:22 -0700 (PDT)
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
Subject: [PATCH v3 5/5] nvme: support dma-buf registered buffers for passthrough
Date: Fri, 30 Oct 2026 07:15:40 +0530
Message-ID: <20261030014540.3065403-6-anuj1072538@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261030014540.3065403-1-anuj1072538@gmail.com>
References: <20261030014540.3065403-1-anuj1072538@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261029_184624_904083_2811EFDD 
X-CRM114-Status: GOOD (  16.52  )
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

Allow registering a dma-buf against an NVMe namespace character device
and using it as the data buffer of fixed uring_cmd passthrough I/O.
Complete through io_uring_cmd_hw_done(), so the dma-buf map is released
at hardware completion.

Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>
---
 drivers/nvme/host/core.c  | 16 ++++++++++++++++
 drivers/nvme/host/ioctl.c |  5 +++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index a7a4d09644c1..33dbaa319bb9 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -8,6 +8,7 @@
 #include <linux/blkdev.h>
 #include <linux/blk-mq.h>
 #include <linux/blk-integrity.h>
+#include <linux/dma-buf-io.h>
 #include <linux/compat.h>
 #include <linux/delay.h>
 #include <linux/errno.h>
@@ -4008,6 +4009,20 @@ static int nvme_ns_chr_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
+static int nvme_ns_chr_init_dma_buf_io_ctx(struct file *file,
+					   struct dma_buf_io_ctx *ctx)
+{
+	struct nvme_ns *ns =
+		container_of(file_inode(file)->i_cdev, struct nvme_ns, cdev);
+	struct nvme_ctrl *ctrl = ns->ctrl;
+
+	if (ctx->dmabuf->size > UINT_MAX)
+		return -EINVAL;
+	if (!ctrl->ops->init_dma_buf_io_ctx)
+		return -EOPNOTSUPP;
+	return ctrl->ops->init_dma_buf_io_ctx(ctrl, ctx);
+}
+
 static const struct file_operations nvme_ns_chr_fops = {
 	.owner		= THIS_MODULE,
 	.open		= nvme_ns_chr_open,
@@ -4016,6 +4031,7 @@ static const struct file_operations nvme_ns_chr_fops = {
 	.compat_ioctl	= compat_ptr_ioctl,
 	.uring_cmd	= nvme_ns_chr_uring_cmd,
 	.uring_cmd_iopoll = nvme_ns_chr_uring_cmd_iopoll,
+	.init_dma_buf_io_ctx = nvme_ns_chr_init_dma_buf_io_ctx,
 };
 
 static void nvme_add_ns_cdev(struct nvme_ns *ns)
diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index d342ccad067a..3f240c9a537f 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -472,7 +472,7 @@ static enum rq_end_io_ret nvme_uring_cmd_end_io(struct request *req,
 			blk_rq_unmap_user(pdu->bio);
 		__io_uring_cmd_done(ioucmd, 0);
 	} else {
-		io_uring_cmd_do_in_task_lazy(ioucmd, nvme_uring_task_cb);
+		io_uring_cmd_hw_done(ioucmd, nvme_uring_task_cb);
 	}
 	return RQ_END_IO_FREE;
 }
@@ -533,7 +533,8 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 					ddir, &iter, issue_flags);
 		else
 			ret = io_uring_cmd_import_fixed(d.addr, d.data_len,
-					ddir, &iter, ioucmd, issue_flags, 0);
+					ddir, &iter, ioucmd, issue_flags,
+					IO_URING_CMD_IMPORT_DMABUF);
 		if (ret < 0)
 			return ret;
 
-- 
2.43.0


