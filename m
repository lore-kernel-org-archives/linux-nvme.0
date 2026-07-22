Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 007AFC4453A
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Jul 2026 18:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XGlz7sxVhffzS6r4ROT44BH0oh58kUxNrwba0cAE+h4=; b=Ls6FSAEJP/fwaV2Qsp+Ee/Cdyl
	6y8qNuyzapHc7MoV44f17krHQFAPZ+y0jpcQt09yYRmdj8XXJWHkPNv2T6pb55aJ8uaqDvbmNnvNa
	nGObXzb9iMCzq07RKqcJq1cmv10kR9ZJqBEu4ViKKaenfvshQ2IN/Vlzk8W30AthGtDog8BM34oAf
	EPOsXk4ciztd4ekPzKWDRgUgo0irfKh7sIFcWgPpMv2MnJkFrIrvoQOIQj+agmslYZaULgeFQhE/S
	nT1hzWSbNXXuobmtCEGhDufIZqlmZ+eWr+UjPtQm66tl6lMYyVuMefPPGm1F1P5oiU/Xq2zHKxmGR
	aKkyKF1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmcA2-0000000CarD-19Al;
	Wed, 22 Jul 2026 18:59:18 +0000
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmc9z-0000000CanU-2UgM
	for linux-nvme@lists.infradead.org;
	Wed, 22 Jul 2026 18:59:16 +0000
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-495437bb891so54356955e9.1
        for <linux-nvme@lists.infradead.org>; Wed, 22 Jul 2026 11:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1784746754; x=1785351554; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XGlz7sxVhffzS6r4ROT44BH0oh58kUxNrwba0cAE+h4=;
        b=ninwvZS0gZ+VR08IqlE5D+bJ2bAJuJSX8rJsv62RLzDaPgBL79sdwURK4O734/5jiv
         AKyisLJWxGtPmWYplPCCMcK213QBNYyCcWWxmz6DpaDuIendbimSLlIfuOBIqDvlahK6
         009nDs6yPRNK0Cw1pWj+4klSExSsLhY3dODWNsZy2ZetR2mrSgZiIU305Fknl2tar4JU
         bQxYPODWq4BGz01zfwBY0yKl/aPpHrMKak9KkHmkcQ50UsjjuU1STK/kfNzNnviFvKdK
         Rz093wDYz9K91lJ15O/S0WG8d4UBa/eL/RuhxoYqByG9tfPYIoD+nnn1LcZtfvhG0MGN
         L5oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784746754; x=1785351554;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XGlz7sxVhffzS6r4ROT44BH0oh58kUxNrwba0cAE+h4=;
        b=iCa57MEJ8BPxUeu6aX8dWMKj9fTwSRS+mdJBdLWjOCq4YZPFkQHwuLFKobbAL7yHzw
         nXM8NfaKXytp5GCfl6JwgDR8cvqS830hDXJZix7NIkEnS7Nf05rSrd6slERRJH3QeWFg
         n85yDixU9aZxjqUYwYDmErLatMzL9jTjdnHlQL1ptHPZUyrqIYR9JM+VDW8DsmWafhsi
         mUT50Tn/Qwg4vGAj53hjw4iz9a+LYN3y3UMMSOuY9a10X6wxbKqCVfeSsxA683p1dqPg
         Rh+NGYuS1J9FQelA8eZJ1FNUzGFtQ0ZyjS4lSfBFXniAI4ZQ5/hFT8rKpSk3rZ6e4nJo
         SoTw==
X-Forwarded-Encrypted: i=1; AHgh+RpP+SSe2NxuYUAd01tBqI7Qd9fZtjmTtCWy+mJb3ZwB2WCTJtE7KwzXlkbidC9qfLoVXmWqJxX6ZzSt@lists.infradead.org
X-Gm-Message-State: AOJu0YxhPKej48YhGm128SlMD9tcCFwU9QH/T11AKeX5+wKbcfw6O+wy
	KQ7g1yUth1LCih4qRwsEhW0N9rotAEtQJgjn6D9Qq2bD876B1AQrShzAtOdyOcnCjg==
X-Gm-Gg: AR+sD11diu0/K0aiiqlXRrSTcE1xH0XDp6X7A0f/ryJtmhAXoVTGdBna92xQilB3A5T
	pWOYQEa2Dwg2Mq9eXltbnQwFjG+jqc40xR/zU5mv/1ealyQABJhhU8c/B9VHOzqMwUB/NJYjypr
	TlWK+fuVrkHCzfApjZdgQtLi+cCnXFiC/ItF9gonLYxwGmMUhYRirywj0xAYK91uG+bhRG7B075
	ny2CzLC8sTnntgFgPmwKc9UeP9TcJkM1jozhdD1yyYyiG36NKurCGDyyW6Cdw+dTlAUz7FR9RGs
	4sFnCBtfwiXdhGHGMySNE4vlfxZri767aJqhIwx4yJYuNcwlw3urmSjhUSTcJe9AcPHlNQAI9w6
	Zn5w2yfcL+CV8K/ump7sbkax+0RjiZoAxma4R/S7Z/3J9grccB2hbjetc4zkdJxL4WD+OWc/Fwr
	oT4AACIBjVxDy7aZexkz4/3YrK+Fd9ybhPsq/ydegg/90+dDA=
X-Received: by 2002:a05:600c:1d23:b0:495:7016:b875 with SMTP id 5b1f17b1804b1-4957016c17dmr25808785e9.13.1784746753845;
        Wed, 22 Jul 2026 11:59:13 -0700 (PDT)
Received: from ai-pc ([46.172.241.174])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-495730353d9sm13740055e9.12.2026.07.22.11.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 11:59:13 -0700 (PDT)
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
Subject: [PATCH v4 7/9] md/raid1,raid10: skip futile retries on P2PDMA mapping failures
Date: Wed, 22 Jul 2026 20:58:39 +0200
Message-ID: <20260722185841.449934-8-mykola@meshstor.io>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260722185841.449934-1-mykola@meshstor.io>
References: <20260722185841.449934-1-mykola@meshstor.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260722_115915_660420_8446837B 
X-CRM114-Status: GOOD (  15.79  )
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

BLK_STS_P2PDMA reflects the peer/member pairing, not member health:
retrying the same pages on the same member cannot succeed.  Keep
WriteErrorSeen so the range stays fenced, but skip WantReplacement and
FailFast eviction, as commit f7b24c7b41f2 ("md/raid1,raid10: don't fail
devices for invalid IO errors") did for BLK_STS_INVAL.

The failure is whole-range and deterministic, so narrow_write_error()'s
block-by-block submit_bio_wait() retries are pointless.  Record the
whole range as a bad block in the completion handler instead.

Fixes: 02666132403a ("md: propagate BLK_FEAT_PCI_P2PDMA from member devices to RAID device")
Assisted-by: Claude:claude-fable-5
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Co-developed-by: Mykola Marzhan <mykola@meshstor.io>
Signed-off-by: Mykola Marzhan <mykola@meshstor.io>
---
 drivers/md/raid1-10.c |  3 +++
 drivers/md/raid1.c    | 12 +++++++++---
 drivers/md/raid10.c   |  8 +++++++-
 3 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/md/raid1-10.c b/drivers/md/raid1-10.c
index cee21452e066..89daf8558251 100644
--- a/drivers/md/raid1-10.c
+++ b/drivers/md/raid1-10.c
@@ -309,6 +309,9 @@ static inline void raid1_write_error(struct mddev *mddev, struct md_rdev *rdev,
 {
 	set_bit(WriteErrorSeen, &rdev->flags);
 
+	if (bio->bi_status == BLK_STS_P2PDMA)
+		return;
+
 	if (!test_and_set_bit(WantReplacement, &rdev->flags))
 		set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
 
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 19c4dec450de..917d694ef401 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -2624,10 +2624,16 @@ static void handle_write_finished(struct r1conf *conf, struct r1bio *r1_bio)
 			 * narrow down and record precise write
 			 * errors.
 			 */
+			struct md_rdev *rdev = conf->mirrors[m].rdev;
+
 			fail = true;
-			narrow_write_error(r1_bio, m);
-			rdev_dec_pending(conf->mirrors[m].rdev,
-					 conf->mddev);
+			/* Mapping failures are whole-range and deterministic */
+			if (r1_bio->bios[m]->bi_status == BLK_STS_P2PDMA)
+				rdev_set_badblocks(rdev, r1_bio->sector,
+						   r1_bio->sectors, 0);
+			else
+				narrow_write_error(r1_bio, m);
+			rdev_dec_pending(rdev, conf->mddev);
 		}
 	if (fail) {
 		spin_lock_irq(&conf->device_lock);
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 428bddddfe71..9045a3f02dae 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -2940,7 +2940,13 @@ static void handle_write_completed(struct r10conf *conf, struct r10bio *r10_bio)
 				rdev_dec_pending(rdev, conf->mddev);
 			} else if (bio != NULL && bio->bi_status) {
 				fail = true;
-				narrow_write_error(r10_bio, m);
+				/* Mapping failures are whole-range and deterministic */
+				if (bio->bi_status == BLK_STS_P2PDMA)
+					rdev_set_badblocks(rdev,
+							   r10_bio->devs[m].addr,
+							   r10_bio->sectors, 0);
+				else
+					narrow_write_error(r10_bio, m);
 				rdev_dec_pending(rdev, conf->mddev);
 			}
 			bio = r10_bio->devs[m].repl_bio;
-- 
2.52.0


