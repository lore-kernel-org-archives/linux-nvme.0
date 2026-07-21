Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E21EDC4452B
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Jul 2026 17:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8dj3uaA5KIKi+y4TtBPBIa/9LhAWdxcRprl1F1cYW18=; b=Lo4fKXJ+geAH1XVxwn6S76ortO
	sws/LEMnYcildIw6oX9PuXNQyKnq5Zuz4yUEj01MpvM6/d/LYxnsF9dx9jQZl0tzy7mtfhxHBYV3m
	vqLNXyKMLO8ZuScHTLuB0AvAN9ELh+ADZg7VNznsmIha+Dnd/hz9iipLVfxQzQV2tUfHdXU6pG/qc
	iR9sr6Bpf2v6CAOjfgTAGYKiBOcRAfARvqFSBMcAOgY4hZCZppYry4/o2wp2wV8XPGhfsWy6zjDYx
	QXCe30AU58i4Eih/G+RiiQ7p4CSTVGNMKj2Q5lS1Wf30/winfXHywGi8faGtiipelDbvc5XG0+Ut2
	NGNlLhBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmEXt-0000000A5c1-1hlG;
	Tue, 21 Jul 2026 17:46:21 +0000
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmEXo-0000000A5Tx-1cdV
	for linux-nvme@lists.infradead.org;
	Tue, 21 Jul 2026 17:46:17 +0000
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-4954d383e64so24655055e9.1
        for <linux-nvme@lists.infradead.org>; Tue, 21 Jul 2026 10:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1784655974; x=1785260774; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8dj3uaA5KIKi+y4TtBPBIa/9LhAWdxcRprl1F1cYW18=;
        b=rUgysEj9w4CDRDz74JW7cR9KZdNEoH0gjrWKQEJlbhEn+JkVitAiW3OLTSO6BUc2Vq
         M9anqxlV/FV/s5EwLYlQO3xK3rswT3hcMjpYx9gwbXQrXP6k/j8jxJOe1S+Srg3ZL31U
         7YOwmxKQeXfEKySg7fjAv/eoCF+l1z+Vyu1Ktau2uxfFcwOpRTbPfQm5Cs2gGB3NEOAp
         ng1v5n1UPkxGsgOPFrOxvPo5oF2U8MJkCpPYgaLhf52yS6ebZm8lryRq+g18p2tSGUly
         5wjpDQA9T0bsmBH6XlVysp+VYrMt9d22asvuPNVTYqGFy5h9Ee6cppefhXjzGpskuPjS
         v41Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784655974; x=1785260774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8dj3uaA5KIKi+y4TtBPBIa/9LhAWdxcRprl1F1cYW18=;
        b=s6UlC7wj0ZUW7jPSfl0bgXopGTfnJqSQUDtmBpkcReaAzPl4xcEJQrb3/857/3NUxw
         wEbA467RTgWJPmY/SiewBlmGvabz9x99DgkzXNWxuJ0bl5sPMJiOhOdiiD26tUOtNPNZ
         JFIh3jIhkwC3o6MXyBIbE2d0wJCKq3fA3JJtBoe+7CYz6qjqJI/yJMJB9i1y7paCamcJ
         1zErsrwEwVb4gJN6XOVctHBuPf6YJV6ePmCoNGpHcuKuMbT4+/7INHOHXMHJs857nI12
         GOtu7THyTbXqOI0R5TiM5HglYN1kX+DdFq7Vbj4rLrMnR+DuffjAO2p0etm7AN8HdkFB
         R8EQ==
X-Forwarded-Encrypted: i=1; AHgh+RocQ25Nn6QsQRVSiRv2mOpSlV8o0t8niVo4oh2rq+/bHRaCcPr0sFeI0nwUrtqrVYCmqDsgyAjvWibn@lists.infradead.org
X-Gm-Message-State: AOJu0Yw8Mudg+emc7UCKxceTZY8rS2wvJ+xOK4VPzKfZi+2n2tvsunp4
	PE4KszwV+ZUTQevTA79kI7Ur3m/BPph4YBVEnbp/+zx7dvDzftCCjEsNAJ78i41sHU2X1da0/6l
	dTM48CA==
X-Gm-Gg: AfdE7ckY3+poKuvt78/eKdV4wPZGqfF+oLt7AC1jSs/wd/ZqxHW27Mt0L+r/9Lknmzp
	TKba12TeAC/2sw/fzI5QdNvESQPDQZKvBWTq406mMgRTvFgVxVpw6i+0cI10zPMH99+oD/NRj/V
	PFLORRne6/1+yO1jGBDOFR2l99vA3cLiqVvzlwJoGYufPxlYQ1JFWlR/4/KE5xTOtohwN/PY8S2
	cfBNXWTQh8KzGR2uLjC6I5j1ihZEiSLfBtRF3IfD6Srkq8kBMvLQULUVrv8UPHnDCBluwBZNXU2
	ZELvJPFrqE1gp+baNuJ7mM5TU88q7E5EszX4f2rJnb4iP5F3FRvZfMLlbmL71oCNpKf++gy4Oes
	z1gqQ9hCnlBOV2WQvehUHmMIn3Kb+5kiryn4uFR+q97toN0JQTvm1PmJZ1PGQ0dZOBhXBXormEX
	FpTDGCtOhgjOK4yk8xWPkN/xiwT9Av8cElPa2aw5scPvyhQCw=
X-Received: by 2002:a05:600c:1914:b0:495:4598:6e13 with SMTP id 5b1f17b1804b1-4954a3f5271mr199481405e9.17.1784655974444;
        Tue, 21 Jul 2026 10:46:14 -0700 (PDT)
Received: from ai-pc ([46.172.241.174])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63eddd27sm40860513f8f.28.2026.07.21.10.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 10:46:13 -0700 (PDT)
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
Subject: [PATCH v3 7/8] md/raid10: skip futile retries on P2PDMA mapping failures
Date: Tue, 21 Jul 2026 19:45:01 +0200
Message-ID: <20260721174502.111503-8-mykola@meshstor.io>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260721174502.111503-1-mykola@meshstor.io>
References: <20260721174502.111503-1-mykola@meshstor.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260721_104616_470838_B14A198D 
X-CRM114-Status: GOOD (  20.41  )
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

Same handling as the preceding raid1 commit: flag P2PDMA master
bios with R10BIO_P2PDMA at submission; on a BLK_STS_TARGET leg
failure retry writes once as a whole range, don't set
WantReplacement, block the leg for reads without charging the
read-error budget, don't trip FailFast.

Replacement legs keep the stock fail-on-write-error policy:
badblocks are never recorded on a replacement, so failing it is
the only outcome that cannot leave a silent hole in a rebuild.

Fixes: 02666132403a ("md: propagate BLK_FEAT_PCI_P2PDMA from member devices to RAID device")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Mykola Marzhan <mykola@meshstor.io>
---
 drivers/md/raid10.c | 63 ++++++++++++++++++++++++++++++++++-----------
 drivers/md/raid10.h |  2 ++
 2 files changed, 50 insertions(+), 15 deletions(-)

diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index f7ef903a3d4e..4c3da50250a5 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -482,15 +482,23 @@ static void raid10_end_write_request(struct bio *bio)
 			 */
 			md_error(rdev->mddev, rdev);
 		else {
-			set_bit(WriteErrorSeen,	&rdev->flags);
-			if (!test_and_set_bit(WantReplacement, &rdev->flags))
-				set_bit(MD_RECOVERY_NEEDED,
-					&rdev->mddev->recovery);
+			/* Peer/member pairing failure, not member health. */
+			bool p2pdma_unmappable =
+				bio->bi_status == BLK_STS_TARGET &&
+				test_bit(R10BIO_P2PDMA, &r10_bio->state);
 
+			set_bit(WriteErrorSeen,	&rdev->flags);
 			dec_rdev = 0;
-			if (test_bit(FailFast, &rdev->flags) &&
-			    (bio->bi_opf & MD_FAILFAST)) {
-				md_error(rdev->mddev, rdev);
+			if (!p2pdma_unmappable) {
+				if (!test_and_set_bit(WantReplacement,
+						      &rdev->flags))
+					set_bit(MD_RECOVERY_NEEDED,
+						&rdev->mddev->recovery);
+
+				if (test_bit(FailFast, &rdev->flags) &&
+				    (bio->bi_opf & MD_FAILFAST)) {
+					md_error(rdev->mddev, rdev);
+				}
 			}
 
 			/*
@@ -1170,6 +1178,9 @@ static void raid10_read_request(struct mddev *mddev, struct bio *bio,
 	 */
 	gfp_t gfp = err_path ? (GFP_NOIO | __GFP_HIGH) : GFP_NOIO;
 
+	if (md_bio_is_p2pdma(bio))
+		set_bit(R10BIO_P2PDMA, &r10_bio->state);
+
 	if (slot >= 0 && r10_bio->devs[slot].rdev) {
 		/*
 		 * This is an error retry, but we cannot
@@ -1357,6 +1368,9 @@ static bool raid10_write_request(struct mddev *mddev, struct bio *bio,
 	sector_t sectors;
 	int max_sectors;
 
+	if (md_bio_is_p2pdma(bio))
+		set_bit(R10BIO_P2PDMA, &r10_bio->state);
+
 	if ((mddev_is_clustered(mddev) &&
 	     mddev->cluster_ops->area_resyncing(mddev, WRITE,
 						bio->bi_iter.bi_sector,
@@ -2786,7 +2800,7 @@ static void fix_read_error(struct r10conf *conf, struct mddev *mddev, struct r10
 	}
 }
 
-static void narrow_write_error(struct r10bio *r10_bio, int i)
+static void narrow_write_error(struct r10bio *r10_bio, int i, bool coarse)
 {
 	struct bio *bio = r10_bio->master_bio;
 	struct mddev *mddev = r10_bio->mddev;
@@ -2800,6 +2814,9 @@ static void narrow_write_error(struct r10bio *r10_bio, int i)
 	 * It is conceivable that the bio doesn't exactly align with
 	 * blocks.  We must handle this.
 	 *
+	 * With 'coarse', retry the whole range as one bio: P2PDMA
+	 * mapping failures fail every block identically.
+	 *
 	 * We currently own a reference to the rdev.
 	 */
 
@@ -2814,9 +2831,12 @@ static void narrow_write_error(struct r10bio *r10_bio, int i)
 		block_sectors = roundup(1 << rdev->badblocks.shift, lbs);
 
 	sector = r10_bio->sector;
-	sectors = ((r10_bio->sector + block_sectors)
-		   & ~(sector_t)(block_sectors - 1))
-		- sector;
+	if (coarse)
+		sectors = sect_to_write;
+	else
+		sectors = ((r10_bio->sector + block_sectors)
+			   & ~(sector_t)(block_sectors - 1))
+			- sector;
 
 	while (sect_to_write) {
 		struct bio *wbio;
@@ -2856,6 +2876,7 @@ static void handle_read_error(struct mddev *mddev, struct r10bio *r10_bio)
 {
 	int slot = r10_bio->read_slot;
 	struct bio *bio;
+	bool p2pdma_error;
 	struct r10conf *conf = mddev->private;
 	struct md_rdev *rdev = r10_bio->devs[slot].rdev;
 
@@ -2868,17 +2889,24 @@ static void handle_read_error(struct mddev *mddev, struct r10bio *r10_bio)
 	 * frozen.
 	 */
 	bio = r10_bio->devs[slot].bio;
+	/* evaluate before the bio_put() below */
+	p2pdma_error = bio->bi_status == BLK_STS_TARGET &&
+		test_bit(R10BIO_P2PDMA, &r10_bio->state);
 	bio_put(bio);
 	r10_bio->devs[slot].bio = NULL;
 
 	if (mddev->ro)
 		r10_bio->devs[slot].bio = IO_BLOCKED;
-	else if (!test_bit(FailFast, &rdev->flags)) {
+	else if (p2pdma_error) {
+		/* Peer can't reach this member: just redirect the read. */
+		r10_bio->devs[slot].bio = IO_BLOCKED;
+	} else if (test_bit(FailFast, &rdev->flags)) {
+		md_error(mddev, rdev);
+	} else {
 		freeze_array(conf, 1);
 		fix_read_error(conf, mddev, r10_bio);
 		unfreeze_array(conf);
-	} else
-		md_error(mddev, rdev);
+	}
 
 	rdev_dec_pending(rdev, mddev);
 	r10_bio->state = 0;
@@ -2947,8 +2975,13 @@ static void handle_write_completed(struct r10conf *conf, struct r10bio *r10_bio)
 					r10_bio->sectors, 0);
 				rdev_dec_pending(rdev, conf->mddev);
 			} else if (bio != NULL && bio->bi_status) {
+				bool coarse = bio->bi_status ==
+						BLK_STS_TARGET &&
+					test_bit(R10BIO_P2PDMA,
+						 &r10_bio->state);
+
 				fail = true;
-				narrow_write_error(r10_bio, m);
+				narrow_write_error(r10_bio, m, coarse);
 				rdev_dec_pending(rdev, conf->mddev);
 			}
 			bio = r10_bio->devs[m].repl_bio;
diff --git a/drivers/md/raid10.h b/drivers/md/raid10.h
index ec79d87fb92f..a2e1554f77db 100644
--- a/drivers/md/raid10.h
+++ b/drivers/md/raid10.h
@@ -174,6 +174,8 @@ enum r10bio_state {
 	R10BIO_Previous,
 /* failfast devices did receive failfast requests. */
 	R10BIO_FailFast,
+/* the master bio carries PCI P2PDMA (peer device memory) pages */
+	R10BIO_P2PDMA,
 	R10BIO_Discard,
 };
 #endif
-- 
2.52.0


