Return-Path: <SRS0=Uoxm=H7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51AFEC433E9
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Mar 2021 19:25:13 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8A4D601FE
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Mar 2021 19:25:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8A4D601FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:In-Reply-To:Message-Id:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f2+MUjyCW/0hT20dV5B93o9/X6IJgOEDdaxDnzQUf3Q=; b=UvHpEuuFzovfDyu8LnxacHlQdu
	IrITnoJt7w/K+P0ygr5Ms4cDSDAIWq+1iVd9dcFtG1mc3mrqWkAkWr99JN9ZWVY9dx/Kk7+2GpiDh
	G8oOnDfVDo09Vg1ljwnXuZctLPc6L39QaCw4M3e+ibXLrAR4/u15aYwsiEsxdNgNmFM3K1A5Xho9I
	XlBfYj27KCXwFJ+UL69rVHaTjlJRAmdwrTqPoiV+lJDrtYbcpYzSCZ7XSkSXn3z9NXNLux/J/ZR0V
	BXIY2iXf6EL4LmBt45bev5A4Z6MeygEiUviUp4XTc7hGfurbc5/76W0hZ4Q2RTUA95b/KbOlVuC5D
	3chmtDkw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lGoAE-0004RW-4e; Mon, 01 Mar 2021 19:25:06 +0000
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lGoA8-0004PT-Gn
 for linux-nvme@lists.infradead.org; Mon, 01 Mar 2021 19:25:02 +0000
Received: by mail-ej1-x634.google.com with SMTP id r17so30341469ejy.13
 for <linux-nvme@lists.infradead.org>; Mon, 01 Mar 2021 11:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=kYRIiLyDMId2Rp0AnLAOvAVnCnG2eyfpP+wggOi7534=;
 b=t0NEsHeMFDC+3rFYfmCP52Ag/+/Uj5tK3zSXfNB53f/9NllBkVv5ZxnwltpVtggVhB
 sL2nnybvGz2Yn/XOJqQNzAhVgO+t6wDU6Ptx0QJoGzMbQIuWrXHwHzL3JARwqdkc9z5m
 DIPTlEEuFR+N0I9h/e4MUUF/hRkL3F0u0xCD3Nbu4Wmz9pXK/nWebKQ0YJhIIEhyn5Rn
 bJ9b1cKaH/P6sShW5BhQ/vNMG+MCGuRPU/LkjWZ1Hv89RNrVcO0VNE1O0L+b8TH3UEoU
 cqyLAwaqWm5hhBZidMiDdv8a2oe7XsdBu8OauvBXGth7kn0b7l/+Vh0tf/iPNt/e4iGk
 KExA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=kYRIiLyDMId2Rp0AnLAOvAVnCnG2eyfpP+wggOi7534=;
 b=FXJ6LZZYUkNpJX1CiB1vHDrDt9lddhAGVX3qgRkIFRhlpyP8Mfo7DGQiaOKkbNFuP/
 xEu1Ub96HFEXadZUKTvpElms567NSV32PZRuwzzWqvPboWXm1xOZrXsXhheT0kkm3nln
 TtCqWOJ3+2xRWP5S7z1ix06pxcIItj0eC3Th4XdinrirKnh93X1dI3KTpg/dDu6m2Yx6
 bgKIWiuZPQO1CZIDKKcO3DC/p1CvAwWJL/lVBJutZI61SYnnaal9Zaa0p0GQCruT9uTn
 ipTrJHXdJGF40PxDp7mOg3RPzp6jgzCjihK+nAOT4DoO+QqVHMwEOjUlNZlZ5+tlR29U
 wB7g==
X-Gm-Message-State: AOAM5312sOpkVEqC4jLCp6MiAhlWUJsi7XIPHxzGnJdLYwrx5WD++nCX
 90klSMyzfC74Dk+Ba285sBR48Aki/FrYHxM9g+o=
X-Google-Smtp-Source: ABdhPJw5ruyiuZTKNYqKN5wCZs7s5BVahTA0+7Xm1CmPmL3eQHfwU3T06wA+8zxqfzKkajHZWpQE1g==
X-Received: by 2002:a17:906:33d9:: with SMTP id
 w25mr17008142eja.413.1614626697804; 
 Mon, 01 Mar 2021 11:24:57 -0800 (PST)
Received: from ch-wrk-javier.localdomain (5.186.124.214.cgn.fibianet.dk.
 [5.186.124.214])
 by smtp.gmail.com with ESMTPSA id i4sm14107110eje.90.2021.03.01.11.24.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Mar 2021 11:24:57 -0800 (PST)
From: javier@javigon.com
X-Google-Original-From: javier.gonz@samsung.com
To: linux-nvme@lists.infradead.org
Subject: [PATCH V6 2/2] nvme: allow open for nvme-generic char device
Date: Mon,  1 Mar 2021 20:24:52 +0100
Message-Id: <20210301192452.16770-3-javier.gonz@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210301192452.16770-1-javier.gonz@samsung.com>
References: <20210301192452.16770-1-javier.gonz@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210301_142500_594112_6B7D543B 
X-CRM114-Status: GOOD (  15.45  )
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
Cc: linux-block@vger.kernel.org, kbusch@kernel.org, minwoo.im.dev@gmail.com,
 hch@lst.de, sagi@grimberg.me
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Minwoo Im <minwoo.im.dev@gmail.com>

Keep rejecting the hidden device access via open, but allow cases
through the nvme-generic char device by moving check for head namespace
to nvme_open() from nvme_ns_open().

Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>
---
 drivers/nvme/host/core.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index b94609bc92f4..ed66ff33a85a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1887,11 +1887,6 @@ static int nvme_compat_ioctl(struct block_device *bdev, fmode_t mode,
 
 static int nvme_ns_open(struct nvme_ns *ns)
 {
-#ifdef CONFIG_NVME_MULTIPATH
-	/* should never be called due to GENHD_FL_HIDDEN */
-	if (WARN_ON_ONCE(ns->head->disk))
-		goto fail;
-#endif
 	if (!kref_get_unless_zero(&ns->kref))
 		goto fail;
 	if (!try_module_get(ns->ctrl->ops->module))
@@ -1913,7 +1908,15 @@ static void nvme_ns_release(struct nvme_ns *ns)
 
 static int nvme_open(struct block_device *bdev, fmode_t mode)
 {
-	return nvme_ns_open(bdev->bd_disk->private_data);
+	struct nvme_ns *ns = bdev->bd_disk->private_data;
+
+#ifdef CONFIG_NVME_MULTIPATH
+	/* should never be called due to GENHD_FL_HIDDEN */
+	if (WARN_ON_ONCE(ns->head->disk))
+		return -ENXIO;
+#endif
+
+	return nvme_ns_open(ns);
 }
 
 static void nvme_release(struct gendisk *disk, fmode_t mode)
-- 
2.17.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
