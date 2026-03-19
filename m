Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8EE31088E5C
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Mar 2026 01:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=t/5KnRjlAuUYt7kyKQxRxr04cjBXpQilD6o1+ihfeZk=; b=HsPC+Ycqr0wGJvfD8kAIPi2DNh
	CGIdAlMNmeUvl/kI/qdZ0lmoLE2nb1stzKcbXXtVcJhDPjTYemHamamN4vuetQGDauv5PAemP+Tyd
	7FlGVNHk99zzn4Bj0dqnkXb4DV+kv105buQWNTFbFPpfzr9NeUl8xiG5w3iLSWXi1QgUdOkIKzmzg
	2KnFrPc4C2PWedYIchHE9+I0fEO/xk3eYXFlb+JJ5xtnEJvrUizUJTVs3f9kWZtCpiiGZcHuTya4S
	Er72MfR97ZDCTHBFpOariTKOeEM2ntT4TKEwopmhz0bnDArIiOSEYXqRRKJi31C0PXazWp671+IWt
	BRzL6DeA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w32A5-00000009ac1-1tCu;
	Thu, 19 Mar 2026 01:26:57 +0000
Received: from mail-qv1-xf2b.google.com ([2607:f8b0:4864:20::f2b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w329y-00000009abc-4BVI
	for linux-nvme@lists.infradead.org;
	Thu, 19 Mar 2026 01:26:56 +0000
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-899ed41208fso8512476d6.1
        for <linux-nvme@lists.infradead.org>; Wed, 18 Mar 2026 18:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773883609; x=1774488409; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t/5KnRjlAuUYt7kyKQxRxr04cjBXpQilD6o1+ihfeZk=;
        b=KoBhMYpkgd2za9sCr2LrG6z+Ov3B3JlBvUVGBkkMSXvzBqhQB87bRLbTZOU/D/TAcj
         2n5oBN/2FTpX4MBSjHqwDX5X7GoV/zbSIsIrsx/8qAl5YVa6B1K4XVngt/wJj/82yrLQ
         l7TTZ8+/bubUpJqT80J3o0mmJna1JZNmLYv+6C2H9aNLLHrkleNpG2YpnqO7ypavGMex
         i+VCqkcKNsCiYPqX9OKW/asEyJde/PCmxr4FBHSQT9GxulxAQ2TWUjZnmXxh21h3ixdL
         slj5//xhipRtPngLnNOmF+Lzmg+xdAbzLPwNWW5nWmsmLjB9A/aNKQWT+EftRpUKQa6I
         5TWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773883609; x=1774488409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t/5KnRjlAuUYt7kyKQxRxr04cjBXpQilD6o1+ihfeZk=;
        b=ekQpLFWML/ipJQO7CZqry33AOfnnnjkzdEGbIeNEgAPr9JMdd2r38imnZjK5R2Oa5R
         IjcGvdQZ9YYnw94nB35TFWU3ING0knx+4erUV86GPp+hUNzJvzbHHqRZdMlGQytLuhap
         1EPK5IfhQLjNDjQ+GIbyJ8CTDAJJ4LBtq/7itkHSEKOMgyiblPKPj20Ra4wfjvN1AiuJ
         tCTCm3+8kKOo6HDR8ZDwYBHBgBZro1GqsNJZdB35n/p/9mcwv9p1/fonEHItKCHZIfWa
         uIq615LaKkw7dTHycgBZP5ksk+Lohwslm/JnFfXPueFgYybRykIO1GxacsBDtlu4aywU
         qhew==
X-Forwarded-Encrypted: i=1; AJvYcCXSFLCtHqekru49vVK1UznijJTC8EnezbS+JSMKXBdhnx3ePIEMe0yWcK/pYZ0NJFbOR5VO3KzNONRj@lists.infradead.org
X-Gm-Message-State: AOJu0YyLVUGEte1HYFhqvPeE9Vy6RaW6gZ6Kv/Ouov2jent0ern1eXFg
	uEBjnR3uoa82thkb6w/5eipgjH1njxnbj9HnWijLIoiYAzWZ43i2+qs4
X-Gm-Gg: ATEYQzxQLBD93vxpL0KB1o8+cNPNDX4XtcePO1BXm7MaQekKW5GY9FMcpa9eHkjVYxq
	y0oL+V3E2k1GDZB6UvhCzVmBpN9dyZcEYk7BWd3v3eX4tXwg7OJxd9wM3rGwDbP76GDyr4pH8VL
	NDKBwOBW0ZxpB+jpedg1pjEsWdz19ueLyUQDuhgJpt3tlQk0XCkEM+Qea3sxwEuZgjjIIuFqxJm
	q7jZhWZfSTAQYRH+XLSa/wroZn5eMdd0BanU4mLNXJ1spdl0tnjCfbSY1ueTGpfZJIsfcSNeKZs
	CfSCaWVU6XsyGq0IPQocYQzwbbBddlx2dc/zdADopwPahhn6WucUlVpfTB8ap5tjZVPi9NosvKd
	vS6G1DY/oyZ4rgdZdSZi3PVhotsUqXyp6Xrsq4MXQ6m32R6w+piBL7xynHF0CqtrbjnmWaC3rRK
	ltpRiZno9KVWTI+qecgzhrR5Cx71OSS5m8S9I8y4ldhZqr41UCnIfsbQxx/gIVBdPhRr5mmUE=
X-Received: by 2002:a05:6214:2aa1:b0:899:f228:66ee with SMTP id 6a1803df08f44-89c6b5ce9a6mr84066746d6.45.1773883609416;
        Wed, 18 Mar 2026 18:26:49 -0700 (PDT)
Received: from rc-szhan197-01.ad.syr.edu (its-crushnat.syr.edu. [128.230.103.233])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89c6b8fc1cdsm34788146d6.14.2026.03.18.18.26.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 18:26:49 -0700 (PDT)
From: Shivam Kumar <kumar.shivam43666@gmail.com>
To: gregkh@linuxfoundation.org
Cc: security@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org,
	kumar.shivam43666@gmail.com
Subject: [PATCH] nvmet-tcp: bound sgl->length check in nvmet_tcp_map_data()
Date: Wed, 18 Mar 2026 21:26:30 -0400
Message-Id: <20260319012630.1802025-1-kumar.shivam43666@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2026031805-stretch-skid-ae5b@gregkh>
References: <2026031805-stretch-skid-ae5b@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260318_182651_041216_13EC25CA 
X-CRM114-Status: GOOD (  12.08  )
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

nvmet_tcp_map_data() reads the SGL length from the incoming NVMe command
and passes it to sgl_alloc() for scatter-gather allocation. The only
existing size check (len > inline_data_size) is gated behind
sgl->type == NVME_SGL_FMT_DATA_DESC | NVME_SGL_FMT_OFFSET, meaning any
other SGL type bypasses the validation entirely. A remote attacker can
send a CapsuleCmd with a non-offset SGL type and a large sgl->length
(e.g. ~3 GB) to trigger an excessive kernel allocation, resulting in a
page allocator WARNING and kernel panic when panic_on_warn is set.

Add an upper-bound check against NVMET_TCP_MAXH2CDATA before calling
sgl_alloc(). This value is already advertised to the host in the ICResp
maxdata field as the maximum data transfer size.

Signed-off-by: Shivam Kumar <kumar.shivam43666@gmail.com>
---
 drivers/nvme/target/tcp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index a456dd2fd8bd..c7253221c342 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -431,6 +431,8 @@ static int nvmet_tcp_map_data(struct nvmet_tcp_cmd *cmd)
 			return NVME_SC_SGL_INVALID_OFFSET | NVME_STATUS_DNR;
 		cmd->pdu_len = len;
 	}
+	if (len > NVMET_TCP_MAXH2CDATA)
+		return NVME_SC_SGL_INVALID_DATA | NVME_STATUS_DNR;
 	cmd->req.transfer_len += len;
 
 	cmd->req.sg = sgl_alloc(len, GFP_KERNEL, &cmd->req.sg_cnt);
-- 
2.34.1


