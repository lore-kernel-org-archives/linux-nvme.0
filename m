Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACAC9C531CC
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Jul 2026 20:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vP39KbYqkNNRmuPyaoPhdZlQ+sTmuJQGW6DJY4lSzaU=; b=vFngX1ink9gTUMUdryHBJJuUP2
	gZDKYfwxOgQCfR9pwuZu7YOMfzaAeQIL+c9xdgP7Hxd4KqXortb2t6susKdZp8f/zI4TEp7gZlrBm
	2oFqAXS0kCC+2YXPpFdAX2ZEoFpM000liVfaPU2uU8vd8BOk5XSu3EjwnAJRh8+XTLA/jkc3+QABS
	uyNp4k+LNX/WE+IVMSACE4u65IgH958tcMVvHg/ch2duVulEmCjPdEp9mZ3Oen4HYC2pGx1b7imWW
	7IWZeji9m2T11IS8s9r/HPSsQdD4okY/KWNBA8vUQUT55pRbZV/z1SGcmrgYWwL009a7IaVZ9IdNT
	3aZYhVnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wn0G4-0000000F3dH-1QaS;
	Thu, 23 Jul 2026 20:43:08 +0000
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wn0G1-0000000F3ar-3Htt
	for linux-nvme@lists.infradead.org;
	Thu, 23 Jul 2026 20:43:06 +0000
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-47f707e5d75so750869f8f.1
        for <linux-nvme@lists.infradead.org>; Thu, 23 Jul 2026 13:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1784839384; x=1785444184; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vP39KbYqkNNRmuPyaoPhdZlQ+sTmuJQGW6DJY4lSzaU=;
        b=Rx5ZUVSjrZi6j+OGadK7XA+gIoc1uzGd1t992pUl7e76UILS0zZ1hn5F0fGGz4PF8G
         PAd3GALBXdfApCTC3xe9fduwvhLIf3Fb0K+xfc1Uhw3fN8a5ZAH8RiWgzCdtvx4Wj/Aq
         AbDFdEJ2TTdOmN2WD3lrbEnDnR3kk0BKjDCsGYi55rgzeDD40r1QMWzztQ/9YeekDtzR
         FrlCiwNgOqNcakfGVXJB8I8DKn9blhMFWzlo6dG+iUUOc6zi/5veR++s6CQwR6Fkg698
         5PlqvQv6S3LbkspXVkop8wi6+ZEqr3WEaSbCD4jdvb5G54MvpLE2FT11silF+czgwD3O
         KwbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784839384; x=1785444184;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vP39KbYqkNNRmuPyaoPhdZlQ+sTmuJQGW6DJY4lSzaU=;
        b=f9oh6+H0zKsYB/OPof/xOTCEqXkoFQSfAUiJdrNm4DHY/mz3/S2zWoRquCYICvJvXv
         IciIgwEiGMOn1q5jtGgvPv6cQ4P0a1NYBtqhhuWlqA2olR8K/Lfl5YrrUvtoV8fqxlEI
         d0If1bPSeMncGlkCXEYctQLQOx7FMPY4/N2V/iWK76iCOzkHb1Ing+q/64lPFP5oxRL2
         uXz6cmSS/MiT34IqvXVwmABeh0yAEKBTTEyOibv1YHH4RRtRK6wnydLdu24Zb9pmcr3X
         z82OhrNH5DU1XSjpVZwPkMYnLZoW5dkwoUv0VM2ENFcOA6nGCARCCQcEAXFFyG6495SJ
         fbGw==
X-Forwarded-Encrypted: i=1; AHgh+RqYb830j37aYAfIybK94G7JArvdnFpkYhZTYQkNUE65FZ5H9pPyzflKZ5x+XTKVaIOF9Xczs2VI+f8E@lists.infradead.org
X-Gm-Message-State: AOJu0YyiBHvDNhfo7Oibymu0qS0TjIbO58hS5eTbCKSp2T6yxtQZ3lDU
	8c/F5+xRf7Cc08M3GemF0cxTcj4EffcySUhSC25kowoZIR3hOHVbPN/dNNVrYQvbNQ==
X-Gm-Gg: AR+sD11RMbYw20KCm4G/1a+bNl2UPjBbx5ogcZK0F2Sdskx7AqfNQnDvgnsHsbmtHRq
	DWHNFIPvnERatcq3kisyE3JZczgdr7XBvxs1QIKMdss0/pdNq3XLs6bxMB/4IJzyqLRSEnosTHz
	hiSEFcZ7Dj0FVMR6LbfKvs+0OqlDE4w3mW1M/SlnfeDFVhd/iylPq84sDQSsfkcSmxwOPnFe6lx
	XVpwSvM9Gw8i3/68fogWwqBfrw1gm+D8fZ7D+mYCU7xQG2uKI5J4GKdX1prl75H/OWTlI/62Igw
	+DIUaAE5xI14Mn9gnmMtHYpcVXghCpX+JcdtmqgWYxYv2FEl8wPV1GNrIirflRUY3MIQmokPkCd
	TgVatGR64TkNwDyJ3rZgqJbJEB73dEZxnCWHEQw3uQIrn+hIhSAEO8gV8Vylayo4ccssl/VeT7y
	39mbvwNUAl6CHUjUVqLtQn4q6SMve0J51MJLBI3UKRmvoKl2j8unKZGd7SoaOc4naj6c/YfxJTm
	BwwNmWoFLnNdCmh/9G0qrfD+DchU0mKKatcJz3Drw==
X-Received: by 2002:a05:6000:1ac5:b0:47f:28e2:d4c4 with SMTP id ffacd0b85a97d-47f8da6e5bcmr6028034f8f.2.1784839384106;
        Thu, 23 Jul 2026 13:43:04 -0700 (PDT)
Received: from meshstor-pc ([185.87.42.56])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c52fc0sm18268192f8f.23.2026.07.23.13.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 13:43:03 -0700 (PDT)
From: Mykola Marzhan <mykola@meshstor.io>
To: Jens Axboe <axboe@kernel.dk>,
	Song Liu <song@kernel.org>,
	Yu Kuai <yukuai@fygo.io>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org,
	linux-raid@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Li Nan <magiclinan@didiglobal.com>,
	Xiao Ni <xiao@kernel.org>,
	Guoqing Jiang <guoqing.jiang@linux.dev>,
	Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kiran Kumar Modukuri <kmodukuri@nvidia.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shivaji Kant <shivajikant@google.com>,
	Pranjal Shrivastava <praan@google.com>,
	Henrique Carvalho <henrique.carvalho@suse.com>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v5 05/10] md/raid1,raid10: factor out raid1_write_error() helper
Date: Thu, 23 Jul 2026 22:42:01 +0200
Message-ID: <20260723204206.76930-6-mykola@meshstor.io>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260723204206.76930-1-mykola@meshstor.io>
References: <20260723204206.76930-1-mykola@meshstor.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260723_134305_840950_8E89AE59 
X-CRM114-Status: GOOD (  12.74  )
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

From: Logan Gunthorpe <logang@deltatee.com>

Factor out a common raid1_write_error() helper from raid1.c and
raid10.c.

This will help reduce code duplication in subsequent patches.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Mykola Marzhan <mykola@meshstor.io>
---
 drivers/md/raid1-10.c | 13 +++++++++++++
 drivers/md/raid1.c    | 13 ++-----------
 drivers/md/raid10.c   | 10 +---------
 3 files changed, 16 insertions(+), 20 deletions(-)

diff --git a/drivers/md/raid1-10.c b/drivers/md/raid1-10.c
index 56a56a4da4f8..cee21452e066 100644
--- a/drivers/md/raid1-10.c
+++ b/drivers/md/raid1-10.c
@@ -303,3 +303,16 @@ static inline bool raid1_should_handle_error(struct bio *bio)
 	return !(bio->bi_opf & (REQ_RAHEAD | REQ_NOWAIT)) &&
 		bio->bi_status != BLK_STS_INVAL;
 }
+
+static inline void raid1_write_error(struct mddev *mddev, struct md_rdev *rdev,
+				     struct bio *bio, bool allow_failfast)
+{
+	set_bit(WriteErrorSeen, &rdev->flags);
+
+	if (!test_and_set_bit(WantReplacement, &rdev->flags))
+		set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
+
+	if (allow_failfast && test_bit(FailFast, &rdev->flags) &&
+	    (bio->bi_opf & MD_FAILFAST))
+		md_error(mddev, rdev);
+}
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 7d769b6460ca..f07edeac6e5a 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -483,17 +483,8 @@ static void raid1_end_write_request(struct bio *bio)
 	 * 'one mirror IO has finished' event handler:
 	 */
 	if (bio->bi_status && !ignore_error) {
-		set_bit(WriteErrorSeen,	&rdev->flags);
-		if (!test_and_set_bit(WantReplacement, &rdev->flags))
-			set_bit(MD_RECOVERY_NEEDED, &
-				conf->mddev->recovery);
-
-		if (test_bit(FailFast, &rdev->flags) &&
-		    (bio->bi_opf & MD_FAILFAST) &&
-		    /* We never try FailFast to WriteMostly devices */
-		    !test_bit(WriteMostly, &rdev->flags)) {
-			md_error(r1_bio->mddev, rdev);
-		}
+		raid1_write_error(conf->mddev, rdev, bio,
+				  !test_bit(WriteMostly, &rdev->flags));
 
 		/*
 		 * When the device is faulty, it is not necessary to
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 0a3cfdd3f5df..5b63175fb382 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -482,16 +482,8 @@ static void raid10_end_write_request(struct bio *bio)
 			 */
 			md_error(rdev->mddev, rdev);
 		else {
-			set_bit(WriteErrorSeen,	&rdev->flags);
-			if (!test_and_set_bit(WantReplacement, &rdev->flags))
-				set_bit(MD_RECOVERY_NEEDED,
-					&rdev->mddev->recovery);
-
 			dec_rdev = 0;
-			if (test_bit(FailFast, &rdev->flags) &&
-			    (bio->bi_opf & MD_FAILFAST)) {
-				md_error(rdev->mddev, rdev);
-			}
+			raid1_write_error(rdev->mddev, rdev, bio, true);
 
 			/*
 			 * When the device is faulty, it is not necessary to
-- 
2.52.0


