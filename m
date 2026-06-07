Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A274CD8C8C
	for <linux-nvme@archiver.kernel.org>; Sun,  7 Jun 2026 06:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=n4CzgW3/VXNfJs9yhqU/zZT2TtJnYVsjAwImG97RFLc=; b=pf14BpxOuMFjoQbhOujdB8qE0N
	v/1mOY4jGw7SiTbtrrz57jftOX7XtfKvjysQo3jUz3hVJV0Dwmt0jfZWUKeWG8qmFmjGlr6dgkJJG
	sUbixlNwFA1Jy4FvTWcSyvXp8uRybnGB1MfWIC/rYHCOuS7MJdiEplqKuqOeJaMZMZryobIR3p9y1
	S2jVYt8z2Ur2bxzP/5m1jDlvQ3FQzeHhmrtrd3oSZOZM5uOlwVHH3T9hRsngCIpVOdiaHn4zM8mYy
	wdDEuFQ8LTwdPTYtyNpJOBznTB36ncCzC96wya96Z5lIVAUQZzultZnSrxvL+A3lhCbiZuHLdkQ/S
	JlCVrWxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wW6jp-000000023r9-3Roo;
	Sun, 07 Jun 2026 06:12:01 +0000
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wW6jm-000000023qL-2zDS
	for linux-nvme@lists.infradead.org;
	Sun, 07 Jun 2026 06:12:00 +0000
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-36d98b68d68so2209989a91.2
        for <linux-nvme@lists.infradead.org>; Sat, 06 Jun 2026 23:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780812718; x=1781417518; darn=lists.infradead.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n4CzgW3/VXNfJs9yhqU/zZT2TtJnYVsjAwImG97RFLc=;
        b=XSpiEYkRnGF/g5V71uTmQtAzZheGSUDlK/jwtSf8LTzuRyoR6prxgYQfoP/edKwUfy
         ddpTDFMJ5nuq/aE+W/tJhOevJHtN3EfsO1LFAUiAEhZvg/CuFIEOA/LXYczLPM/doi6t
         IASVP88cqOiLDhh9oTO0gOB3s6A4mWqGk3QvKGWnvJGUq2m1cx+MRLQIFoByfpp2mSCG
         hruYRgXeAeAK9/xd3Va4VSfIo+BmhCbWxhQ0CnS/U7DeZqgEW55nmXQNXb2gRPEWaRFg
         3G34uqYnMAVC+kcT6EacQ3zCE/huso59sZ4bu0CIcde4A8sxVMDxlP6o6xDiviEivXfO
         HlzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780812718; x=1781417518;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n4CzgW3/VXNfJs9yhqU/zZT2TtJnYVsjAwImG97RFLc=;
        b=UPgQWYFEOqNVyPTYNYyACqFa3dJG9kF2pmZWhih2Wrkf2+bdTLy8vKH2WlOHeoKHe7
         NMcpCq3KwZd0S2uJWrWvioW7NInfxcRA9+VTgvWaxBUwiPLiiT2H7edixHroLAqVSWUp
         1/M4IayJxtyDaSCYCpMYpLLUfqjfKjr4EVivCuWgAvoc5wVRDKqtNPZoJbY7GZj/lqkA
         Ih5Kyy28xImLU3PaUatVffAMRwkEhrBPbEOIW6d7yzPN0GPjBILjbj6JG+IJ/3nTy1aR
         FT1jgOxO8vJcttk6Us3+0OcHbzeizhF+vbrYXmfGsMTFmEnZJjlK00Kg5V4lGxRcE6KL
         HmdQ==
X-Forwarded-Encrypted: i=1; AFNElJ+plXvcUZQGiCiPMy0LxMEZgVDrC5QB2j8tMLlI5XVKPGiKV6ugu8zt/67oCnRXIAdz5FBgy+7yyIbf@lists.infradead.org
X-Gm-Message-State: AOJu0YzY5MvBxRUHs3z1wWMD0X52WFD4bb2jSyPNuIxCyt1l/EfmzHxP
	+pXP668seifVmUp0taYtYvWqjdSGJBU22T7hTBgQc/qGvsnxqAbsptQQ
X-Gm-Gg: Acq92OHZznBzRrDinIXO8/VUmiGoIFXPMFn5ZaJOnOAyWllG1B0jI5tOU64nJJJIgiU
	B7qN2iXFz/GFgDfM4rtVUVmKUQWYbbOnKrI792rGZRl/AJNEvfUlJ1RBqNJeqXqX5++bqspjhG/
	Ld8kZki6dbwnXs7gALfrfI903DJxnEOaJYYaWb9+EjrpNbq7NGmcedSDI2pBFU8CuYOhbW3IZoT
	4wnPCt8Sq6RmfiYLMbEPBznfPLV2qQRNuXeeWyZd/zaIKu2ODoiW4fbXMhL1KDctwOk4Mb89Y5a
	v+41xKj10CKwkDGtvrFwNzfrgDslozOQGWMlzStAiCuBQsrqswXxtt3XTihYzI8IPd8y/4mAm17
	hEDkBFQhtoXso698a7f3eQcRdOzOXlwfXI6fyBZ484RoOhDSXjYTSqSQFrX4vLh9fWvcq/25/yI
	K8aQ3nVLr1APjoMddY/zqwVXG1iDuyjFHkxMLO
X-Received: by 2002:a05:6a21:134b:b0:3b4:b216:2b1f with SMTP id adf61e73a8af0-3b4ccf80159mr13680216637.28.1780812717650;
        Sat, 06 Jun 2026 23:11:57 -0700 (PDT)
Received: from [127.0.1.1] ([223.122.38.120])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-c85df0a4afdsm14265308a12.19.2026.06.06.23.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 23:11:57 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Sun, 07 Jun 2026 14:10:58 +0800
Subject: [PATCH v2] nvme-apple: Prevent shared tags across queues on Apple
 A11
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260607-prevent-tag-collision-t8015-v2-1-dc4ef4fb42bc@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42NQQ6CMBBFr0Jm7Zi2gEFX3sOwqMMAkwA1tCEa0
 rs7cgIzq/fz/5sdIq/CEW7FDitvEiUsCu5UAI1+GRilUwZn3MXo4UtbvCRMfkAK03QsMDXG1mi
 p8d2zdGXVMahBu728D/ujVR4lprB+jmeb/aX/eTeLBq8lUV8x+bo292H2Mp0pzNDmnL9xWMvex
 gAAAA==
X-Change-ID: 20260606-prevent-tag-collision-t8015-1c8adb3234de
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Neal Gompa <neal@gompa.dev>, Keith Busch <kbusch@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2577; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=sD96oirqm4ckkhaWc1fQu9F2uL78837hDwpVhGdgQ3s=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBqJQuj5X7yX0st4BSLbvwlG4Y23Krqmjcv8kUJK
 eJmcCRztTuJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaiULowAKCRABygi3psUI
 JAj2D/9pVvXx4a209XoxNjr9ggO6sjnN9gdaSZUU6WD/bPUTGFUyk2mhMNzxfWJ2wIQQ89SnX6W
 pJGIZH55vvdXeN3NI6t9RwdBoS98XmqHS9nGZFb9Wqb7dFhkxTGMVVOuSEn9661DibNck167UDu
 boT1wYaIcB+T8RCR2QkqfaKq603iB1OizXUU+OQEqVCkIH5MigRf2S5/+AwzcqHYDh/epJyCk3Z
 B6PSTSWNm7puzXwLDXdH3+o5WP8VWoPisatGyzTt70KMTs3wrFNIqK4aQ3rq06GXPC5f5RCWS+D
 d6XVaiIIHuB60G7mJXVaETbfMIyhJZ/rEJb2BChuQXl9jv7O0vduj1977TUgaAG5LIHqY0EVDRD
 SbIgcxt4EIYW6+JZJC2l6EFajmHi1wicQq9199JbTkLav7ZS1dTbuQDeEl6pLLqjI8Av16OoIkw
 G3F1xlvBUoEEFi4h2cEFa4EqWFOmE6bNVqCpou1qHZq6zfovkqiRlmNi85ZcHg1+h66Tq+LZpZ1
 BgdcHV89lsGc1vpmhWbRhnCD2CfWnKgiWdqU1u3rXXcNOD4IJeCFV3ejOk+xxfl9b9KhmbH36PQ
 Ev6rU6o2iuHBvAzxFinW4zH3znRlCBPoZ6FYiClWNy1EbJUYGMiR2J9GK6PiFvOD/7x+D2eVKcp
 Fa8BpKVdI21En8g==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260606_231158_798169_CC526B45 
X-CRM114-Status: GOOD (  15.35  )
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

On Apple A11, tags of pending commands must be unique across the admin
and IO queues, else the firmware crashes with
"duplicate tag error for tag N", with N being the tag.

Apply the existing workaround for M1 of reserving two tags for the admin
queue to A11.

Cc: stable@vger.kernel.org
Fixes: 04d8ecf37b5e ("nvme: apple: Add Apple A11 support")
Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
Changes in v2:
- Complete rewrite to use the existing workaround for M1.
- Link to v1: https://lore.kernel.org/r/20260606-prevent-tag-collision-t8015-v1-0-93ccf4eca550@gmail.com
---
 drivers/nvme/host/apple.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index c692fc73babf..da6e983e2005 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -225,7 +225,7 @@ static unsigned int apple_nvme_queue_depth(struct apple_nvme_queue *q)
 {
 	struct apple_nvme *anv = queue_to_apple_nvme(q);
 
-	if (q->is_adminq && anv->hw->has_lsq_nvmmu)
+	if (q->is_adminq)
 		return APPLE_NVME_AQ_DEPTH;
 
 	return anv->hw->max_queue_depth;
@@ -303,7 +303,7 @@ static void apple_nvme_submit_cmd_t8015(struct apple_nvme_queue *q,
 		memcpy((void *)q->sqes + (q->sq_tail << APPLE_NVME_IOSQES),
 			cmd, sizeof(*cmd));
 
-	if (++q->sq_tail == anv->hw->max_queue_depth)
+	if (++q->sq_tail == apple_nvme_queue_depth(q))
 		q->sq_tail = 0;
 
 	writel(q->sq_tail, q->sq_db);
@@ -1139,10 +1139,7 @@ static void apple_nvme_reset_work(struct work_struct *work)
 	}
 
 	/* Setup the admin queue */
-	if (anv->hw->has_lsq_nvmmu)
-		aqa = APPLE_NVME_AQ_DEPTH - 1;
-	else
-		aqa = anv->hw->max_queue_depth - 1;
+	aqa = APPLE_NVME_AQ_DEPTH - 1;
 	aqa |= aqa << 16;
 	writel(aqa, anv->mmio_nvme + NVME_REG_AQA);
 	writeq(anv->adminq.sq_dma_addr, anv->mmio_nvme + NVME_REG_ASQ);
@@ -1325,8 +1322,7 @@ static int apple_nvme_alloc_tagsets(struct apple_nvme *anv)
 	 * both queues. The admin queue gets the first APPLE_NVME_AQ_DEPTH which
 	 * must be marked as reserved in the IO queue.
 	 */
-	if (anv->hw->has_lsq_nvmmu)
-		anv->tagset.reserved_tags = APPLE_NVME_AQ_DEPTH;
+	anv->tagset.reserved_tags = APPLE_NVME_AQ_DEPTH;
 	anv->tagset.queue_depth = anv->hw->max_queue_depth - 1;
 	anv->tagset.timeout = NVME_IO_TIMEOUT;
 	anv->tagset.numa_node = NUMA_NO_NODE;

---
base-commit: e43ffb69e0438cddd72aaa30898b4dc446f664f8
change-id: 20260606-prevent-tag-collision-t8015-1c8adb3234de

Best regards,
-- 
Nick Chan <towinchenmi@gmail.com>


