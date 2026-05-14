Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0316DCD4851
	for <linux-nvme@archiver.kernel.org>; Thu, 14 May 2026 13:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=dxjsDTEPx7x+FMifRYMV1hqCeB1iIjDkPxo6+pakXPM=; b=CirCGs0tVV//3TAfXf4eMU9Ey+
	ACa8EA/51vpyiFM4DgUJv7cNZne2qTF1VU/z7o4RI2At9id6IAlGJBvX4cVV4MOVKm4vWiVS9pL75
	638H5b8swUhJlvveeTXkJ5C7ul1j5kH0H0H+knWQBbCLc/YiyR0F5Tk6yUJv/g1e9WzJnan0KhENo
	GYl4Bh1G4Ofb6YrwH72+m1I4/UfLvFrJDIWSv33UtDjsKCIQG9dMsCOKUNzsxurnciA3rGJhaSXxs
	goQpGO1dEdFpFE116IUQmkgxhstHlLVW/IB7y+zMrCP2d5WO4C/gGfhfB5DOOqt0TN2gHyqFggvbr
	NngKVwBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNVvZ-00000005ZV0-3Oe4;
	Thu, 14 May 2026 13:16:37 +0000
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNVvX-00000005ZU0-01aQ
	for linux-nvme@lists.infradead.org;
	Thu, 14 May 2026 13:16:36 +0000
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-2b9fcf7c91bso79064695ad.0
        for <linux-nvme@lists.infradead.org>; Thu, 14 May 2026 06:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778764594; x=1779369394; darn=lists.infradead.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dxjsDTEPx7x+FMifRYMV1hqCeB1iIjDkPxo6+pakXPM=;
        b=qqy/8aYwnqJNM2CffDNSar4qr4eb92Fh3KHpH2dvIGPRy09ajKNH5wIEajxir5e2h5
         FvQT1L/Scq9f471xIJGQtAQda3Z8qStTBFnRKIDsMgVpR8LaluKKexv/hqzgVH7jkMW6
         m4vxPWBkb88jbKBc8U4+/L1qFZK9Q3YZH3SAFvyl9ek1BuBc+6/FbcaJ7cbn/RsnCZuE
         CA8EP10PJF3GuDz32oHDTZL322aS4xfp4Ta7VOmxTomc05OLBn9mDIiTM5cdigBnZ0HF
         Tg9Juc544nDeNMoJbLYhpWtNi5jl3iPsybt1LJmIl6HzNBsVI3CpWeSyc4XVoL6lSwkb
         y+/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778764594; x=1779369394;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dxjsDTEPx7x+FMifRYMV1hqCeB1iIjDkPxo6+pakXPM=;
        b=eKVcKAJ6i087oJTrZltrHSuZy/A74uVKkaNzzPSeQGvOOQp27h/00OdeAEPIqjm4k3
         I3Ti/xxtHMMQmCdc2oGA4wrwaEHHbxb4nywzbsIj5xbfD551764pQq1ACrNK3kPQw0pB
         Co9a4CPQdfztkmZfuO5FEROd8T4LgWrOUxQwUZ+3Huy+WOpykxq8urRs4BWOKXydV0f9
         O8wklMszfnrE33sWkttgv/jVj9hauYHylaNXuohaFxRNU1B4Vdz+rLy8sGQ3SgWTjkk3
         EpjDgG0ns8jUadlI/J/wMErTw76xDSJqdWURULkKrjDdZSSvPO2MZWkuk91YrlWFvpJj
         dDXw==
X-Forwarded-Encrypted: i=1; AFNElJ9mo/Z67XPYFDgp1vWu78krJjt/DpqyMLWDrTdDXd40dpFwVdqv9VlZjt4lGfj0JHvLagBLkANOHgP6@lists.infradead.org
X-Gm-Message-State: AOJu0YxBdSqIBlAMfpfRfUKwu3Edy5840wZyLlS/8NV1hlO6Lne900M6
	SEvxJNtqZ8baa292470mG6R4g2+kOCPhpH5vwzkxdzFV7YaUKDhku5Ye
X-Gm-Gg: Acq92OFLRPS3jxtHtryEilXvblW0KZ2mDTUdKTsnS15mw6RqtsKri5fkGaX1qJBdJ4y
	B9gAp5feLqZQ5VRCfQcBbl0OE9qK3T1VfZVMkrgsvhEOT+GbDD1aRJ7Bof8SS03K0l/NenPhZha
	wVO3Y7WaMqZvfMvHaPgZF2cxpMy9tMMWviBgtgZJbBi0OgyXXvBVuN1V1PFmiJLqOxwzj5ZpEsB
	pxWCBDSRgvxjP7PEwdfKFzJhNIz8jqsdlSuRh+AvSWjqPCog1BHsyNEaIuojrnB9vIunMWuIbAd
	FEOHJj0pJMzKuJfmDn7KZMvyx2oqjgIydbyBWthrpjmJWBoqUR87Gv3SBKXOew7VVGwW6rd3HVB
	qx1FVfvFiH6ZkHQA2EQpNekdWdsfGBuBkO/JBspWsB+VVr8XytJIcH59a+LJgH1cK0ya4uL8ctM
	zTaskTAezLBut6+W90jnVd9dO6KKV2TqhgQBM=
X-Received: by 2002:a17:903:388c:b0:2bc:e62a:979b with SMTP id d9443c01a7336-2bd30333de6mr80854555ad.30.1778764594127;
        Thu, 14 May 2026 06:16:34 -0700 (PDT)
Received: from [127.0.1.1] ([59.188.211.98])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2bd5bd5f30bsm30953275ad.16.2026.05.14.06.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 06:16:33 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Thu, 14 May 2026 21:16:01 +0800
Subject: [PATCH v2] nvme-apple: Reset q->sq_tail during queue init
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-nvme-apple-sq-reset-v2-1-84cbb5c70bf5@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NQQ6CMBBFr0Jm7RhaqFZW3sOwQPzCJECxJY2Gc
 HcrB3D5XvLfXynACwJV2UoeUYK4KYE+ZNT2zdSB5ZGYdK5PuVElT3EEN/M8gMOLPQIWNgW0hrX
 t+Z5TWs4eT3nv1VuduJewOP/ZT6L62f+9qFixvRQKpTHaKly7sZHh2LqR6m3bvmtHeGy2AAAA
X-Change-ID: 20260514-nvme-apple-sq-reset-53e22e88c7b0
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Neal Gompa <neal@gompa.dev>, Keith Busch <kbusch@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Yuriy Havrylyuk <yhavry@gmail.com>, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1204; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=jl08X3NCLgmcZoiX/JRkZFjNthe8bvfBiVgfd+XVW5g=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBqBcsvQUZgV7lMIoBJkU6SplIAUQALX59m3rswM
 Ju0qI6zlQ6JAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCagXLLwAKCRABygi3psUI
 JN8JEACwOZAPoKWuJZMLfBID3QAgWkZEOfVVIl1hXXM5d17MAF1zrTZA8DDoNnOxJJhQJiRsOlp
 +QA8rVCZkVF2d3eukmBADzOGA2sLHHgzFHdHsMiC1TzaVmyOyHlosVYQ4QpCOrntfYn8Ief+kf1
 dU2C8V6wfmrP69rmjJWBOxIWG/ITq2+A+PgNZFJw8rvIYw7EmdvudX8Ad+9YnsgyRlsTUEBg1zE
 SPe4LTeH1C9DL0SFhyCuAOsQ3YGr7L0E923wAgUPYmUzmATooVEhyGVouKE0p80jPPTSWjkTq+2
 sIBrK9qlOFgLaWFxUgYP6/Y2R6NFal9KSyn9nQtcuc+JrnbXisbX2XRYRnW4T3zIFqBPJeIwaBr
 HEKQfto0SI0mOrxyueKQsge5FMYjDF5noX0ZqsOmPs9j9yJOI2lAk0PBlAa2trKC3NL1Giz5XuV
 6pyftpibUZeTTMDlCKryZCaa7P2htuazpMHGUktU6f3mlGDXKPXLu2KW5kZwRovQFlp6HaMR9/1
 4q+WnDsfn8R3j0qo7VGd1uXtbS4gAGtOJHimc54QP82uq/92L8GUEQu2THl1jhNTbPmZ0XSD1Qq
 JE32qAW2gU2Bskqmit3QUg9ywWgIG/qsW0aqk+BVCKXsASJL2YkOZxQQP1YuKftd/zp6yR95cvp
 29qFsWAWPK+XS6Q==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260514_061635_056996_A467C0BB 
X-CRM114-Status: GOOD (  12.33  )
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

Fixes a "duplicate tag error for tag 0" firmware crash during controller
reset while setting up the admin queue on Apple A11 / T8015.

Fixes: 04d8ecf37b5e ("nvme: apple: Add Apple A11 support")
Cc: stable@vger.kernel.org
Suggested-by: Yuriy Havrylyuk <yhavry@gmail.com>
Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
Changes in v2:
- Cc stable
- Details on how controller reset is fixed
- Link to v1: https://lore.kernel.org/r/20260514-nvme-apple-sq-reset-v1-1-8931e455281e@gmail.com
---
 drivers/nvme/host/apple.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index 423c9c628e7b..c692fc73babf 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -1009,6 +1009,7 @@ static void apple_nvme_init_queue(struct apple_nvme_queue *q)
 	unsigned int depth = apple_nvme_queue_depth(q);
 	struct apple_nvme *anv = queue_to_apple_nvme(q);
 
+	q->sq_tail = 0;
 	q->cq_head = 0;
 	q->cq_phase = 1;
 	if (anv->hw->has_lsq_nvmmu)

---
base-commit: 5d6919055dec134de3c40167a490f33c74c12581
change-id: 20260514-nvme-apple-sq-reset-53e22e88c7b0

Best regards,
-- 
Nick Chan <towinchenmi@gmail.com>


