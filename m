Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AB29C43458
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Jul 2026 09:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=EUQ29qtnue7GGPW+uOfgi0aOvv9tmXtSIWyDlapW4Xg=; b=Cezt9pkUCQNfnnEsPc+7jGb/sR
	dq/FblpX8ScwzBVupjwnNu2vwxL5tAwyMy7ZRMkztTGULcZRUlZ1l34EFTF22BVdqi1rIugZ5Nj/j
	XN5mxBvKcVDskUQtY7TX8jc1JTclagQ9uuWUqfHtMmb2UP8vHL1dp2H9Lxi+Esv+sWK0835XkxFQj
	KM0mWPiSHzm7XgDqRcrXHuXXrQk88JjGlLXVVlNZuJMr2uOTNKbsdes974LJgNkQ24oOe6QVK+cqE
	n80H+9d/yVJ7yWJPiFP0K1bDDOJ49hOdbupmfkKUXjnejIKgw+Q6/h3UzUGS5w+TwcV2uaBK36SVY
	LQAHf+tg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjZS2-0000000BSNW-3Vhu;
	Tue, 14 Jul 2026 09:29:18 +0000
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjZRz-0000000BSNA-2lUM
	for linux-nvme@lists.infradead.org;
	Tue, 14 Jul 2026 09:29:16 +0000
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-8487b7b3fc8so3515326b3a.3
        for <linux-nvme@lists.infradead.org>; Tue, 14 Jul 2026 02:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784021354; x=1784626154; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EUQ29qtnue7GGPW+uOfgi0aOvv9tmXtSIWyDlapW4Xg=;
        b=qn7GaknkglG1ny2wYbvICRnI6TsUpYTlDL+S6MNFk0t6gn3XmBYRHrWawSmImqDrUB
         PuFAKndU5n3K/KeD8SsmSu9mmA6ps1VyTNQB/X10My20RJHag5BxO4VR1ylAz3Leokfi
         xMkLtRGaxOstT6FZerxsUnr9o9hUxiLCz+LnwwLo349weM7j4m7I2swJx6+wl+3871GO
         qPs63ZUWHYb+TT0qmgakhfYAPS21etEZB6x3empb+parksXwUlGL/vdo8Y5etKTAbjm/
         luhbKnXJFGpCiyaRQyulgVQPYlnA9stIm1vBB4C9bPpjjoBAjhRrcRy4Yz/pPkXYwAdZ
         PVww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784021354; x=1784626154;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EUQ29qtnue7GGPW+uOfgi0aOvv9tmXtSIWyDlapW4Xg=;
        b=mYbJqpr+QEXGtEp3BexQ5DTbCdstWZTOOS3cCabZaehfHtm1wh6pCH+rtHOXr/b9Fg
         ODVw3X/Z3wv42F3D9cgO5hbkbJ1QIwTIeX5HFU5E0E0GXOhTDte/COLnqoCOtwAFrqsy
         eoRjChNVh5uBKPRjO+3WgjPTeewn16Zywo2+98iZJjbaVUbd0C87xZb0+YMjp0lKyDBa
         fkmlnpcfxNVnWaxhRPuyTvtvBTlrtYRa+12ZAdaCM0Wjoh54i/3fAaiROlXXdjoMKmVx
         83mgGttYdxuPtf28IQksFZSMTI9CS+9s/0SkyNssPRwKLIi3fy0F7X+nLveVxv2Yg7sK
         UaGA==
X-Gm-Message-State: AOJu0Yy6gelAcTbXbhGcgbE2JlnTiU3KLBYrTmTp+gmxEACb6qeAXYYz
	HpCYOod8fw+3sXgToXa9NrP8Km8BHUpIAIQWuNfeuwBqJhArbVqlfgWH
X-Gm-Gg: AfdE7ck6hDKKXvFaxD/agk14Lyega6C9a6k6/KXJwNMGkz9JMSVlPnjTtRH9i1Rs41c
	hlzsl8hvcr1Bqp6qH4Tih6KxACZmb/boP+xa6TimCBqLdn+EJxGaAPvFa9AWxAOb9PujEs7YcwY
	VhOlNHWZeFhidg26gst/9LoVp5WC9DvvDb2iYC1x+kEKLTM7smg4ZClitAPU/cgeZ3tIZUC+Fh4
	0DzjkzF2gU15K9edWOYINIhBC8s02QIuuDiWQopmQ0xOcmMjs8Bw1IQUtHvT10A2YSfKzyQcZSI
	57v6kMG+vjrlBSvKifiQ5G1+d3WubwCRdRPeQp1rlsEtH0y8MtPQ0fkZIvTOUqX+h8JyqQq6YuJ
	3ubqysoJK7t4EuDKAMNPQV/7DPAXNnrBfLnscsI018tuTShyVg8PZGxwnda9hiHNhdjxTJhHmCX
	zfx23A
X-Received: by 2002:a05:6a00:3e27:b0:848:87f0:ffab with SMTP id d2e1a72fcca58-84a5167760fmr2667959b3a.78.1784021354196;
        Tue, 14 Jul 2026 02:29:14 -0700 (PDT)
Received: from n232-175-066.byted.org ([240e:83:200::343])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a4f278aecsm1186856b3a.24.2026.07.14.02.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 02:29:13 -0700 (PDT)
From: guzebing <guzebing1612@gmail.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Guzebing <guzebing@bytedance.com>
Subject: [PATCH v2] nvme: reduce firmware activation poll interval
Date: Tue, 14 Jul 2026 17:28:46 +0800
Message-Id: <20260714092846.3381169-1-guzebing1612@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260714_022915_702891_4FE5F76E 
X-CRM114-Status: GOOD (  13.56  )
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

From: Guzebing <guzebing@bytedance.com>

nvme_fw_act_work() polls the controller processing-paused status every
100 ms while firmware activation is pending. Some devices can complete
online activation in only a few hundred milliseconds, so the fixed
100 ms interval can add up to 100 ms of latency before the driver
observes completion.

Poll every 1 to 2 ms instead. The shorter interval reduces the delay
before the driver observes completion and allows the timeout check to
track the MTFA boundary more closely.

Signed-off-by: Guzebing <guzebing@bytedance.com>
---
Changes in v2:
- Drop the module parameter and use a fixed 1 to 2 ms poll interval.

v1: https://lore.kernel.org/linux-nvme/20260627010610.47768-1-guzebing1612@gmail.com/

 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 453c1f0b2dd09..c226baf8641a5 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4813,7 +4813,7 @@ static void nvme_fw_act_work(struct work_struct *work)
 			nvme_try_sched_reset(ctrl);
 			return;
 		}
-		msleep(100);
+		usleep_range(1000, 2000);
 	}
 
 	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_CONNECTING) ||
-- 
2.20.1

