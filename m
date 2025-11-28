Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CB0DCFD376
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Nov 2025 08:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3B+NwUppxNtx5dO3GeNOAlGv3QVGc2Q+cteUdMRhiTw=; b=Jf4DPXx1KUlO++9sMBFRm/odTb
	qPC5QhrmnEy1xRqMFFsuuAyfGt013gRFtUQJ46vzSh+sb4IlRvccdJTVpvVbC/iBfnwzguAHhBOyx
	6eKywHTUxx3dCCL62+RSvhUVeaU+6XlXIh9WiNfWKSGtX9LAQz8M6SmmM4kM5mqEs+d973MS30RLk
	gd/KDbqA7yZAA76aeXunaF+RdlnkPSroIJqpJYVjzKCM+W7eQxgR9uZY53iG9POujrHj44jnObTu4
	cOTRB07r26P+k0nBpGyGooOU3H+s0VYnrKqqM/4mWj+MW9uFNxcRY2sGgteOBIHfIrd0Vd8Ws8FK6
	CLouzvLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOtuS-000000009KZ-0x6p;
	Fri, 28 Nov 2025 08:32:56 +0000
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOtuQ-000000009Je-05GQ
	for linux-nvme@lists.infradead.org;
	Fri, 28 Nov 2025 08:32:55 +0000
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-7b86e0d9615so1899082b3a.0
        for <linux-nvme@lists.infradead.org>; Fri, 28 Nov 2025 00:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764318773; x=1764923573; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3B+NwUppxNtx5dO3GeNOAlGv3QVGc2Q+cteUdMRhiTw=;
        b=j/OR6rxuNCoYWzBu4jEuZHga6ZHsuExqSvXg+ZYxWFbvxBctV6+UKiTBjxL1JtIvuH
         3gBqQY6YjWcKuGPxWZgyK+9TlSulTxEJ/w4RP2P3n00yup1eGBUGajuVJ5am/8loTF/2
         UPtsl/7IERvFfd7lQctqcTIG3TyXUGxkVwAuG+rSGw35IPXWiISFuMcDMR6RXpX9qkLp
         MBsBt6sSvn3SxpO8ZX4DbSFt8AEtTRoHynnrcqSgFmrX7FTSDpsV+6W+LsvVBxMztnJx
         vkfWVlkQH3Ehy0Kv7bLexHBFGdcLg9kZUH1ddfrFeEYribd//0oECKrkETqmZL7sLXMI
         mI/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764318773; x=1764923573;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3B+NwUppxNtx5dO3GeNOAlGv3QVGc2Q+cteUdMRhiTw=;
        b=NRNPLMeLudeeWY3VLstcAwzyZfLV0nCiyPEjNafLJ6kRwqLQOMXYuZ9q4MMZQWIuRb
         F7dHHxDPgyAWAS8qcSIOp/JLhxT45LqM0KOP51kFYEYbahmDAqxpqlMfyfC/eMHmxvDM
         0d3Q3Jx27xGSH8jW9WmoLuzQeteja38CYBgcEINs0YcPDX1ZyzJcrZ0WJmWvj+3esRqQ
         a+sOIkK/mWJfbG50McYohvIR5MHUvjP4tdRnisCW1s9Y9cgKWGuxSleM4VayFcDfvpnM
         XscXI3YNWQ1mOYLX7+RtIQF9NA4pMSnsYot2c2ljgsJF3on8sIAp0rgefUiOkvALUtOZ
         BATQ==
X-Forwarded-Encrypted: i=1; AJvYcCXc9jr4hCXxPs7UECk67oLlpCaYTLu8W22Ymog7TKBYl4hzRDBHBmNrTOu7Umcsf0h0bBpkla1t+hfQ@lists.infradead.org
X-Gm-Message-State: AOJu0Yyqe76GYt32XF6JQ12PxWGd4u+UryE1B0PztNpi2UczRq2SZHOe
	Urp77O+p9wruLiWDFCZr8dQfL2dqlVfUjKQoZigReb7IJJZNW2amd1Zo
X-Gm-Gg: ASbGnct5RaOnagNuBcVxoiBQm2FpNp43cexC/zJfrHVgJJOnKpDVqqYxBPZ4l9kS93H
	lBH+0AURHIU4LVRQGzCDc28lSRn7XtZkeqolhzPfIZX+oTCPfDncfNP+LambgBegBAiuT3AXszN
	a7fVhWU3CMix7C8YYoV5VxW4ZyMTffYFJngcnCl9EIbBbhTb3fJUDeo2IGRJcvxSfGFNuflNEV2
	Evpaf+EUDZA/Vf7VPfaZkxE5E6xpbUK0onEFtbzBNDwAJ47RG4JGAKqcF465Uw7CZyqIC3Ka2ky
	KlKwew5yBeffwlKevtz6noNRcrN38o8/V83C/I0kPEX+x5QwJiLGhGausQukHThDgzzzkN/JzKr
	jumVxfc9shPyTPplIi002PWC3J5MYohnmrqfArl0ZgMDY/VdlAEvjZAtALbUQLPXTfu+8ogfxC2
	zE2S3QiaSt2aVBAQCYOwj1eK4mXw==
X-Google-Smtp-Source: AGHT+IExpRIXm/rx9JSaduyyoo433z0edlCZgYRCixn+2l+uiE9AooEQRv+QW8QlPPxN5lYcC0yJLw==
X-Received: by 2002:a05:7022:2390:b0:11b:2de8:6271 with SMTP id a92af1059eb24-11c9d8635bcmr22508225c88.39.1764318773026;
        Fri, 28 Nov 2025 00:32:53 -0800 (PST)
Received: from localhost.localdomain ([104.128.72.44])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcaed5f6bsm20941371c88.1.2025.11.28.00.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 00:32:52 -0800 (PST)
From: zhangshida <starzhangzsd@gmail.com>
X-Google-Original-From: zhangshida <zhangshida@kylinos.cn>
To: Johannes.Thumshirn@wdc.com,
	hch@infradead.org,
	gruenba@redhat.com,
	ming.lei@redhat.com,
	siangkao@linux.alibaba.com
Cc: linux-block@vger.kernel.org,
	linux-bcache@vger.kernel.org,
	nvdimm@lists.linux.dev,
	virtualization@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	gfs2@lists.linux.dev,
	ntfs3@lists.linux.dev,
	linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhangshida@kylinos.cn,
	starzhangzsd@gmail.com
Subject: [PATCH v2 03/12] md: bcache: fix improper use of bi_end_io
Date: Fri, 28 Nov 2025 16:32:10 +0800
Message-Id: <20251128083219.2332407-4-zhangshida@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251128083219.2332407-1-zhangshida@kylinos.cn>
References: <20251128083219.2332407-1-zhangshida@kylinos.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251128_003254_067390_310C7751 
X-CRM114-Status: GOOD (  11.50  )
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

From: Shida Zhang <zhangshida@kylinos.cn>

Don't call bio->bi_end_io() directly. Use the bio_endio() helper
function instead, which handles completion more safely and uniformly.

Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
---
 drivers/md/bcache/request.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/md/bcache/request.c b/drivers/md/bcache/request.c
index af345dc6fde..82fdea7dea7 100644
--- a/drivers/md/bcache/request.c
+++ b/drivers/md/bcache/request.c
@@ -1104,7 +1104,7 @@ static void detached_dev_end_io(struct bio *bio)
 	}
 
 	kfree(ddip);
-	bio->bi_end_io(bio);
+	bio_endio(bio);
 }
 
 static void detached_dev_do_request(struct bcache_device *d, struct bio *bio,
@@ -1121,7 +1121,7 @@ static void detached_dev_do_request(struct bcache_device *d, struct bio *bio,
 	ddip = kzalloc(sizeof(struct detached_dev_io_private), GFP_NOIO);
 	if (!ddip) {
 		bio->bi_status = BLK_STS_RESOURCE;
-		bio->bi_end_io(bio);
+		bio_endio(bio);
 		return;
 	}
 
@@ -1136,7 +1136,7 @@ static void detached_dev_do_request(struct bcache_device *d, struct bio *bio,
 
 	if ((bio_op(bio) == REQ_OP_DISCARD) &&
 	    !bdev_max_discard_sectors(dc->bdev))
-		bio->bi_end_io(bio);
+		detached_dev_end_io(bio);
 	else
 		submit_bio_noacct(bio);
 }
-- 
2.34.1


