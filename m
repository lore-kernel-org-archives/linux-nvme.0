Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DCF0C4453C
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Jul 2026 18:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vP39KbYqkNNRmuPyaoPhdZlQ+sTmuJQGW6DJY4lSzaU=; b=3hsEdodoe9pDBu7nBgpALPedkO
	7bLpI2QHZ4WJjhIGoGg/2PneTJVMQbfeIbiyzYhGubfIZIZ+9QR5iJBZP09G5GEM+4/+KeFB+iwxZ
	UbXK0e6IihjK5dLsW6nGZariPKhpbgjwT7YQF+hGrL6Ye/BLs0diLgIQkdv2atMO47Xj3XMif++6F
	MFGctpEtgqDZ8R1v88v+psE926FfTluWgT2A9yLVxEXlIZOPOZj9Jr5pt17LUuo+3WzCatE34UyOH
	PWmjn5y8s7U4ZE6Wn8uldJc+BObch9IH7DBwgn6FjCp8DMWRb1L+3oFO0F3xbiWDdaMMSd//sGBMh
	KoVs+chg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmc9z-0000000Caob-42Lg;
	Wed, 22 Jul 2026 18:59:15 +0000
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmc9v-0000000CajS-0QhL
	for linux-nvme@lists.infradead.org;
	Wed, 22 Jul 2026 18:59:12 +0000
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-49571fea44eso2339195e9.2
        for <linux-nvme@lists.infradead.org>; Wed, 22 Jul 2026 11:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1784746749; x=1785351549; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vP39KbYqkNNRmuPyaoPhdZlQ+sTmuJQGW6DJY4lSzaU=;
        b=CYIw3YKC6fQx6RVtjXznTKJmMwdjJIg6bPR8UX2sZ8f4CAe+vkENRZmTzX5AK3XJwL
         jZHqhLHK/99tCNdZO0DiF2ZHSDCnZaIKXhSQfEx9qF4jq0Zwl9Q0m72YJOYgMYzms6GB
         X7VhhPKmR0i48+n225/dQ+JcM3hQPlBnwQZgsQIVMuORkea4NvmuNVeYeySw6Wc5s6UH
         wvZ1GvUoSFOSuSZdasNqDbRS4c1hpEs0Igy1Zy0kErM3kxCpcLjZgdt1X6gwL1tyNxSY
         rQ/pCDO5KX3y2M6fC2EipDBxAj9GPreniM5hd2IKfLRdmNRwuqdHBBcv+BUvM1KK0I5b
         oDsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784746749; x=1785351549;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vP39KbYqkNNRmuPyaoPhdZlQ+sTmuJQGW6DJY4lSzaU=;
        b=kW8rXt2QGI9hs0S4CjZz0PohYjvUhw4ROgGFZsGB3Ej23OnAgHdlGJFKem1GAq0JVl
         CEYnYQJQsIBwtbHQrtqptVZvRkDLIYY0sg9irwSyViG7yVxHBB5s4P+RKYn0ONFaaI8L
         WvhjxLRk2LoaEB184sod1qdwrTci7mjvdD6OBFh4qakRAVrcP2OHPCG2UUZSN4RA3Bjb
         X773nfLJpq+AHn3iB7s47464FKfufKMko6/eXPhl7liG9pfzj7tFqA65Vpi4SW2R0t8J
         V6tztf7PVr+obn6ZYS3DLZrWFmY2S0ZAg7MUVi2QVobWkXXDaoGvlIIUjZ/cWEcOXSBz
         F4Zg==
X-Forwarded-Encrypted: i=1; AHgh+Rq0hVKsz7B0MgK5Zz3ZVSvmrXQ0oFspeAyVY42218qm0rB9Xp+zGjvVqKdRp+tmDEfGbDkico6zIrXw@lists.infradead.org
X-Gm-Message-State: AOJu0YyKly+ibJK9jvE/a1+p1yK3wFvOKfJFdWuhikLsFJm5dIgHCfTb
	5pnXZLryMop64CFtazPEaD6zVMve8RLt5GLF2DiGs/U2vuwOaQ7Tbq8RAQOpyli13A==
X-Gm-Gg: AR+sD11QEeMJ0IFPyuZDfVsEQUbMFvL/pJKBkeQ2ITEvgR6XlnkOsa6nzX/2lcBa4Mt
	roKkFerr3J+iwpNg3tECNp5w+4h4rG1M0fg7yyadd4pX8jzi0bcWCFIQ4L0esEStNEP7AE8miH1
	IG7IS8qOABX41P3Flc+/8fPAUs35ovzazuARbMXaXbGu9c991DvYwhOclqAwSV6LaiDJmIXOh6g
	/mGuwakxwDKnZovBHgoCO+IMISZ/VdGuup+ogIZz+UsSJQNUHf8cBIg7Dxf7/hIzIUBc/Sy15Xz
	qF/aGVZAmRujz7aSdzuz5aX5RQXq4WKZdNO86h5CcsvZoxrZwcqogaMqXRJXzFCiw9FS8hVcZUJ
	5y3Y0FqagOYBbUhsZDEsoDSHH+ZTAUhGf1NP2/bxFIQKCQa8PEI90tOUFROW6Wq+opoTdhM6mn7
	+EhEnCv8YMCN7Js/MhsOGiPsTD6oJ+Qnfw9lgOsI85dL1IMP0=
X-Received: by 2002:a05:600c:5490:b0:495:6130:7805 with SMTP id 5b1f17b1804b1-49561307a51mr135357485e9.14.1784746749133;
        Wed, 22 Jul 2026 11:59:09 -0700 (PDT)
Received: from ai-pc ([46.172.241.174])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-495730353d9sm13740055e9.12.2026.07.22.11.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 11:59:08 -0700 (PDT)
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
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v4 5/9] md/raid1,raid10: factor out raid1_write_error() helper
Date: Wed, 22 Jul 2026 20:58:37 +0200
Message-ID: <20260722185841.449934-6-mykola@meshstor.io>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260722185841.449934-1-mykola@meshstor.io>
References: <20260722185841.449934-1-mykola@meshstor.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260722_115911_162295_5DAEA993 
X-CRM114-Status: GOOD (  13.33  )
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


