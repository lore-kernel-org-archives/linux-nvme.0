Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19D34FF886F
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Apr 2026 23:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SPjgILMKtOb7NTQi1kf0IroalcWcxhj98BeMxmComO8=; b=e9y1Lte8EInoF74rbCvTyT3JSX
	Uv9+hHkDETVx5uvqcNcrnK5HPhp+MVWAzCqUw03QUfQWKbDJMqzoQ61htIK9TSLkCaofMVUIThEnP
	N3V+bLGUtkpJKozRYG+8q//11FU0Tb6WPJ0QoJwnnARQm07+4miX4yceOPmmB5xO+K30nn9GHoPh/
	NySD1y62Q91O3bBOigyqv/Pw5LeMlM1JJf3ScwtqZLRT5OGu60fEnYQWrECVoBMDNGSsV1mu0udz5
	dDRkMtZ2wvHBKMPqFuvz4PwTb1yY4p0bIMblvj1VzJbqydNZ2iYK9VaVxLd1rcUbUQ5xNM5ciLghM
	DXzSDAtA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIapQ-000000066fI-1cNb;
	Thu, 30 Apr 2026 23:29:56 +0000
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIapM-000000066dZ-439H
	for linux-nvme@lists.infradead.org;
	Thu, 30 Apr 2026 23:29:54 +0000
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-48984d29fe3so20920455e9.0
        for <linux-nvme@lists.infradead.org>; Thu, 30 Apr 2026 16:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1777591791; x=1778196591; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SPjgILMKtOb7NTQi1kf0IroalcWcxhj98BeMxmComO8=;
        b=AYxYKI3h+/jGkiZzgqNEq8tI8S71zVLXNIkF7a1W1EJYR1D4xYx9q32sR3ffVU+FaC
         tvEcPOGiihZtDa3xdmaZwsOf7+PWjd5VBZL3znGW97PiuYosRWYdh2zCU6PJUzBPZFaM
         7Ax0AsExjo4BGEm5v2RGwio+uszQNLatnVQg3s7+bN12LrW+SUwK2/ueB/IdHosbvbhh
         /j5H/xPD4cHzTkSLoX4mqlB7knUcFIVQk+RG78wkwsq6f7eWFEUJX89m5Jj5KFR6QdqW
         9Lf0KYPW2BzlIzkHrlnvNSbPslBhEsAUTWotIXdHPWYCtV1QiszdUQAHNE8scyg7t4XJ
         g2TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777591791; x=1778196591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SPjgILMKtOb7NTQi1kf0IroalcWcxhj98BeMxmComO8=;
        b=cyfz2NLQJH1IiNTxRvjfxl/LYg7k0mZEzs9JIjslPGmaz6trrmRrD4UuyXdWOjLkCt
         A5wUA82bJvkP38jEpPHS0tjgcm7hQT/PnhS6SUgGT4jKYnyQ87pwMJSd4uci1sQNaxoM
         +1wxdtzIKn10Or3J6h346ExRNZXlFKt+tlVUqKgbToTKJHvjQHZNVp/ai8vQqKIxOvex
         Ykuj62gWdZapuOiJ8YgGEIeRZpGeP8T0N/KpuqTAGx2mFl1Pcw2h/2E4qORGtUvexkin
         r/7GV7wFNTWOzLkUcN1lzhiESOqJhl2kEUqyoPEv4VASnmdapqT/AY2fZlIH18xfAhmo
         SH+A==
X-Forwarded-Encrypted: i=1; AFNElJ8h4jqwf0osW39W/N5De+uCI1kEd4ULlSF7PSC3mNGELAntxt4BOgl8ZYBlP73smWMwcdz7M2p6poiq@lists.infradead.org
X-Gm-Message-State: AOJu0YzncfxrARyeYLLhNUwpUAuJmzQ9qZ459l3gjU9D2hcMQuvk18gX
	PA+lCwuVLJNELPq7/5MnAfS9emz2WiY2GgZCicYIXurJS5OR3lyddgmDidN8todDvrCR3eSoAIe
	CLWK6
X-Gm-Gg: AeBDieuRohdek+C7GUo0RtI1nx3Eg+IOUD0O0KdWpGqs9IK2JAye14gNHh+x5lAE7T5
	hwkCOSanZaD12nMoZ3P9QVyguUQyMF1yDJ+rsGPLBK3aKrabnwguL6xqc+6uRhJu32zU498M6nL
	c25OBn1BPFuC6HiyrUNjGeMK6+AHJ+RAyExiFe3Hu6qReqnyvwCEq0eF5Vxd5RBQzDmPRXxyy29
	TqmvpIo6XFKTjQPiyiCR7BhgrT9Fa9JmmyAqUyxIyjqyiEb5EFgW1uKgAMR9+tDgUQ4V61km/Cf
	cp1jRt9YhH3Y9OsSwerUhZthT/21wFqPD94Lg1lfVcRWUPTRo89Ek/8gev/kpxq+hW0UiErfv9e
	pUwKjNpDafTcB7t+QqGlhRSOITWYEbV5ov0N6eeup674VPMOh0U8BK99UVgdTKQz50jsXhyfKMN
	+1C3tAWvpUcBNlz4Z6Z9uMKD4eBy1iAhWevUazL52Q5MJ9QNRIrvKbaE1tWGwsesdFwlGpt4h7V
	14UtKa9yP0kY0WyoWmllh75lFrKhUJfgRjKenXcP8ecWuJfkRc=
X-Received: by 2002:a05:600c:4893:b0:488:9fb7:376d with SMTP id 5b1f17b1804b1-48a84463facmr53896795e9.28.1777591791015;
        Thu, 30 Apr 2026 16:29:51 -0700 (PDT)
Received: from dev-randyj3.dev.purestorage.com ([208.88.159.128])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-48a8eba865fsm11942715e9.10.2026.04.30.16.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 16:29:49 -0700 (PDT)
From: Randy Jennings <randyj@purestorage.com>
To: lsf-pc@lists.linux-foundation.org,
	linux-nvme@lists.infradead.org
Cc: cleech@redhat.com,
	mkhalfella@purestorage.com
Subject: [PATCH 1/7] fixup: nvme fix CCR command
Date: Thu, 30 Apr 2026 17:29:07 -0600
Message-ID: <20260430232913.129271-2-randyj@purestorage.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260430232913.129271-1-randyj@purestorage.com>
References: <20260430232913.129271-1-randyj@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260430_162953_008667_129EF4A6 
X-CRM114-Status: UNSURE (   9.90  )
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

From: Mohamed Khalfella <mkhalfella@purestorage.com>

---
 include/linux/nvme.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index e7f70774cbd8..742159dd2b89 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -1247,9 +1247,9 @@ struct nvme_cross_ctrl_reset_cmd {
 	__le32			nsid;
 	__le64			rsvd2[2];
 	union nvme_data_ptr	dptr;
-	__u8			rsvd10;
-	__u8			ciu;
 	__le16			icid;
+	__u8			ciu;
+	__u8			rsvd10;
 	__le32			cdw11;
 	__le64			cirn;
 	__le32			cdw14;
-- 
2.54.0


