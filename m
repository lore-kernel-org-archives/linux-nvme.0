Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FC31E67482
	for <linux-nvme@archiver.kernel.org>; Sun, 21 Dec 2025 13:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=YoSQ42mrLVsYXEbrMaFWRBaq0h+SRn/ybUjjsp9uLcU=; b=lVD+pY0O7zxUJpMCZfzD4nn/O7
	ZzlqmDuf7aQil9tiaxASfumsDJ86wP4VZzOd/Qj1hWfxC9RO+WuDw8e3o2xYa4CbaJQvBPQG0AKxK
	n6PjtoHyTuS5GlrSlRRbhnPN5L6/4TEy8mZMCvOvqY2XeLeRvwxzopLYDxhyEvOQCMUOF5qM/UCKA
	3WnEBu2NFeyfQH+DnHf0YrwLT9GVSSSs71Pkxd9HLJH0Gy0oQsGTQCqFHL1Zc2uRXjYDJNkeOWa16
	zJwVuZPEkrLe6D6IGqgiNa02IJq1HG1PbGyIlDv7lJPqTVUQW/4vs71hSG5Rz6FF+kF3aLSf15kf3
	GcDP4EhA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vXJQ9-0000000CSoa-2Yg9;
	Sun, 21 Dec 2025 13:24:25 +0000
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vXJQ6-0000000CSo9-21lF
	for linux-nvme@lists.infradead.org;
	Sun, 21 Dec 2025 13:24:24 +0000
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-5958931c9c7so3687762e87.2
        for <linux-nvme@lists.infradead.org>; Sun, 21 Dec 2025 05:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766323460; x=1766928260; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YoSQ42mrLVsYXEbrMaFWRBaq0h+SRn/ybUjjsp9uLcU=;
        b=DRfGFduPj6IJ61Dbs3X95EHDnCEUf41Vbbgg43nq57HEUctjHFNJ04bA0kstNWiNYR
         uuVeaVekDHqPSj3MggfTUeP9iJ/CqUqLUa0/7VcS5C0Rnal1QYULhqx4/HooVdud1h5x
         vcaiSnUnYEDVWgYFch+xUy4mSOXmMNbF/oNU9g4ZgVe3sb/wdZOPlsHPzoXqqztsXc+4
         dCDuna59/o3crJ7CYj32+gwYEoc4QmZiYbY0ru/FFVHp3XazcH+6O0xrloAkRJqN9QD1
         BHPA4682djCw9r0LX3AeV+d/bfL1UIF648AjMj5Kbt+vcrl4EX1XQ1CYgSPelMUOMWO1
         LiBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766323460; x=1766928260;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YoSQ42mrLVsYXEbrMaFWRBaq0h+SRn/ybUjjsp9uLcU=;
        b=I3MWe22c3x1P2nkric1lUdaHN59keo5cR0Ts2J39Lm9jWGOwAbOYKZAl3/NUhEpfHk
         e3DCDqrlVj42h/us7FWdqBWwVTzco5Z7YTWO1cuiquGBoJmgRz8yioEmCsUtxZBGp0gf
         ayOyI3JaDuDrPQqaleQSFbj0hG9q6v6tSVxjXlCN2NPgVagn1lfEAg1fRUCyki/3xKyo
         fLid1HBiGL9eBTWHZqvf9YclypwONTVLhjV67LHYtvpG+ndim2oOqx8ql/AnEDg3HFRA
         AfhenNagPyQI0woH61jpgje8sH+u/g7mRoITBHmpxAzPAk79vBbCQQixt8gewEdDMQkI
         Kggw==
X-Forwarded-Encrypted: i=1; AJvYcCUj3Y/M0wSFe1BliBJ/qCcLpYVGPnUDNUDWVXpCtjMomz4bpZFSzU7v69unaTO2vZxR5jMTd55und/i@lists.infradead.org
X-Gm-Message-State: AOJu0YyHKGe4ogB1oYNPb/5s2X7/QUd8k6gIPMzcEnxHkTVgBH5azxDR
	bE0T1CS1uKOUDa3lS+GdKfiQv1t7P9PMp/27k7xfY+YLgHx71mPC1x72xn/w3Eig07E=
X-Gm-Gg: AY/fxX7W+p4fncROW9lyYrhaK7zQw0wwaAJcTCNcxKMFS2FhuYXfksKQnxamszR0Fje
	Ex4h23odPSmWCqTGsBdDnO263FJJlNFhIqUUvMoLCJwT++XQJ2zbecMTIn9ZQIx1k7LfUeetzMr
	2y4esB9+et6G4jPZfnITsBeTIezg3PdrHDJbJt79GILRPz0a2KT6zDnC9w6Jiq7P3Y/yp5DB2/l
	3BFBHPWVXT3R18yPG27JGcF3NBgS3MT6B3mlKpPj2Pw9rfv6ExEO5wB08UXweoLDuiGmCEBLUc/
	XkyUtsFXjF0yjYBO3rgGF67JHzlXal1Xc4ahgoSGXAZUfKd6gFK6vy8hnUvs1F7Gx5q2EHA51md
	ZoTvnS4g2d7v/Ze4BkKFTGnCwY75+2JY1RBpE8KRrIXRYCXMlWT9I+ZiNNiI5RSEt2A+a0CnESN
	VThGM4sptZZ1ND8Np5Ln02DKoPQaaFHGQ/8jF1FaURKAZKQxzDGAoSNsA=
X-Google-Smtp-Source: AGHT+IGrUPswrGfWjOqQP3snzEfw2F7MfyIrcGhl52qtlVj8tDCZHAWezyXnpr2il7RjW0E0QZrKOg==
X-Received: by 2002:a05:6512:4006:b0:59a:1238:2f52 with SMTP id 2adb3069b0e04-59a17de2c27mr3232118e87.27.1766323459996;
        Sun, 21 Dec 2025 05:24:19 -0800 (PST)
Received: from mismas.lan ([176.62.179.109])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59a185dda8dsm2306800e87.41.2025.12.21.05.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Dec 2025 05:24:19 -0800 (PST)
From: Vitaliy Filippov <vitalifster@gmail.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Vitaliy Filippov <vitalifster@gmail.com>
Subject: [PATCH v2] Do not require atomic writes to be power of 2 sized and aligned on length boundary
Date: Sun, 21 Dec 2025 16:24:02 +0300
Message-ID: <20251221132402.27293-1-vitalifster@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251221_052422_547487_BC5477E0 
X-CRM114-Status: UNSURE (   7.60  )
X-CRM114-Notice: Please train this message.
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

It contradicts NVMe specification where alignment is only required when atomic
write boundary (NABSPF/NABO) is set and highly limits usage of NVMe atomic writes

Signed-off-by: Vitaliy Filippov <vitalifster@gmail.com>
---
 fs/read_write.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index 833bae068770..5467d710108d 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1802,17 +1802,9 @@ int generic_file_rw_checks(struct file *file_in, struct file *file_out)
 
 int generic_atomic_write_valid(struct kiocb *iocb, struct iov_iter *iter)
 {
-	size_t len = iov_iter_count(iter);
-
 	if (!iter_is_ubuf(iter))
 		return -EINVAL;
 
-	if (!is_power_of_2(len))
-		return -EINVAL;
-
-	if (!IS_ALIGNED(iocb->ki_pos, len))
-		return -EINVAL;
-
 	if (!(iocb->ki_flags & IOCB_DIRECT))
 		return -EOPNOTSUPP;
 
-- 
2.51.0


