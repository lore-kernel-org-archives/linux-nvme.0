Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32FFBC531D0
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Jul 2026 20:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2ii4b8aBCeGQxAV9y7kovFsk89PBwma3JtjswJc/vPQ=; b=TEGBRXeSxrj0a/NwuWhMFirrvp
	qK5PdUEfTet1/bxaR2GLMtuL0yQsK/+O3vujyj3oWxywG8WepYJnMGSKLngJFPvKvCTDfM5RWbpMX
	x9FNq/Sc5CDVt+sOAerAsDw08Luvvzs13W2CUCW3C0eIWiA5wIaIOivtlDgFjyql4TbDndeTAc9HN
	2NBY/bGNzmhhdD1ry9h5U3jPeML3atkGkJFIUlvriPVVkCNumwnoCMtVcLHKeZtnurr05nvNqje6h
	wusVFfsytEtlSTl9InMii960Tq52uEllKBLf8kJ5ZJ0gF4BSK8lDECJJ6dZK6mtb62GqC7FFs1yfa
	MG1XmiyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wn0G9-0000000F3iW-3EU8;
	Thu, 23 Jul 2026 20:43:13 +0000
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wn0G6-0000000F3eR-2g40
	for linux-nvme@lists.infradead.org;
	Thu, 23 Jul 2026 20:43:13 +0000
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-49548aebcd8so8488335e9.3
        for <linux-nvme@lists.infradead.org>; Thu, 23 Jul 2026 13:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1784839389; x=1785444189; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2ii4b8aBCeGQxAV9y7kovFsk89PBwma3JtjswJc/vPQ=;
        b=aup/Q0E0XRZ3E16Wh8f+eBYPMNq/6z/dbUusB13YLqQrY4vtdhG45jq1XWHj16uaYj
         Ziwc1I9yEK+FwTHWz3JhT3ozRSHecmB9eFzL9XqF32EM9QyOsToRXJpHiSuqEMIae7AM
         z1yFAg7FAQCWNNeyeOCx7eLoIM5QJczU2lGMsInhNjn8G5H3eNzJpbt+RCNlIM3/S12R
         bZcriby4REyORpTJf6dmXIRk+5PcVE17IeGnYThzP9wNN1E4g1VI5mlZz5sQF71gy/h3
         vfTY5tAUyLAqgbxSJYRBZ8Sno8Ook2HP4Yjdclcv9Adi3vVoyOD7pQmSYCQDaJ1Qc9gD
         r06g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784839389; x=1785444189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2ii4b8aBCeGQxAV9y7kovFsk89PBwma3JtjswJc/vPQ=;
        b=msVByHZVjlvrj/x+OpmYcIu2iZPtwwqaykjEL9n4UdS2PrQ8MlBEtrNJ3mBRwNNRjN
         CYQSL5FY7hVoTZd0nymgDAjbXB1PkB9go7LpIBZc2WgBT1VrjE+tTdJZnXvHV/00yOfV
         gvR2jzpYExWFQvMMzaYeEAGW5PGeIePhn4Cch9V2MqgonTMNr/s/OpofRL/AK/5fnUYA
         Sc19+XKiCoPkRTIstP31TJeIHbxFoaGuD+UsqQotLFWE3JiaXoNLr/WAouf1da4XlZfj
         0PeLSYCCGRjvO6ORLQ9c5QKLUAKOFyIRm+dyCQLJ62bSFN7/aqAT5ZjlRmSUeiizITZB
         SLGA==
X-Forwarded-Encrypted: i=1; AHgh+RrPYpi09CPZB1ShHr6tvS2IaoPktgfqmNAR74oSMHl9h2h2QjPRlqZM7fsJSY0til477xflwdY5CcaQ@lists.infradead.org
X-Gm-Message-State: AOJu0Yzxm7BWvsc7JWOyIM8qsHqRlfM/CuvSw1P/PZcLhwatKbtdcJ2b
	ZC2eO3ihsr5MZf0Ki+UAHan6bADdMDYVAR3PESBWJXUiqDwx39ellqgPhrJRJVSoWA==
X-Gm-Gg: AR+sD11tCKVGTDdRRWqR60yr7TtqfJifCm/3mbDe42m0mglF3/PRBDsVcYnB+c1+ZaH
	sqiwHdPXB7ShnU0/9RQrRYn4A+8pxYutx3Pb8c1JGBbP+WVK0/5fbbPl88wzQwDm/C99kcBJCAZ
	PG0RAHjA4WjWsDWzn23842Ivmpb12DrKK3xBMMvt+dl1OHbeNkj+OpsXbqtE/77KhMMWmtpybka
	n/0UxTZYOeJGE1Qxm964yUDmg29YMe4QxgO44wqxOWen1XSCFsR0qmcv4exqYQtw8N8mKO+RdcZ
	Mq+nlbj3g+oT/Nv5LNfoAmlVh2air/YBwIneSFgbHzOUvagU9Je98CxhDzfC3gHo75iIjOSpguk
	Ce9Lqs+9+W+L8hWO5VNephItr8PJpAMHlBvtX/jljijddYJ/fsh8Z8OG07RJ4q5qNLeFa1IftMP
	K+sRJaJsU62vyDqIdcbcroYTD4xMsWn7D10XO3Rzhj9De9Ymviuz6iqHN9j/2FEMh2UzEaEMwCE
	qgIumaOLIRSZHs02kUHRwbrjPioRqlgbPmhuK7boQ==
X-Received: by 2002:a05:6000:4702:b0:475:f100:35f4 with SMTP id ffacd0b85a97d-47f8dca9a60mr5832815f8f.49.1784839388604;
        Thu, 23 Jul 2026 13:43:08 -0700 (PDT)
Received: from meshstor-pc ([185.87.42.56])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c52fc0sm18268192f8f.23.2026.07.23.13.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 13:43:08 -0700 (PDT)
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
Subject: [PATCH v5 07/10] md/raid1,raid10: skip futile retries on P2PDMA mapping failures
Date: Thu, 23 Jul 2026 22:42:03 +0200
Message-ID: <20260723204206.76930-8-mykola@meshstor.io>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260723204206.76930-1-mykola@meshstor.io>
References: <20260723204206.76930-1-mykola@meshstor.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260723_134310_708006_DF28A449 
X-CRM114-Status: GOOD (  14.76  )
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
Signed-off-by: Mykola Marzhan <mykola@meshstor.io>
---
 drivers/md/raid1-10.c |  3 +++
 drivers/md/raid1.c    | 11 ++++++++---
 drivers/md/raid10.c   |  7 ++++++-
 3 files changed, 17 insertions(+), 4 deletions(-)

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
index 19c4dec450de..83ebf40237d5 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -2624,10 +2624,15 @@ static void handle_write_finished(struct r1conf *conf, struct r1bio *r1_bio)
 			 * narrow down and record precise write
 			 * errors.
 			 */
+			struct md_rdev *rdev = conf->mirrors[m].rdev;
+
 			fail = true;
-			narrow_write_error(r1_bio, m);
-			rdev_dec_pending(conf->mirrors[m].rdev,
-					 conf->mddev);
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
index 428bddddfe71..77c7d8a59916 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -2940,7 +2940,12 @@ static void handle_write_completed(struct r10conf *conf, struct r10bio *r10_bio)
 				rdev_dec_pending(rdev, conf->mddev);
 			} else if (bio != NULL && bio->bi_status) {
 				fail = true;
-				narrow_write_error(r10_bio, m);
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


