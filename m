Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D84BC44512
	for <linux-nvme@archiver.kernel.org>; Sun, 19 Jul 2026 10:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DOCIvHQcUURC426TdmWIVqFzZor35QO+zXIWNPhmEXE=; b=gut2Zsq5vO5S/tKuIneGIbQU08
	AINR15C5M1yEn3MqHCFyMk+GXapXqDrj5HAjz2VLAm0V1JZyJDVf4JSbzeUqjknU/lBFttLqOVxcS
	HnzLGRAQy4WZ6RiXH8CJM7CShX5HqDSu5HgTJMN3K0vv/KRAUfBx6gIdHCCH1OIAdaS/JVK9qmdmb
	m8MuVzD1pUJnP8SNJwgKIegIiDdGYA1XYmTwi6Q9tnR9x8RR+UP4Zeg2EDdipi35tqo2G1HFlE3Lk
	7ti5Vba8YeEFypgCMQqwfZVi14UMoTz2eb56Y1NTPKy/wUrcNmR04rNLxYV9sulacCSZIVU9Q+HmS
	OQauSOuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlP9b-00000004vgn-2UnQ;
	Sun, 19 Jul 2026 10:53:51 +0000
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlP9Y-00000004vdE-3v9j
	for linux-nvme@lists.infradead.org;
	Sun, 19 Jul 2026 10:53:50 +0000
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-49556f97a9dso3162355e9.1
        for <linux-nvme@lists.infradead.org>; Sun, 19 Jul 2026 03:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1784458427; x=1785063227; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DOCIvHQcUURC426TdmWIVqFzZor35QO+zXIWNPhmEXE=;
        b=oo6TnLFAJggsEIpblG4FRjXY+MC07uDxfsNFxt2Lyw20wyWl1V8Mhz5xIhSH+x6TOm
         mzNyjFvA3I++cN24bVrZHYmn3pswEycZsiIYw7f51uTKBNWoehMd7g2ptqB8j+Fg2yrT
         eSN4XMTSj5SplWpEVBhTFRiuhdYssPOnpBEY1NrDzT7V++fRdzMJLpZYD3hHlzHWb1AB
         Hy4rUtH9lA/H+uEaxyx7e75XR1L1nTgwf908k53019tsnszrIcbTh49D1B1CAavl/EoB
         wXkKd9IoD8uHbtCirphkatxc25567f1NSd8Urfi+qTd0elyIWSOzaZdBAfRpiKukX9xQ
         9z1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784458427; x=1785063227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DOCIvHQcUURC426TdmWIVqFzZor35QO+zXIWNPhmEXE=;
        b=DRZ5u9u7ka3Mi2BHum4F55ccWLQt6vOeihHZ9dTUI3adxGOwUfJ59ZBEueQIgMQdl3
         1IgFtnjcKfsOUBQQI3jFwVsbAjv0Z546c1k3NrByzkMeZ8GNe1thpJV3Tqkri/InTAV5
         yjTtgjahH+HIGQH1EF8nEjwfQ2mjiwE4I2VG91ok8mkYtGuObO7LZmrnQtff1tG2UFzQ
         9pgCp5ZDGLnBophtHIa4CSi4GLF/jX560XnSHleVdv8tHSgOrRp6F0HxiE9GZC0+qsAu
         eyUP+0esksWRmRtGEHewVHJUjv9gUSEnEa7+a7gp/9hOeckhDkwCBXDu3DbOfZphs7mU
         DCLQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpprc/Fr4mETavziWMnZFBQFi6RLOpfvM6cehiAadkeyr4xMdfZfkZ1aohU1XkAIlyEPt1NhoRcL5n1@lists.infradead.org
X-Gm-Message-State: AOJu0Yzxjc1tNb4YBiJp9QJvJH5oWGMC78POPS8hbElKtSxNHJZlK7RT
	4s/f9EDSsJS5uzFXcxTsqnW+fOI6wtxhPzMStSuFl/hU6kfdCEaJjrmxvySoO0apEA==
X-Gm-Gg: AfdE7clOkfzDPAiD/wLoTYFMRF0h/xV6mRIexiR/Rmu2zvQ1rpmH0zud5errpQElYEA
	sQ9DSoLprm3uJ+jJt8lUxEp6LWztQ65BYp5Qapj01H1Fe1BKgAEhzE77MV07dM0ZSjSW9H7rv6J
	rKlQagFDpHFfl3JXTmQ3LLBtHonX3KGvgh5PqhEpBL3oU21d21wL+WI/Ca88P58jxxA0LSe2g4n
	+pIw93R3a2gGpaq3Ym//k1/CoNGNM/aJTzdnVtRc1Mbv8e2v8DOd4T05oolMgLj9AcmiEVpsw1T
	TTRiOXOTp2NL7bkeSkxEKK7k5BjqJFrsUZO0UzF4EeexOPO/EOE5I9FqdwT9EoM67gWJJcDir8B
	TceV6qjYfdIyDhxV49c9YlAiTk2CVPmPY+96BomUMnH2lWu3oQVsdL3nf0wm1KlYzGTE5n/tE
X-Received: by 2002:a05:600c:3143:b0:493:faf3:3ea5 with SMTP id 5b1f17b1804b1-4954a3d0925mr109816675e9.4.1784458427000;
        Sun, 19 Jul 2026 03:53:47 -0700 (PDT)
Received: from mf-00-01.. ([194.220.239.180])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954a2a24b6sm197679575e9.3.2026.07.19.03.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 03:53:46 -0700 (PDT)
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
Subject: [PATCH v2 6/7] md/raid1,raid10: skip futile retries on P2PDMA mapping failures
Date: Sun, 19 Jul 2026 10:53:26 +0000
Message-ID: <20260719105327.864949-7-mykola@meshstor.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260719105327.864949-1-mykola@meshstor.io>
References: <20260719105327.864949-1-mykola@meshstor.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260719_035349_144824_2D8B3357 
X-CRM114-Status: GOOD (  29.10  )
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

Since commit 02666132403a ("md: propagate BLK_FEAT_PCI_P2PDMA from
member devices to RAID device") raid1 and raid10 arrays accept P2PDMA
(peer device memory) bios, and a member that cannot DMA-map the
peer's pages fails its leg bio with BLK_STS_TARGET (from
blk_dma_map_iter_start()).  That mapping failure is a property of the
peer-device/member pairing, not of the medium: re-submitting the same
peer pages to the same member cannot succeed, and there is nothing on
the disk to repair.  Routing it through the stock error machinery
misfires on every path:

 - narrow_write_error() re-issues the failed write in badblock-sized
   chunks, serializing hundreds of guaranteed-to-fail synchronous bios
   through raid1d/raid10d per failed write (256 for a 1 MiB write on
   4K logical blocks, 2048 on 512e).

 - the write-error handler sets WantReplacement, so a hot spare is
   pulled in, rebuilt onto, and the healthy member is then evicted by
   spare_active() -- and if the spare is also unreachable from the
   peer, the cycle consumes the next spare.

 - fix_read_error() probes members with kernel pages, starting with
   the failing member itself.  That probe succeeds (the member is
   healthy for host memory), so the routine rewrites nothing, records
   nothing, and logs nothing -- but each invocation costs a full
   freeze_array() quiesce and a tick of the read-error budget.  The
   budget exists to evict members whose medium keeps producing
   corrected errors; its hourly decay is sized for sporadic medium
   errors, while mapping failures are deterministic and arrive at I/O
   rate.  On an asymmetric PCIe topology a mixed host/P2P read
   workload charges 20 errors to the unreachable leg within a second
   and kicks a perfectly healthy member.

 - On FailFast members both paths short-circuit into md_error(), so a
   single unroutable peer-memory I/O evicts a healthy mirror outright.

Track P2PDMA masters with a new r1bio/r10bio state bit, set at
submission where bio_has_data() is still meaningful; a leg's mapping
failure is then "BLK_STS_TARGET and the master carries P2PDMA pages",
cheap to test on every completion path.  Handle it explicitly:

 - Writes: probe the whole range with one retry and record one bad
   range if it also fails.  BLK_STS_TARGET is also produced for
   device conditions that narrow_write_error()'s retry loop recovers
   from (e.g. NVME_SC_NS_NOT_READY and NVME_SC_CMD_INTERRUPTED via
   nvme_error_status()), and md cannot tell the two apart from
   bi_status alone, so it must not skip the retry outright.  A single
   whole-range probe observes the outcome instead of predicting it.
   WriteErrorSeen is still set (it gates the write-path badblocks
   consult), but WantReplacement is not: replacing a member cannot
   fix a topology property, and spending a spare on it destroys
   redundancy management for real failures.

 - Reads: mark the leg IO_BLOCKED so read_balance() picks another
   mirror, and skip the freeze/fix cycle and the budget charge.  The
   same TARGET ambiguity exists here, but a redirected read leaves
   nothing to fence, and fix_read_error()'s host-page probe fails
   the same way under e.g. NVME_SC_NS_NOT_READY -- charging the
   budget would evict a healthy member for a firmware activation
   window.  A genuinely failing member is still evicted via host
   reads, writes and BLK_STS_MEDIUM errors.  If no mirror can serve
   the read the master bio fails with EIO as before (md completes
   masters by Uptodate state, as for any failed mirror I/O), now
   without kicking healthy members on the way.

 - FailFast: a mapping failure is rejected at map time and never
   reaches the wire, so it is no evidence of device unreliability;
   don't let it trigger the FailFast md_error() -- the same reasoning
   commit f7b24c7b41f2 ("md/raid1,raid10: don't fail devices for
   invalid IO errors") applied to BLK_STS_INVAL.

raid10 replacement legs keep their stock policy: badblocks are never
recorded on a replacement, so failing it is the only outcome that
cannot leave a silent hole in a rebuilding replacement.

This belongs in the same release as the BLK_STS_TARGET restoration:
with that fix alone, an unroutable leg costs the retry storms and
the healthy-member evictions above.

Measured on QEMU q35 rigs (one CMB provider, two NVMe members),
8KiB peer-memory I/O, reads x90 under concurrent host reads:

  scenario       stock error machinery     with this patch
  asym reads     90/90 ok, healthy far     90/90 ok, no eviction,
                 leg kicked after ~20      no budget charge
  unreach reads  all EIO, one healthy      all EIO, no members
                 member kicked             kicked
  p2p TARGET     16 chunk retries from     1 whole-range probe,
  write          raid1d, then badblocks    same badblocks, master ok

A transient TARGET recovers through the single probe with no
badblocks recorded, and a mapping failure no longer trips FailFast
eviction while a genuine I/O error still does -- both verified on
the same rig.

Fixes: 02666132403a ("md: propagate BLK_FEAT_PCI_P2PDMA from member devices to RAID device")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Mykola Marzhan <mykola@meshstor.io>
---
 drivers/md/raid1.c  | 56 +++++++++++++++++++++++++++++++-----
 drivers/md/raid1.h  |  2 ++
 drivers/md/raid10.c | 69 ++++++++++++++++++++++++++++++++++++++-------
 drivers/md/raid10.h |  2 ++
 4 files changed, 112 insertions(+), 17 deletions(-)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index f562b6bd438b..61f635463475 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -483,12 +483,22 @@ static void raid1_end_write_request(struct bio *bio)
 	 * 'one mirror IO has finished' event handler:
 	 */
 	if (bio->bi_status && !ignore_error) {
+		/*
+		 * A P2PDMA mapping failure reflects the peer/member
+		 * pairing, not member health: don't pull in a spare
+		 * or trip FailFast for it.
+		 */
+		bool p2pdma_unmappable = bio->bi_status == BLK_STS_TARGET &&
+			test_bit(R1BIO_P2PDMA, &r1_bio->state);
+
 		set_bit(WriteErrorSeen,	&rdev->flags);
-		if (!test_and_set_bit(WantReplacement, &rdev->flags))
+		if (!p2pdma_unmappable &&
+		    !test_and_set_bit(WantReplacement, &rdev->flags))
 			set_bit(MD_RECOVERY_NEEDED, &
 				conf->mddev->recovery);
 
-		if (test_bit(FailFast, &rdev->flags) &&
+		if (!p2pdma_unmappable &&
+		    test_bit(FailFast, &rdev->flags) &&
 		    (bio->bi_opf & MD_FAILFAST) &&
 		    /* We never try FailFast to WriteMostly devices */
 		    !test_bit(WriteMostly, &rdev->flags)) {
@@ -1378,6 +1388,8 @@ static void raid1_read_request(struct mddev *mddev, struct bio *bio,
 	else
 		init_r1bio(r1_bio, mddev, bio);
 	r1_bio->sectors = max_read_sectors;
+	if (md_bio_is_p2pdma(bio))
+		set_bit(R1BIO_P2PDMA, &r1_bio->state);
 
 	/*
 	 * make_request() can abort the operation when read-ahead is being
@@ -1557,6 +1569,8 @@ static bool raid1_write_request(struct mddev *mddev, struct bio *bio,
 
 	r1_bio = alloc_r1bio(mddev, bio);
 	r1_bio->sectors = max_sectors;
+	if (md_bio_is_p2pdma(bio))
+		set_bit(R1BIO_P2PDMA, &r1_bio->state);
 
 	/* first select target devices under rcu_lock and
 	 * inc refcount on their rdev.  Record them by setting
@@ -2525,7 +2539,7 @@ static void fix_read_error(struct r1conf *conf, struct r1bio *r1_bio)
 	}
 }
 
-static void narrow_write_error(struct r1bio *r1_bio, int i)
+static void narrow_write_error(struct r1bio *r1_bio, int i, bool coarse)
 {
 	struct mddev *mddev = r1_bio->mddev;
 	struct r1conf *conf = mddev->private;
@@ -2539,6 +2553,11 @@ static void narrow_write_error(struct r1bio *r1_bio, int i)
 	 * It is conceivable that the bio doesn't exactly align with
 	 * blocks.  We must handle this somehow.
 	 *
+	 * With 'coarse', retry the whole range as one bio and record
+	 * one bad range if it fails: for P2PDMA mapping failures,
+	 * which fail every block identically, while the single retry
+	 * still lets a cleared transient error recover.
+	 *
 	 * We currently own a reference on the rdev.
 	 */
 
@@ -2553,9 +2572,12 @@ static void narrow_write_error(struct r1bio *r1_bio, int i)
 		block_sectors = roundup(1 << rdev->badblocks.shift, lbs);
 
 	sector = r1_bio->sector;
-	sectors = ((sector + block_sectors)
-		   & ~(sector_t)(block_sectors - 1))
-		- sector;
+	if (coarse)
+		sectors = sect_to_write;
+	else
+		sectors = ((sector + block_sectors)
+			   & ~(sector_t)(block_sectors - 1))
+			- sector;
 
 	while (sect_to_write) {
 		struct bio *wbio;
@@ -2636,8 +2658,18 @@ static void handle_write_finished(struct r1conf *conf, struct r1bio *r1_bio)
 			 * narrow down and record precise write
 			 * errors.
 			 */
+			bool coarse = r1_bio->bios[m]->bi_status ==
+					BLK_STS_TARGET &&
+				test_bit(R1BIO_P2PDMA, &r1_bio->state);
+
 			fail = true;
-			narrow_write_error(r1_bio, m);
+			/*
+			 * A P2PDMA mapping failure fails the whole range
+			 * identically: probe it once (coarse) instead of
+			 * narrowing block by block. A transient TARGET
+			 * recovers via the probe with nothing recorded.
+			 */
+			narrow_write_error(r1_bio, m, coarse);
 			rdev_dec_pending(conf->mirrors[m].rdev,
 					 conf->mddev);
 		}
@@ -2664,6 +2696,9 @@ static void handle_read_error(struct r1conf *conf, struct r1bio *r1_bio)
 {
 	struct md_rdev *rdev = conf->mirrors[r1_bio->read_disk].rdev;
 	struct bio *bio = r1_bio->bios[r1_bio->read_disk];
+	/* evaluate before the bio_put() below */
+	bool p2pdma_error = bio->bi_status == BLK_STS_TARGET &&
+		test_bit(R1BIO_P2PDMA, &r1_bio->state);
 	struct mddev *mddev = conf->mddev;
 	sector_t sector;
 
@@ -2683,6 +2718,13 @@ static void handle_read_error(struct r1conf *conf, struct r1bio *r1_bio)
 	 */
 	if (mddev->ro) {
 		r1_bio->bios[r1_bio->read_disk] = IO_BLOCKED;
+	} else if (p2pdma_error) {
+		/*
+		 * The peer cannot reach this member; nothing on the
+		 * medium to fix. Skip the read-error budget and
+		 * FailFast, just keep this leg out of the retry.
+		 */
+		r1_bio->bios[r1_bio->read_disk] = IO_BLOCKED;
 	} else if (test_bit(FailFast, &rdev->flags)) {
 		md_error(mddev, rdev);
 	} else {
diff --git a/drivers/md/raid1.h b/drivers/md/raid1.h
index c98d43a7ae99..61b788a99d14 100644
--- a/drivers/md/raid1.h
+++ b/drivers/md/raid1.h
@@ -184,6 +184,8 @@ enum r1bio_state {
 	R1BIO_MadeGood,
 	R1BIO_WriteError,
 	R1BIO_FailFast,
+/* the master bio carries PCI P2PDMA (peer device memory) pages */
+	R1BIO_P2PDMA,
 };
 
 static inline int sector_to_idx(sector_t sector)
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index f7ef903a3d4e..144d07b6029c 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -482,13 +482,24 @@ static void raid10_end_write_request(struct bio *bio)
 			 */
 			md_error(rdev->mddev, rdev);
 		else {
+			/*
+			 * A P2PDMA mapping failure reflects the
+			 * peer/member pairing, not member health: don't
+			 * pull in a spare or trip FailFast for it.
+			 */
+			bool p2pdma_unmappable =
+				bio->bi_status == BLK_STS_TARGET &&
+				test_bit(R10BIO_P2PDMA, &r10_bio->state);
+
 			set_bit(WriteErrorSeen,	&rdev->flags);
-			if (!test_and_set_bit(WantReplacement, &rdev->flags))
+			if (!p2pdma_unmappable &&
+			    !test_and_set_bit(WantReplacement, &rdev->flags))
 				set_bit(MD_RECOVERY_NEEDED,
 					&rdev->mddev->recovery);
 
 			dec_rdev = 0;
-			if (test_bit(FailFast, &rdev->flags) &&
+			if (!p2pdma_unmappable &&
+			    test_bit(FailFast, &rdev->flags) &&
 			    (bio->bi_opf & MD_FAILFAST)) {
 				md_error(rdev->mddev, rdev);
 			}
@@ -1170,6 +1181,9 @@ static void raid10_read_request(struct mddev *mddev, struct bio *bio,
 	 */
 	gfp_t gfp = err_path ? (GFP_NOIO | __GFP_HIGH) : GFP_NOIO;
 
+	if (md_bio_is_p2pdma(bio))
+		set_bit(R10BIO_P2PDMA, &r10_bio->state);
+
 	if (slot >= 0 && r10_bio->devs[slot].rdev) {
 		/*
 		 * This is an error retry, but we cannot
@@ -1357,6 +1371,9 @@ static bool raid10_write_request(struct mddev *mddev, struct bio *bio,
 	sector_t sectors;
 	int max_sectors;
 
+	if (md_bio_is_p2pdma(bio))
+		set_bit(R10BIO_P2PDMA, &r10_bio->state);
+
 	if ((mddev_is_clustered(mddev) &&
 	     mddev->cluster_ops->area_resyncing(mddev, WRITE,
 						bio->bi_iter.bi_sector,
@@ -2786,7 +2803,7 @@ static void fix_read_error(struct r10conf *conf, struct mddev *mddev, struct r10
 	}
 }
 
-static void narrow_write_error(struct r10bio *r10_bio, int i)
+static void narrow_write_error(struct r10bio *r10_bio, int i, bool coarse)
 {
 	struct bio *bio = r10_bio->master_bio;
 	struct mddev *mddev = r10_bio->mddev;
@@ -2800,6 +2817,11 @@ static void narrow_write_error(struct r10bio *r10_bio, int i)
 	 * It is conceivable that the bio doesn't exactly align with
 	 * blocks.  We must handle this.
 	 *
+	 * With 'coarse', retry the whole range as one bio and record
+	 * one bad range if it fails: for P2PDMA mapping failures,
+	 * which fail every block identically, while the single retry
+	 * still lets a cleared transient error recover.
+	 *
 	 * We currently own a reference to the rdev.
 	 */
 
@@ -2814,9 +2836,12 @@ static void narrow_write_error(struct r10bio *r10_bio, int i)
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
@@ -2856,6 +2881,7 @@ static void handle_read_error(struct mddev *mddev, struct r10bio *r10_bio)
 {
 	int slot = r10_bio->read_slot;
 	struct bio *bio;
+	bool p2pdma_error;
 	struct r10conf *conf = mddev->private;
 	struct md_rdev *rdev = r10_bio->devs[slot].rdev;
 
@@ -2868,17 +2894,28 @@ static void handle_read_error(struct mddev *mddev, struct r10bio *r10_bio)
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
+		/*
+		 * The peer cannot reach this member; nothing on the
+		 * medium to fix. Skip the read-error budget and
+		 * FailFast, just keep this leg out of the retry.
+		 */
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
@@ -2947,8 +2984,20 @@ static void handle_write_completed(struct r10conf *conf, struct r10bio *r10_bio)
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
+				/*
+				 * A P2PDMA mapping failure fails the whole
+				 * range identically: probe it once (coarse)
+				 * instead of narrowing block by block.  A
+				 * transient TARGET recovers via the probe
+				 * with nothing recorded.
+				 */
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
2.43.0


