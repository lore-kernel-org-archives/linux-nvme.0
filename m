Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F6B1C53219
	for <linux-nvme@archiver.kernel.org>; Sun, 26 Jul 2026 11:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vP39KbYqkNNRmuPyaoPhdZlQ+sTmuJQGW6DJY4lSzaU=; b=wIKEnKWqWDygW8GB4HIkgLogRO
	xRbWKUZ50jKdcij/YvklEcN7q3QB/SlpU6kJ5YI6/3WB6DG+9klAtQhyDRKtHUx0c2iZR86kJXFUI
	RdfOJu4ykSrxqOPUCwiU+/BoSCCCT9EFl0ERCm7gnKrqObIMMhmIJGeH0W6FKBHex+fx+RA4PwFac
	D+Ua8iPoZQ6j21fs3YNSMLtRl475TasekzlZR56QqvNUdQHJIOg7bsD6Z5K6gYkF6cUAyJN+mx/nc
	xfMlIB3OYsNIn1AsnbmzeF6MVITBMr2BKIVVqaHOmUaSVFKlzb/8sx/faU101vb113fKmbeLtfZZX
	22qXTpsw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnx6A-0000000171S-2Ufm;
	Sun, 26 Jul 2026 11:32:50 +0000
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnx68-000000016zg-0LQ9
	for linux-nvme@lists.infradead.org;
	Sun, 26 Jul 2026 11:32:49 +0000
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-4728c12ba97so1097671f8f.0
        for <linux-nvme@lists.infradead.org>; Sun, 26 Jul 2026 04:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1785065566; x=1785670366; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vP39KbYqkNNRmuPyaoPhdZlQ+sTmuJQGW6DJY4lSzaU=;
        b=YbBMoQ2dwQK2M5LKnJ/SnysMIUD1DjmYRq46FQb5n3cnvPHirD86WrzHmcuX7N02id
         twynZAD1sWFRnfX6/5T/6EG06p37kf7QXcHW8Rhp8nedgdCwtC3pZHg+J+POj92E/VUQ
         YGIsCVN+bMCDcbeSY1Gv1sbjpld2Id8myaICLxvUc7cp1n70Qvs+N0rKhYadguNjKNLx
         /kzOSVAW5XQeDaxuDYD+kS7wV0L1M4uj0ZCQz6F13cPKpEm/cE1QH7dNeMxh1p9o8klJ
         xFQ4+VjYpT0k4jYHTnHOeNPOzX6ksAOPDcqa2v1ox3ve91MaCndvZvWVQmjBt8WnqtJD
         ElWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785065566; x=1785670366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vP39KbYqkNNRmuPyaoPhdZlQ+sTmuJQGW6DJY4lSzaU=;
        b=p54ptdHI4ehqWlYlMyDmBJXmlJhcWkwkjbiSTjkkHmj9pzYDQQU/aZtmfj2wbOYt+7
         ngYWaMDVdUFUc5JKS6FHwu+q9ca5qqxOcFImTxEvcelJQbxWOZ7KfRu/4GjNM+I98+eU
         4Rnxd+24ddMHF7rNm1yfbY+Ah+obQPXPNnVmcTrwA41n7BpoRhspDm7AppFDkmI6DwkE
         KxX09NtfQiS4M/DqMSb3XqL5N2yQpZYszuaMYef5ICw2y6IIj089EG8d2ZskDUxCrDtX
         RQ95Ep2dehZZZZEI7XZzwolcVp2W4c17rovIpCxQK/9A1Z9xEIfceplk4HRcthXAkx/0
         ugtQ==
X-Forwarded-Encrypted: i=1; AHgh+RpjIa5RJX18+D+CjsooGaf9/BuSXX6ny4+JcVGmXiwXvvmLx9HNTlrmoXxmkFCBnbIOzH2A1KcFLipn@lists.infradead.org
X-Gm-Message-State: AOJu0YxlO/uoFWT9AvN/qxbeO31Z/LRsuYUEF9Xx5Qgp0JCrD1LsT6tW
	EsDEEptj9KDBHj7uvppxkwkZBHWe62xWBibamozWQZ0ZFFmVihhj/+aBIkirBqkd0Q==
X-Gm-Gg: AR+sD10lc++JdCWvTZtSOkl13tdr7K0GgJzAKsrLB1QePeFfju/rYM9mJpRkzIC4k+s
	GxSUmX/74+yBugvnwob021dQp7EPhvjQNYROZ1X+OT3uFSdNrunR4rbNo5LjOVfGuWv4uS9F4Bp
	NQJ30AfTVm/LsccbqK3q+X4K+0ty72cSCCuFttlpLYT9/3bTBpQkTfEOvjsSmg1Uqmt1XL0XNDd
	L7wT3wLiKENnF1J5kgdfqPHcW6aABi+IMTlC92n6nfkiaH8VOtfVXKYSluVOWR4WCSq4aupDhJe
	V8gWQdjeAs2KizryqLcDg8XqIrik9AzFzayaXnjTbXSLsfSZu1cC7j6pTWmdULyl9mrXOpoFm9Q
	YQkQIaSu7+rp/Z7loyvHELMScBgVox7pMWS4XueEKjmi3fsMH21P7Zw5ILmYg6eiTlrLaV4VW2K
	H1xBWtXrygAXBDriD0ONYL+ldTrN/MDrbyYNU89FElTXupFRM3hLphqH+4irq2m/KjLGa/1XqGQ
	7ygT5y1ItkSk87+vslIQ9JaLr/TbqOhbrlv5RNiOQ==
X-Received: by 2002:a05:6000:200f:b0:46e:c978:7ddc with SMTP id ffacd0b85a97d-47f9fe9bc91mr5809021f8f.24.1785065566081;
        Sun, 26 Jul 2026 04:32:46 -0700 (PDT)
Received: from meshstor-pc ([185.87.42.56])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85bb57cfsm40533083f8f.11.2026.07.26.04.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 04:32:45 -0700 (PDT)
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
	linux-pci@vger.kernel.org,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	Martin Wilck <mwilck@suse.com>
Subject: [PATCH v6 05/12] md/raid1,raid10: factor out raid1_write_error() helper
Date: Sun, 26 Jul 2026 13:32:22 +0200
Message-ID: <20260726113229.2154269-6-mykola@meshstor.io>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260726113229.2154269-1-mykola@meshstor.io>
References: <20260726113229.2154269-1-mykola@meshstor.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260726_043248_135347_5E45496B 
X-CRM114-Status: GOOD (  13.07  )
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


