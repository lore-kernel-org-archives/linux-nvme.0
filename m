Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1F741091937
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Mar 2026 00:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=cVxNKhy+wXeBWKHwq1xrJ2npx/pGlGXsl/NeTEQ5RzY=; b=pHI2MxxDZRNdsCPwWk7gWOx9XF
	4HJLndjuQPTCHTXEkCtGjhKUpTLl3/UIuxZMwEJCYgnwaIu2d2wP7rbPGX+yeRHDwY0fcKTNT+wsX
	QcQiLmAzCwCkfUo3BlNgLCfqcPY/zG6Brm5mJLWQomzwyfkFZsodByXyKdN2zTxtbxzbKicntPtRa
	sLWAQvYLDexVjzOz+6aAkf9yEjAK+sRIXqrhwWNTifoLUGpMOPXYYPB58KhIXmG+k4v0Y/iBq08il
	jFe31RuJeE4niaSRaguhoXVqDvpdyabDZlcW4OVXYKlfvAg02oX29ysLfo2eW1xF8SHF8ebEn2kxE
	Xi95m2ng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3Nbu-0000000Bpmw-0IBE;
	Fri, 20 Mar 2026 00:21:06 +0000
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3Nbo-0000000Bpm0-3r5Z
	for linux-nvme@lists.infradead.org;
	Fri, 20 Mar 2026 00:21:05 +0000
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-35bb9070644so71143a91.2
        for <linux-nvme@lists.infradead.org>; Thu, 19 Mar 2026 17:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773966060; x=1774570860; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cVxNKhy+wXeBWKHwq1xrJ2npx/pGlGXsl/NeTEQ5RzY=;
        b=ULQz8usCs0+V0rcK3E5ZlXHDlMsDUss80vit906x9MIyImWYR8BWoYHfDPU/K5iWkH
         tIOEboz1aNIMnqr9YRJC6r3zLwoGMWG38kzSYYS9YxIF/ss6vsq47E1lZWJX5w09LAhW
         0AZcdpxOaYolPzzxU0IGfwCSLaTyzhbsuJULd0EC0+iOHTGzS0yWN1i5DnMpAadFdkMh
         3AljAl6knmiEEa+L9DjOhAsie6kACiw2k6ldnrw399Ub/3ICt0W6ztelAg8OMvEJlPoP
         t1JFCaJOTIdjURYktrX1HUWVipdiIvcc+RLg1M7SSGLxeHnz+QjSvYqczvnrS7v2NQJS
         KwoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773966060; x=1774570860;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cVxNKhy+wXeBWKHwq1xrJ2npx/pGlGXsl/NeTEQ5RzY=;
        b=C967C3+VRQhvWlU8OdL1nPhOOHhaWJq8PtPsG0RPPFdm7eA4Q8+2D4nkhP1Mu2tR/O
         qxr1qr/mwXSaqwabHDxsxQYBpCJJHYYbin1Jnlm6bhp2065Ee0PFusIccX2EqiLrHOh2
         jxE3qIqKLVOxARZNZNqbEmsBDOSkBg6h+oL1hPnqF20GZJW6b8O29mqQnEqqYSzT58T2
         2fpVwn7w2G+2/7RcgrNiT7YheUKP8b8z5poSy+1Eq4HvVMlU4djom90rrTXyxnt8zhGa
         jdkPQ2zHnuf2SepH+eFIvgAssBtsYVrJx6OcIZE2p4Fgcqen0J/e3H9AjmEQuU7Wg2Cq
         sd4w==
X-Forwarded-Encrypted: i=1; AJvYcCVyxAFxePjkmknH5yCby5hBOAaCtOXLW//2Sv0WoCcoAj6IsruOtnMKYQApnRd22Mzwlhle3WLPu+q/@lists.infradead.org
X-Gm-Message-State: AOJu0Yzm+glqPWvYKZTRqv5i/mgGZAjzwnKR5LrKWtzhVrO36/pcwc5A
	9UbQWMsDSaUTRYuPtceQMIAUngr5U+sw4e6Rk0/YfertfVbL6MltsQSz
X-Gm-Gg: ATEYQzzLm79fX2d/UFw0ygESjcaCeb2sBqhizEG+n4cuYLzRSG9HiLTt8N1mrzrcPuP
	KbKLWi3x5iCLT10db+aut1vIJObOpmtoonnrzGUdLsI0uRFf2613GjfqjBSNDJ6jj5uBzIfiLmX
	XMzytXAkqLVI10XqjTW6GWVjlLhIT/KkNsGawVUaXnhQeDLxtPV4oDVfP8dNLWT0h9/AFfeXY+J
	7AGyrHAjx2Dp5ikTkcFpQnuhm0EViCPB4kA/HzsVM+94tmE8tpyD2XM4B1lYjTaVLZ7gqn6T4Bj
	/2zH2T2kUKmmfsZ3UrPjNgm2ZJm7mq2UNEeq6tE2c6snxAIpDQU6Y2jmFoHxIXzxbFnXIykjQvX
	0m7v1S+dU9h0MmnSLOvIjJrtCz8+7XkihORpz3vtRQdXYhXfRqmI/SncZTo9PuK8tRypIZXoNRC
	d65Zc5FYVG13V9qcnk6lv5l5dH+L9EzHMmG97L7Qu4Fw==
X-Received: by 2002:a17:90b:2884:b0:359:f77f:8cff with SMTP id 98e67ed59e1d1-35bd2c9b202mr635612a91.19.1773966059990;
        Thu, 19 Mar 2026 17:20:59 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c743a801701sm428255a12.4.2026.03.19.17.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 17:20:59 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: hare@suse.de,
	kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	yjshin0438@gmail.com
Cc: alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v4 1/2] nvme: Add the DHCHAP maximum HD IDs
Date: Fri, 20 Mar 2026 10:20:44 +1000
Message-ID: <20260320002045.1927526-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260319_172101_333932_6134AD6C 
X-CRM114-Status: UNSURE (   8.72  )
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

From: Alistair Francis <alistair.francis@wdc.com>

In preperation for using DHCHAP length in upcoming host and target
patches let's add the hash and diffie-hellman ID length macros.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
v4:
 - New patch

 include/linux/nvme.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 655d194f8e72..b9d3dbe2564d 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -2332,4 +2332,8 @@ enum nvme_pr_change_ptpl {
 
 #define NVME_PR_IGNORE_KEY (1 << 3)
 
+/* Section 8.3.4.5.2 of the NVMe 2.1 */
+#define NVME_AUTH_DHCHAP_MAX_HASH_IDS 30
+#define NVME_AUTH_DHCHAP_MAX_DH_IDS 30
+
 #endif /* _LINUX_NVME_H */
-- 
2.53.0


