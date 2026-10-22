Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F26606A31A
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Oct 2026 14:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=MO6Wjnt/;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hJyeb5CS
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=s4dfUUsZqZsY4HZ9PSieo9kggL9QkrHJ8v9DDPPYPu8=; b=MO6Wjnt/wz8k/D
	IhjuCbHk+kWvz6HV5NXQ2+QigD/ESKfccPMTmyxOxHygN9qVV9sMM+Je9e4KX02XbF36jWrcU4ehX
	A41KMje4quLdkfncTUzlz+LuBHmD/ttuLDAjJjxt2g17O0Lp1DPctkIh0Wl8IbgM7ycsKliHzwsWc
	pYaLH3jvM+HRvwl32ZaIPDh/37yo4osKf2piUvO+MVZAQ5lyvaa79t6Rf/8UUBzDm3qi9YAXXGwjI
	J61hjEuH3fl6yqsIzdg/iHc0VrF5w/BaCu6O+qZNI2zyvztbUBRUXlHlsdAt3tv4yuhjlKFhgvywG
	+/B0yMcNIExfR6nw81MA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xJu3e-0000000EKtq-2B9a;
	Thu, 22 Oct 2026 14:46:18 +0000
Received: from mail-dy1-x1333.google.com ([2607:f8b0:4864:20::1333])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xJu3b-0000000EKrH-45Sy
	for linux-nvme@lists.infradead.org;
	Thu, 22 Oct 2026 14:46:17 +0000
Received: by mail-dy1-x1333.google.com with SMTP id 5a478bee46e88-35d0be18c71so1092050eec.1
        for <linux-nvme@lists.infradead.org>; Thu, 22 Oct 2026 07:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792680375; x=1793285175; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s4dfUUsZqZsY4HZ9PSieo9kggL9QkrHJ8v9DDPPYPu8=;
        b=hJyeb5CSLfIRtXIc0Mh7mETjuIAr+1z4jeoNsbDI9+1shjQSBer23c+OfaXy+n8m6C
         4DAXC70800K8VVN7P6ATj5rkE8FMh4Kec+bMB28NeGwDj95fa4gSfewDiAxqLr9seUPm
         OywQZN6FokUO63o+MVNZHRzV+KvNKEY1MWC3EgBj9p2vfaUgw/mWfHO4/vmzxfRQF//m
         1ZbjPE7Wg54Qtk7iisD/IcBBsemjHLWzWyBGBHLQ6v/k8ZU37jTPbJo1zgT6+o8lrTSJ
         MKRhW3/Ztqbf4R9Sx34QkGonqL3BcZ1/2tXKr3BrB9DQX4Vf1aVv5IccnA9MrJ7wscsN
         fGmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792680375; x=1793285175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=s4dfUUsZqZsY4HZ9PSieo9kggL9QkrHJ8v9DDPPYPu8=;
        b=gtY5JlsY9zZ7qs7KlfFI+jLeP4u1JxgzE1hKssxRSpc+ZV3+6kx2m97UNs7AzZM8oh
         YgtXTqg0XI3JfE4ZPbZY2ciua1nQzIjZnTTlZP756CCu2XcwNITshbZLoTaKNa8OgGi5
         xOpuGeRClViWVQHVJ9MeJthksrsGa3ghOJhnl4Q5fBAziROflAT9YHSdHhDvey2Fvhy5
         F9k+mDEUFv1EQIwYYsx2pgyvV5zgAbTQtiRXhhofYW+CXwwTUxmH4qEneyVZO7XQ72xo
         GLu6kWJ3yfjJTFfYxH0szrik+s1SDKpgnYMheeEtqkGbcavt5KkBaJ7iDgz02Hu0fCYT
         u3yA==
X-Forwarded-Encrypted: i=1; AKwUvBwrvBclwis214nOBBYjcIeXFnKGqLucg4B/81PWU7USoK7P7ojA0XCA89q/gRKCk/eL2f6NSdM15BtU@lists.infradead.org
X-Gm-Message-State: AFq9FYK7Rs+8INLMfaoycsssmtzT5io7hwhXMgXNGg4K/pptduG2wkZc
	uXARjTAICt185XVz9Ot2Qe8ZAZKowvwyYMXSuwMH/RdbJZnJ+er8Y4s=
X-Gm-Gg: AYBFou1C59tEr+sCoe5QWyRlYDJkTF+nzZCfCD4EYiKu+bv3M1hUW51iJJ6d38zAFK4
	ne7FxR+CSnfwYfegj0HEwV0UlSSJhRxetuaCTZLv+3wjAboOFt+Qufs5OV9HCMG2jK13xcQdvwe
	jmbk5ozMTZIrYwgjjA76QZNhhf/a8TXJBnJp5DYyxW/3aGTkWdTSmUsH8TLjD55HqB3yk2/uqUI
	58LQalvq3EDVtR0/9se2GKFQm80rm/eTasl3EfCpTqxBA9yXt1TohnSIAY9b95su0Gg+Ey1O57Y
	uzpWFSUyC3dj79v0Fj9pDKdzcD+o1FhZ450l7R0ZZ5RL/VMiNofyursDOROlEvL25uXWUXtpNu5
	aX4MJ/h6uXxJ0v451E3Mv79qc6VCeHleg53+B6kyLZ19FetA3AEyhWzWZ0CiM1JjN9EoTbcUCmi
	6fTyFjStfhK/7Ohc6BmXjogDxxF7udD62SnwPiRBlIUxKQ3D+hbCT4ZJ4XB5pt08D+05F5otp0j
	3Xi848zhhDt1x9fqBSMBo9oEqGsTiOrgshTx0T6PzpvFe/k1Q0k24dlMGU8VQvcRy1qVBEhY5Je
	EZZHzHO4xeZH5GVylib9z1AkPwPLBi4UbCcP2h8pNRw=
X-Received: by 2002:a05:7023:a47:20b0:159:d448:dd1c with SMTP id a92af1059eb24-192f4dc4252mr3056915c88.19.1792680374872;
        Thu, 22 Oct 2026 07:46:14 -0700 (PDT)
Received: from anuj-MacBookPro.. ([2406:7400:63:e55a:5016:92c7:7a35:f3ff])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1903a275026sm23625880c88.5.2026.10.22.07.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 07:46:14 -0700 (PDT)
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
Subject: [PATCH v2 5/5] nvme: support dma-buf registered buffers for passthrough
Date: Thu, 22 Oct 2026 20:14:56 +0530
Message-ID: <20261022144501.2478417-6-anuj1072538@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261022144501.2478417-1-anuj1072538@gmail.com>
References: <20261022144501.2478417-1-anuj1072538@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261022_074616_018075_DE40072F 
X-CRM114-Status: GOOD (  16.15  )
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
---
 drivers/nvme/host/core.c  | 16 ++++++++++++++++
 drivers/nvme/host/ioctl.c |  5 +++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d81462e864a4..6157ff839929 100644
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
@@ -3982,6 +3983,20 @@ static int nvme_ns_chr_release(struct inode *inode, struct file *file)
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
+		return -EINVAL;
+	return ctrl->ops->init_dma_buf_io_ctx(ctrl, ctx);
+}
+
 static const struct file_operations nvme_ns_chr_fops = {
 	.owner		= THIS_MODULE,
 	.open		= nvme_ns_chr_open,
@@ -3990,6 +4005,7 @@ static const struct file_operations nvme_ns_chr_fops = {
 	.compat_ioctl	= compat_ptr_ioctl,
 	.uring_cmd	= nvme_ns_chr_uring_cmd,
 	.uring_cmd_iopoll = nvme_ns_chr_uring_cmd_iopoll,
+	.init_dma_buf_io_ctx = nvme_ns_chr_init_dma_buf_io_ctx,
 };
 
 static void nvme_add_ns_cdev(struct nvme_ns *ns)
diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 612d3009dd29..645446acc10a 100644
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


